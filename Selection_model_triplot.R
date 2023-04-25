# ordistep car accepte quanti et quali variables
# modèle nul

xrda<-rda(amphi.hel~ Condition(topo$aire +topo$profondeur), data=dat)

# selection forward
step.forward<-ordistep(xrda, scope = formula(prda), direction="forward", permutations = how(nperm=499))
RsquareAdj(step.forward)
step.forward$anova
  
final<-rda(amphi.hel~ cloture + poissons+ Condition(topo$aire +topo$profondeur), data=dat)
anova(final, permutations = how(nperm = 999)) 
anova(final, permutations = how(nperm = 999), by = "axis") 


# Triplot joli

perc <- round(100*(summary(final)$cont$importance[2, 1:2]), 2)

## extract scores - these are coordinates in the RDA space
sc_si <- scores(final, display="sites", choices=c(1,2))
ssc_sp <- scores(final, display="species", choices=c(1,2))
sc_bp <- scores(final, display="bp", choices=c(1, 2))



# Set up a blank plot with scaling, axes, and labels
plot(final,
     scaling = 1, # set scaling type 
     type = "none", # this excludes the plotting of any points from the results
     frame = T,
     # set axis limits
     ylim = c(-1.5,1.5), 
     xlim = c(-1.5,1.5),
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
legend()
```

