


d = read_xlsx('data/spelling_error_class_Nancy_person.xlsx')


elp = read_csv('../words/elp/elp_clean.csv') %>% 
  select(word, f = Freq_HAL, length_orth = Length, length_phon = NPhon, length_syll = NSyll, length_morph = NMorph) %>% 
  mutate(target = case_when(word %in% unique(d$Spelling_Target) ~ "target",
                            TRUE ~ "not_target")) %>% 
  mutate(length_phon = as.numeric(length_phon),
         length_syll = as.numeric(length_syll),
         length_morph = as.numeric(length_morph))


all_orth = read_csv('data/all_orth.csv', col_names = 'word') %>% 
  rownames_to_column() %>% 
  mutate(i = as.numeric(rowname)-1) %>% # subtract 1 to align with the zero indexing of the distance dataframes
  select(index1 = i, index1_word = word)


tmp = read_csv('data/all_orth.csv', col_names = 'word') %>% 
  rownames_to_column() %>% 
  mutate(i = as.numeric(rowname)-1) %>% 
  select(index2 = i, index2_word = word)

orth_distances = read_csv('data/subset_orth_distances.csv') %>% 
  left_join(all_orth,  by = 'index1') %>% 
  left_join(tmp, by = 'index2')

phon_distances = read_csv('data/subset_phon_distances.csv')
