library(tidyverse)
library(ggplot2)

colours = c("#bd3106", "#d9700e", "#e9a00e", "#eebe04",
                     "#5b7314", "#c3d6ce", "#89a6bb", "#454b87")

colours = c("#2c2d54", "#434475", "#6b6ca3", "#969bc7",
                     "#87bcbd", "#87bcbd", "#6f9954")

df = tibble(block=c(1:8),
            rt = c(655, 590, 540, 490, 460, 440, 540, 535))


# plot
plt = df %>%
  ggplot( aes(x=block, y=rt)) +
  geom_line(color="#2c2d54", size=1) +
  geom_point(shape=21, color="white", fill="#2c2d54", stroke=3, size=4) +
  scale_x_continuous(limits=c(1, 8), breaks=c(1:8)) +
  xlab("Block") +
  ylab("Reaction Times (ms)") +
  geom_vline(xintercept=6.5, linetype="dotted", size=1) +
  geom_text(x=3.9, y=645, label="Systematic\nSequence", size=5, stat = "unique") +
  geom_text(x=7.5, y=645, label="Random\nSequence", size=5, stat = "unique") +
  theme_minimal(base_size=14) +
  theme(axis.line = element_line(size=0.5),
        axis.ticks = element_line(size=0.5))

print(plt)
ggsave("Sequence_learning.png", plt, device="png", width=8, height = 4)
