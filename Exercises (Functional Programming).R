#Functional Programming
# 12.5.1 Exercises

geoms<-list(
  geom_point(),
  geom_boxplot(aes(group=cut_width(displ,1))), #cut_width() makes groups with displ having width 1
  list(geom_point(),geom_smooth())
)
p<-ggplot(mpg,aes(displ,hwy))
lapply(geoms,function(g) p+g)#anonymous function
# g is the argument that we pass in , here , geoms
#returns geoms as a list


#1.How could you add a geom point() layer to each element of the following
#list?
plots <- list(
  ggplot(mpg, aes(displ, hwy)),
  ggplot(diamonds, aes(carat, price)),
  ggplot(faithfuld, aes(waiting, eruptions, size = density))
)

lapply(plots,function(plots) plots+geom_point())
#verify
ggplot(mpg, aes(displ, hwy))+geom_point()
ggplot(diamonds, aes(carat, price))+geom_point()
ggplot(faithfuld, aes(waiting, eruptions, size = density))+geom_point()

# What does the following function do? What's a better name for it?
?Reduce #works kind of the same as cumsum() when used with '+'
mystery <- function(...) {
  Reduce('+', list(...), 
         accumulate = TRUE)#return all intermediate results
}
#Reduce(f='+',x=1:6,accumulate = TRUE)
mystery(
  ggplot(mpg,aes(displ,hwy))+geom_point(),
  geom_smooth(),
  xlab(NULL),
  ylab(NULL)
)

#better name - cumulativeplots

