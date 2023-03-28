library(tidyverse)
library(ggplot2)

colours = c("#bd3106", "#d9700e", "#e9a00e", "#eebe04",
            "#5b7314", "#c3d6ce", "#89a6bb", "#454b87")

colours = c("#2c2d54", "#434475", "#6b6ca3", "#969bc7",
                     "#87bcbd", "#89ab7c", "#6f9954")

# make date
br_effect = 20
ro_effect = 50
m = 506
df = tibble(ro= factor(c("colour", "suit")),
            bright=c(m, m+ro_effect),
            blurred=c(m+br_effect, m+br_effect+ro_effect))

data = df %>% pivot_longer(cols = c("bright", "blurred"),
                    names_to = "Brightness") %>%
        mutate(cond="a) Same Processing Stage")

# add interaction
tmp = data %>%
  mutate(value = value + c(0,0, -25, 20),
         cond="b) Different Processing Stages")
data = rbind(data, tmp) %>% mutate(
  Brightness =factor(Brightness)
)

# plot
plt = ggplot(data=data,
       aes(x=ro, y=value, group=Brightness))  +
  geom_line(size=1, aes(colour=Brightness)) +
  geom_point(color='white', stroke=3, shape=21, size=5, aes(fill=Brightness)) +
  scale_fill_manual(values=c("#2c2d54", "#6f9954")) +
  scale_color_manual(values=c("#2c2d54", "#6f9954")) +
  ylab("Reaction Times (ms)") +
  xlab("Response Option") +
  ylim(480, 620) +
  facet_wrap(.~cond) +
  theme_minimal(base_size=14) +
  theme(axis.line = element_line(size=0.5),
        axis.ticks = element_line(size=0.5),
        plot.background = element_rect(fill = "white"))

print(plt)

ggsave("Fig.3.1.png", plt, device="png", units="px", width=2000, height = 2000*0.4)

