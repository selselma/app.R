#Package à utiliser 
library(packHV)
library(epiDisplay)
library(survival)

#Importer les données patients### 
dataLung <-file.choose()

#lecture de la table dataLung
datap <- read.csv(file = paste0(dataLung), sep=";")

#Choisir les variables les plus pertinentes 
dttp = datap[,c("source.location","characteristics.tag.gender",
                "characteristics.tag.histology",
                "characteristics.tag.tumor.size.maximumdiameter",
                "characteristics.tag.stage.primary.tumor",
                "characteristics.tag.stage.nodes",
                "characteristics.tag.stage.mets",
                "characteristics.tag.grade")]

# Renommer les variables 
names(dttp) <- c("Localisation","Gender","characteristics.histology",
                 "tumor.size","stage.primary.tumor","stage.nodes",
                  "primaryVSmets","grade")

#Analyse descriptive

# 1-Localisation: Variable qualitative
summary(dttp$Localisation)
pie(table(dttp$Localisation))

# 2-Gender : variable qualitative
summary(dttp$Gender)
plot(dttp$Gender,main="Gender",col="pink")

# 3- Characteristics.histology: Variable qualitative
#Regrouper les moins exprimés en categorie "autres"
summary(dttp$characteristics.histology)
levels(dttp$characteristics.histology)<-c("autres", "autres", "autres", 
                                          "Adenocarcinoma, Bronchiolo-alveolar Features", 
                                          "autres","autres", "Adenocarcinoma, NOS",
                                          "Adenocarcinoma, Papillary, NOS", "autres",
                                          "Non-Small Cell", "autres","autres","autres",
                                          "Squamous Cell Carcinoma, NOS","autres", "autres",
                                          "autres")
levels(dttp$characteristics.histology)
summary(dttp$characteristics.histology)
plot(dttp$characteristics.histology,main="characteristics.tag.histology",col="green")

# 4Tumor size : variable quantitative
library(prettyR)
table(dttp$tumor.size)
describe(table(dttp$tumor.size))

# 5- Stage.primary.tumor: variable 
# Recodage de la variable stage.primary.tumor pour grouper les sous categories
        #Stage de la tumeur
levels(dttp$stage.primary.tumor)<-c("pT1","pT1","pT1","pT2","pT2","pT2",
                                    "pT2","pT3","pT4","pTx", "pTx")
levels(dttp$stage.primary.tumor)
table(dttp$stage.primary.tumor)
pie(table(dttp$stage.primary.tumor))

# 6-stage.nodes: variable qualitative
summary(dttp$characteristics.tag.stage.nodes)
plot(dttp$characteristics.tag.stage.nodes,main="characteristics.tag.stage.nodes",col="blue")

# 7-Stage.mets : variable qualitative
summary(dttp$characteristics.tag.stage.mets)
plot(dttp$characteristics.tag.stage.mets,main="characteristics.tag.stage.mets",col="magenta")

#8- characteristics.tag.grade: variable qualitative 
summary(dttp$characteristics.tag.grade)
plot(dttp$characteristics.tag.grade,main="characteristics.tag.grade",col="red")
