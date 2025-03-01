library("lubridate")
here::i_am("Programs/ANOVA.R")

data <- readRDS(file = here::here("Output/data_clean.rds"))
data
str(data$length)


#transforming length variable to be numeric, set as minutes

convert_hh_mm_ss_to_numeric <- function(x){
  
  split_x <- strsplit(x, split = ":")
  
  get_minutes <- function(y){
    
    y <- as.numeric(y)
    
    if(length(y) == 1){
      
      # assume it's seconds
      
      y / 60
      
    }else if(length(y) == 2){
      
      y[1] + y[2]/60
      
    }else if(length(y) == 3){
      
      60 * y[1] + y[2] + y[3]/60
      
    }else{
      
      NA
      
    }
    
  }
  
  minutes <- unlist(lapply(split_x, get_minutes))
  
  return(minutes)
  
}

data$length_n <- convert_hh_mm_ss_to_numeric(data$length)


plant.aov <- aov(length_n ~ week, data = data)
summary_anova<-summary(plant.aov)
saveRDS(summary_anova,file = here::here("Output/summary_anova.rds"))


