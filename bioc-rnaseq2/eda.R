
# Load packages
library(SummarizedExperiment)
library(DESeq2)
library(vsn)
library(ggplot2)
library(ComplexHeatmap)
library(hexbin)
library(iSEE)


se <- readRDS("output/GSE96870_se.rds")

se

rowData(se)
colData(se)
assay(se) |> head()

colData(se)
se

# Subsetting based on columns (colData)
se_female <- se[ , se$sex == "Female"]
se_female

se_female_infected_t8 <- se[, se$sex == "Female" &
                                se$infection == "InfluenzaA" &
                                se$time == "Day8"]
se_female_infected_t8

# Subset based on rows (rowData)
se2 <- se[rowData(se)$gbkey == "ncRNA", ]
se2

idx <- rowData(se)$gbkey == "ncRNA"
se[idx, ]

se2 <- se[rowData(se)$gbkey == "ncRNA", ]
se2

rowMeans(assay(se2))

se

#' Practice
#' 
#' Subset the `se` object to keep only samples from male mice
#' at time point 4.
#'
#'

p1 <- se[, se$sex == "Male" & se$time == "Day4"]
p1

ncol(p1)


# Filtering genes out
## Example 1: housekeeping genes (high mean expression; low variance)
## Example 2: remove unexpressed genes

sum(assay(se)[1, ])

keep <- rowSums(assay(se)) >5
fse <- se[keep, ]

#' Practice
#' 
#' Try different cut-offs (min sum of counts), 
#' e.g. 10, 15, 20, and then check how many genes are left.
#'

se[rowSums(assay(se)) >5, ] |> nrow()
se[rowSums(assay(se)) >10, ] |> nrow()
se[rowSums(assay(se)) >20, ] |> nrow()


head(assay(se))

# Check for library size differences
se$libSize <- colSums(assay(se))
colData(se)

## Visualize library sizes
colData(se) |>
    as.data.frame() |>
    ggplot(aes(x = geo_accession, y = libSize / 1e6, fill = sex)) +
    geom_bar(stat = "identity")


# Estimate size factors
dds <- DESeqDataSet(fse, design = ~ sex + time)
dds <- estimateSizeFactors(dds)

colData(dds)

# Variance-stabilizing transformation
meanSdPlot(assay(dds), ranks = FALSE)

vsd <- vst(dds, blind = TRUE)

meanSdPlot(assay(vsd), ranks = FALSE)

# Principal Component Analysis (PCA)
plotPCA(vsd, intgroup = c("sex", "time"))










