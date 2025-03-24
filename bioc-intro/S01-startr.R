1 + 11

## Variables

x <- 2 * 123

x

y <- 2

weight_kg <- 67


2 * weight_kg

weight_kg <- 2 * weight_kg

2 * x

2 * k

k

## Exercice

mass <- 47.5            # mass?
age <- 122             # age?
mass <- mass * 2.0      # mass?
age  <- age - 20        # age?
mass_index <- mass / age  # mass_index?

age < - 122

## Functions

ls() 

round(3.14)

?round

round(3.14, digits = 1)

k <- round(3.14, 1)
k

## Vectors


weight_g <- c(60, 50, 65, 82)

length(weight_g)
class(weight_g)


molecules <- c("dna", "rna", "protein")
molecules
length(molecules)
class(molecules)

c(20, weight_g)

lw <- 
  length(  
    c( 20, weight_g, 100 )  
    )

class(c(20, weight_g, 100))


10

molecules

class("1")

c(1, 2)

c("1", "2")

c("1", 2)

as.numeric("1")

as.numeric("a")

TRUE
FALSE

length(c(TRUE, FALSE))
class(c(TRUE, FALSE))

## Ex

num_char <- c(1, 2, 3, "a")
num_char
class(num_char)

num_logical <- c(1, 2, 3, TRUE, FALSE)
num_logical
class(num_logical)

char_logical <- c("a", "b", "c", TRUE)
char_logical
class(char_logical)

tricky <- c(1, 2, 3, "4")
tricky

ls()
rm(molecuels)
ls()

## Subsetting

molecules <- c("dna", "rna", 
               "protein", "metabolite")


molecules

molecules[c(1, 2)]

## Ex: dna protein

molecules[c(1, 3)]

## Ex: protein dna 

molecules[c(3, 1)]

## Ex: dna dna dna 

molecules[c(1, 1, 1)]

## Ex: dna rna metabolite

molecules[c(1, 2, 4)]

molecules[-3]

weight_g
weight_g[c(1, 3)]


weight_g[c(TRUE, FALSE, TRUE, FALSE)]

weight_g > 62

weight_g[weight_g > 62]

## weights > 66 or < 61

weight_g > 66
weight_g < 61

weight_g[weight_g < 61 | weight_g > 66]

## weights > 66 and < 61

weight_g > 66
weight_g < 61

weight_g[weight_g > 66 & weight_g < 61]


molecules[molecules == "dna" | molecules == "rna"]

nucl <- c("dna", "rna", "rrna", "mrna", 
          "trna", "lnrna")

molecules[molecules %in% nucl]


## Names

weight_g
names(weight_g)

names(weight_g) <- c("Fab", 
                     "Maria",
                     "Zedias", 
                     "Laurent")

weight_g

weight_g[c("Fab", "Zedias")]

## Ex: extract Maria's and Laurent's weights

weight_g[c("Maria", "Laurent")]

weight_g[c(2, 4)]


c(10, 1, NA)


mean(c(10, 11, 12))

mean(c(10, 11, 12, NA))

mean(c(10, 11, 12, NA), na.rm = TRUE)




















