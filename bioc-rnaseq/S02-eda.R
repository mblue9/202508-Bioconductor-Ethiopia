## S02-eda.R

library(SummarizedExperiment)
library(tidyverse)
library(DESeq2)
library(vsn)

## Bioconductor package installation
BiocManager::install("vsn")

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


## Compute the library sizes, i.e the sum
## of counts for each sample.

libSize <- colSums(assay(se))

## Add the calculation to the colData
## (call the new colData variable libSize).

colData(se)$libSize <- colSums(assay(se))

colData(se)$libSize
se$libSize

## Visualize the library sizes.

View(libSize)

colData(se) %>%
  as.data.frame() %>%
  ggplot(aes(
   x = geo_accession,
   y = libSize,
   fill = time
   )) +
  geom_bar(stat = "identity")


colData(se) %>%
  as.data.frame() %>%
  ggplot(aes(
    x = geo_accession,
    y = libSize,
    fill = sex
  )) +
  geom_bar(stat = "identity")




## Compute/estimate size factors
library(DESeq2)

names(colData(se))

dds <- DESeqDataSet(se, design = ~ sex + time)

dds <- estimateSizeFactors(dds)

colData(dds)

## Visualize the size factors.

colData(dds) %>%
  as.data.frame() %>%
  ggplot(aes(
    x = geo_accession,
    y = sizeFactor,
    fill = sex
  )) +
  geom_bar(stat = "identity")

colData(dds) %>%
  as.data.frame() %>%
  ggplot(aes(
    x = geo_accession,
    y = sizeFactor,
    fill = time
  )) +
  geom_bar(stat = "identity")


## Transformation

library(vsn)

meanSdPlot(assay(dds), ranks = FALSE)


vsd <- vst(dds, blind = TRUE)
meanSdPlot(assay(vsd), ranks = FALSE)

## Principal Component Analyis

pcaData <- plotPCA(vsd, intgroup = c("sex", "time"),
                   returnData = TRUE)

attributes(pcaData)

pcaData %>%
  ggplot(aes(
    x = PC1,
    y = PC2,
    colour = group
  )) +
  geom_point(size = 5)

attr(pcaData, "percentVar")

## iSEE

## Convert DESeqDataSet object to a SingleCellExperiment object, in order to
## be able to store the PCA representation
sce <- as(dds, "SingleCellExperiment")

## Add PCA to the 'reducedDim' slot
stopifnot(rownames(pcaData) == colnames(sce))
reducedDim(sce, "PCA") <- as.matrix(pcaData[, c("PC1", "PC2")])

## Add variance-stabilized data as a new assay
stopifnot(colnames(vsd) == colnames(sce))
assay(sce, "vsd") <- assay(vsd)

app <- iSEE(sce)
shiny::runApp(app)