require(readxl)

msp = read_xlsx('data/mispelling_pronunciations.xlsx') %>% 
  rename(misspell = Misspellings,
         orth = Spelling_Target)


preds = read_csv('data/cmudict_predicted_spelling_misspelled_words_raw.csv', col_names = 'pred') %>% 
  as_tibble() %>% 
  mutate(split_ = str_match(pred, '\\s+'),
         phon = str_split(pred, split_, simplify = T)[,2],
         phon = str_replace_all(phon, ' ', '-'),
         misspell = tolower(str_split(pred, split_, simplify = T)[,1]),
         misspell = str_replace_all(misspell, regex("\\W+"), '')) %>% 
  select(misspell, phon) %>% 
  left_join(msp) %>% 
  select(orth, misspell, phon)

write.csv(preds, file = 'data/cmudict_predicted_spelling_of_misspelled_words.csv', row.names = F)
