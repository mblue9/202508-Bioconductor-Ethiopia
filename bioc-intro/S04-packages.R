## CRAN package installation
## See https://carpentries-incubator.github.io/bioc-intro/20-r-rstudio.html#r-packages


## CRAN = Comprehensive R Archive Network



## Bioconductor package installation




## All packages
## See https://carpentries-incubator.github.io/bioc-rnaseq/
BiocManager::install(c("tidyverse", "SummarizedExperiment",
                       "ExploreModelMatrix", "AnnotationDbi", "org.Hs.eg.db", 
                       "org.Mm.eg.db", "csoneson/ConfoundingExplorer",
                       "DESeq2", "vsn", "ComplexHeatmap", "hgu95av2.db",
                       "RColorBrewer", "hexbin", "cowplot", "iSEE",
                       "clusterProfiler", "enrichplot", "kableExtra",
                       "msigdbr", "gplots", "ggplot2", "simplifyEnrichment",
                       "apeglm", "microbenchmark", "Biostrings",
                       "SingleCellExperiment"))