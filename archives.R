
# l1=function () {
# par(
#   mfrow=c(1,3),
#     mar=c(1,1,1,1)
#   )
# for(i in 1:3) {
#   hist(amphi[,i], main=names(amphi)[i], breaks=30)
# }
# }
# 
# l2=function () {
# par(
#   mfrow=c(1,3),
#     mar=c(2,1,1,1)
#   )
# for(i in 1:3) {
#   boxplot(amphi[,i], main=NULL, horizontal=T)
# }
# }
# 
# line1=plot_grid(ggdraw(l1) , ggdraw(l2), ncol=1, rel_heights = c(.7 , .3))
# l3=function () {
# par(
#   mfrow=c(1,3),
#     mar=c(1,1,1,1)
#   )
# for(i in 4:6) {
#   hist(amphi[,i], main=names(amphi)[i], breaks=30)
# }
# }
# 
# l4=function () {
# par(
#   mfrow=c(1,3),
#     mar=c(2,1,1,1)
#   )
# for(i in 4:6) {
#   boxplot(amphi[,i], main=NULL, horizontal=T)
# }
# }
# 
# line2=plot_grid(ggdraw(l3) , ggdraw(l4), ncol=1, rel_heights = c(.7 , .3))
# 
# l5=function () {
# par(
#   mfrow=c(1,3),
#     mar=c(1,1,1,1)
#   )
# for(i in 7:9) {
#   hist(amphi[,i], main=names(amphi)[i], breaks=30)
# }
# }
# 
# l6=function () {
# par(
#   mfrow=c(1,3),
#     mar=c(2,1,1,1)
#   )
# for(i in 7:9) {
#   boxplot(amphi[,i], main=NULL, horizontal=T)
# }
# }
# 
# line3=plot_grid(ggdraw(l5) , ggdraw(l6), ncol=1, rel_heights = c(.7 , .3))
# plot_grid(line1, 
#           line2,
#           line3, ncol=1)
# 
# rm(l1,l2, l3, l4, l5,l6,
#    line1, 
#    line2, 
#    line3)


Les données d'abondances sont loins d'être *Gaussienne*. Les RDAs sont des tests non-paramétriques, donc elles conviennent très bien aux données d'abondance que nous avons. À l'inverse, une MANOVA exige une distribution normale multivariée. 

On a aussi décidé de faire une RDA partielle car on a des covariables (profondeur et aire) qui ne nous intéressent pas mais qui vont influencer les relations entre les autres variables. 

La RDA est un test statistique basé sur des permutations, ce qui nous permet d'étudier le lien entre une matrice de variables réponse et une matrice de variables expplicative. Les analyses non-contraintes (p. ex. une PCA) sont seulement descriptives: on ne test pas des liens de cause à effet.


### Selection forward de variables

En faisant la selection **forward** de la RDA partielle, ces variables sont celles qui ressortent: 
```{r, echo=F, eval=T, message=FALSE, results="hide", warning=FALSE}
# The one that runs #
xrda<-rda(amphi.hel~ Condition(topo$aire +topo$profondeur), data=env) # modèle nul
set.seed(1)
step.forward<-ordistep(xrda, scope = formula(prda), direction="forward", permutations = how(nperm=499))
## list(nitrates, temperature, poissons, cloture, topo$aire, topo$profondeur)
```
```{r, echo=T, eval=F, message=FALSE, warning=FALSE}
step.forward<-ordistep(xrda, scope = formula(prda), direction="forward", permutations = how(nperm=499))

## list(poissons, cloture, topo$aire, topo$profondeur)
```
Avec un R² ajusté de 
```{r, echo=F, eval=T}
RsquareAdj(step.forward)$adj.r.squared
```
et le test de permutations sur les variables ajoutées à l'air de ceci:
  ```{r, echo=F, eval=T}
step.forward$anova
```



## - à compléter ! Modèle parcimonieux 
On prend le backward ou le forward ? On choisit d'inclure les variables issues du backward selection ? <br>
On lance la RDA partielle pour le modèle parcimonieux. 

```{r RDA.parci_launched, message=FALSE, echo=T, eval=F}
#require(vegan)

(rda.parci=rda(amphi.hel~ cloture + poissons + Condition(topo$aire +topo$profondeur), env) )
(R2adj.parci <- round(RsquareAdj(rda.parci)$adj.r.squared, dig=3))

set.seed(1)
anova(rda.parci, permutations = how(nperm = 999))
anova(rda.parci, by="axis", permutations = how(nperm = 999))
anova(rda.parci, by="term", permutations = how(nperm = 999))
vif.cca(rda.parci)

#source("triplot.rda.R")

par(mfrow=c(1,3), 
    mar=c(4,2,1,1))
triplot.rda(rda.parci, scaling=1, 
            move.origin=c(0, 0), 
            mar.percent=0.05,
            silent=T)
triplot.rda(rda.parci, scaling=2, 
            move.origin=c(0, 0), 
            mar.percent=0.05,
            silent=T)
```

## - à compléter. triplot super cool qui donne pas la meme chose qu'avec triplot.rda().

```{r, echo=FALSE, eval=F}

# Triplot joli

perc <- round(100*(summary(rda.parci)$cont$importance[2, 1:2]), 2)

## extract scores - these are coordinates in the RDA space
sc_si <- scores(rda.parci, display=c("lc"), choices=c(1,2))
sc_sp <- scores(rda.parci, display="sp", choices=c(1,2))
sc_bp <- scores(rda.parci, display="cn", choices=c(1, 2))


par(mfrow=c(1,2), 
    mar=c(4,2,1,1))
triplot.rda(rda.parci, scaling=1, 
            #move.origin=c(0, 0), 
            #mar.percent=0.05,
            silent=T)
triplot.rda(rda.parci, scaling=2, 
            move.origin=c(0, 0), 
            mar.percent=0.05,
            silent=T)
# Set up a blank plot with scaling, axes, and labels
plot(rda.parci,
     scaling = 1, # set scaling type 
     type = "none", # this excludes the plotting of any points from the results
     frame = T,
     # set axis limits
     # ylim = c(-1,1),
     # xlim = c(-.6,.6),
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

```

