
# Cyclistic bike-share analysis case study

### Scenario
You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of
marketing believes the company’s future success depends on maximizing the number of annual memberships. Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Moreno(director of company) believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members.  Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. 

We need to answer following question:
How do annual members and casual riders use Cyclistic bikes differently?

#### My stakeholders
- Lily Moreno: The director of marketing and your manager.
- Cyclistic marketing analytics team
- Cyclistic executive team

#### Major Steps to Follow
1. Prepare data
2. Process data
3. Analyse data
4. Share data

### Prepare Data 
For the purposes of this case study, the data has been made available by Motivate International Inc. I will be working on the data including the time period from April 2019 to March 2020. This data from four quarters will be combined together into single dataframe of 12 months. I will be using R studio to carry out the analysis and answer the business questions.
* Downloaded the required quarter data Cyclistic trip data from https://divvy-tripdata.s3.amazonaws.com/index.html.
* Unziped the files.
* Created a folder on desktop to house the files and used appropriate file-naming conventions.
* Uploaded the files on R studio.

### Process Data
Step 1.  Install the required packages in R for completing the analysis. We will use tidyverse, lubridate and ggplot2.

Step 2.  Load the libraries. 

Code: ![install packages](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/098f3d49-2b5e-4db4-b35d-8c26eedd7749)

Step 3.   Input the quarterly bikeshare data into respective data frames using read.csv() function.

Code: ![read csv](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/1cb7cd68-5368-4b2e-88e9-4ac643a39ff6)

Step 4. Explore the dataset, where relevant, make columns consistent and combine them into a single worksheet. Let's explore the column names first. 

Code: ![colnames](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/63438d5c-8b2e-4e6f-adfe-9a9860a2a21f)

We can see that column names are not consistent. We will make the column names same as that of q1_2020. Also there are extra columns such as start_lat, start_lng, end_lat, and end_long in q1_2020, we will deal with those columns later.

Step 5: Rename the column names using rename() function. Syntax of rename(): df=rename(df,final colname=initial colname)

code: ![rename_colnames](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/dfdc8eab-86ce-4e65-815f-e2c29639909f)

Verify the column names.
Code:
![Verifying colnames](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/48018f99-3933-499a-be48-677a4cfb8f43)
We can see the column names are consistent now. 

Step 6: Explore the data types of data frames and examine data type of each column using str() function.
Code:
![datatype 1](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/9e690e8d-0ffb-4132-8c45-cc5256aeb8e9)

![datatype2](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/f76ccbc0-0f1d-4d0a-ae7e-387160909b98)

![datatype 3](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/5d0641b4-dee9-40a4-8f64-c01074b5d7bc)

![datatype 4](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/0f77389c-62be-4c9e-8566-7a52595029bd)

We can observe that the data type of ride_id and rideable_type are in integer format in q2_2019, q3_2019 and q4_2019. Ideally it should be in character formmat. 

Step 7: Change the data type of ride_id and rideable_type. and recheck with str().

![mutate](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/2435ae4f-1a9e-40b7-8b0c-b88f1664695b)

Step 8. Stack all four data frames into one big data frame using bind_rows() function. 

![bind_rows](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/51142d60-5447-4be6-9de0-344df56f898f)

Step 9. Remove unwanted columns lat, long, birthyear, and gender. 

![select(-c())](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/24335a6e-48a6-4b23-bde1-50a4eed8d0c7)

Step 10. Now, we might feel our data is ready for analysis. But, lets re-check again by computing number of rows, column names using head(), str() and summary() function and cross checking dimensions of data frame. Basically, carefully inspect the new table all_trips that has been created.

![nrow and dim](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/a294d41d-497c-4d8b-b550-4947a117009f)

nrow() will return number of rows. dim() will return number of rows and columns. We have 3879822 rows and 11 columns in our dataframe.
 
![head()](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/3a618da6-30ad-4c58-b5e5-8b4f7b5304f5)

head() function will give details of first 6 rows. 

![str()](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/b12516a4-c95c-4cee-9bb9-3c5b863018b7)

str() returns columns, its datatypes and initial observations in dataframes.

![summary()](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/0cef52d5-09bd-4c35-96e5-32b00fc24282)

summary() will give the statistical summary as shown above. 

After careful observation, we could see that there are two names for members (“member” and “Subscriber”) and two names for casual riders (“Customer” and “casual”) in the member_casual column. We will need to consolidate that from four to two labels.

Step 11. Check how many observations fall under each user type.
Use table() function.

![member_casual](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/9a478464-02bf-49e8-83e1-d0fa44b4d4af)

Step 12. Change the membership names subscriber and customer to member and casual resp. Re-check the user type. 

![recode() and re-check](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/05e8a1c6-37ad-4b21-ac48-c7214ef84319)

Now the observations are consistent. 

Step 13. Add separate columns for the date, month, day, and year of each ride. This will allow us to aggregate ride data for each month, day, or year.

![date, month, year](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/52ab3571-6f20-4827-bef4-9a1d692b9a61)

Step 14. Create a column called “ride_length.” Calculate the length of each ride by subtracting the column “ended_at” from the column “started_at”. We can do this by using difftime().

![ride_length](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/257c521a-c975-42bd-9d65-df8f3866ea25)

Also, we can check the data types and initial values using str() function. 

![str() recheck](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/1b66b79a-26e5-4619-9da2-8fd9269d28e8) 
I have highlighted the newly created columns here.

Step 15. Let's check if all the values in the ride_length column are numeric. we can use as.numeric() function. 
![numeric1](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/67cd3d11-9c61-4122-8d48-f6f2544fc744)

as result came FALSE, we will first convert ride_length column to numeric and recheck the formats.

![chartonum](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/713cf956-6a32-4a4c-b534-e531131e618b)

Now it is TRUE.

Step 16. The data frame includes a few hundred entries, when bikes were taken out of docks and checked for quality by company. These values can be identified by negative value in “ride_length”. We will create a new version of the data frame (v2) where rows with negative “ride_length” data is being removed.

![all_trips_v2](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/e0d1c0c4-3e28-4e4b-85bb-d052653e9fab)

In (step 10.) we can see 3879822 rows were there. it reduced to 3876042. that means there were 3780 rows with negative “ride_length”. 

Now, we can use the data for twelve months to do further analysis as we have completed a number of cleaning tasks and made it consistent.

### Analyse Data


Step 1. Do descriptive analysis on ride_length (all values in seconds).

![summary_ridelength](https://github.com/PoojaParab-DA/SAS-programming-case-study/assets/172165136/ffb2735b-54af-49dc-997e-f36dc252f969)


Step 2. Our Aim is to find data about how casual riders use bike share compared to Annual members. So, we compare various parameters like average “ride_length” and number of trips for both categories of users in each week day.

![aggregate](https://github.com/PoojaParab-DA/R-programming/assets/172165136/7a0cee10-696b-4dc5-81cf-d94cceff1516)

Step 3. Notice how the days of the week are out of order. We can fix that by using the following code chunk:

![ordered()](https://github.com/PoojaParab-DA/R-programming/assets/172165136/2ddfa21f-4959-4b73-a5c7-ed2960c376fe)

If we re-run the step 2 code we will get weeks in proper order with average 'ride_length'. 

![ordered() read](https://github.com/PoojaParab-DA/R-programming/assets/172165136/573d245e-9b61-4b05-8647-8c96d73f566a)


Step 4. Next, we can analyze and find insights about user type by day of the week. The, followed by grouping data by user type and day of the week.
Then, we calculate number of rides and average duration of each ride to sort them by user type and day of the week. We use data pipes to complete all these analysis in the following code chunk

![number-of_rides](https://github.com/PoojaParab-DA/R-programming/assets/172165136/cfed76b7-e3a4-48b5-80e6-8d8291261751)

1) From the above graph, it is clear that number of trips by annual members are higher compared to casual riders especially during weekdays. Further analysis needs to be done to determine whether higher number of trips by annual members correspond to home-work commute during weekdays.
2) Again, we can observe casual riders have taken more number of trips during weekends compared to weekdays. Further analysis needs to be done to determine the reason for an increase in number of trips by casual users during weekend.
3) This graph also suggests the possibility of exploring weekend offers and ads targeting casual riders to convert to annual members.

We come to the end of bike-share case study! We have compared the data about casual users and annual members to obtain insights which would help in increasing memberships.




