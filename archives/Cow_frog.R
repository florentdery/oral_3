library(ggplot2)
library(data.table)
library(vegan)

data<-read.table("jeu_données.txt", header=T)

# Assemblages de communautés (Y) en fonction de la présence de vaches (X)
# Nos X : cloture (binaire), vache (intensité)
# Nos Y : espèces, paramètres chimiques étangs
names(data)


# # Données aberrantes en X et en Y ---------------------------------------

## --> vache : quantité de bouse retrouvée autour de chaque étang contrôlée
## pour la taille de chaque étang

range(data$vache) # [0-0.575]
hist(data$vache, breaks = 30)
plot(data$vache) # pas tellement de valeurs aberrantes
boxplot(data$vache) # 1 outlier

## --> cloture : binaire, étang : ID

## --> profondeur, conductivité, nitrates, oxygène, pH, temperature, aire
TopoChimie<-data[ , c(4:10)]
par(mfrow=c(3,3))
par(mar=c(1,1,1,1))
for(i in 1:ncol(TopoChimie)) {
  boxplot(TopoChimie[,i], main=names(TopoChimie)[i])
}

## outliers : conductivité, température, oxygène, aire
for(i in 1:ncol(TopoChimie)) {
  hist(TopoChimie[,i], main=names(TopoChimie)[i], breaks=30)
}

## à virer : données négatives pour l'oxygène, x2, je garderais le reste
range(data$temperature)
range(data$oxygene)
range(data$conductivite)
range(data$aire)


## --> animaux 
living<-data[ , c(11:22)]
par(mfrow=c(3,4))
par(mar=c(1,1,1,1))

for(i in 1:ncol(living)) {
  boxplot(living[,i], main=names(living)[i])
}

## invertébrés, poissons et écrevisses ok mais outliers dans tous les amphibiens

for(i in 1:ncol(living)) {
  hist(living[,i], main=names(living)[i], breaks=30)
}

## soit beaucoup de zéros, soit peu de données + beaucoup de zéros
 

# Homogénéité de la variance des Y  -------------------------------------



# Normalité des résidus des Y -------------------------------------------


# Des zéros étranges?------ ---------------------------------------------

## check %tage de zéro nb de zero/nb lines

sum(data$A_Gr ==0)/nrow(data) # 0.90%
sum(data$G_Ca ==0)/nrow(data) # 0.55
sum(data$S_La ==0)/nrow(data) # 0.675
sum(data$H_Ci ==0)/nrow(data) # 0.60
sum(data$H_Fe ==0)/nrow(data) # 0.95
sum(data$H_Sq ==0)/nrow(data) # 0.425
sum(data$L_Gr ==0)/nrow(data) # 0.70
sum(data$L_Sp ==0)/nrow(data) # 0.60
sum(data$N_Vi ==0)/nrow(data) # 0.95


## How to deal with zeros?

amphibiens<-data[ , c(14:22)]
binaire <- decostand(amphibiens, method = "pa") 
# on peut faire une analyse de composition : richesse spécifique

# bubble plot des abondances d'amphibiens
ggplot(amphibiens, aes(x=A_Gr, y=lifeExp, size = pop)) +
  geom_point(alpha=0.7)

nopoop<-subset(data, vache ==0)
nopoop<-nopoop[, c(3:22)]
poop<- subset(data, vache!=0)
poop<- poop[, c(3:22)]

NoPoop<-rda(nopoop, scale=T)
Poop<-rda(poop, scale=T)
par(mfrow = c(1, 2))
biplot(NoPoop, scaling = 1, main = "PCA - scaling 1") 
biplot(NoPoop, main = "PCA - scaling 2") # Default scaling 2
biplot(Poop, scaling = 1, main = "PCA - scaling 1") 
biplot(Poop, main = "PCA - scaling 2") # Default scaling 2







# Prelim Flo:

dat2=dat

rownames(dat2) <- dat2$etang

dat2=dat2 %>%
  arrange(etang) %>% 
  select(A_Gr:N_Vi)

dat2 %>% range()

sum(dat2==0) #254 absences 
sum(dat2>0) #106 presences
sum(dat2==0)/(nrow(dat2)*ncol(dat2))# 70% zeros

#number of sites with occurences of a given species 

 <- apply(dat2 > 0, 2, sum)
# Sort the results in increasing order
sort(spe.pres)

spe.relf <- 100*spe.pres/nrow(dat2)
# Round the sorted output to 1 digit
round(sort(spe.relf), 1)


par(mfrow=c(1,2))


# 3 espèces sont présentes dans 0 à 5 sites
hist(spe.pres, main="Species Occurrences", right=FALSE, las=1, 
     xlab="Number of occurrences", ylab="Number of species", 
     breaks=seq(0,30,by=5), col="bisque") 
# 3 espèces sont présentes dans 0 à 5 sites ^^ (p. ex)
hist(spe.relf, main="Species Relative Frequencies", right=FALSE, las=1,
     xlab="Frequency of occurrences (%)", ylab="Number of species",
     breaks=seq(0, 100, by=5), col="bisque")

# To sum by rows, the second argument of apply(), MARGIN, is set to 1
sit.pres <- apply(dat2> 0, 1, sum)
# Sort the results in increasing order
sort(sit.pres)

# Plot species richness vs. position of the sites along the river
plot(sit.pres,type="s", las=1, col="gray",
     main="Species richness across sites",
     xlab="site number", ylab="Species richness")
text(jitter(sit.pres, factor=1, amount=.1), row.names(dat2), cex=.8, col="red")
















