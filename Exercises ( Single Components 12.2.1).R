# Single Components

library(ggplot2)

#12.2.1 Exercises
#1. Create an object that represents a pink histogram with 100 bins

phist<-function(bins=100,fill='pink',...){
  geom_histogram(bins=bins,fill=fill,...)
}

#Trying it out 
diamonds
ggplot(diamonds,aes(carat))+phist()

#2.. Create an object that represents a fill scale with the Blues ColorBrewer
#palette

#getting to know the palette
library(RColorBrewer)
display.brewer.all()#Blues is a palette in RcolorBrewer package

#To use RcolorBrewer palettes in ggplot2
library(ggplot2)
bp<-ggplot(iris,aes(Species,Sepal.Length))+
  geom_boxplot(aes(fill=Species))+
  theme_void()+
  theme(legend.position='top')
bp
#To change ggplot group colours using RColourBrewer palettes
#Box plot
bp + scale_fill_brewer(palette='Accent')


#To create the object
Blupal<-function(fill="Blues",...){
  scale_fill_brewer(palette=fill,...)
}
#Trying it out
#NOTE: You need to add the 'fill' aesthetics to your plot in order for the scale_fill_brewer(in the function/not) to work
gp<-ggplot(diamonds,aes(cut,carat))+
  geom_boxplot(aes(fill=cut))
gp
gp+Blupal()


#4.Create scale_colour_wesanderson(). It should have a parameter to pick the palette from the wesanderson package, 
# and create either a continuous or discrete scale


#Getting familiar with wesanderson
library("wesanderson")
#To see all the palettes in wesanderson
names(wes_palettes)
#To see each
wes_palette("Cavalcanti1")
#normal use with ggplot2
names(mtcars)
ggplot(mtcars,aes(factor(cyl),fill=factor(vs)))+geom_bar()+
  scale_fill_manual(values=wes_palette('Darjeeling2'))


#Creating the object required
length(wes_palette("Moonrise3"))
scale_colour_wesanderson<-function(pale='Moonrise3',n=4,type = c("discrete", "continuous"))
{
  scale_fill_manual(values=wes_palette(pale,n,type))
}

ggplot(iris,aes(Species))+geom_bar(aes(fill=Species))+
  scale_colour_wesanderson(n=5)

head(mtcars)
ggplot(mtcars,aes(factor(cyl),fill=factor(vs)))+geom_bar()+
  scale_colour_wesanderson()

bp<-ggplot(iris,aes(Species,Sepal.Length))+
  geom_boxplot(aes(fill=Species))+
  theme_void()+
  theme(legend.position='top')
bp
bp+scale_colour_wesanderson()

# 3. Read the source code for theme grey(). What are its arguments? How does it work?


