library(tidyverse)
library(ggplot2)

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
  scale_fill_manual(values=c("#004C99", "#02AA00")) +
  scale_color_manual(values=c("#004C99", "#02AA00")) +
  ylab("Mean RT (ms)") +
  xlab("Response Option") +
  ylim(480, 620) +
  facet_wrap(.~cond) +
  theme_minimal(base_size=14) +
  theme(axis.line = element_line(size=0.5),
        axis.ticks = element_line(size=0.5))

print(plt)

ggsave("Posner.png", plt, device="png", width=10, height = 4)

