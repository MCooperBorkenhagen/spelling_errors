

all_distances = orth_distances %>% 
  select(index1, index2, orth = distance) %>% 
  left_join(phon_distances, by = c('index1', 'index2')) %>% 
  rename(phon = distance)

cor(all_distances$orth, all_distances$phon)

all_distances %>% 
  slice(1:10000) %>% 
  ggplot(aes(orth, phon)) +
  geom_point()

prcomp_  = prcomp(all_distances$orth)


all_distances %>% 
  group_by(index1) %>% 
  summarise(mean(orth)) %>% 
  nrow()


