# creator:  Peter Herman
# contact:  peter.herman.89@gmail.com
# date:     2020-12-07
# 
# Summary ####
# This R script aims to download all favicons from the URLs of a JSON
# bookmarks file.
#   - read in Firefox bookmarks JSON file
#   - subset the bookmark folders
#   - generate favicon URL from the host URL of a site
#   - download all favicons to a directory
#   - name each favicon to the host URL part of the respective site
# 
# Input ####
# A JSON file of the bookmarks from the web browser, for example:
# paste0("https://gist.githubusercontent.com/hermanp/",
#        "c01365b8f4931ea7ff9d1aee1cbbc391/raw/",
#        "33c21c88dad35145e2792b6258ede9c882c580ec/",
#        "bookmarks-example.json")
# 
# Output ####
# A directory with a bunch of .ico files.
# 
# Parameters ####
# jsonfile: the input JSON file path
# 
# Example ####
# download_favicons(paste0("https://gist.githubusercontent.com/hermanp/",
#                          "c01365b8f4931ea7ff9d1aee1cbbc391/raw/",
#                          "33c21c88dad35145e2792b6258ede9c882c580ec/",
#                          "bookmarks-example.json")))

library(httr)
source("static/generate_md.R", encoding = "UTF-8")

useragent <- user_agent("R httr package, Peter Herman, hermanp.github.io")

download_favicons <- function(jsonfile) {
  raw_md <- generate_md(jsonfile = jsonfile, foricondownload = TRUE)
  split_md <- strsplit(x = raw_md, split = "\n", perl = T)[[1]]
  
  md_urls <- sapply(split_md,
                    function(x) gsub(pattern = "(?<=\\[)(.*)]\\(NA",
                                     replacement = "\\1]\\(\\1/favicon.ico",
                                     x = x,
                                     perl = T))
  md_urls <- sapply(md_urls,
                    function(x) gsub(pattern = "(?<=\\[)(.*)]\\(fake-favicon-uri:.*(?=\\))",
                                     replacement = "\\1]\\(\\1/favicon.ico",
                                     x = x,
                                     perl = T))
  md_urls <- unique(md_urls)
  md_urls <- md_urls[!grepl("- [[:alpha:]]", md_urls)]
  
  filnames <- sapply(md_urls,
                     function(x) regmatches(x,
                                            regexpr(pattern = "(?<=\\[)(.*)(?=])",
                                                    text = x,
                                                    perl = T)),
                     USE.NAMES = F)
  favicon_urls <- sapply(md_urls,
                         function(x) regmatches(x,
                                                regexpr(pattern = "(?<=\\()(.*)(?=\\))",
                                                        text = x,
                                                        perl = T)),
                         USE.NAMES = F)
  
  for (j in seq_along(favicon_urls)) {
    parsed_url <- parse_url(favicon_urls[j])
    if (is.null(parsed_url$scheme)){
      favicon_urls[j] <- paste0("http://", favicon_urls[j])
    }
  }
  
  # Create favicon directory, where files are downloaded.
  if (!dir.exists("static/favicons/")) {
    dir.create("static/favicons/")
  }
  
  pb <- txtProgressBar(min = 0, max = length(favicon_urls), width = 100, style = 3)
  
  for (i in seq_along(favicon_urls)) {
    tryCatch(
      expr = {
        response <- GET(url = favicon_urls[i],
                        useragent,
                        timeout(seconds = 5))
        
        if (http_type(response) == "image/png"){
          writeBin(content(response, as = "raw"),
                   con = file.path("static", "favicons",
                                   paste0(filnames[i], ".ico")))
        }
        
        # Create log file row.
        log_row <- data.frame(host = filnames[i],
                              URL = favicon_urls[i],
                              time = Sys.time(),
                              http_type = http_type(response),
                              status = status_code(response),
                              stringsAsFactors = F)
        
        # Create or append log file about downloading. If log file is
        # created freshly, then write the column names also, otherwise
        # do not write them.
        if (file.exists("static/favicons/favicon_log.txt")) {
          write.table(x = log_row,
                      file = "static/favicons/favicon_log.txt",
                      append = T,
                      quote = F,
                      sep = "\t",
                      row.names = F,
                      col.names = F)
        } else {
          write.table(x = log_row,
                      file = "static/favicons/favicon_log.txt",
                      append = T,
                      quote = F,
                      sep = "\t",
                      row.names = F,
                      col.names = T)
        }
      },
      
      error = function(e) {
        error_string <- toString(e)
        # Create error log file row.
        error_row <- data.frame(host = filnames[i],
                                URL = favicon_urls[i],
                                time = Sys.time(),
                                error = error_string,
                                stringsAsFactors = F)
        
        # Create or append log file about downloading. If log file is
        # created freshly, then write the column names also, otherwise
        # do not write them.
        if (file.exists("static/favicons/error_log.txt")) {
          write.table(x = error_row,
                      file = "static/favicons/error_log.txt",
                      append = T,
                      quote = F,
                      sep = "\t",
                      row.names = F,
                      col.names = F)
        } else {
          write.table(x = error_row,
                      file = "static/favicons/error_log.txt",
                      append = T,
                      quote = F,
                      sep = "\t",
                      row.names = F,
                      col.names = T)
        }
      },
      
      finally = {
        setTxtProgressBar(pb, i)
      }
    )
  }
  
  close(pb)
  
}
