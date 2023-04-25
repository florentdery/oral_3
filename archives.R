
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