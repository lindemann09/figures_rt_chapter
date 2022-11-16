library(tidyr)
library(ggplot2)


df = tibble(fa= factor(c("yes", "no")),
            fb1=c(334, 78),
            fb2=c(89, 34))


dat =pivot_longer(df, cols = c("fb1", "fb2"), names_to = "fb")

plt = ggplot(data=dat,
       aes(x=fa, y=value, group=fb))  +
       geom_point(size = 4, aes(colour=fb, shape=fb, fill=fb))+
       geom_line(size=1, aes(colour=fb)) +
       ylab("Mean RT (ms)") +
       xlab("X label") +
       theme_bw(base_size=18)

ggsave("Posner.png", plt, device="png")

