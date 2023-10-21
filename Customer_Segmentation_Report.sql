
/*
+ Use at least 3 different data types while creating tables
+ Use at least 2 constraints while creating tables, not including primary key or foreign key
+ Normalise the DB by splitting the data out in tables where appropriate and not
containing any duplicate data.
*/

-- Creating a database
CREATE DATABASE Customer_Segmentation_Report;
-- Using the database
USE Customer_Segmentation_Report;

-- 1.Creating the first table to store customer information with different data types and a PRIMARY KEY, CHECK & NOT NULL constraints:
CREATE TABLE Customers (
Customer_ID INTEGER NOT NULL PRIMARY KEY,
First_name VARCHAR(100),
Last_name VARCHAR(100),
City VARCHAR(55),
Postal_Code VARCHAR(55),
Email VARCHAR(100),
Gender CHAR(10) NOT NULL,
DOB DATE CHECK (DOB <= '2005-12-31')
);

-- 2.Creating the second table to store customer account details with different data types and a PRIMARY KEY,FOREIGN KEY,CHECK, UNIQUE & NOT NULL constraints:
CREATE TABLE Accounts (
Account_number INT NOT NULL UNIQUE PRIMARY KEY,
Customer_ID INT,
Account_type VARCHAR(100),
Current_account_balance NUMERIC(7, 2) CHECK (Current_account_balance >= 100.00),
Has_Overdraft VARCHAR(10),
FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- 3.Creating the third table to store transaction details with different data types and a PRIMARY KEY,FOREIGN KEY,CHECK, UNIQUE & NOT NULL constraints:
CREATE TABLE Transactions (
Transaction_ID INT NOT NULL PRIMARY KEY,
Customer_ID INT NOT NULL,
Transaction_Date DATE,
Transaction_details VARCHAR(100),
Merchant_name VARCHAR(100),
Amount DECIMAL(10, 2),
Category_name VARCHAR(50),
FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- 4. Creating the fourth table to store spending categories:
CREATE TABLE Categories (
    Category_ID VARCHAR(50) UNIQUE PRIMARY KEY,
    Category_name VARCHAR(50)
);

-- 5.Creating the fifth table called Inflation_rates to store the inflation rate:
CREATE TABLE Inflation_rates (
Rate_ID INT PRIMARY KEY,
Year INT NOT NULL,
Month INT NOT NULL,
Inflation_Rate DECIMAL(3, 2)
);

-- 6. Creating table six called Weather_details to store weather details for July & August:
CREATE TABLE Weather_details (
Weather_Date DATE,
Weather VARCHAR(200)
);

-- Viewing all the tables in my database
SHOW TABLES;

/*
+ Use at least 3 queries to insert data
*/
-- TABLE 1 - Inserting data values for each column for the Customers table:
INSERT INTO Customers
(Customer_ID, First_name, Last_name, City, Postal_Code, Email, Gender, DOB)
VALUES
    (1, 'Perry', 'Pound', 'Manchester', 'M30 ODW', 'ppound0@imdb.com', 'Male', '1980-03-28'),
    (2, 'Shoshanna', 'Mathiassen', 'London', 'SW1A 1AA', 'smathiassen1@topsy.com', 'Female', '1993-05-16'),
    (3, 'Rupert', 'Lissenden', 'Birmingham', 'B90 5JS', 'rlissenden2@drupal.org', 'Male', '1994-02-20'),
    (4, 'Neile', 'Poad', 'Liverpool', 'L17 2LR', 'npoad3@soup.io', 'Male', '1985-07-16'),
    (5, 'Norene', 'Farnorth', 'Nottingham', 'NG7 2LR', 'nfarnorth6@histats.com', 'Female', '1987-01-26'),
    (6, 'Beau', 'McIlwraith', 'Manchester', 'M14 9DW', 'bmcilwraith5@earthlink.net', 'Male', '1976-07-13'),
    (7, 'Blisse', 'Liddiatt', 'London', 'E1 6QL', 'bliddiatt9@skyrock.com', 'Female', '1995-03-05'),
    (8, 'Andrea', 'De Giorgis', 'Sunderland', 'S80 OPW', 'adegiorgisc@goodreads.com', 'Female', '1999-06-10'),
    (9, 'Ulla', 'Yallop', 'Manchester', 'M24 9HV', 'uyallopf@dropbox.com', 'Female', '1991-05-12'),
    (10, 'Uche', 'Warren', 'Sunderland', 'M30 ODW', 'Uwarreng@msn.com', 'Female', '1993-09-20'),
    (11, 'Alice', 'Smith', 'London', 'SW1A 1AA', 'aliceSmith@dropbox.com', 'Female', '1995-08-15'),
    (12, 'John', 'Doe', 'Nottingham', 'MR7 3LP', 'johnDoe@skyrock.com', 'Male', '1988-12-10'),
    (13, 'Emily', 'Johnson', 'Birmingham', 'B97 9JY', 'emilyJohnson@goodreads.com', 'Female', '1992-05-20'),
    (14, 'David', 'Brown', 'Liverpool', 'L19 9RR', 'davidBrown@imdb.com', 'Male', '1990-03-02'),
    (15, 'Sophia', 'Wilson', 'Liverpool', 'L37 9LR', 'sophiaWilson@topsy.com', 'Female', '1985-11-08');

-- Viewing data from the Customers table
SELECT * FROM Customers;

-- Using the DATE_FORMAT function to format the date date to a UK format
SELECT DATE_FORMAT(DOB, '%d/%m/%Y') AS formatted_date FROM Customers;

-- Altering the 'Account_number' column data type to ensure large set of numbers are used in my table
ALTER TABLE Accounts
MODIFY COLUMN Account_number BIGINT;

-- TABLE 2 - Inserting data values for each column for the Accounts table:----------------------------------------------------------
INSERT INTO Accounts
(Account_number,Customer_ID,Account_type,Current_account_balance,Has_Overdraft)
VALUES
(2407337455,1,'Debit',2000.00,'No'),
(2467312218,2,'Debit',900.00,'No'),
(9861002204,3,'Debit',750.57,'No'),
(5921311391,4,'Debit',450.75,'No'),
(7269096047,5,'Debit',200.92,'No'),
(6475704857,6,'Debit',300.00,'No'),
(5279088936,7,'Debit',150.55,'No'),
(1173392482,8,'Debit',200.97,'No'),
(5094161649,9,'Debit', 199.99,'No'),
(8660739778,10,'Debit',120.00,'No'),
(1234567890,11,'Debit',120.00,'No'),
(9876543210,12,'Debit',1200.00,'No'),
(5555555555,13,'Debit',6000.00,'No'),
(9999999999,14,'Debit',5000.00,'No'),
(1111111111,15,'Debit',190.00,'No');

-- Viewing data from the Accounts table
SELECT * FROM Accounts;

-- TABLE 3 - Inserting data values for each column for the Transactions table:------------------------------------------------------
INSERT INTO Transactions
(Transaction_ID,Customer_ID,Transaction_Date,Transaction_details,Merchant_name, Amount,Category_name)
VALUES
(1001, 1, '2023-07-01', 'Lunch at a bakery', 'Gails', 50.00, 'Eating & Drinking'),
(1002, 1, '2023-07-15', 'Beyonce Concert Ticket', 'Ticketmaster', 340.99, 'Hospitality and Leisure'),
(1003, 2, '2023-07-05', 'Holiday to Greece', 'KLM Flights', 1200.00, 'Travel'),
(1004, 2, '2023-08-30', 'Barbie Tickets', 'Everyman Cinema', 100.60, 'Hospitality and Leisure'),
(1005, 3, '2023-07-04', 'Zara Online Store', 'Inditex', 500.50, 'Retail'),
(1006, 3, '2023-08-19', 'Oppenheimer Tickets', 'Odeon', 50.45, 'Hospitality and Leisure'),
(1007, 4, '2023-07-15', 'Dinner at a restaurant', 'Tattu Restaurant', 190.99, 'Eating & Drinking'),
(1008, 4, '2023-08-18', 'Barbie Tickets', 'Vue Cinema', 27.95, 'Hospitality and Leisure'),
(1009, 5, '2023-07-08', 'Barbie Tickets', 'Vue Cinema', 59.00, 'Hospitality and Leisure'),
(1010, 5, '2023-08-28', 'Lunch at restaurant', 'Nandos', 67.00, 'Eating & Drinking'),
(1011, 6, '2023-07-08', 'Zara Online Store', 'Inditex', 109.00, 'Retail'),
(1012, 6, '2023-08-25', 'Holiday to Italy', 'Ryanair', 870.00, 'Travel'),
(1013, 7, '2023-07-04', 'Zara Online Store', 'Inditex', 100.00, 'Retail'),
(1014, 7, '2023-08-21', 'Oppenheimer Tickets', 'Odeon', 35.00, 'Hospitality and Leisure'),
(1015, 8, '2023-07-08', 'Day flight Milan', 'Ryan Air', 60.95, 'Travel'),
(1016, 8, '2023-08-24', 'Holiday to Turkey', 'KLM Flights', 1600.00, 'Travel'),
(1017, 9, '2023-07-01', 'Oppenheimer Tickets', 'Odeon', 45.00, 'Hospitality and Leisure'),
(1018, 9, '2023-08-08', 'Grocery Warehouse', 'Costco Wholesale', 350.00, 'Grocery'),
(1019, 10, '2023-07-09', 'Oppenheimer Tickets', 'Odeon', 25.66, 'Hospitality and Leisure'),
(1020, 10, '2023-08-22', 'Holiday to France', 'Air France', 1167.00, 'Travel'),
(1021, 10, '2023-07-04', 'Coffee', 'Starbucks', 19.22, 'Eating & Drinking'),
(1022, 1, '2023-07-23', 'Home Improvement Store', 'Ikea', 595.00, 'Home & Garden'),
(1023, 1, '2023-08-30', 'Train ticket', 'Virgin Train', 120.00, 'Transport'),
(1024, 10, '2023-07-31', 'Barbie Tickets', 'Vue Cinema', 29.29, 'Hospitality and Leisure'),
(1025, 10, '2023-07-18', 'Barbie Tickets', 'Vue Cinema', 29.30, 'Hospitality and Leisure'),
(1026, 3, '2023-07-14', 'Barbie Tickets', 'Vue Cinema', 13.98, 'Hospitality and Leisure'),
(1027, 3, '2023-08-19', 'Topshop', 'Asos', 50.99, 'Retail'),
(1028, 4, '2023-07-04', 'Diesel Fuel', 'Morrisons', 80.00, 'Fuel'),
(1029, 5, '2023-08-30', 'Sushi Restaurant', 'Yo Sushi', 99.00, 'Eating & Drinking'),
(1030, 7, '2023-07-05', 'Train ticket', 'Northern Train', 125.00, 'Transport'),
(1051, 11, '2023-07-14', 'Fast Food', 'KFC', 12.99, 'Eating & Drinking'),
(1052, 12, '2023-08-21', 'Hardware Store', 'Ikea', 85.60, 'Home & Garden'),
(1053, 13, '2023-08-21', 'Bookstore', 'Amazon', 27.50, 'Books'),
(1054, 14, '2023-07-14', 'Gas Station', 'BP', 38.75, 'Fuel'),
(1055, 15, '2023-07-23', 'Grocery', 'Aldi', 62.30, 'Groceries'),
(1056, 11, '2023-08-15', 'London Fashion', 'COS', 99.95, 'Clothing'),
(1057, 12, '2023-08-14', 'London restaurant', 'Hakkassan', 299.99, 'Eating & Drinking'),
(1058, 13, '2023-08-08', 'Bus', 'First', 5.25, 'Transportation'),
(1059, 14, '2023-08-28', 'Train to Paris', 'Euro Star', 110.00, 'Travel'),
(1060, 15, '2023-08-08', 'Bookstore', 'Waterstone', 31.75, 'Books');

-- Viewing data from the Accounts table
SELECT * FROM Transactions;

-- Selecting distinct category Names to populate the Categories table
SELECT DISTINCT Category_name
FROM Transactions;

-- Using the UPDATE statement to modify existing records in a table. (DML commands)
UPDATE Transactions
SET Category_name = 'Groceries'
WHERE Transaction_ID = 1018;

UPDATE Transactions
SET Category_name = 'Transportation'
WHERE Transaction_ID = 1023;

-- Had to do this separately instead of using AND because I the ran the previous code first.
UPDATE Transactions
SET Category_name = 'Transportation'
WHERE Transaction_ID = 1030;

SELECT * FROM Transactions;

-- Using the ALTER TABLE statement to add a new column to the table.
ALTER TABLE Transactions
ADD Weather_Details VARCHAR(100);

-- Dropping the weather column as I think it would be better to create a different table to document this data
ALTER TABLE Transactions
DROP COLUMN Weather_Details;

/* + Use at least 1 query to delete data */
-- Deleting a row of data with Transaction_ID 1056 (DML commands)
DELETE FROM Transactions
WHERE
    Transaction_ID = 1056;

SELECT * FROM Transactions;

-- TABLE 4 - Inserting data values for each column for the spending categories:
INSERT INTO Categories
(Category_ID, Category_name)
VALUES
    ('1GR','Groceries'),
	('2BS','Books'),
	('3TR','Travel'),
	('4ED','Eating & Drinking'),
    ('5CG','Clothing'),
	('6TP','Transportation'),
	('7HL','Hospitality and Leisure'),
	('8RT','Retail'),
    ('9HG','Home & Garden'),
    ('10FL','Fuel');

SELECT * FROM Categories;

-- TABLE 5 - Inserting data values for each column for the Inflation_rates table:
INSERT INTO Inflation_rates
(Rate_ID,year,month,Inflation_Rate)
VALUES
(50,2023, '07',6.8),
(51,2023, '08',7.5);

SELECT * FROM Inflation_rates;


-- Selecting distict the Transaction_Date to populate the Weather_Details table
SELECT DISTINCT Transaction_Date
FROM Transactions
ORDER BY Transaction_Date ASC; -- using order by In Ascending order

-- TABLE 6 - Inserting data values for each column for the Inflation_rates table:
INSERT INTO Weather_Details
(Weather_Date, Weather )
VALUES
('2023-07-01','Sunny'),
('2023-07-04','Cloudy'),
('2023-07-05','Rainy'),
('2023-07-08','Sunny'),
('2023-07-09','Cloudy'),
('2023-07-14','Rainy'),
('2023-07-15','Cloudy'),
('2023-07-18','Rainy'),
('2023-07-23','Rainy'),
('2023-07-31','Cloudy'),
('2023-08-08','Sunny'),
('2023-08-14','Sunny'),
('2023-08-18','Sunny'),
('2023-08-19','Sunny'),
('2023-08-21','Sunny'),
('2023-08-22','Rainy'),
('2023-08-24','Rainy'),
('2023-08-25','Rainy'),
('2023-08-28','Rainy'),
('2023-08-30','Sunny');

SELECT * FROM Weather_Details;


-- QUERIES TO RETRIEVE DATA -------------------------------------------------------------------------------------------------------------------------------------

/*
 + Use at least 2 aggregate functions & + Use at least 2 in-built functions
 + Use data sorting for majority of queries with ORDER BY
*/

-- 1. Counting the number of items for each distinct Category_name in the 'Transactions' table using the 'COUNT()' function along with the 'GROUP BY' clause.
SELECT
    Category_name, COUNT(*) AS Item_Count
FROM
    Transactions
GROUP BY Category_name
ORDER BY Item_Count DESC; -- In decending order

-- 2. Finding out the total sum amount and average sum spend within each category name using SUM & AVG & COUNT:
 -- Using the ROUND in-built function to round avg amount to specific decimal value
SELECT
    Category_name,
    COUNT(*) AS Item_total,
    SUM(Amount) AS Total_Amount,
    ROUND(AVG(Amount), 2) AS Average_Amount
FROM
    Transactions
GROUP BY Category_name
ORDER BY Item_total DESC;

-- 3. Finding out the minimum and maximum amount spent for each category using MIN & MAX :
SELECT
    Category_name,
    MIN(Amount) AS Min_Amount,
    MAX(Amount) AS Max_Amount
FROM
    Transactions
GROUP BY
    Category_name;

/*
+ Use at least 5 queries to retrieve data
+ Use data sorting for majority of queries with ORDER BY
+ Use at least 2 in-built functions -STR_TO_DATE */

-- 1.Retrieving Transaction Data between specific dates and formatting the date to UK format:
SELECT Transaction_details,Merchant_name,Amount, Category_name,
DATE_FORMAT(Transaction_Date, '%d/%m/%Y') AS Date
FROM Transactions
WHERE Transaction_Date BETWEEN '2023-07-22' AND '2023-08-18'
ORDER BY Amount;

-- 2.Retrieving Inflation Rate for August 2023:
SELECT Inflation_rate
FROM Inflation_rates
WHERE Year = 2023 AND Month = 08;

-- 3.Identify the top spending categories among all customers
SELECT T.Category_name, SUM(T.Amount) AS Top_spent
FROM Transactions AS T
GROUP BY T.Category_name
ORDER BY Top_spent DESC;

-- 4.Calculate the average spending for each day of the week.
SELECT DAYNAME(Transaction_date) AS DayOfWeek, ROUND(AVG(Amount), 2) AS Avg_Spent
FROM Transactions
GROUP BY DayOfWeek
ORDER BY Avg_Spent DESC;

-- 5. Analyse spending trends at 'Vue Cinema' and convert the date into a readable format.
SELECT DATE_FORMAT(Transaction_Date, '%W %M %Y') AS 'Formatted Transaction Date',
SUM(Amount) AS Total_Spent
FROM Transactions
WHERE Merchant_name = 'Vue Cinema'
GROUP BY Transaction_date
ORDER BY Transaction_date;


-- 6. To find the top 10 merchants based on the total amount spent and aggregates transaction data by merchant and orders the results by the total amount spent in descending order.
SELECT Merchant_name AS Top_Merchants , SUM(Amount) AS Total_Spent
FROM Transactions
GROUP BY Merchant_name
ORDER BY Total_Spent DESC
LIMIT 10;


/*
+ Use at least 2 joins
+ Use data sorting for majority of queries with ORDER BY */

-- 1.Find out the total amount spent by each customer using Left Join:
SELECT C.First_name,C.Last_name,C.City,SUM(T.Amount) AS Total_spent
FROM Customers AS C
LEFT JOIN Transactions AS T
ON C.Customer_ID = T.Customer_ID
GROUP BY C.Customer_ID,C.First_name
ORDER BY Total_Spent DESC;

-- 2.Calculate the average spending per month for each customer.
SELECT C.Customer_ID,C.First_name,C.Last_name, ROUND(AVG(T.Amount),2) AS Avg_Spending_Per_Month
FROM Customers AS C
LEFT JOIN Transactions AS T
ON C.Customer_ID = T.Customer_ID
GROUP BY C.Customer_ID,C.First_name
ORDER BY Avg_Spending_Per_Month ASC;

-- 3. Find customers with spending above a certain threshold - DATE,WEATHER CATERGORY NAME, INFLATION FOR THAT MONTH
SELECT C.First_name,C.Gender,C.City, SUM(T.Amount) AS Above_spent
FROM Customers AS C
JOIN Transactions AS T
ON C.Customer_ID = T.Customer_ID
GROUP BY C.Customer_ID, C.First_name
HAVING Above_spent > 1000;

-- 4. Find customers with spending above a certain threshold including the DATE,WEATHER CATERGORY NAME, INFLATION RATE FOR THAT MONTH

SELECT
    T.Customer_ID,
    I.Inflation_rate,
    DATE_FORMAT(Transaction_Date, '%W %M %Y') AS 'Formatted Transaction Date',
    W.Weather,
    C.Category_name,
    SUM(T.Amount) AS Total_Spending
FROM
    Transactions AS T
        JOIN
    Weather_details AS W ON T.Transaction_date = W.Weather_Date
        JOIN
    Categories AS C ON T.Category_name = C.Category_name
        JOIN
    Inflation_rates AS I ON YEAR(T.Transaction_Date) = I.Year
        AND MONTH(T.Transaction_Date) = I.Month
GROUP BY T.Customer_ID , T.Transaction_Date , W.Weather , C.Category_name , I.Inflation_Rate
HAVING SUM(T.Amount) > 200
ORDER BY T.Customer_ID;

/*
+ Create and use one stored procedure or function to achieve a goal
- creating a stored procedure to calculate total spending by category within a specified date range.
It joins the Categories and Transactions tables on the Category_name field and calculates the sum of the Amount for each category.
*/
-- Create a stored procedure to calculate total spending by category
-- Using Delimiter
DELIMITER //

-- Create the stored procedure
CREATE PROCEDURE CalculateTotalSpendingByCategory(
    IN startDate DATE,
    IN endDate DATE
)
BEGIN
    SELECT
        c.Category_name,
        SUM(t.Amount) AS TotalSpending
    FROM
        Categories c
    LEFT JOIN
        Transactions t ON c.Category_name = t.Category_name
    WHERE
        t.Transaction_Date BETWEEN startDate AND endDate
    GROUP BY
        c.Category_name;
END;
//

DELIMITER ;

-- using the SP and calling it by providing startDate and endDate parameters
CALL CalculateTotalSpendingByCategory('2023-07-01', '2023-08-18');
