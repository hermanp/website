library(jsonlite)
library(dplyr)
# IMPORTANT! Without encoding = "UTF-8", the re will be problems with
# non-ASCII characters, even in comments or in code. The problem may not
# drop an error message, just simply live on. Problem for you and not
# for the machine.
source("static/generate_md.R", encoding = "UTF-8")

# Generate a markdon file for the site.
# cat(generate_md(paste0("https://gist.githubusercontent.com/hermanp/",
#                        "c01365b8f4931ea7ff9d1aee1cbbc391/raw/",
#                        "33c21c88dad35145e2792b6258ede9c882c580ec/",
#                        "bookmarks-example.json")))

jsonfile <- file.path("static", "bookmarks.json")
pretty_json <- prettify(toJSON(fromJSON(jsonfile)), indent = 2)
writeLines(pretty_json, jsonfile, useBytes = T)

index_md <- readLines("content/en/resources/bookmarks/index.md",
                      encoding = "UTF-8")
end_of_yaml <- which(grepl("---", index_md))[2]
front_matter <- index_md[seq.int(from = 1, to = end_of_yaml, by = 1L)]

bookmarks_md <- generate_md(jsonfile = jsonfile, foricondownload = F)
# I want to insert header signs (#: pound or hash) before every folder
# in the list. With this, a table of contents can be shown on the site,
# because Hugo (or basic markdown?) can handle this combination
# (let it be part of the list and be a header).
# The only sign for folder depth is the number of spaces (indentation)
# before every list element:
#   - 0: level 1 folder
#   - 2: level 2 folder
#   - 4: level 3 folder
# and so on. Because the indentation is 2 horizontal spaces (\\h in regex)
# if I extract the number of consecutive spaces from the string and
# call a table() on it, I can find out which is the deepest level of
# the folders and then I can gsub() these separately, inserting the
# hashes inside them.
# 
# space_places <- gregexpr(pattern = "\\h+", bookmarks_md, perl = T)
# table(attr(space_places[[1]], "match.length"))
#    1    2    3    4    5    6 
# 1949   67    1  330    1   23 
# 
# This means, there are 4 levels of bookmarks (from level 1 to 4, from
# 0 to 6 spaces indentation, respectively). Because there must be
# another level inside a folder and that level should be the maximal
# depth, if there are 6 indentation, therefore 4 levels, it means
# there are 3 levels of folders. But lets keep the fourth level also.
# If the regex is good and there's no match, then there won't be any 
# problem with it.

bookmarks_list <- strsplit(bookmarks_md, "\\n", perl = T)[[1]]
level1_hash <- gsub(pattern = "(^ {0}- )([[:alpha:] &]+$)",
                    replacement = "\\1# \\2",
                    x = bookmarks_list,
                    perl = F)
level2_hash <- gsub(pattern = "(^ {2}- )([[:alpha:] &]+$)",
                    replacement = "\\1## \\2",
                    x = bookmarks_list,
                    perl = F)
level3_hash <- gsub(pattern = "(^ {4}- )([[:alpha:] &]+$)",
                    replacement = "\\1### \\2",
                    x = bookmarks_list,
                    perl = F)
level4_hash <- gsub(pattern = "(^ {6}- )([[:alpha:] &]+$)",
                    replacement = "\\1#### \\2",
                    x = bookmarks_list,
                    perl = F)
level1_logi <- grepl("^ {0}- # [[:alpha:] &]+$", level1_hash, perl = F)
level2_logi <- grepl("^ {2}- ## [[:alpha:] &]+$", level2_hash, perl = F)
level3_logi <- grepl("^ {4}- ### [[:alpha:] &]+$", level3_hash, perl = F)
level4_logi <- grepl("^ {6}- #### [[:alpha:] &]+$", level4_hash, perl = F)

level1_coalesce <- ifelse(level1_logi, level1_hash, NA)
level2_coalesce <- ifelse(level2_logi, level2_hash, NA)
level3_coalesce <- ifelse(level3_logi, level3_hash, NA)
level4_coalesce <- ifelse(level4_logi, level4_hash, NA)
nohash_coalesce <- ifelse(level1_logi |
                          level2_logi |
                          level3_logi |
                          level4_logi,
                          yes = NA,
                          no = bookmarks_list)

bookmarks_hash <- coalesce(level1_coalesce,
                           level2_coalesce,
                           level3_coalesce,
                           level4_coalesce,
                           nohash_coalesce)
bookmarks_hash <- paste0(bookmarks_hash, collapse = "\n")

bookmarks_end <- paste0(paste0(front_matter, collapse = "\n"),
                       "\n",
                       bookmarks_hash)

writeLines(text = bookmarks_end,
           con = "content/en/resources/bookmarks/index.md",
           useBytes = T)

# Download favicons for display.
# https://superuser.com/questions/157925/how-to-download-favicon-from-website
# Dismissed.
