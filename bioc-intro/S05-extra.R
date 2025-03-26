library(tidyverse)

rna <- read_csv("data/rnaseq.csv")

rna <- rna %>% 
  mutate(log_expression = log(expression + 1))

rna_fc <- rna %>% 
    select(gene, time, 
           log_expression, 
           gene_biotype) %>% 
    group_by(gene, time, gene_biotype) %>% 
    summarise(mean_exp = mean(log_expression)) %>% 
    pivot_wider(names_from = time, 
                values_from = mean_exp) %>% 
  mutate(fc_4_vs_0 = `4` - `0`) %>% 
  mutate(fc_8_vs_0 = `8` - `0`)
  
## Create a vector containing the names of the 
## 10 genes with the highest fold-change at time 
## 8 vs 0.
## 1. Arrange/sort the table by descending fc_8_vs_0
  
rna_fc %>% 
  arrange(desc(fc_8_vs_0))

## 2. Keep the 10 first rows (genes), i.e. those
##    with the highest fc_8_vs_0.
  
rna_fc %>% 
  arrange(desc(fc_8_vs_0)) %>% 
  head(10)

## 3. Extract the gene column as a vector.

gene10 <- rna_fc %>% 
  arrange(desc(fc_8_vs_0)) %>% 
  head(10) %>% 
  pull(gene)

gene10

## Create a subset of rna that contains 
## the observations for the 10 genes of 
## interest stored in gene10.

rna %>% 
  filter(gene == "Dok3") ## only 1 gene

rna10 <- rna %>% 
  filter(gene %in% gene10) ## many genes

rna10

## Compute the average expression for each 
## gene/time/sex.

rna_time_sex_gene <- rna10 %>% 
  group_by(gene, time, sex) %>% 
  summarise(mean_exp = mean(log_expression))

rna_time_sex_gene

## Visualise the changes over time of the 
## average expressions for the 10 genes and 
## the 2 sexes.

rna_time_sex_gene %>% 
  ggplot(aes(
    x = time, 
    y = mean_exp,
    colour = gene
  )) + 
  geom_line() +
  facet_wrap(~ sex)



rna_time_sex_gene %>% 
  ggplot(aes(
    x = time, 
    y = mean_exp,
    colour = sex
  )) + 
  geom_line() +
  facet_wrap(~ gene)

rna_time_sex_gene %>% 
  ggplot(aes(
    x = time, 
    y = mean_exp,
    colour = sex
  )) + 
  geom_line() +
  facet_wrap(~ gene, 
             scale = "free_y")


rna_time_sex_gene %>% 
  ggplot(aes(
    x = time, 
    y = mean_exp,
    colour = sex
  )) + 
  geom_line() +
  facet_grid(sex ~ gene)

rna_time_sex_gene %>% 
  ggplot(aes(
    x = time, 
    y = mean_exp,
    colour = sex
  )) + 
  geom_line() +
  facet_grid(gene ~ sex)


rna_time_sex_gene %>% 
  ggplot(aes(
    x = time, 
    y = mean_exp,
    colour = sex
  )) + 
  geom_line() +
  facet_wrap(sex ~ gene)

rna_time_sex_gene %>% 
  ggplot(aes(
    x = time, 
    y = mean_exp,
    colour = sex
  )) + 
  geom_line() +
  geom_point() +
  facet_wrap(~ gene, 
             scale = "free_y")


version
sessionInfo()

citation()

citation("ggplot2")

citation("DESeq2")

## Ex: How to cite SummarizedExperiment?

citation("SummarizedExperiment")


