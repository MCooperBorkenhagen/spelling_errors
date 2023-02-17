


d = read_xlsx('data/spelling_error_class_Nancy_person.xlsx')

misspellings = d %>% 
  filter(spell_corr_item == 0) %>% 
  pull(spell_item)

elp = read_csv('../words/elp/elp_clean.csv') %>% 
  select(word, f = Freq_HAL, length_orth = Length, length_phon = NPhon, length_syll = NSyll, length_morph = NMorph) %>% 
  mutate(target = case_when(word %in% unique(d$Spelling_Target) ~ "target",
                            TRUE ~ "not_target")) %>% 
  mutate(length_phon = as.numeric(length_phon),
         length_syll = as.numeric(length_syll),
         length_morph = as.numeric(length_morph))

controls = read_csv('data/')

all_orth = read_csv('data/all_orth.csv', col_names = 'word') %>% 
  rownames_to_column() %>% 
  mutate(i = as.numeric(rowname)-1) %>% # subtract 1 to align with the zero indexing of the distance dataframes
  select(index1 = i, index1_word = word)

phon_distances = read_csv('data/subset_phon_distances.csv')

tmp = read_csv('data/all_orth.csv', col_names = 'word') %>% 
  rownames_to_column() %>% 
  mutate(i = as.numeric(rowname)-1) %>% 
  select(index2 = i, index2_word = word)


targets_ = d %>% 
  group_by(Spelling_Target) %>% 
  distinct(spell_item) %>% 
  arrange(Spelling_Target) %>%
  select(index1_word = spell_item, target_word = Spelling_Target)

distances = read_csv('data/subset_orth_distances.csv') %>% 
  left_join(all_orth,  by = 'index1') %>% 
  left_join(tmp, by = 'index2') %>% 
  rename(orth = distance) %>% 
  left_join(phon_distances, by = c('index1', 'index2')) %>% 
  rename(phon = distance) %>% 
  mutate(target = case_when(index1_word %in% d$Spelling_Target | index2_word %in% d$Spelling_Target ~ 'target',
                            TRUE ~ 'not_target'),
         misspelling = case_when(index1_word %in% misspellings | index2_word %in% misspellings ~ 'misspelling',
                                 TRUE ~ 'not_misspelling')) %>% 
  left_join(targets_) %>% 
  

distances %>% 
  filter(index1_word == target_word)


distances %>% 
  filter(index2_word == target_word) %>%  nrow()
  View()

