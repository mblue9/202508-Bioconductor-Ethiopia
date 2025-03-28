#load SE package 
library(SummarizedExperiment)

## read RDS 
se <- readRDS("data/se.rds")
##assay, colData and rowData
se

head(assay(se),10)

head(colData(se))

head(rowData(se))


#subsetting -  5 first features (genes) 
#for the 3 first samples.
se1 <- se[1:5,1:3]
se1
assay(se1)
colData(se1)
rowData(se1)
#subsetting - we keep only miRNAs and 
#the non infected samples
se2 <- se[rowData(se)$gene_biotype =="miRNA",
   colData(se)$infection =="NonInfected"]

assay(se2)
rowData(se2)
colData(se2)
## Ex1. Extract the gene expression levels 
## of the 3 first genes
## in samples at time 0 and at time 8.

# how to find the first 3 genes?

1:3
c(1, 2, 3)

# how to find samples at time 0 and 8?

colData(se)$time
se$time == 0
se$time == 8

se$time == 0 | se$time == 8

se$time != 4

se$time %in% c(0, 8)

# how to get the expression data?
assay(se[1:3, se$time ==8 | se$time ==0])
assay(se)[1:3, colData(se)$time !=4]

assay(se[1:3, colData(se)$time !=4])
assay(se)[1:3, colData(se)$time !=4]

se3 <- se[1:3, colData(se)$time !=4]
assay(se3)


#Adding variables to metadata
colData(se)$seqCenter <- rep("ILRI", 
                             nrow(colData(se)))

colData(se)

#delete column seqCenter
colData(se)$seqCenter <- NULL

#add a column with mean expression values
rowData(se)$mean_exp <- rowMeans(assay(se))
rowData(se)


















