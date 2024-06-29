
# import required libraries
library(tidyverse)
library(sqldf)

cr_path<- "C:/Users/atl-vigneshn/Desktop/mcdaniel/ANA515/week-6/StormEvents_details-ftp_v1.0_d1997_c20220425.csv"
#read csv file for 1997 data
se<-read.csv(cr_path)
#select required columns
se_1<-se[c("BEGIN_YEARMONTH","EPISODE_ID","STATE","STATE_FIPS","CZ_NAME","CZ_TYPE","CZ_FIPS","EVENT_TYPE")]
#sort by state in ascending order
se_1<-se_1[order(se_1$STATE,decreasing = FALSE),]
#Change State and country names to title case
se_1$STATE<-str_to_title(se_1$STATE)
se_1$CZ_NAME<-str_to_title(se_1$CZ_NAME)
# filter by CZ_TYPE
se_2<-filter(se_1,grepl("C",CZ_TYPE))
#Remove CZ_TYPE column
se_2<-se_2[c("BEGIN_YEARMONTH","EPISODE_ID","STATE","STATE_FIPS","CZ_NAME","CZ_FIPS","EVENT_TYPE")]
#pad state and county FIPS with a 0 and unite the two columns to make a combined FIPS Column
se_2$STATE_FIPS<-paste("0",as.character(se_2$STATE_FIPS))
se_2$CZ_FIPS<-paste("0",as.character(se_2$CZ_FIPS))
se_2$STATE_CZ_FIPS<-NA
se_2$STATE_CZ_FIPS<-paste(as.character(se_2$STATE_FIPS),as.character(se_2$CZ_FIPS))
#change all column names to lower case
se_2<-se_2 %>% 
  rename_with(str_to_lower)
# create a new dataframe with the required three columns
state<-data.frame(state.name,state.area,state.region)
colnames(state)<-c('State','area','region')
#create a dataframe by grouping with state
se_2$count<-1 #having a count column would help with the aggregation
strom_events<-se_2 %>% group_by(state) %>% summarize(strom_events = sum(count))
#merge the above two dataframes to get our required data
required_df<-sqldf("SELECT d.strom_Events, s.area,s.region,d.state
                   from strom_events d
                   left join state s on s.state = d.state
                   where s.region is not null")
#create the scatter plot
ggplot(required_df,aes(x=area,y=strom_events,color=region)) +
  geom_point()+
  ggtitle("Storm events by area and region") + xlab("Land area(Square miles)") + ylab ("# of storm events in 1997")


