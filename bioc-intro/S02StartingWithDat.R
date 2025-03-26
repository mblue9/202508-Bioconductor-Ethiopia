# ---- Starting with data ----

#Content:
#1. Describe dataframes
#2. Load data using read.csv and read.table  
#3. Summarize the contents of a data frame
#4. Indexing and subsetting data frames
#5. Factors
#6. Matrices
#7. Export and save data

#####
# ---- What is the data?  ----
#Gene expression data -  published by Blackmore et al. (2017)
#The effect of upper-respiratory infection on transcriptomic changes in the CNS
#Mice were inoculated with saline or with Influenza A 
#Transcriptomic changes (RNA-seq) - evaluated at days 0 (non-infected), 4 and 8

#####
##set working directory 
getwd()
#setwd("/Users/michaellandi/Documents/BioCondWorshop/BioC-Intro")

#download data 
#url - https://github.com/carpentries-incubator/bioc-intro/raw/main/episodes/data/rnaseq.csv
download.file(url = "https://github.com/carpentries-incubator/bioc-intro/raw/main/episodes/data/rnaseq.csv",
              destfile = "data/rnaseq.csv")

## read data 
rna <- read.csv("data/rnaseq.csv")

#view the data on the console  
rna
#view the first six lines of the data frame
head(rna)
tail(rna)
head(rna,10)
# how does read.csv() read data - commas , try read.table 

rna1 <- read.table("data/rnaseq.csv",sep = ",",header = TRUE)

head(rna1)
#What are data frames? 
#data.frame: two dimensions, one type per column (vector).
class(rna)

##inspecting the structure of a dataframe
str(rna)

#size of the dataframe - dimension and number of rows and columns 
dim(rna)
#Names of rows and columns 
colnames(rna)
names(rna)
rownames(rna)

#Summary 
summary(rna)

#Content (snippet) - first 6 and last 6 line 


##### ---- Challenge 1 (all) ----
#Based on the output of str(rna), can you answer the following questions?
#1. What is the class of the object rna?
#2. How many rows and how many columns are in this object?

#####

#Indexing and subsetting data frames
# first element in the first column of the data frame
rna[1,1]
# first element in the 6th column
rna[1,6]
# first column of the data frame
rna[,1]
#another command - first column of the data frame 
rna[1]
#What is the difference? 
class(rna[1]) #outputs dataframe

class(rna[,1]) #vector 
rna[2,]

class(rna[2,])
# first three elements in the 7th column 
rna[1:3,7]

head(rna[7])

#
rna[1:10,7]

# equivalent to head(rna) using subsetting command
head(rna[7])

##You can also exclude certain indices of a data frame using the “-” sign
## The whole data frame, except the first column
rna[,-1]
head(rna[0,-1])

#number of row 
nrow(rna)
ncol(rna)
## Equivalent to head(rna) - where one removes from row number 7
rna[-(7:nrow(rna)),]

#Data frames can be subsetted by calling their column names directly:
#this can be achieved in different ways
#as a vector 
rna$gene
class(rna$gene)

#as a dataframe 
rna["gene"]
class(rna["gene"])
#### ---- Challenge 2 (class) ----
#1. Create a data.frame (rna_200) containing first 200 rows of the rna dataset.
#2. Use nrow() to extract the row that is in the middle of the rna dataframe. 
#Store the content of this row in an object named rna_middle.
#3. Combine nrow() with the - notation above to reproduce the behavior of head(rna), 
#keeping just the first through 6th rows of the rna dataset.

rna_200 <- rna[1:200,]

nrow(rna_200)

n_rows <- nrow(rna)

rna_middle <- rna[n_rows/2,]

rna_middle

rna[nrow(rna)/2,]



#Q3
rna[-(7:nrow(rna)),]

