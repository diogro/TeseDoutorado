if(!require(tidyverse)){install.packages("tidyverse"); library(tidyverse)}
if(!require(evolqg)){install.packages("evolqg"); library(evolqg)}
if(!require(cowplot)){install.packages("cowplot"); library(cowplot)}
vectorCor = function(x, y) Normalize(x) %*% Normalize(y)

rects <- data.frame(xstart = seq(0,80,20), xend = seq(20,100,20), col = letters[1:5])

bounds = data.frame(xstart = c(-1, -1, -1, -1),
                    xend   = c(1, 1, 1, 1),
                    ystart = c(1, -1, 0.5, -0.5),
                    yend = c(-1, 1, -0.5, 0.5))
formulas = data.frame(slopes = c(0.5, 1, 2),
                      inter = c(0, 0, 0))

steps_neg = seq(-0.5, 0, length.out = 100)
steps_pos = seq(0, 0.5, length.out = 100)
l_modular = data.frame(x = steps_neg,
                       bottom = sapply(steps_neg, FUN = function(x){x*0.5}),
                       top = sapply(steps_neg, FUN = function(x){x*-0.5}),
                       col = "modular")
r_modular = data.frame(x = steps_pos,
                       bottom = sapply(steps_pos, FUN = function(x){x*-0.5}),
                       top = sapply(steps_pos, FUN = function(x){x*0.5}),
                       col = "modular")
l_antagonistic = data.frame(x = steps_neg,
                            bottom = steps_neg * -0.5,
                            top  = sapply(steps_neg * -2, min, 0.5))
r_antagonistic = data.frame(x = steps_pos,
                            top = steps_pos * -0.5,
                            bottom  = sapply(steps_pos * -2, max, -0.5))
l_integrative = data.frame(x = steps_neg,
                           top = steps_neg * 0.5,
                           bottom  = sapply(steps_neg * 2, max, -0.5))
r_integrative = data.frame(x = steps_pos,
                            top = sapply(steps_pos * 2, min, 0.5),
                            bottom  = steps_pos * 0.5)

steps_neg = seq(-0.95, 0, length.out = 100)
steps_pos = seq(0, 0.95, length.out = 100)
t_modular_1 = data.frame(x = steps_neg,
                       bottom = steps_neg*-2,
                       top = 0.5)
t_modular_2 = data.frame(x = steps_pos,
                         bottom = steps_pos*2,
                         top = 0.5)
b_modular_1 = data.frame(x = steps_neg,
                         top = steps_neg*2,
                         bottom = -0.5)
b_modular_2 = data.frame(x = steps_pos,
                         top = steps_pos*-2,
                         bottom = -0.5)

if(!require(wesanderson)){install.packages("wesanderson"); library(wesanderson)}
pallet = wes_palette("Darjeeling1")
modular_col = wes_palette("FantasticFox1")[3]
antagonistic_col = wes_palette("FantasticFox1")[5]
integrative_col = pallet[4]
local_col = "#00BFFF"
(vector_classification = ggplot() +
  geom_ribbon(data = l_modular, aes(x = x, ymin = bottom, ymax = top), fill = modular_col, alpha = 0.9) +
  geom_ribbon(data = r_modular, aes(x = x, ymin = bottom, ymax = top), fill = modular_col, alpha = 0.9) +
  geom_ribbon(data = t_modular_1, aes(x = x, ymin = bottom, ymax = top), fill = modular_col, alpha = 0.9)+
  geom_ribbon(data = t_modular_2, aes(x = x, ymin = bottom, ymax = top), fill = modular_col, alpha = 0.9)+
  geom_ribbon(data = b_modular_1, aes(x = x, ymin = bottom, ymax = top), fill = modular_col, alpha = 0.9)+
  geom_ribbon(data = b_modular_2, aes(x = x, ymin = bottom, ymax = top), fill = modular_col, alpha = 0.9)+
  geom_ribbon(data = l_antagonistic, aes(x = x, ymin = bottom, ymax = top), fill = antagonistic_col, alpha = 0.9)+
  geom_ribbon(data = r_antagonistic, aes(x = x, ymin = bottom, ymax = top), fill = antagonistic_col, alpha = 0.9)+
  geom_ribbon(data = l_integrative, aes(x = x, ymin = bottom, ymax = top), fill = integrative_col, alpha = 0.9)+
  geom_ribbon(data = r_integrative, aes(x = x, ymin = bottom, ymax = top), fill = integrative_col, alpha = 0.9)+
  geom_abline(data = formulas, aes(slope = slopes, intercept = inter), alpha = 1, col =  "white") +
  geom_abline(data = formulas, aes(slope = -slopes, intercept = inter), alpha = 1, col = "white") +
  geom_vline(xintercept = 0) +
  geom_hline(yintercept = 0) +
  theme_void() +
  theme(aspect.ratio=1) + scale_y_continuous(limits = c(-0.5, 0.5)) + scale_x_continuous(limits = c(-0.5, 0.5)))
save_plot("~/Dropbox/labbio/articles/TeseDoutorado/capa.png", vector_classification, base_height = 6, base_aspect_ratio = 1)

