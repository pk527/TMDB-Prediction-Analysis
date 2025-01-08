pacman::p_load(tidyverse,
               lubridate,
               ggthemes,
               plotly,
               corrplot,
               gridExtra,
               VIM,
               viridis,
               readr,
               tidyr,
               infotheo,
               outliers,
               Hmisc,
               randomForest,
               modelr,
               caret,
               tidymodels,
               DMwR2,
               ggplot2,
               dplyr,
               broom,
               datarium,
               DataExplorer,
               ggpubr,
               Amelia,
               rpart,
               rpart.plot,
               GGally,
               AICcmodavg,
               xgboost,
               mice)

full_data  <- bind_rows(train, test)
#missing data status:
DataExplorer::profile_missing(full_data)
#plot the missing data status
library(VIM)
aggr_plot <- aggr(full_data, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE, labels=names(data), cex.axis=.7, gap=3, ylab=c("Histogram of missing data","Pattern"))
#train data
glimpse(train)
#head of train data
head(train)

# Budget
ggplot(train, aes(x = budget, y = revenue, color = budget)) +
  geom_point() +
  # scale_color_gradient(low = "grey10", high = "grey75") +
  scale_color_viridis(begin = 0, end = .95, option = 'D') + 
  geom_smooth(method = 'lm', color = 'red3', fill = 'red3') +
  scale_y_continuous(breaks = c(0, 500000000, 1000000000, 1500000000),
                     labels = c('$0', '$500', '$1000', '$1500')) +
  theme_classic() +
  theme(legend.position = 'none') +
  labs(title = 'Revenue by budget', x = 'Budget', y = 'Revenue (Millions)')
# Runtime
ggplot(train, aes(x = runtime, y = revenue, color = runtime)) +
  geom_point() +
  # scale_color_gradient(low = "grey10", high = "grey75") +
  scale_color_viridis(begin = 0, end = .95, option = 'D') + 
  geom_smooth(method = 'lm', color = 'red3', fill = 'red3') +
  scale_y_continuous(breaks = c(0, 500000000, 1000000000, 1500000000),
                     labels = c('$0', '$500', '$1000', '$1500')) +
  theme_classic() +
  theme(legend.position = 'none') +
  labs(title = 'Revenue by runtime', x = 'Runtime', y = 'Revenue (Millions)')


# Collection
train$collection_name <- str_extract(train$belongs_to_collection, 
                                     pattern = "(?<=name\\'\\:\\s{1}\\').+(?=\\'\\,\\s{1}\\'poster)")

train %>%
  group_by(collection_name) %>%
  summarise(movie_count = n()) %>%
  arrange(desc(movie_count)) %>%
  filter(!is.na(collection_name)) %>%
  head(10) 
train$collection[!is.na(train$belongs_to_collection)] <- 'Collection'
train$collection[is.na(train$belongs_to_collection)] <- 'No collection'

# Main genre
genres_matching_point <- "Comedy|Horror|Action|Drama|Documentary|Science Fiction|
              Crime|Fantasy|Thriller|Animation|Adventure|Mystery|War|Romance|Music|
              Family|Western|History|TV Movie|Foreign"

train$main_genre <- str_extract(train$genres, genres_matching_point)

# Production company id

train$prod_comp_id <- str_extract(train$production_companies, 
                                  pattern = "([0-9]+)")

#Top production companies
train$prod_comp_name <- gsub('(^\\[\\{\'name\'\\:\\s\'|\'\\,\\s\'id.*)', '',
                             train$production_companies)

train %>%
  group_by(prod_comp_name) %>%
  summarise(movie_count = n()) %>%
  arrange(desc(movie_count)) %>%
  filter(!is.na(prod_comp_name)) %>%
  head(10) 

train$top_prod_comp[train$prod_comp_name=='Universal Pictures'] <- 'Universal Pictures'
train$top_prod_comp[train$prod_comp_name=='Paramount Pictures'] <- 'Paramount Pictures'
train$top_prod_comp[train$prod_comp_name=='Twentieth Century Fox Film Corporation'] <- 'Twentieth Century Fox Film Corporation'
train$top_prod_comp[train$prod_comp_name=='Columbia Pictures'] <- 'Columbia Pictures'
train$top_prod_comp[train$prod_comp_name=='New Line Cinema'] <- 'New Line Cinema'
train$top_prod_comp[train$prod_comp_name=='Warner Bros.'] <- 'Warner Bros.'
train$top_prod_comp[train$prod_comp_name=='Walt Disney Pictures'] <- 'Walt Disney Pictures'
train$top_prod_comp[is.na(train$top_prod_comp)] <- 'Other'

#Production company size

train$prod_comp_size[train$prod_comp_name=='Universal Pictures'] <- 'Big producer' 
train$prod_comp_size[train$prod_comp_name=='Paramount Pictures'] <- 'Big producer' 
train$prod_comp_size[train$prod_comp_name=='Twentieth Century Fox Film Corporation'] <- 'Big producer'
train$prod_comp_size[train$prod_comp_name=='Columbia Pictures'] <- 'Big producer'
train$prod_comp_size[train$prod_comp_name=='New Line Cinema'] <- 'Big producer'
train$prod_comp_size[train$prod_comp_name=='Warner Bros.'] <- 'Big producer'
train$prod_comp_size[train$prod_comp_name=='Walt Disney Pictures'] <- 'Big producer'
train$prod_comp_size[is.na(train$prod_comp_size)] <- 'Small producer'

#Top production countries

train$prod_country <- str_extract(string = train$production_countries, 
                                  pattern = "[:upper:]+")
train %>%
  group_by(prod_country) %>%
  summarise(movie_count = n()) %>%
  arrange(desc(movie_count)) %>%
  filter(!is.na(prod_country)) %>%
  head(10) 

train$top_prod_country[train$prod_country=='US'] <- 'United States'
train$top_prod_country[train$prod_country=='GB'] <- 'Great Britain'
train$top_prod_country[train$prod_country=='FR'] <- 'France'
train$top_prod_country[is.na(train$top_prod_country)] <- 'Other'

# IMDB id

train$imdb_id_2 <- str_extract(train$imdb_id, '[0-9]+')

#Language

train %>%
  group_by(original_language) %>%
  summarise(movie_count = n()) %>%
  arrange(desc(movie_count)) %>%
  filter(!is.na(original_language)) %>%
  head(10) 

train$language[train$original_language=='en'] <- 'English'
train$language[is.na(train$language)] <- 'Non-English'

# Year, quarter, month, week, and weekday released

which(is.na(full_data$release_date))

full_data[3829, c('title', 'runtime')]

full_data$release_date[3829] <- '3/20/01'

train$release_date_mod <- parse_date_time2(train$release_date, "mdy",
                                           cutoff_2000 = 20)

# Create year, quarter, month, week, and weekday released using the LUBRIDATE package.

train$year_released <- ymd(train$release_date_mod) %>% 
  lubridate::year()  # Grab year.

train$quarter_released <- ymd(train$release_date_mod) %>%
  lubridate::quarter()  # Grab quarter.

train$month_released <- ymd(train$release_date_mod) %>% 
  lubridate::month(label = TRUE, abbr = FALSE)  # Grab month.

train$week_released <- ymd(train$release_date_mod) %>%
  lubridate::week()  # Grab week.

train$weekday_released <- ymd(train$release_date_mod) %>%
  lubridate::wday(label = TRUE, abbr = FALSE)  # Grab weekday.



#Tagline presence

train$tagline_presence[is.na(train$tagline)] <- 'No tagline'
train$tagline_presence[is.na(train$tagline_presence)] <- 'Tagline'

#Homepage presence

train$homepage_presence[is.na(train$homepage)] <- 'No homepage'
train$homepage_presence[is.na(train$homepage_presence)] <- 'Homepage'

#Gender of cast & crew

# Total cast count and by gender
train$number_of_cast <- str_count(train$cast, 'name')
train$female_cast <- str_count(train$cast, ('gender\'\\:\\s1'))
train$male_cast <- str_count(train$cast, ('gender\'\\:\\s2'))
train$unspecified_cast <- str_count(train$cast, ('gender\'\\:\\s0'))

# Total crew count and by gender
train$number_of_crew <- str_count(train$crew, 'name')
train$female_crew <- str_count(train$crew, ('gender\'\\:\\s1'))
train$male_crew <- str_count(train$crew, ('gender\'\\:\\s2'))
train$unspecified_crew <- str_count(train$crew, ('gender\'\\:\\s0'))

#Number of (1) genres, (2) production companies, (3) production countries, (4) spoken languages, and (5) keywords.

train$number_of_genres <- str_count(train$genres, 'name')
train$number_of_prod_companies <- str_count(train$production_companies, 'name')
train$number_of_prod_countries <- str_count(train$production_countries, 'name')
train$number_of_spoken_languages <- str_count(train$spoken_languages, 'name')
train$number_of_keywords <- str_count(train$Keywords, 'name')

#Length of (1) title_length, (2) overview_length, and (3) tagline_length by extracting the lengths of the strings of the variables.

train$title_length <- str_length(train$title)
train$tagline_length <- str_length(train$tagline)
train$overview_length <- str_length(train$overview)

# Subsetting the data

my_data_subset <- subset(train, 
                         select = c(popularity, runtime, budget, prod_comp_size, 
                                    top_prod_comp, prod_comp_id, main_genre, language, collection,
                                    top_prod_country, tagline_presence, homepage_presence,
                                    year_released, quarter_released, month_released, week_released,
                                    weekday_released, number_of_keywords, number_of_prod_companies,
                                    number_of_genres, title_length, tagline_length, number_of_cast,
                                    number_of_crew, female_cast, male_cast, female_crew, male_crew,
                                    # number_of_prod_countries, number_of_spoken_languages,
                                    # imdb_id_2, overview_length, unspecified_cast, unspecified_crew,
                                    revenue))

my_data_subset <- mutate(my_data_subset,
                         budget = log10(budget + 1),
                         year_released = log10(year_released),
                         popularity = log10(popularity + 1),
                         revenue = log10(revenue + 1))

#Imputation (mice)

set.seed(12345)

# pattern of Data

md.pattern(my_data_subset)

# Plot themissing values in our data set.
aggr_plot <- aggr(my_data_subset, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE, labels=names(data), cex.axis=.7, gap=3, ylab=c("Histogram of missing data","Pattern"))

#mice to impute
mice_my_data_subset <- mice(my_data_subset,m=5,maxit = 50,method = "pmm",seed = 500)

# distribution plot of given original values and imputed missing values in imputed columns
xyplot(mice_my_data_subset,revenue ~ number_of_cast+number_of_crew+runtime,pch=18,cex=1)
xyplot
#Complete the mice imputation
newDATA <- complete(mice_my_data_subset, 1)

# Treating missing values of categorical data in dataset

newDATA$prod_comp_id[is.na(my_data_subset$prod_comp_id)] <- 10000
newDATA$main_genre[is.na(my_data_subset$main_genre)] <- "Drama"

#missing data status after imputation
DataExplorer::profile_missing(newDATA)

#plot for the missing data status after imputation
aggr_plot <- aggr(newDATA, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE, labels=names(data), cex.axis=.7, gap=3, ylab=c("Histogram of missing data","Pattern"))


#data cleaning
my_data_clean <- newDATA %>% 
  mutate(revenue)
#Missing values
colSums(prop.table(is.na(my_data_clean)))

#Data modeling
library(rsample)
set.seed(100)
#splitter
index <- initial_split(my_data_clean %>% 
                         select(-popularity),prop = 0.70) 
train <- training(index)
test <- testing(index)
test_step <- testing(index)

prop.table(table(train$revenue))
prop.table(table(test$revenue))
prop.table(table(test_step$revenue))
 #summary 
summary(test_step)
#
GGally::ggcorr(test_step %>% 
                 select_if(is.numeric),label = T,legend.position = "none")

#linear regression

lm_model1 <- lm( revenue ~ budget+runtime+ number_of_cast  + year_released + week_released + quarter_released +
                    number_of_genres,data = test_step)

lm_model2 <- lm( revenue ~ budget+runtime+ number_of_cast  + year_released + week_released + quarter_released + number_of_crew
                 +title_length + tagline_length + number_of_keywords + female_cast + female_crew +male_crew +male_cast
                 +  number_of_genres,data = test_step)



lm_model3 <- lm( revenue ~ budget+runtime+ number_of_cast  + year_released + week_released +prod_comp_id + quarter_released + number_of_crew
                 +title_length + tagline_length + number_of_keywords + female_cast + female_crew +male_crew +male_cast + number_of_keywords + number_of_prod_companies
                  +  number_of_genres,data = test_step)

summary(lm_model1)
summary(lm_model2)
summary(lm_model3)

#AIC
#define list of models
models <- list(lm_model1, lm_model2, lm_model3)

#specify model names
mod.names <- c('disp.hp.wt.qsec', 'disp.qsec', 'disp.wt')

#calculate AIC of each model
aictab(cand.set = models, modnames = mod.names)

#Make predictions on the test set using the linear regression model.
pred_lm = predict(lm_model3, test_step)
summary(pred_lm)
summary(lm_model3)
plot(pred_lm, test_step$revenue, main="Predicted vs actual revenue value")
#hypothesis testing
cor.test(test_step$runtime,test_step$revenue)
cor.test(test_step$budget,test_step$revenue)
hypoout=aov(test_step$revenue~test_step$runtime+test_step$budget)
summary(hypoout)
confint(hypoout)

ggplot(test_step,aes(x=runtime,y=revenue))+
  geom_point(colour="lightblue",shape=15)+
  geom_smooth(aes(x=budget+runtime,y=revenue),method=lm,colour="black")+
  labs(title="Hypothesis Testing",
       x="budget and runtime",y="revenue")+
  theme_pander()+
  theme(axis.title=element_text())  

#random forest
set.seed(222)

rf_model <- randomForest(revenue ~ .,
                         my_data_clean, 
                         ntree = 501,
                         replace = TRUE,
                         nodesize = 9,
                         importance = TRUE);

print(rf_model)
plot(rf_model)


