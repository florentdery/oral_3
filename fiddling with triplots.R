require(tidyverse)
dat=read.delim("data/jeu_ecologique.txt") %>% 
  mutate(etang=as.factor(as.character(etang)),
         cloture=factor(cloture)) %>% 
  rename(vache_std=vache) %>% 
  arrange(aire) 
glimpse(dat)
library("vegan")
#library(adespatial)
#A-  Faire une matrice de distance Hellinger

# Alternate, two-step computation in vegan: 
amphi.hel= dat%>% 
  subset(oxygene>0) %>% 
  # on enlève les sites avec l'oxygène à 0 ^^
  select(A_Gr:N_Vi) %>% 
  decostand("hellinger")
rownames(amphi.hel) <- subset(dat, oxygene>0)$etang
# On change le nom des lignes pour se retrouver plus tard ^^

## B- On standardise les covariables.
# Co-variables
topo=dat %>% 
  subset(oxygene>0) %>% 
  select(aire, profondeur) %>% 
  decostand("standardize")

rownames(topo) <- subset(dat, oxygene>0)$etang
# On change le nom des lignes pour se retrouver plus tard ^^

## On prépare les variables.

env=dat %>% 
  select( vache_std, conductivite:temperature, invertebres:poissons) %>%
  select(-pH) %>% # on enlève ceci. pas assez fiable. 
  subset(oxygene>0) %>% # erreurs de mesure. pas assez fiable.
  decostand("standardize") %>% 
  mutate(cloture=dat[dat$oxygene>0,]$cloture) %>% data.frame()
# on rattache la variable cloture, qui n'est pas standardisée (catégorique)^^
rownames(env) <- subset(dat, oxygene>0)$etang
# On change le nom des lignes pour se retrouver plus tard ^^
glimpse(env)

# On lance la RDA
(prda=rda(amphi.hel~ . + Condition(topo$aire +topo$profondeur), env) )

source("triplot.rda.R")

# ajouter ellipse autour des sites avec cloture, 
# souligner les 4 variables sorties de notre modèle. 

# plot(prda,
#      scaling = 1,
#      display = c("sp", "lc", "cn"),
#      main = "Triplot RDA - scaling 1 - lc scores"
# )
# spe.sc1 <-
#   scores(prda,
#          choices = 1:2,
#          scaling = 1,
#          display = "sp"
#   )
# arrows(0, 0,
#        spe.sc1[, 1] * 0.92,
#        spe.sc1[, 2] * 0.92,
#        length = 0,
#        lty = 1,
#        col = "red"
# )


#ordiplot(prda, scaling=1, type="text", display = c("lc", "sp", "cn", "bp"))
# triplot.rda(prda, scaling=2, 
#             move.origin=c(0, 0), 
#             mar.percent=0.05,
#             silent=T,site.sc = "lc", optimum = T)

# Triplot joli

perc <- round(100*(summary(prda)$cont$importance[2, 1:2]), 2)

#compare lc, sites scores scaling 1. from 
# eig.val = prda$CCA$eig        # Eigenvalues of Y-hat
# Lambda = diag(eig.val)           # Diagonal matrix of eigenvalues
# n = nrow(prda$CCA$u)          # Number of observations
# Z.sc2 = prda$CCA$u*sqrt(n-1)  # "lc" site scores, scaling=2
# (Z.sc1 = Z.sc2 %*% Lambda^(0.5))   # "lc" site scores, scaling=1
# cbind((sc_sp <- scores(prda, display="sp", choices=c(1,2),correlation=T)),
#       (sc_spbad <- scores(prda, display="sp", choices=c(1,2), correlation = T)))
# 
# cbind((sc_sp <- scores(prda, display="sp", choices=c(1,2),  scaling = 2)),
#       (sc_spbad <- scores(prda, display="sp", choices=c(1,2), scaling = 2)))


## extract scores - these are coordinates in the RDA space
sc_si <- scores(prda, display="lc", choices=c(1,2), scaling = 1)
sc_cn <- scores(prda, display="cn", choices=c(1, 2),  scaling = 2)
sc_bp <- scores(prda, display="bp", choices=c(1, 2),  scaling = 2)
sc_sp <- scores(prda, display="sp", choices=c(1,2),  scaling = 2)

# Set up a blank plot with scaling, axes, and labels

par(mfrow=c(2,1))

triplot.rda(prda, scaling=1, 
            # move.origin=c(0, 0), 
            # mar.percent=0,
            # optimum = T,
            silent=T, site.sc = "lc",
            col.centr = "blue")

plot(prda,
     scaling = 1, # set scaling type 
     type = "none", # this excludes the plotting of any points from the results
     frame = T,
     # set axis limits
     ylim = c(-0.83,.65),
     xlim = c(-2,2),
     # label the plot (title, and axes)
     main = "Triplot RDA - scaling 1",
     xlab = paste0("RDA1 (", perc[1], "%)"), 
     ylab = paste0("RDA2 (", perc[2], "%)") , 
     bty="o"
)

# add points for site scores
points(sc_si, 
       pch = 21, # set shape (here, circle with a fill colour)
       col = "black", # outline colour
       bg = "lightgreen", # fill colour
       cex = 1.2) # size

points(sc_si[c("48","90", "126", "150", "209"), ], 
       pch = 21, # set shape (here, circle with a fill colour)
       col = "black", # outline colour
       bg = "darkgreen", # fill colour
       cex = 1.2) # size


# add points for species scores
points(sc_sp, 
       pch = 24, # set shape (here, square with a fill colour)
       col = "orange",
       bg = "orange", 
       cex = 1.2)
# add text labels for species abbreviations
text(sc_sp + c(0.03, 0.09), # adjust text coordinates to avoid overlap with points 
     labels = rownames(sc_sp), 
     col = "orange", 
     font = 2, # bold
     cex = 1)
# add arrows for effects of the expanatory variables
arrows(0,0, # start them from (0,0)
       sc_bp[,1], sc_bp[,2], # end them at the score value
       col = "red", 
       lwd = 1)
# add text labels for arrows
text(x = sc_bp[,1] -0.1, # adjust text coordinate to avoid overlap with arrow tip
     y = sc_bp[,2] - 0.03, 
     labels = rownames(sc_bp), 
     col = "red", 
     cex = 0.9, 
     font = 1)


