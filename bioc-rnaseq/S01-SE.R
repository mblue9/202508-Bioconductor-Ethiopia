download.file(
  url = "https://github.com/carpentries-incubator/bioc-rnaseq/raw/main/episodes/data/GSE96870_counts_cerebellum.csv",
  destfile = "data/GSE96870_counts_cerebellum.csv"
)

library(tidyverse)

## 1. Create the count _matrix_

counts <- read.csv("data/GSE96870_counts_cerebellum.csv",
                   row.names = 1) %>%
  as.matrix()

View(counts)

dim(counts) ## 41786    22
class(counts) ## matrix

## 2. Load the sample data as a _data.fame_,
##    GSE96870_coldata_cerebellum.csv, making sure
##    that the rownames of that data.frame correspond
##    to the colnames of counts.

coldata <- read.csv("data/GSE96870_coldata_cerebellum.csv",
                    row.names = 1)
View(coldata)


## Use == to check that the rownames(coldata)
## and colnames(counts) are the same

all(colnames(counts) == rownames(coldata))

## 3. Load the row data

rowranges <- read.delim("data/GSE96870_rowranges.tsv",
                        row.names = 5)
rowranges$ENTREZID <- as.character(rowranges$ENTREZID)

# dim(rowranges)
# class(rowranges)
# View(rowranges)

all(rownames(counts) == rownames(rowranges))

## Create a SummarizedExperiment named se using the 
## counts matrix and the coldata and rowranges 
## data.frames.

library(SummarizedExperiment)

se <- SummarizedExperiment(
    assay = list(counts = counts),
    colData = coldata,
    rowData = rowranges
)

se

rse <- SummarizedExperiment(
  assay = list(counts = counts),
  colData = coldata,
  rowRanges = as(rowranges, "GRanges")
)

rse

saveRDS(se, file = "data/se.rds")

saveRDS(rse, file = "data/rse.rds")












