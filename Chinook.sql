-- 1.0	Setting up Oracle Chinook
-- In this section you will begin the process of working with the Oracle Chinook database
-- Task – Open the Chinook_Oracle.sql file and execute the scripts within.
-- 2.0 SQL Queries
-- In this section you will be performing various queries against the Oracle Chinook database.
-- 2.1 SELECT
-- Task – Select all records from the Employee table.
SELECT * FROM employee;
-- Task – Select all records from the Employee table where last name is King.
SELECT * FROM employee WHERE lastname = 'King';
-- Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
SELECT * FROM employee WHERE firstname = 'Andrew' AND reportsto IS NULL;
-- 2.2 ORDER BY
-- Task – Select all albums in Album table and sort result set in descending order by title.
SELECT * FROM album ORDER BY title DESC;
-- Task – Select first name from Customer and sort result set in ascending order by city
SELECT firstname, city FROM customer ORDER BY city;
-- 2.3 INSERT INTO
-- Task – Insert two new records into Genre table
INSERT into genre (genreid, name)
    VALUES (26, 'K-pop'), (27, 'Indie');
-- Task – Insert two new records into Employee table
INSERT into employee (employeeid, lastname, firstname, title, reportsto)
    VALUES (88, 'Morgan', 'Danae', 'Person', null),
    (86, 'James', 'Bob', 'Sale Support Agent', 1);
-- Task – Insert two new records into Customer table
INSERT into genre (genreid, name)
    VALUES (26, 'K-pop'), (27, 'Indie');
-- 2.4 UPDATE
-- Task – Update Aaron Mitchell in Customer table to Robert Walter
UPDATE customer SET firstname = 'Robert', lastname = 'Walter' 
WHERE firstname = 'Aaron' AND lastname = 'Mitchell';
-- Task – Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR”
UPDATE artist SET name = 'CCR'
WHERE name ='Creedence Clearwater Revival';
-- 2.5 LIKE
-- Task – Select all invoices with a billing address like “T%”
SELECT * FROM invoice WHERE billingaddress LIKE 'T%';
-- 2.6 BETWEEN
-- Task – Select all invoices that have a total between 15 and 50
SELECT * FROM invoice GROUP BY total, invoiceid HAVING SUM (total)>15 AND SUM (total)<50;
-- Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
SELECT * FROM employee WHERE hiredate > TIMESTAMP '2003-06-01' AND 
hiredate < TIMESTAMP '2004-03-01'; 
-- 2.7 DELETE
-- Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
ALTER TABLE invoice
DROP CONSTRAINT fk_invoicecustomerid

ALTER TABLE invoice
ADD CONSTRAINT fk_customerid
FOREIGN KEY (customerid) REFERENCES chinook.customer (customer) ON DELETE CASCADE

ALTER TABLE invoiceline
DROP CONSTRAINT fk_invoicelineinvoiceid

ALTER TABLE invoiceline
AND CONSTRAINT fk_invoiceline_id
FOREIGN KEY (invoiceid) REFERENCES chinook.invoice (invoiceid) ON DELETE CASCADE;

-- 3.0	SQL Functions
-- In this section you will be using the Oracle system functions, as well as your own functions, to perform various actions against the database
-- 3.1 System Defined Functions
-- Task – Use a function that returns the current time.
SELECT CURRENT_TIME;
-- Task – Use a function that returns the length of a mediatype from the mediatype table
--If you mean length of the table:
SELECT COUNT (mediatypeid) FROM mediatype;
--If you mean length of each name in the table:
SELECT length(name) from mediatype;
-- 3.2 System Defined Aggregate Functions
-- Task – Use a function that returns the average total of all invoices
SELECT AVG (total) FROM invoice;
-- Task – Use a function that returns the most expensive track
--For more expensive track price:
SELECT MAX (unitprice) FROM track;
--For names of the tracks with that price
SELECT * from track WHERE unitprice IN (
SELECT MAX (unitprice) FROM track);
-- 7.0 JOINS
-- In this section you will be working with combing various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.
-- 7.1 INNER
-- Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
SELECT customer.firstname, customer.lastname, invoice.invoiceid FROM customer
INNER JOIN invoice ON customer.customerid = invoice.invoiceid;
-- 7.2 OUTER
-- Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.
SELECT customer.customerid, customer.firstname, customer.lastname, invoice.invoiceid, invoice.total FROM customer
LEFT JOIN invoice ON customer.customerid = invoice.invoiceid;
-- 7.3 RIGHT
-- Task – Create a right join that joins album and artist specifying artist name and title.
SELECT artist.name, album.title FROM artist
RIGHT JOIN album ON artist.artistid = album.albumid
-- 7.4 CROSS
-- Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
SELECT * FROM album
CROSS JOIN artist ORDER BY artist.name ASC;
-- 7.5 SELF
-- Task – Perform a self-join on the employee table, joining on the reportsto column.
SELECT * FROM employee
INNER JOIN employee ON employee.employeeid = employee.reportsto