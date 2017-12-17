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

# Construction des échantillons d'apprentissage et des échantillons de test
set.seed(111) # initialisation du générateur
# Extraction des échantillons
test.ratio=.2 # part de l'échantillon test
npop=nrow(dtt)
nvar=ncol(dtt) # nombre de colonnes
ntest=ceiling(npop*test.ratio)
# indices de l'échantillon test
testi=sample(1:npop,ntest)
# indices de l'échantillon d'apprentissage
appri=setdiff(1:npop,testi)
# construction de l'échantillon d'apprentissage
datapq=dtt[appri,]
# construction de l'échantillon test
datestq=data[testi,]
