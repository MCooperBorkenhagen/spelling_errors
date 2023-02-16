

all_orth_distances = read_csv('data/all_orth_distances.csv', col_names = T)

d = read_xlsx('data/spelling_error_class_Nancy_person.xlsx')


elp = read_csv('../../words/elp/elp_clean.csv') %>% 
  select(word, f = Freq_HAL, length_orth = Length, length_phon = NPhon, length_syll = NSyll, length_morph = NMorph) %>% 
  mutate(target = case_when(word %in% unique(d$Spelling_Target) ~ "target",
                            TRUE ~ "not_target")) %>% 
  mutate(length_phon = as.numeric(length_phon),
         length_syll = as.numeric(length_syll),
         length_morph = as.numeric(length_morph))

all_orth = read_csv('data/all_orth.csv', col_names = 'word') %>% 
  rownames_to_column() %>% 
  mutate(i = as.numeric(rowname)) %>% 
  select(i, word)


