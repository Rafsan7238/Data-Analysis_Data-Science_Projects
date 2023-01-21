# Solving a Murder Mystery with SQL

This project and all the related data has been collected from NUKnightLab, whose detailed description is available <a href="https://github.com/NUKnightLab/sql-mysteries" target="_blank">here</a>. 

## The Project:

A crime has taken place and the detective needs your help. The detective gave you the crime scene report, 
but you somehow lost it. You vaguely remember that the crime was a murder that occurred sometime on Jan. 15, 2018 
and that it took place in SQL City. All the clues to this mystery are buried in a huge database, and you need to 
use SQL to navigate through this vast network of information. Your first step to solving the mystery is to retrieve 
the corresponding crime scene report from the police department's database.

### Objective: 

The objective of the project is to use various SQL commands to query the SQL Police Department Database to find the murderer 
and also the main mastermind behind the crime. 

## The Data:

### Database Schema:

<img src="/Data/database schema diagram.png">

The data tables used in this project has been generated as follows:

### Crime Scene Report Table:

| Column  | Description |
|---------|-------------|
| date  | Date of the crime |
| type  | Type of the crime |
| description | Official police report of the crime |
| city  | City the crime took place |

### Drivers License Table:

| Column  | Description |
|---------|-------------|
| id  | Unique driver's license number |
| age | Age of the driver |
| height  | Height of the driver  |
| eye_color | Eye colour of the driver  |
| hair_color  | Hair colour of the driver |
| gender  | Gender of the driver  |
| plate_number  | Registered plate number of the car  |
| car_make  | Manufacturer of the car |
| car_model | Model of the car  |

### Facebook Event CheckIn Table:

| Column  | Description |
|---------|-------------|
| person_id | Unique ID of the person checking in |
| event_id  | Unique ID of the event  |
| event_name  | Name of the event |
| date  | Date the checkin was made |

### Get Fit Now Members Table:

| Column  | Description |
|---------|-------------|
| id  | Unique member's ID  |
| person_id | Unique ID of the person |
| name  | Name of the member  |
| membership_start_date | Date the person became a member |
| membership_status | Membership tier of the person |

### Get Fit Now CheckIn Table:

| Column  | Description |
|---------|-------------|
| membership_id | Unique ID of the member |
| check_in_date | Date the member checked into the gym | 
| check_in_time | Time the member checked into the gym  |
| check_out_time  | Time the member checked out of the gym |

### Income Table:

| Column  | Description |
|---------|-------------|
| ssn | Unique social security number of the person |
| annual_income | Annual income of the person in USD  |

### Interview Table:

| Column  | Description |
|---------|-------------|
| person_id | Unique ID of the person |
| transcript  | Offical transcript of the person's interview  |

### Person Table:

| Column  | Description |
|---------|-------------|
| id  | Unique ID of the person |
| name  | Name of the person |
| license_id  | Unique driver's license number  |
| address_number  | Apt. number of the person |
| address_street_name | Street name of the person's address |
| ssn | Unique social security number of the person |
