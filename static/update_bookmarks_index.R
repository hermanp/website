source("static/generate_md.R")

# Generate a markdon file for the site.
# cat(generate_md(paste0("https://gist.githubusercontent.com/hermanp/",
#                        "c01365b8f4931ea7ff9d1aee1cbbc391/raw/",
#                        "33c21c88dad35145e2792b6258ede9c882c580ec/",
#                        "bookmarks-example.json")))

index_md <- readLines("content/en/resources/bookmarks/index.md",
                      encoding = "UTF-8")
end_of_yaml <- which(grepl("---", index_md))[2]
front_matter <- index_md[seq.int(from = 1, to = end_of_yaml, by = 1L)]

bookmarks_md <- paste0(paste0(front_matter, collapse = "\n"),
                       "\n",
                       generate_md(paste0("static/",
                                          "bookmarks.json")))

writeLines(text = bookmarks_md,
           con = "content/en/resources/bookmarks/index.md",
           useBytes = T)

# Download favicons for display.
# https://superuser.com/questions/157925/how-to-download-favicon-from-website
# Dismissed.
