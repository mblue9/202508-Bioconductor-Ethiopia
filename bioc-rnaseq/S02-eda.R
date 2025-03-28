## S02-eda.R

library(SummarizedExperiment)
rse <- readRDS("data/rse.rds")

## Ex: Find and remove unexpressed genes.

assay(rse)[1:10, 1:3]

## - calculate the sum of counts for each gene
##   (hint rowMeans()) -> rowSums() of the assay

rs <- rowSums(assay(rse))

length(rs)

1:5 > 3

rs > 5

se <- rse[rs > 5, ]

## How many genes have been kept/removed?

nrow(se)

dim(se)

nrow(rse) - nrow(se)

table(rs > 5)


## What are pros and cons of more aggressive filtering?
## What are important considerations?


table(rs > 10)

table(rs > 25)


## Compute the library sizes, i.e the sum of counts for each sample.

## Add the calculation to the colData (call the new colData variable libSize).

## Extract the colData and visualsie the library sizes.