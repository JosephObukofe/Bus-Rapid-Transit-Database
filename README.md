# Bus Rapid Transit (BRT) Database </br>
*A Database Engineering project using PostgreSQL*

## Table of Contents </br>
Understanding the Context </br>
Identifying the Entities </br>
Visualizing the Process Flow </br>
Identifying the Relationships between Entities </br>
Adding Default Values </br>
Adding Constraints </br>
* *Testing with Dummy Data*

Running Validation Queries </br>
Running Test Queries </br>
Creating Indexes </br>

## Understanding the Context 
Preparatory steps taken to create the BRT database were to answer a number of questions and provide clarity on the context of the database and its use 
cases. They included: </br>
* ***To define the purpose of the database***. 
  * It included identifying the context around its definition.
* ***To identify the users that would interact with the database***. 
  * Data professionals like Data Analysts, Data Scientists and Data Engineers seeking to provide a system to store related information. 
Once these were duly answered and clarified, the next phase was to investigate the entities that would make up our database. 

## Identifying the Entities
An important step to consider when identifying the entities was to visualize how a BRT system works in a concise manner to avoid early data redundancies. 
In a metropolis like Lagos, users or passengers in this case book a trip, then board a bus going to their trip destination. The driver on the other hand 
conveys passengers with similar trip info and then drops them at their destination.

## Visualizing the Process Flow
![Process Flow](https://user-images.githubusercontent.com/119716469/207320711-464e5bb3-cb2e-4c30-af2e-fd716456a167.png "Process Flow")

The major entities in our flow includes: passengers, `drivers`, `vehicles`, `trips` and `route locations`. But just considering these to be our major entities in our database would be detrimental as the issues of functionality (based on how the database would operate and store data) and also data consistency would have to be considered. Hence the following entities were further introduced. 
* `passenger_cards`
* `passenger_trips`
* `driver_vehicle_logs`
* `driver_identification_cards`
* `driver_additional_details`
* `license`


## Identifying the Relationships between Entities
The next step would be to identify the relationships between the entities in our BRT database and if present, *map the cardinalities* for each. If we 
consider a typical parent—child relationship, the foreign key in the child table acts like DNA, a strand that references the existence of the parent in 
the child’s body. So without the parent, the child would not exist. This is a concept I’d like to call ***"Existence Dependency"***. 
Consider the following related entities and their relationships. </br>
* `passengers` : `passenger_cards` - (1 : M)
* `passengers` : `passenger_trips` - (1 : M)
* `trips` : `passenger_trips` - (1 : M)
* `drivers` : `trips` - (1 : M)
* `drivers` : `driver_vehicle_logs` - (1 : M)
* `vehicles` : `driver_vehicle_logs` - (1 : M)
* `drivers` : `driver_identifiaction_cards` - (1 : 1)
* `drivers` : `driver_additional_details` - (1 : M)
* `drivers` : `license` - (1 : 1)

The only standalone entity in the database is the `corridor_location` entity that lists the various corridor locations accessible for bus transits.

![BRT Schema Diagram](https://user-images.githubusercontent.com/119716469/207329155-0596d89d-2f5d-409a-86a9-68ae1f9ee59f.png "BRT Schema Diagram")

## Adding Default Values
Some of the default values added to the columns of the database includes:
* NOW ( )
* 'TBD' (To be determined)

The NOW ( ) function determines the current date information. This was used to determine the issue date for (passenger_cards) as new card information was 
inserted into the database. It was also used in a CHECK constraint to determine the qualifications for drivers in our database. 
‘TBD’ is a string value that is added to the license status as a default value, as the column would be left untouched during data insertion. </brt>

`"license_status" varchar(7) DEFAULT('TBD'), -- Left untouched` </brt>

## Adding Constraints
> Constraints are sets of rules imposed on a table (or column) that prevents the entry of improperly formatted data.
The following constraints were added to the database tables to ensure data consistency and integrity:
1. FOREIGN KEY
2. NOT NULL
3. UNIQUE
4. CHECK

### Testing with Dummy Data
In order to fully test the integrity and functionality of our database, test data has to be inserted.

> Disclaimer: In order to protect sensitive information that would fit the context of our database tables and functionality, dummy data were created. 
These are randomly generated values to enable us work with data and test our database effectively

Kindly find the test data [here](https://drive.google.com/drive/folders/165ZvcTz81stNGoVjG5t7dfZp_umqhYnh?usp=share_link)

## Running Test Queries
In order to test the functionality of the database, I ran some simple queries. One of which was to run a query that aims to find the top ten passengers 
with the highest number of trips. The company is looking to run a discount for frequent passengers with respect to the number of trips taken. Note that 
the database at this point is already normalized so we’d have to join two tables in this case; the `passenger_trips` and the `passengers` table. Or we 
would like to continue with the vehicle—driver pairings so we want to know the available vehicles ready for a driver.

## Creating Indexes
So far, we have been able to run basic tests on our newly formed database with simple queries, but most times searching and filtering operations would 
begin to underperform as our database scales vertically. Since we have a fairly small database with the largest tuples of our dataset of about 1000, we 
could disregard the need for adding indexes as the DBMS would rather run a sequential scan than a bitmap index (especially in cases where the filter 
returns multiple values). However, we should consider the possibility of scaling and hence indexes were added.















