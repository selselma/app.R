getPatient <- function(titre){
  resultPatient <- patients %>%
    filter(title ==  titre)
} 