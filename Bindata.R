box1.R
#0-0.125 0.125-0.375 0.375-0.625 0.625-0.875 0.875-1.125 1.125-1.375 1.375-1.625
df <- read.csv("site_MAR_all4.csv", header=TRUE, sep=",") ##读取源数据
box_l <-0.25
#df$box <- ceiling((df$age_ma)/box_l)
df$box <- floor((df$age_ma-box_l)/box_l)+1
sites = unique(df$Site);
df_all = merge(x=data.frame(age = c(0:48)),y=data.frame(site = sites),all = TRUE) 
df_g = aggregate(df$MAR_toc,by=list(df$box,df$Site),mean)
colnames(df_g) <- c("age","site","MAR_box")
df_all = merge(x=df_all,y=df_g,by=c("age","site"),all.x = TRUE)
df_all$age = df_all$age * box_l;
write.csv(file = "MAR_box_all.csv",df_all) ## 保存每个站点的数据
df_all_old <- df_all
df_all = subset(df_all,!is.na(df_all$MAR_box))
#0-0.125 0.125-0.375 0.375-0.625 0.625-0.875 0.875-1.125 1.125-1.375 1.375-1.625

# 站点平均
#df_all_mean = aggregate(df_all$MAR_box,by=list(df_all$age),mean)
#colnames(df_all_mean) <- c("age","MAR_box_mean")
#write.csv(file = "MAR_box_all_mean.csv",df_all_mean) ##保存均值

#0-0.25 0-0.5 0.25-0.75 0.5-1 0.75-1.25 1-1.5 1.25-1.75
df <- read.csv("site_MAR_all4.csv", header=TRUE, sep=",") ##读取源数据
box_l <-0.25
#df$box <- ceiling((df$age_ma)/box_l)
df$box <- floor((df$age_ma-box_l)/box_l)+1
df$box1 <- df$box+1
df <- melt(df, id = c("age_ma","MAR_toc","Site"))
df$box <- df$value
keeps <- c("age_ma", "MAR_toc","Site","box")
df <- df[keeps]
sites = unique(df$Site);
df_all = merge(x=data.frame(age = c(0:48)),y=data.frame(site = sites),all = TRUE) 
df_g = aggregate(df$MAR_toc,by=list(df$box,df$Site),mean)
colnames(df_g) <- c("age","site","MAR_box")
df_all = merge(x=df_all,y=df_g,by=c("age","site"),all.x = TRUE)
df_all$age = df_all$age * box_l;
write.csv(file = "MAR_box_all.csv",df_all) ## 保存每个站点的数据
df_all_old <- df_all
df_all = subset(df_all,!is.na(df_all$MAR_box))


#-0.5-0.5 0-1 0.5-1.5 1-2 1.5-2.5 
df <- read.csv("site_MAR_all4.csv", header=TRUE, sep=",") ##读取源数据
box_l <-0.5
#df$box <- ceiling((df$age_ma)/box_l)
df$box <- floor((df$age_ma-box_l)/box_l)+1
df$box1 <- df$box+1
df <- melt(df, id = c("age_ma","MAR_toc","Site"))
df$box <- df$value
keeps <- c("age_ma", "MAR_toc","Site","box")
df <- df[keeps]
sites = unique(df$Site);
df_all = merge(x=data.frame(age = c(0:48)),y=data.frame(site = sites),all = TRUE) 
df_g = aggregate(df$MAR_toc,by=list(df$box,df$Site),mean)
colnames(df_g) <- c("age","site","MAR_box")
df_all = merge(x=df_all,y=df_g,by=c("age","site"),all.x = TRUE)
df_all$age = df_all$age * box_l;
write.csv(file = "MAR_box_all.csv",df_all) ## 保存每个站点的数据
df_all_old <- df_all
df_all = subset(df_all,!is.na(df_all$MAR_box))


#-1 -1.5-0.5

# 0 -1-1



#-1.5-0.5（none）  -1-1 -0.5-1.5 0-2 0.5-2.5 
library('reshape2')
df <- read.csv("site_MAR_all4.csv", header=TRUE, sep=",") ##读取源数据
box_l <-0.5
#df$box <- ceiling((df$age_ma)/box_l)
df$box <- floor((df$age_ma-box_l*2)/box_l)+1
df$box1 <- df$box+1
df$box2 <- df$box1+1
df$box3 <- df$box2+1


df <- melt(df, id = c("age_ma","MAR_toc","Site"))


df$box <- df$value

keeps <- c("age_ma", "MAR_toc","Site","box")
df <- df[keeps]
sites = unique(df$Site);


df_all = merge(x=data.frame(age = c(0:48)),y=data.frame(site = sites),all = TRUE) 



df_g = aggregate(df$MAR_toc,by=list(df$box,df$Site),mean)



colnames(df_g) <- c("age","site","MAR_box")


df_all = merge(x=df_all,y=df_g,by=c("age","site"),all.x = TRUE)


df_all$age = df_all$age * box_l;


write.csv(file = "MAR_box_all.csv",df_all) ## 保存每个站点的数据
df_all_old <- df_all
df_all = subset(df_all,!is.na(df_all$MAR_box))