#load package 
library(tidyverse)

#read data 
rna <- read_csv("data/rnaseq.csv")
rna

#subset columns 
select(rna,gene,sample ,expression)

#except - gene, sample, expression
select(rna, -gene, -sample, -expression)

#filter
filter(rna, sex=="Male")

#filter - Male mice + Noninfection
filter(rna, sex =="Male" & infection =="NonInfected")

filter(rna, time ==4)
select(rna, time)
#summary time 
table(rna$time)

#missing values
colnames(rna)

genes <- select(rna, gene, hsapiens_homolog_associated_gene_name)
genes

#rows - NAs within homolog column 
filter(genes, is.na(hsapiens_homolog_associated_gene_name))

#gene IDs with human homologs
filter(genes, !is.na(hsapiens_homolog_associated_gene_name))

####
# filter Male mice
rna1 <- filter(rna, sex=="Male") 
#selected gene, sample , expression
rna2 <- select(rna1, gene,sample, expression)
rna2

#nested function
rna3 <- select(filter(rna, sex =="Male"),gene, sample, expression)
rna3

## %>% %>% %>% %>% |>
rna  %>% filter(sex =="Male") %>% 
  select(gene, sample, expression)


# Ex1. 

rna %>% filter(sex =="Female",
               time == 0,
               expression > 50000) %>% 
  select(gene,sample,time,expression,age)


#Ex 5.

rna %>%  filter(chromosome_name=="X" |chromosome_name =="Y") %>% 
  group_by(sex, chromosome_name) %>% 
  summarise(mean_exp = mean(expression)) %>% 
  pivot_wider(names_from = sex,
              values_from = mean_exp)

#Ex5
rna %>% filter(chromosome_name %in% c("X","Y") )%>% 
  group_by(sex, chromosome_name) %>% 
  summarise(mean_exp = mean(expression)) %>% 
  pivot_wider(names_from = sex,
              values_from = mean_exp)



##Joining tables

#from rna df lets us create - 3 columns (gene, sample, expression) and 10 lines

genes <- rna %>% select(gene,sample,expression) %>% 
  head(10)

genes

#we will now download annotation file
download.file(url = "https://carpentries-incubator.github.io/bioc-intro/data/annot1.csv",
              destfile = "data/anno.csv")

#read file 
anno <- read_csv("data/anno.csv")
anno

##We now want to join these two tables into a single one containing all variables
genes_descrip <- full_join(genes, anno, by = "gene")
genes_descrip


# export from r
write_csv(genes_descrip, "data/genes_description.csv")

























































































