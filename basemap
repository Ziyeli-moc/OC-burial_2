library(sp)
library(float)

color.bar <- function(lut, min, max=-min, nticks=11, ticks=seq(min, max, len=nticks), title='') {
  scale = (length(lut)-1)/(max-min)
  
  dev.new(width=1.75, height=5)
  plot(c(0,10), c(min,max), type='n', bty='n', xaxt='n', xlab='', yaxt='n', ylab='', main=title)
  axis(2, ticks, las=1)
  for (i in 1:(length(lut)-1)) {
    y = (i-1)/scale + min
    rect(0,y,10,y+1/scale, col=lut[i], border=NA)
  }
}

data <- read.csv("btw.csv", header=FALSE, sep=",")
btw.lat=as.numeric(as.vector(data[1,-1]))
btw.lon=data[-1,1]
btw.value <- data[-1,]
btw.value <- as.matrix( btw.value[,-1])
regions <- readOGR(".", "Longhurst_world_v4_2010")
data(meuse)
dimnames <- list(lon=btw.lon,lat=btw.lat)
dimnames(btw.value) <-dimnames
tt <-as.data.frame(as.table(btw.value))
xy <- cbind(tt$lat,tt$lon)
df <- tt[-1:-2]
SPDF <- SpatialPointsDataFrame(coords=xy, data=df)
proj4string(regions) <- CRS(as.character(NA))
proj4string(SPDF) <-CRS(as.character(NA))
result <- over(regions, SPDF,fn=mean)
areas <- sapply(regions@polygons, function(x) x@area
)

region_v <- result * areas
region_v[is.na(region_v)] <- 0

region_v <- (region_v-min((region_v)))/(max((region_v)-min((region_v))))
region_v <- region_v$Freq
colormap <- colorRampPalette(rainbow(10))(10)
colors <- colorRampPalette(rainbow(10))(54)[region_v*54]
#colors<-sample(colors()[1:152],54)
#pdf('colorbar.pdf')
pdf('v.pdf')
plot(regions,col = colors)
text(coordinates(regions), labels = regions@data$ProvCode,cex=0.5)
#color.bar(rainbow(10) ,0,1)
dev.off()
