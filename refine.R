refine_original<- read.csv("refine.csv")

#Clean up brand names
refine_original$company[grep('ph', refine_original$company)] <- "Phillips"
refine_original$company[grep('f', refine_original$company)] <- "Phillips"
refine_original$company[grep('ak', refine_original$company)] <- "akzo"
refine_original$company[grep('A', refine_original$company)] <- "akzo"
refine_original$company[grep('van', refine_original$company)] <- "van houten"
refine_original$company[grep('Van', refine_original$company)] <- "van houten"
refine_original$company[grep('uni', refine_original$company)] <- "unilever"
refine_original$company[grep('Uni', refine_original$company)] <- "unilever"
glimpse(refine_original)

#separate productcode and number
refine_original <-refine_original %>% 
  separate(Product.code...number,c("ProductCode","ProductNumber"))

refine_original <- mutate(refine_original, ProductCategory= ProductCode)

#Add product categories
refine_original$ProductCategory[grep('p', refine_original$ProductCategory)] <- "Smartphone"
refine_original$ProductCategory[grep('v', refine_original$ProductCategory)] <- "TV"
refine_original$ProductCategory[grep('x', refine_original$ProductCategory)] <- "Laptop"
refine_original$ProductCategory[grep('q', refine_original$ProductCategory)] <- "Tablet"
 glimpse(refine_original)

#Combine Adressess
refine_original <- refine_original %>% 
  unite(FullAddress, address, city, country, sep = ",", remove = FALSE) 

#Rename column names
refine_original <- rename(refine_original, full_address=FullAddress)

#Dummy columns
refine_original <- refine_original %>% 
  mutate(company=paste('company',company,sep = "_"),ProductCategory = paste("product",ProductCategory,sep = '_')) %>% 
  spread(company,company) %>%
  spread(ProductCategory,ProductCategory)

glimpse(refine_original)
#Dummy variables 

refine_original$company_akzo <- ifelse(!is.na(refine_original$company_akzo),1,0)
refine_original$company_Phillips <- ifelse(!is.na(refine_original$company_Phillips),1,0)
refine_original$company_unilever <- ifelse(!is.na(refine_original$company_unilever),1,0)
refine_original$`company_van houten` <-ifelse(!is.na(refine_original$`company_van houten`),1,0)
refine_original$product_Laptop <-ifelse(!is.na(refine_original$product_Laptop),1,0)
refine_original$product_Smartphone <-ifelse(!is.na(refine_original$product_Smartphone),1,0)
refine_original$product_Tablet <-ifelse(!is.na(refine_original$product_Tablet),1,0)
refine_original$product_TV <-ifelse(!is.na(refine_original$product_TV),1,0)
glimpse(refine_original)

write.csv(refine_original, file=refine_original.csv)

