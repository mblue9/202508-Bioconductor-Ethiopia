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
