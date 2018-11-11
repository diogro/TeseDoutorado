if(!require(evolqg)){install.packages("evolqg"); library(evolqg)}
if(!require(wesanderson)) { install.packages("wesanderson"); library(wesanderson) }
if(!require(ggplot2)){install.packages("ggplot2"); library(ggplot2)}  
if(!require(ggthemes)){install.packages("ggthemes"); library(ggthemes)}
if(!require(cowplot)){install.packages("cowplot"); library(cowplot)}

plot_pop = function(p, mean, sd, multi, ...){
  x <- seq(-1,11,0.01)
  MyDF <- data.frame(x = x, y = dnorm(x, mean, sd)*multi)
  shade <- rbind(c(0.1, 0), MyDF, c(MyDF[nrow(MyDF), "X"], 0))
  pop = p + geom_line(data = MyDF, aes(x, y)) + geom_polygon(data = shade, aes(x, y), ...)
  return(pop)
}

p1 <- ggplot() + labs(x = "Um locus", y= "") + theme_tufte() + theme(panel.grid.major = element_blank(),
                                                                               panel.grid.minor = element_blank(),
                                                                               axis.text = element_blank())+
  scale_y_continuous(breaks = NULL) + scale_x_continuous(breaks = NULL)
p1 = plot_pop(p1, 5.0, 0.8, 0.9, color = "lightblue", alpha = 0)
p1 = plot_pop(p1, 6.5, 1, 0.5, color = "lightblue", alpha = 0)  
p1 = plot_pop(p1, 3.5, 1, 0.5, color = "lightblue", alpha = 0) 
p1 = plot_pop(p1, 5, 1.57, 1.8, color = "blue", alpha = 0) + geom_hline(yintercept = 0)

p2 <- ggplot() + labs(x = "Dois loci", y= "") + theme_tufte() + theme(panel.grid.major = element_blank(),
                                                                     panel.grid.minor = element_blank(),
                                                                     axis.text = element_blank()) +
  scale_y_continuous(breaks = NULL) + scale_x_continuous(breaks = NULL)
p2 = plot_pop(p2, 5.0, 0.8, 0.7, color = "lightblue", alpha = 0)
p2 = plot_pop(p2, 6, 1, 0.5, color = "lightblue", alpha = 0)  
p2 = plot_pop(p2, 4, 1, 0.5, color = "lightblue", alpha = 0) 
p2 = plot_pop(p2, 7.5, 1, 0.1, color = "lightblue", alpha = 0)  
p2 = plot_pop(p2, 2.5, 1, 0.1, color = "lightblue", alpha = 0) 
p2 = plot_pop(p2, 5, 1.57, 1.8, color = "blue", alpha = 0) + geom_hline(yintercept = 0)
p2
p1p2 = plot_grid(p1, p2, ncol = 1, labels = c("A", "B"))
save_plot("~/Dropbox/labbio/articles/TeseDoutorado/discrete_gaussian.png", p1p2, base_height = 6, nrow = 2, base_aspect_ratio = 1.2)
