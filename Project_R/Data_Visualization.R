title: "Homework Data Viz"
author: "Arnonnut M"
date: "2023-03-13"
output:
  html_document: default
  pdf_document: default
---

This is markdown language. Today we learn a few topics in R.

- database
- working with date
- ggplot2
- rmarkdown

## Homework
### Chart 1 Diamonds - Relationship between carat and price

```{r message=FALSE, warning=FALSE}
library(tidyverse)

```

```{r message=FALSE, warning=FALSE}
set.seed(10)
ggplot(diamonds %>% sample_n(500),
       mapping = aes(carat, price, col=cut)) +
  geom_point(size=2, alpha=0.6) +
  theme_minimal() +
  labs(
    title = "Relationship between carat and price",
    x = "Carat",
    y = "Price USD",
    subtitle = "We found a positive relationship",
    caption = "Data source : diamonds ggplot2"
  ) +
  scale_color_brewer(type="seq", palette = 4)
```

### Chart 2 found a positive relationship between two variables.

```{r message=FALSE, warning=FALSE}
ggplot(diamonds, mapping = aes(cut, fill=color))+
  geom_bar(position="fill")+
  theme_minimal()
```
### Chart 3

```{r message=FALSE, warning=FALSE}
ggplot(diamonds %>% sample_n(5000), aes(carat, price)) +
  geom_point(alpha=0.5) +
  geom_smooth(col="red", fill="gold") +
  theme_minimal() +
  facet_grid(cut ~ color)
```

Comment what did we find in this chart?

Add Link

[google](https://www.google.com)

Add an image to this report.

![new imgae](https://www.simplilearn.com/ice9/free_resources_article_thumb/Data-Science-vs.-Big-Data-vs.jpg)
