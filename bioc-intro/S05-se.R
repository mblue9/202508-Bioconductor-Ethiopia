library(SummarizedExperiment)

# install.packages("BiocManager")
# BiocManager::install("SummarizedExperiment")

## Ex: How many samples?

length(unique(rna$sample))

## How many genes?

length(unique(rna$gene))


names(rna)

## Download the data by hand
## carpentries-incubator.github.io/bioc-intro

## 1. Create the assay (expression matrix)

count_matrix <- 
  read.csv("data/count_matrix.csv",
         row.names = 1)

class(count_matrix)
dim(count_matrix)
count_matrix[1:5, 1:3]

count_matrix <- as.matrix(count_matrix)
class(count_matrix)

## 2. Create the colData (sample annotation)
sample_metadata <- 
  read.csv("data/sample_metadata.csv")

## How many rows?
nrow(sample_metadata)

## 3. Create the rowData (gene annotation)
gene_metadata <- read.csv("data/gene_metadata.csv")

## How many rows?
nrow(gene_metadata)

## 4. Create the SummarizedExperiment (SE)

SummarizedExperiment(
  assays = list(counts = count_matrix),
  colData = sample_metadata,
  rowData = gene_metadata
)







