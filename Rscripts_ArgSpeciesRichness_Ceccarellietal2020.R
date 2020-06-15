#####################################################
## Functions to generate species richness patterns ##
#####################################################

# Load packages
library(letsR)
library(maptools)

# Set your working directory (dir)
setwd(dir)

#World shapefile
data(wrld_simpl)

# ARGENTINA SHAPEFILE
arg_map <- wrld_simpl[wrld_simpl$NAME=="Argentina",]

#######################################################################################################
## Functions to import spatial data, create presence-absence matrices and calculate species richness ##
#######################################################################################################
#Load your spatial data

####Points####
#get the data (as a table, not as a shapefile)

puntos.table.total <- read.dbf("SpsoloArg-Total.dbf")
puntos.table.pre <- read.dbf("SpsoloArg-pre2000.dbf")
puntos.table.post <- read.dbf("SpsoloArg-post2000.dbf")

#create the PAM (presenceAbsence object)

puntos.table.total.pam025 <- lets.presab.points(puntos.table.total[,1:2],puntos.table.total[,3],
                                              xmn = -75, xmx = -50, ymn = -60, ymx = 20, 
                                              resol = 0.25, remove.cells = FALSE)

puntos.table.pre.pam025 <- lets.presab.points(puntos.table.pre[,1:2],puntos.table.pre[,3],
                                              xmn = -75, xmx = -50, ymn = -60, ymx = 20, 
                                              resol = 0.25, remove.cells = FALSE)

puntos.table.pos.pam025 <- lets.presab.points(puntos.table.post[,1:2],puntos.table.pos[,3],
                                              xmn = -75, xmx = -50, ymn = -60, ymx = 20, 
                                              resol = 0.25, remove.cells = FALSE)


# Plotting the geographic pattern of species richness

x11()
plot(puntos.table.total.pam025, world = FALSE, axes = FALSE, 
     box = FALSE, col_rich = matlab.like2, 
     main = "Argentinean Triatomine Species Richness 0.25", xlim= c(-75,-50), ylim= c(-60,20))
plot(arg_map, add=TRUE, border='dark grey')

x11()
plot(puntos.table.pre.pam025, world = FALSE, axes = FALSE, 
     box = FALSE, col_rich = matlab.like2, 
     main = "Argentinean Triatomine Species Richness 0.25 Pre-2000", xlim= c(-75,-50), ylim= c(-60,20))
plot(arg_map, add=TRUE, border='dark grey')

x11()
plot(puntos.table.post.pam025, world = FALSE, axes = FALSE, 
     box = FALSE, col_rich = matlab.like2, 
     main = "Argentinean Triatomine Species Richness 0.25 Post2000", xlim= c(-75,-50), ylim= c(-60,20))
plot(arg_map, add=TRUE, border='dark grey')

writeRaster(puntos.table.total.pam025$Richness_Raster, 'sp_richness025_total', format= "GTiff", overwrite=TRUE)
writeRaster(puntos.table.pre.pam025$Richness_Raster, 'sp_richness025_pre', format= "GTiff", overwrite=TRUE)
writeRaster(puntos.table.post.pam025$Richness_Raster, 'sp_richness025_post', format= "GTiff", overwrite=TRUE)
