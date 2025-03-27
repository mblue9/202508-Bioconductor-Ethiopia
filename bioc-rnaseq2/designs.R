
# Load packages
library(SummarizedExperiment)
library(DESeq2)
library(tidyverse)
library(clusterProfiler)
library(org.Mm.eg.db)
library(enrichplot)

# Load the data
se <- readRDS("output/GSE96870_se.rds")

keep <- rowSums(assay(se)) >5
se <- se[keep, ]

# Differential expression analysis
## Day4 vs Day0
dds <- DESeqDataSet(se, design = ~ sex + time)

dds <- DESeq(dds)
results_d4 <- results(
    dds,
    contrast = c("time", "Day4", "Day0")
)


## Day4 vs Day0 - Female
#dds2 <- DESeqDataSet(se, design = ~ sex * time)
se$sex_time <- paste(se$sex, se$time, sep = "_")

dds2 <- DESeqDataSet(se, design = ~ sex_time)
dds2 <- DESeq(dds2)

results_d4_female <- results(
    dds2, 
    contrast = c("sex_time", "Female_Day4", "Female_Day0")
)

head(results_d4_female)

# Goal: vector of up-regulated DEGs
up <- results_d4_female |>
    as.data.frame() |>
    filter(log2FoldChange >1,
           !is.na(padj),
           padj <0.05)
    
up <- rownames(up)

up

# Overrepresentation analysis
rowData(se)
head(up)

up_entrez <- rowData(se) |>
    as.data.frame() |>
    rownames_to_column("gene") |>
    filter(gene %in% up) |>
    pull(ENTREZID)
    
# Species with orgDb packages (model organisms)
go_day4 <- enrichGO(
    gene = up_entrez, 
    OrgDb = org.Mm.eg.db,
    ont = "BP"
)

as.data.frame(go_day4) |> View()

barplot(go_day4, showCategory = 52)
dotplot(go_day4)

# Non-model organisms
banana_annotation <- read_tsv(
    "https://ftp.psb.ugent.be/pub/plaza/plaza_public_monocots_05/MapMan/mapman.msi.csv.gz",
    comment = "# "
)

banana_annotation <- banana_annotation |>
    dplyr::select(desc, gene_id)

enricher(
    gene = up_entrez,
    TERM2GENE = banana_annotation
)


