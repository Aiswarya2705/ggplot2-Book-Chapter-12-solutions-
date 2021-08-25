#plot functions 
# 12.4.3 Exercises

library(ggplot2)
library(RColorBrewer)

# 1. distribution() for continuous distributions
#choose between histograms , frequency polygons, density plots

?geom_histogram
distribution<-function(geom='',var='',...) {
  if (geom=='histogram'){
    #bins=as.integer(readline(prompt = 'Enter the bin value:'))
    geom_histogram(color='steelblue',fill='cadetblue1',...)
    #geom_vline(aes(xintercept=colMeans(var, na.rm = TRUE)),
    #linetype='dashed',na.rm = TRUE,size=0.6)
    
  }
  else if (geom=='freqpoly') {
    bins=as.integer(readline(prompt = 'Enter the bin value:'))
    geom_freqpoly(stat='bin',bins=bins,color='blueviolet',...)
  }
  
  else if(geom=='density') {
    geom_density(colour='azure3',fill='antiquewhite',...)
  }
}
ggplot(diamonds,aes(price))+distribution(geom='histogram',var='price',bins=10)
ggplot(diamonds,aes(carat))+distribution(geom='freqpoly',var='carat')
ggplot(diamonds,aes(carat))+distribution(geom='density',var='carat')


#2.What additional arguments should pcp() take? What are the downsides of
#how ... is used in the current code?

pcp_data<-function(df){
  is_numeric<-vapply(df,is.numeric,logical(1))
  rescale01<-function(x){
    rng<-range(x,na.r=TRUE)
    (x-rng[1])/(rng[2]-rng[1])
  }
  df[is_numeric]<-lapply(df[is_numeric],rescale01)
  df$.row<-rownames(df)
  tidyr::gather_(df,'variable','value',names(df)[is_numeric])
}
pcp<-function(df,alpha,points,...){
  df<-pcp_data(df)
  if (points=='yes'){
    ggplot(df,aes(variable, 
                  value,
                  group=.row))+
      geom_line(alpha=alpha,...)+geom_point(alpha=0.5,...)  
  }
  else if(points=='no'){
    ggplot(df,aes(variable, 
                  value,
                  group=.row))+
      geom_line(alpha=alpha,...)
    
  }
}
pcp(mpg,alpha=0.6,points='no',color='coral2')
pcp(mpg,alpha=0.3,points='yes',aes(colour=class),show.legend=FALSE)+
  scale_color_brewer(palette='Spectral')
# we have used ... in the function def as well as with geom_line and geom_point
# what if we pass an arg to the main func def ,wanting to use it with geom_line only
#That is not possible ,since we have mentioned ... with geom_line as well as with geom_point
# a choice is not there

piechart<-function(data,mapping){  # pie chart is a stacked bar chart in polar coordinates 
  ggplot(data,mapping)+ #aesthetic mappings
    geom_bar(width = 1)+
    coord_polar(theta ='y' )+ #map angle to y
    xlab(NULL)+
    ylab(NULL)
}
piechart1<-function(data,var,...){
  piechart(data,aes_(~factor(1),fill=as.name(var)))
}
piechart1(mpg,'class')+#as a string
  theme(legend.position = 'none')
piechart1(mpg,'drv')#+theme(legend.position = 'none')

piechart2<-function(data,var,...){
  piechart(data,aes_(~factor(1),fill=var))
}
piechart2(mpg,~class)+# as a formula
  theme(legend.position = 'none')

piechart3<-function(data,var,...){
  piechart(data,aes_(~factor(1),fill=substitute(var)))
}
piechart3(mpg,class) + # bare expression
  theme(legend.position = 'none')

#3.why doesn't this code work? How can you fix it?
#f <- function() {
#  levs <- c("2seater", "compact", "midsize", "minivan", "pickup", 
#            "subcompact", "suv")
#  piechart3(mpg, factor(class, levels = levs))
#}
#f()
#> Error in factor(class, levels = levs): object 'levs' not found
#Ans (with help from @Ankitha Topson)
levs <- c("2seater", "compact", "midsize", "minivan", "pickup",
          "subcompact", "suv")
f <- function(levs) {
  piechart3(mpg, factor(class, levels = levs))
  
}
f()
#or
f <- function() {
  piechart3(mpg, factor(class, levels = levs))
}
f()
#or
f <- function() {
  list(levs,
       piechart3(mpg, factor(class, levels = levs)))
}
f()

