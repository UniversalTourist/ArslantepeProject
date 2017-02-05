#Hazel Kavili - Arslantepe Project Graphs by ggplot2

#cv_data <- melt(cv, id = "Year")
#cv_plot <- ggplot(data=cv_data, aes(x=Year, y=value, colour=variable)) + geom_line()

library(readxl)
library(reshape2)
library(dplyr) # data_frame and n_distinct
library(tidyr) # gather
library(ggplot2) # plotting!
library(scales) # hue_pal, linetype_pal (standard ggplot palettes)

# gather everything except year
mylandcover <- gather(landcover, key = "Field",  value = "Value", -Year)

# number of colours (based on first character)
ncol <- n_distinct(substr(mylandcover$Field, 1, 1))

# number of linetypes (based on second character)
ntype <- n_distinct(substr(mylandcover$Field, 2, 2))

# plot with combined colour/linetype legend
ggplot(mylandcover, aes(x = Year, y = Value, col = Field, linetype = Field)) +
  geom_line() + 
  scale_linetype_manual(values = rep(linetype_pal()(ntype), times = ncol)) +
  scale_color_manual(values = rep(hue_pal()(ncol), each = ntype)) +
  theme_minimal() + 
  xlab("Year of Simulation") + ylab("Coefficient of Variation")

