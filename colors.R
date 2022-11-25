box1.R
colors.R
library(rgeos)
library(sp)
library(rgdal)
library(mgcv)
library(rmatio)


data <- read.csv("burail.csv", header=FALSE, sep=",")
#data <- read.csv("btw.csv", header=FALSE, sep=",")
btw.lat=as.numeric(as.vector(data[1,-1]))
btw.lon=((data[-1,1]-180)%%360)-180
btw.value <- data[-1,]
btw.value <- as.matrix( btw.value[,-1])
regions <- readOGR(".", "Longhurst_world_v4_2010")
data(meuse)
dimnames <- list(lon=btw.lon,lat=btw.lat)
dimnames(btw.value) <-dimnames
tt <-as.data.frame(as.table(btw.value))
xy <- cbind(tt$lat,tt$lon)
df <- tt[,c(1,2)]
or <- tt["Freq"]
df[] <- lapply(df, function(x) {
  if(is.factor(x)) as.numeric(as.character(x)) else x
})
coords <- df
SPDF <- SpatialPointsDataFrame(coords=coords, data=or)
proj4string(regions) <- CRS(as.character(NA))
proj4string(SPDF) <-CRS(as.character(NA))
areas <- sapply(regions@polygons, function(x) x@area
)
regions@data <- cbind(regions@data, areas)



mapped<-cbind(SPDF@coords,SPDF@data,over( SPDF,regions))
rmean<-aggregate(mapped['Freq'], by=list(ProvCode=mapped$ProvCode),mean)
rsum<-aggregate(mapped['Freq'],by=list(ProvCode=mapped$ProvCode),sum)
rmedian<-aggregate(mapped['Freq'],by=list(ProvCode=mapped$ProvCode),median)
rcount<-aggregate(mapped, by=list(ProvCode=mapped$ProvCode),mean)

resultp <- over(x=regions,y=SPDF,fn=sum)

results <-regions@data;
results <- merge(results, rmean, by = "ProvCode")
results <- merge(results, rsum, by = "ProvCode")
results <- merge(results, rmedian, by = "ProvCode")
colnames(results)[colnames(results)=="Freq.x"] <- "mean"
colnames(results)[colnames(results)=="Freq.y"] <- "sum"
colnames(results)[colnames(results)=="Freq"] <- "median"

resultp <- over(x=regions,y=SPDF,fn=sum)

write.csv(file = "results.csv",results)

#write.csv(file = "zonedata2.csv",a)


#region_v <- result #* areas
#region_v[is.na(region_v)] <- 0
#region_v <- (region_v-min((region_v)))/(max((region_v)-min((region_v))))
#region_v <- region_v$Freq


#colormap = colorRampPalette(c("white","red","yellow","blue"))(128)
#colormap <- rainbow(6)
#colors <- sapply(region_v*6, function(x) 
#  if (x==0) {
#"#FFFFFF"
#  } else {
#  colormap[ceiling(x)]
#  #colormap[2]
#}
#)
  
#print(colors)
  #write.csv(file = "data.csv",cbind(regions@data$ProvCode,areas,result))
#colors<-sample(colors()[1:100],54)
#pdf('colorbar.pdf')
#pdf('default.pdf')
  #pdf('v1.pdf')
  #plot(regions,col = colors)
  #text(coordinates(regions), labels = regions@data$ProvCode,cex=0.5)
#color.bar(colorRampPalette(c("white","blue","red"))(54),0,1)
  #dev.off()


