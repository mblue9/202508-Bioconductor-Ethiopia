library(DESeq2)

dds

## dds <- DESeqDataSet(se, design = ~ sex + time)


dds <- DESeq(dds)

dds

resultsNames(dds)

res1 <- results(dds, name = "time_Day8_vs_Day0")
## res2 <- results(dds, contrast = c("time", "Day8", "Day0"))

summary(res1)

View(res1)

res1
dim(res1)


res1 <- data.frame(res1) %>% 
  rownames_to_column() %>% 
  as_tibble()

res1


## Find the 10 most significantly differentially
## expressed genes.

res1 %>% 
  arrange(padj) %>% 
  head(10)

## How many significantly differentially 
## expressed genes are there? (Using padj < 0.01)

res1 %>% 
  filter(padj < 0.01) %>% 
  nrow()


res1 %>% 
  filter(padj < 0.05) %>% 
  nrow()

res1 %>% 
    filter(padj < 0.1) %>% 
  nrow()

res1 %>% 
  filter(padj < 0.00001) %>% 
  nrow()

## Generate a *volcano plot*, i.e plot each 
## gene with its log2 fold-change along the x and
## log10 of the adjusted p-value along the 
## y axis.










