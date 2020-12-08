# creator:  Peter Herman
# contact:  peter.herman.89@gmail.com
# date:     2020-12-01
# 
# Summary ####
# This R script aims to convert a JSON bookmarks file to a markdown.
#   - read in Firefox bookmarks JSON file
#   - subset the publishable content
#   - generate markdown
# After the bookmarks are finalized, a markdown file has to be generated
# which can be deployed in the respective content folder.
# 
# Input ####
# A JSON file of the bookmarks from the web browser, for example:
# paste0("https://gist.githubusercontent.com/hermanp/",
#                    "c01365b8f4931ea7ff9d1aee1cbbc391/raw/",
#                    "33c21c88dad35145e2792b6258ede9c882c580ec/",
#                    "bookmarks-example.json")
# 
# Output ####
# A length one character vector, which can be cat() or write on disk
# with writeLines(). Use writeLines() with useBytes = TRUE.
# 
# Parameters ####
# jsonfile:         the input JSON file path.
# foricondownload:  logical. If TRUE, the generated md text contains info for
#                   downloading the favicons.
# 
# Example ####
# cat(generate_md(paste0("https://gist.githubusercontent.com/hermanp/",
#                        "381eaf9f2bf5f2b9cdf22f5295e73eb5/raw/",
#                        "76b74b2c3b5e34c2410e99a3f1b6ef06977b2ec7/",
#                        "bookmarks-example-hyphen.json"), foricondownload = F))

library(jsonlite)

# This function recursively converts the bookmark titles to unordered
# list items.
recursive_func <- function (level, foricondownload) {
  md_result <- character()
  
  # Iterate through the current data frame, which may have a children
  # column nested with other data frames.
  for (i in seq_len(nrow(level))) {
    # If this element is a bookmark and not a folder, then grab
    # the title and construct a list item from it.
    if (level[i, "type"] == "text/x-moz-place"){
      md_title <- level[i, "title"]
      md_uri <- level[i, "uri"]
      md_iconuri <- level[i, "iconuri"]
      # Condition: the URLs all have schema (http or https) part.
      # If not, filname will be a zero length character vector.
      host_url <- regmatches(x = md_uri,
                             m = regexpr(pattern = "(?<=://)[[:alnum:].-]+",
                                         text = md_uri,
                                         perl = T))
      
      if (isTRUE(foricondownload)){
        md_link <- paste0("[", host_url, "]", "(", md_iconuri, ")")
        md_listitem <- paste0("- ", md_link, "\n")
      } else {
        md_link <- paste0("[", md_title, "]", "(", md_uri, ")")
        md_listitem <- paste0("- ", md_link, "\n")
      }
      
      # If this element is a folder, then get into it, call this
      # function over it. Insert two space (for indentation) in
      # the generated sting before every list item. Paste this
      # list of items to the folder list item.
    } else if (level[i, "type"] == "text/x-moz-place-container") {
      md_title <- level[i, "title"]
      md_listitem <- paste0("- ", md_title, "\n")
      md_recurs <- recursive_func(level = level[i, "children"][[1]],
                                  foricondownload = foricondownload)
      md_recurs <- gsub("(?<!(\\w ))-(?= )", "  -", md_recurs, perl = T)
      md_listitem <- paste0(md_listitem, md_recurs)
    }
    
    # Collect and paste the list items of the current data frame.
    md_result <- paste0(md_result, md_listitem)
  }
  
  # Return the (sub)list of the data frame.
  return(md_result)
}

generate_md <- function (jsonfile, foricondownload) {
  # Encoding problem with tidyjson::read_json
  bmarks_json_lite <- fromJSON(txt = jsonfile)
  
  # This is the start point, a data frame. It represents the
  # elements inside the Bookmarks Toolbar in Firefox.
  level1 <- bmarks_json_lite$children$children[[2]]
  # Choose only certain folders to keep.
  level1 <- level1[level1$title
                   %in% c("Adat", "R", "Info", "Érdekesség", "Forrás", "Sport"), ]
  
  # Do not know how to make it prettier, but it works.
  markdown_result <- recursive_func(level = level1,
                                    foricondownload = foricondownload)
  
  return(markdown_result)
}
