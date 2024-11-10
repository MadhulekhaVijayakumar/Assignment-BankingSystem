--Task 1
--1.Create the database named "HMBank"
create database HMBank
use HMBank

--2.Define the schema for the Customers, Accounts, and Transactions tables based on the provided schema
--Customer table
create table Customers(
customer_id int identity primary key,
first_name varchar(25) not null,
last_name varchar(25) not null,
DOB date not null,
email varchar(100),
phone_number varchar(20),
cus_address varchar(200))
drop table Accounts
--Accounts table
create table Accounts(
account_id int primary key,
customer_id int,
account_type varchar(50),
balance decimal(18, 2) default 0)
drop table Transactions
--Transactions table
create table Transactions (
transaction_id int primary key,
account_id int,
transaction_type varchar(50),
amount decimal(18, 2) NOT NULL,
transaction_date date)

--5.Create appropriate Primary Key and Foreign Key constraints for referential integrity.
--foreign key constraint for accounts table
alter table Accounts
add constraint FK_Accounts_Customers
foreign key(customer_id) References Customers(customer_id)
on delete cascade

--foreign key constraint for Transactions table
alter table Transactions
add constraint FK_Transactions_Accounts
foreign key(account_id) References Accounts(account_id)
on delete cascade

--Tasks 2: Select, Where, Between, AND, LIKE
--1. Insert at least 10 sample records into each of the following tables.
-- Insert records into Customers table
insert into Customers (first_name, last_name, DOB, email, phone_number, cus_address)
values ('John', 'Joy', '1985-05-15', 'john.joy@example.com', '7859644235', '123 Main St, Banglore'),
    ('preeti', 'Smith', '1990-07-22', 'preeti.smith@example.com', '8569742351', '456 Elm St, Chennai'),
    ('Rob', 'Johnson', '1988-03-30', 'rob.j@example.com', '3456789012', '789 Oak St, Banglore'),
    ('Ram', 'Priya', '1992-01-14', 'ram.p@example.com', '7894256813', '321 Map st, Coimbatore'),
    ('Madhu', 'Shree', '1985-12-21', 'madhu.w@example.com', '8569741235', '654 Pine St, Mumbai'),
    ('Anu', 'Sudha', '1979-09-05', 'anu.s@example.com', '6789012345', '987 y Rd, Pune'),
    ('Taylor', 'Jones', '1983-11-19', 'taylor.j@example.com', '1234567890', '123 gandhi St, Coimbatore'),
    ('Patricia', 'Garcia', '1975-02-23', 'patricia.g@example.com', '1098765432', '456 Spruce St, Pune'),
    ('David', 'Martinez', '1995-06-10', 'david.m@example.com', '9012345678', '789 Willow St, Bangalore'),
    ('Jennifer', 'Anderson', '1987-04-17', 'jennifer.a@example.com', '9985741124', '321 Aspen Ave, Delhi')

--Insert records into Account table
insert into Accounts (account_id, customer_id, account_type, balance)
values (101, 1, 'savings', 50000.75),
    (102, 2, 'current', 150000.00),
    (103, 3, 'savings', 25000.50),
    (104, 4, 'zero_balance', 0.00),
    (105, 5, 'savings', 35000.00),
    (106, 6, 'current', 200000.00),
    (107, 7, 'savings', 48000.00),
    (108, 8, 'zero_balance', 0.00),
    (109, 9, 'savings', 70000.25),
    (110, 10, 'current', 120000.00)

--Insert records into Transaction table
insert into Transactions (transaction_id, account_id, transaction_type, amount, transaction_date)
values (1001, 101, 'deposit', 10000.00, '2024-01-15'),
    (1002, 102, 'withdrawal', 5000.00, '2024-02-12'),
    (1003, 103, 'transfer', 1500.00, '2024-03-10'),
    (1004, 104, 'deposit', 3000.00, '2024-04-05'),
    (1005, 105, 'withdrawal', 2000.00, '2024-05-01'),
    (1006, 106, 'deposit', 25000.00, '2024-06-18'),
    (1007, 107, 'transfer', 5000.00, '2024-07-20'),
    (1008, 108, 'deposit', 15000.00, '2024-08-25'),
    (1009, 109, 'withdrawal', 3000.00, '2024-09-30'),
    (1010, 110, 'transfer', 4500.00, '2024-10-15')

--2. Write SQL queries for the following tasks
--	1. Write a SQL query to retrieve the name, account type and email of all customers.
select c.first_name,c.last_name,a.account_type,c.email
from Customers as c
join
Accounts as a on c.customer_id=a.customer_id

--2. Write a SQL query to list all transaction corresponding customer.
select c.first_name,c.last_name,t.transaction_id,t.transaction_type,t.amount,t.transaction_date
from Customers as c
join
Accounts as a on c.customer_id=a.customer_id
join
Transactions as t on a.account_id=t.account_id

--3. Write a SQL query to increase the balance of a specific account by a certain amount.
update Accounts set balance=balance+600
where account_id=102

--4. Write a SQL query to Combine first and last names of customers as a full_name.
select customer_id ,first_name +' '+last_name 
as full_name from Customers

--5. Write a SQL query to remove accounts with a balance of zero where the account type is savings.
delete from Accounts 
where balance =0 and account_type='savings'

--6. Write a SQL query to Find customers living in a specific city.
select customer_id,first_name,last_name,cus_address
from Customers
where cus_address Like '%Pune%'

--7. Write a SQL query to Get the account balance for a specific account.
select balance from Accounts
where account_id=105

--8. Write a SQL query to List all current accounts with a balance greater than $1,000.
select account_id,customer_id,balance 
from Accounts
where account_type='current' and balance>1000

--9. Write a SQL query to Retrieve all transactions for a specific account.
select transaction_id,transaction_type,amount,transaction_date
from Transactions
where account_id=105

--10. Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.
select account_id,balance,
balance*0.06 as interest_accured
from Accounts
where account_type='savings'

--11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.
select account_id,customer_id,balance
from Accounts
where balance < 5000

--12. Write a SQL query to Find customers not living in a specific city.
select customer_id,first_name,last_name,cus_address
from Customers
where cus_address not like '%Coimbatore%'

--Task 3: Aggregate functions, Having, Order By, GroupBy and Joins
--1. Write a SQL query to Find the average account balance for all customers. 
select avg(balance) as average_balance
from Accounts

--2. Write a SQL query to Retrieve the top 10 highest account balances.
select top 10 account_id,
customer_id,balance
from Accounts
order by balance desc

--3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
select sum(amount) as total_deposits
from Transactions
where transaction_type = 'deposit' and transaction_date = '2024-06-18'

--4. Write a SQL query to Find the Oldest and Newest Customers.
select  min(DOB) as oldest_customer,
		max(DOB) as newest_customer
from Customers

--5. Write a SQL query to Retrieve transaction details along with the account type.
select t.transaction_id,
	   t.account_id,
       t.transaction_type,
	   t.amount,
       t.transaction_date,
       a.account_type
from Transactions as t
JOIN 
Accounts as a on t.account_id = a.account_id

--6. Write a SQL query to Get a list of customers along with their account details.
select c.customer_id,
       c.first_name,
       c.last_name,
       a.account_id,
       a.account_type,
       a.balance
from Customers as c
JOIN 
Accounts as a on c.customer_id = a.customer_id

--7. Write a SQL query to Retrieve transaction details along with customer information for a specific account.
select t.transaction_id,
       t.transaction_type,
       t.amount,
       t.transaction_date,
       c.customer_id,
       c.first_name,
       c.last_name
from 
Transactions as t
JOIN 
Accounts as a on t.account_id = a.account_id
JOIN 
Customers as c on a.customer_id = c.customer_id
where 
t.account_id =102

--8. Write a SQL query to Identify customers who have more than one account.
insert into Customers (first_name, last_name, DOB, email, phone_number, cus_address)
values ('preeti','Smith','1990-07-22','preeti.smith@example.com','8569742351','456 Elm St,Chennai')
insert into Accounts (account_id, customer_id, account_type, balance)
values (111, 2, 'current', 102000)
insert into Transactions (transaction_id, account_id, transaction_type, amount, transaction_date)
values (1012, 102, 'deposit', 15000.00, '2024-06-15')
select customer_id,
       count(account_id) AS account_count
from Accounts
group by customer_id
having count(account_id) > 1

--9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.
select account_id,
       sum(case when transaction_type = 'deposit' then amount else 0 end) -
       sum(case when transaction_type = 'withdrawal' then amount else 0 end) as balance_diff
from Transactions
group by account_id;

--10. Write a SQL query to Calculate the average daily balance for each account over a specified period.
select a.account_id,
       avg(a.balance) as average_daily_balance
from Accounts as a
JOIN 
Transactions as t on a.account_id = t.account_id
where t.transaction_date between '2024-01-01' AND '2024-04-01'
group by 
a.account_id

--11. Calculate the total balance for each account type.
select account_type,
       sum(balance) as total_balance
from Accounts
GROUP BY 
account_type

--12. Identify accounts with the highest number of transactions order by descending order.
select account_id,
       count(transaction_id) as transaction_count
from Transactions
group by account_id
order by transaction_count desc

--13. List customers with high aggregate account balances, along with their account types.
select c.customer_id,c.first_name,c.last_name,a.account_type,
       sum(a.balance) as total_balance
from Customers as c
JOIN 
Accounts as a on c.customer_id = a.customer_id
group by 
c.customer_id, c.first_name, c.last_name, a.account_type
having 
sum(a.balance) > 100000

--14. Identify and list duplicate transactions based on transaction amount, date, and account.
select account_id,transaction_date,amount,
       count(*) as duplicate_count
from Transactions
group by account_id, transaction_date, amount
having count(*) > 1

--Tasks 4: Subquery and its type
--1. Retrieve the customer(s) with the highest account balance.
select customer_id,account_id,balance
from Accounts
where
    balance = (select max(balance) from Accounts)

--2. Calculate the average account balance for customers who have more than one account.
select avg(balance) as average_balance
from Accounts
where 
        customer_id IN (
        select customer_id
        from Accounts
        Group by customer_id
        Having  count(account_id) > 1
       )

--3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
select account_id,transaction_id,amount
from Transactions
where 
    amount > (select avg(amount) from Transactions)

--4. Identify customers who have no recorded transactions.
select c.customer_id,c.first_name,c.last_name
from Customers as c
where 
		c.customer_id NOT IN (
        select distinct a.customer_id
        from Accounts as a
        JOIN Transactions as t on a.account_id = t.account_id
    )

--5. Calculate the total balance of accounts with no recorded transactions.
select sum(balance) as total_balance_of_notransactions
from Accounts
where 
    account_id NOT IN (select distinct account_id from Transactions)

--6. Retrieve transactions for accounts with the lowest balance.
select t.transaction_id,
       t.account_id,
       t.transaction_type,
       t.amount,
       t.transaction_date
from Transactions as t
where 
		t.account_id in (
        select account_id 
        from Accounts 
        where balance = (select min(balance) from Accounts)
    )

--7.Identify customers who have accounts of multiple types.
select customer_id
from Accounts
group by customer_id
having count(distinct account_type) > 1

--8. Calculate the percentage of each account type out of the total number of accounts.
select account_type,
       count(*) * 100.0 / (select count(*) from Accounts) as percentage_of_total
from Accounts
group by account_type;

--9. Retrieve all transactions for a customer with a given customer_id.
select t.transaction_id,
	   t.account_id,
       t.transaction_type,
       t.amount,
       t.transaction_date
from Transactions as t
JOIN 
    Accounts as a on t.account_id = a.account_id
where 
a.customer_id = 2

--10. Calculate the total balance for each account type, including a subquery within the SELECT clause.
select account_type,
       (select sum(balance) from Accounts as a2 where a2.account_type = a1.account_type) as total_balance
from Accounts as a1
group by account_type

