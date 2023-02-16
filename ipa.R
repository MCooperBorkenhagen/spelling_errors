


require(readxl)
msp = read_xlsx('mispelling_pronunciations.xlsx')

ARPAbet = read_xlsx('../../words/ARPAbet/ARPAbet.xlsx')

trigger = msp$miss_preds %>% 
  str_extract_all(boundary("character")) %>% 
  unlist() %>% 
  unique()

target = unique(ARPAbet$IPA)

# IPA characters in the ARPAbet set not in the Gutierrez transcriptions
setdiff(target, trigger)

# IPA characters in transcriptions not in the ARPAbet table
setdiff(trigger, target)


msp %>% 
  #filter(str_detect('a', miss_preds))
  select(Misspellings) %>% 
  write.table('~/Desktop/msp.txt', row.names = F)
