#Mutiple components - Exercises
library(ggplot2)
library(RColorBrewer)
library(wesanderson)

#12.3.4 Exercises
#1. Function to hide axis labels and legends
noleg_axes<-function(){
  list(theme(legend.position='none'),
       theme(axis.title.x=element_blank(),axis.title.y=element_blank()))
}
#without the function
ggplot(iris,aes(Species,Sepal.Length))+
  geom_boxplot(aes(fill=Species))+
  scale_fill_manual(values=wes_palette('Moonrise2'))
#with the function
ggplot(iris,aes(Species,Sepal.Length))+
  geom_boxplot(aes(fill=Species))+
  noleg_axes()+
  scale_fill_manual(values=wes_palette('Moonrise2'))

#2. Extend the borders() function to also add coord_quickmap() to the plot

?coord_quickmap#puts the plot into the right proportion
borders<-function(database='world',regions='.',fill=NA,
                  colour='grey70',...){
  df<-map_data(database,regions)
  geom_polygon(
    aes_(~lat,~long,group=~group),
    data=df,fill=fill,colour=colour,...,
    inherit.aes = FALSE,show.legend = FALSE
  )
  coord_quickmap()
}
#data(package="maps")
#ggplot()+borders()
#for 
nz <- map_data("nz")
#View(nz)
ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")+borders()

#NOTE :when you comment out borders() , you get the plot wider(acc to cartesian coordinates)
# and when you use borders , you get the plot in the right proportion(w.r.t earth) with 
#coord_quickmap(),which uses mercator projection by default

#obs - when you comment out coord_quickmap() in borders() and run the above piece of code ,
# then you get the plot for the world data from borders() (acc to inherit.aes=FALSE)
# so maybe coord_quickmap negates(or nullify) the inherit,aes=FALSE

#for world data 
df<-map_data('world')
ggplot(df, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "pink", colour = "white")+borders()

#3. Look through your own code. What combinations of geoms or scales do
# you use all the time? How could you extract the pattern into a reusable
# function?
?geom_bar
vignette("ggplot2-specs")

usual<-function(){
  list(geom_point(alpha=0.6,size=3,shape='circle',colour='orchid'),
       scale_fill_brewer(palette='Blues')
  )
}
ggplot(iris,aes(Petal.Length,Sepal.Length))+usual()
ggplot(mtcars, aes(wt, mpg))+usual()

#or , to use a lot of geoms using one function
fav<-function(geom=''){
  if (geom=="geom_point"){
    list(geom_point(alpha=0.6,size=3,shape='circle',colour='orchid'),
         scale_fill_brewer(palette='Blues')
    )
  }
  else if(geom=='geom_boxplot'){
    fill1=as.character(readline(prompt = 'Enter the fill varaible:'))
    list(geom_boxplot(outlier.color = 'red',na.rm=FALSE,#remove with a warning
                      show.legend = FALSE,aes(fill=fill1)),
         scale_fill_manual(values = wes_palette('Moonrise3'))
    )
  }
  else if(geom=='geom_bar'){
    reqfill=as.character(readline(prompt = 'Does the plot require a fill? '))
    if (reqfill=='yes'){
      fill2=as.character(readline(prompt = 'Enter the fill variable:'))
    }
    else{
      fill2=NA
    }
    list(geom_bar(aes(fill=fill2)),
         theme(legend.position = "top"),
         scale_fill_manual(values =wes_palette('Rushmore')))
  }
}
#Trying it  out
ggplot(iris,aes(Petal.Length,Sepal.Length))+fav(geom="geom_point")
ggplot(iris,aes(Species,Sepal.Length))+fav(geom='geom_boxplot')
ggplot(mpg, aes(class))+fav(geom='geom_bar')
#or
g <- ggplot(mpg, aes(class))