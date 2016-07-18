#reading titanic_original
titanic_original<- read.csv("titanic_original.csv", na.strings = c("", " ","NA"))
glimpse(titanic_original)
 

#Replacing all NA values with S

ind_embarkation <- which(is.na(titanic_original$embarked))
titanic_original$embarked[ind_embarkation] <- "S" 

titanic_original$embarked

#Mean of Age and replacing with mean 

titanic_original_mean<- mean(titanic_original$age, na.rm=TRUE)

titanic_original$age[which(is.na(titanic_original$age))] <- titanic_original_mean
glimpse(titanic_original)

#Filling empty values in boat with NA
titanic_original$boat[which(is.na(titanic_original$boat))] <- NA 
  
#new column for missing cabin numbers 

titanic_original <- titanic_original %>% 
  mutate(has_cabin_number = as.factor(ifelse(!is.na(cabin),1,0)))




