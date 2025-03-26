## ggplot2

library(tidyverse)

rna <- read_csv("data/rnaseq.csv")
rna


ggplot()

ggplot(data = rna)

ggplot(data = rna, 
       mapping = aes(
         x = expression)) +
  geom_histogram()

# ggplot(data = rna, 
#        mapping = aes(
#          x = expression)) 
# + geom_histogram()

rna %>% 
  filter(gene == "Dok3")

# rna 
# %>% filter(gene == "Dok3")


2 * 5


2 * 
  5

# 2
# * 5

## Ex: Histogram of log2 of (expression + 1)

ggplot(data = rna, 
       mapping = aes(
         x = log2(expression + 1))) +
  geom_histogram()



rna <- rna %>% 
  mutate(log_expression = log2(expression + 1))

ggplot(data = rna, 
       mapping = aes(
         x = log_expression)) +
  geom_histogram()


## Fold changes

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


# x %>% 
#   mutate(fc_4_vs_0 = t4 - t0) %>% 
#   mutate(fc_8_vs_0 = t8 - t0)




rna_fc %>% 
  ggplot(aes(
    x = fc_4_vs_0, 
    y = fc_8_vs_0
  )) + 
  geom_point()


rna_fc %>% 
  filter(fc_4_vs_0 < -1.5)

rna_fc %>% 
  ggplot(aes(
    x = fc_4_vs_0, 
    y = fc_8_vs_0,
  )) + 
  geom_point(colour = "blue")


rna_fc %>% 
  ggplot(aes(
    x = fc_4_vs_0, 
    y = fc_8_vs_0,
    colour = gene_biotype
  )) + 
  geom_point()



sel <- rna_fc %>% 
  arrange(desc(fc_8_vs_0)) %>% 
  head(10) %>% 
  pull(gene)

sel

rna2 <- rna %>% 
  filter(gene %in% sel)

rna_mean_time <- rna2 %>% 
  group_by(gene, time) %>% 
  summarise(m_exp = mean(log_expression))
  
rna_mean_time %>% 
  ggplot(aes(
    x = time,
    y = m_exp,
    group = gene
  )) + 
  geom_line()

rna_mean_time %>% 
  ggplot(aes(
    x = time,
    y = m_exp,
    colour = gene
  )) + 
  geom_line() + 
  facet_wrap(~ gene)





## Create line plots for the same 10 genes,
## differentiating the male and female mice.


rna %>% 
  ggplot(aes(
    x = sample,
    y = log(expression + 1)
  )) +
  geom_boxplot() +
  geom_jitter()


ggplot(rna,
       aes(
  x = sample,
  y = log(expression + 1),
  colour = sex
)) +
  geom_boxplot() 

ggplot(rna,
       aes(
         x = sample,
         y = log(expression + 1),
         colour = sex
       )) +
  geom_boxplot() +
  geom_jitter()

ggplot(rna,
       aes(
         x = sample,
         y = log(expression + 1),
         colour = sex
       )) +
  geom_jitter() +
  geom_boxplot() 


ggplot(rna,
       aes(
         x = sample,
         y = log(expression + 1)
       )) +
  geom_jitter(aes(colour = sex)) +
  geom_boxplot() 


ggplot(rna,
       aes(
         x = sample,
         y = log(expression + 1)
       )) +
  geom_jitter(colour = "steelblue") +
  geom_boxplot() 

ggplot(rna,
       aes(
         x = sample,
         y = log(expression + 1)
       )) +
  geom_jitter(colour = "steelblue") +
  geom_boxplot(colour = "steelblue") 
