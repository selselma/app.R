library(randomForest)
data<-read.csv(file= paste0(dataLung), sep=";")
#creation de la base de travail
#netoyer la base
library(dplyr)
summary(data)
dtt = data[,c("source.location","characteristics.tag.gender",
                "characteristics.tag.histology",
                "characteristics.tag.tumor.size.maximumdiameter",
                "characteristics.tag.stage.primary.tumor",
                "characteristics.tag.stage.nodes",
                "characteristics.tag.stage.mets",
                "characteristics.tag.grade")]

# Construction des �chantillons d'apprentissage et des �chantillons de test
set.seed(111) # initialisation du g�n�rateur
# Extraction des �chantillons
test.ratio=.2 # part de l'�chantillon test
npop=nrow(dtt)
nvar=ncol(dtt) # nombre de colonnes
ntest=ceiling(npop*test.ratio)
# indices de l'�chantillon test
testi=sample(1:npop,ntest)
# indices de l'�chantillon d'apprentissage
appri=setdiff(1:npop,testi)
# construction de l'�chantillon d'apprentissage
datapq=dtt[appri,]
# construction de l'�chantillon test
datestq=data[testi,]