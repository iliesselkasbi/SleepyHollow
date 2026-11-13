BEGIN
    FOR t IN (
        SELECT table_name FROM user_tables
        WHERE table_name IN (
            'EMPLOYEES', 'LOGIN', 'PHONES', 'ADDRESSES', 'CUSTOMERS',
            'CALLS', 'PRODUCTS', 'INVENTORIES', 'QUOTA_OFFERS', 'AWARDS',
            'AWARD_CENTERS', 'EMP_SALES', 'EMP_MONTH_YEAR', 'TRANSACTIONS',
            'CERTIFICATE', 'TXNS_PRODS', 'TRANSFER', 'GRANTED', 'CONTAIN',
            'TXNS_PROD_INV'

        )
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
END;
/


-- Professor's Create tables.

CREATE TABLE Employees(
name VARCHAR2(30),
ssn VARCHAR2(11),
dob DATE,
marital_status VARCHAR2(10),
sex VARCHAR2(1),
dependent# NUMBER,
PRIMARY KEY (ssn)
);
CREATE TABLE Login(
username VARCHAR2(30),
passwd VARCHAR2(30),
ssn VARCHAR2(11),
PRIMARY KEY (username),
FOREIGN KEY (ssn) REFERENCES Employees
);
CREATE TABLE Phones(
phone_num NUMBER(12, 0),
ssn VARCHAR2(11),
PRIMARY KEY (ssn, phone_num),
FOREIGN KEY (ssn) REFERENCES Employees
);
CREATE TABLE Addresses(
bldg# NUMBER,
street VARCHAR2(20),
city VARCHAR2(20),
state VARCHAR2(20),
zip NUMBER(5, 0),
ssn VARCHAR2(11),
PRIMARY KEY (ssn,bldg#, street, city, state, zip),
FOREIGN KEY (ssn) REFERENCES Employees
);
CREATE TABLE Customers(
cust_id NUMBER(10, 0),
cust_name VARCHAR2(20),
phone_num NUMBER(12, 0),
PRIMARY KEY (cust_id)
);
CREATE TABLE Calls(
c_id NUMBER(10, 0),
c_time TIMESTAMP,
c_date DATE,
c_duration NUMBER(10,0),
c_status VARCHAR2(10),
cust_id NUMBER(10, 0),
ssn VARCHAR2(11),
PRIMARY KEY (c_id),
FOREIGN KEY (cust_id) REFERENCES CUSTOMERS,
FOREIGN KEY (ssn) REFERENCES EMPLOYEES
);
CREATE TABLE Products(
prod_id NUMBER(10, 0),
prod_name VARCHAR2(20),
p_price NUMBER(15, 2),
PRIMARY KEY(prod_id)
);
CREATE TABLE Inventories(
inv_id NUMBER(10, 0),
inv_location VARCHAR2(30),
inv_name VARCHAR2(30),
PRIMARY KEY (inv_id)
);
CREATE TABLE Quota_Offers(
o_id NUMBER(10, 0),
o_date DATE,
o_description VARCHAR2(50),
PRIMARY KEY(o_id)
);
CREATE TABLE Awards(
award_id NUMBER(10, 0),
max_sale NUMBER(15, 2),
min_sale NUMBER(15, 2),
type VARCHAR2(30),
PRIMARY KEY (award_id)
);
CREATE TABLE Award_Centers(
center_id NUMBER(10, 0),
center_name VARCHAR2(30),
center_location VARCHAR2(30),
PRIMARY KEY (CENTER_ID)
);
CREATE TABLE Emp_Sales(
account_id NUMBER(10, 0),
Year NUMBER(4, 0),
total_sales NUMBER(15, 2),
jan NUMBER(15, 2),
feb NUMBER(15, 2),
mar NUMBER(15, 2),
apr NUMBER(15, 2),
may NUMBER(15, 2),
jun NUMBER(15, 2),
jul NUMBER(15, 2),
aug NUMBER(15, 2),
sep NUMBER(15, 2),
oct NUMBER(15, 2),
nov NUMBER(15, 2),
dec NUMBER(15, 2),
ssn VARCHAR2(11),
PRIMARY KEY(account_id,year),
FOREIGN KEY(ssn) REFERENCES EMPLOYEES
);
CREATE TABLE Emp_Month_Year(
achievement_id NUMBER(10, 0),
sales_amount NUMBER(15, 2),
date_of_achvmnt NUMBER(4, 0),
type_of_achvmnt VARCHAR2(10),
account_id NUMBER(10, 0),
Year NUMBER(4, 0),
PRIMARY KEY(achievement_id),
FOREIGN KEY(account_id,year) REFERENCES Emp_Sales(account_id,year)
);
CREATE TABLE Transactions(
trans_id NUMBER(10, 0),
t_date DATE,
amount NUMBER(15, 2),
t_description VARCHAR2(20),
ssn VARCHAR2(11),
account_id NUMBER(10, 0),
Year NUMBER(4, 0),
PRIMARY KEY (trans_id),
FOREIGN KEY(ssn) REFERENCES Employees,
FOREIGN KEY(account_id,year) REFERENCES Emp_Sales(account_id,year)
);
CREATE TABLE Certificate(
certificate_id NUMBER(10, 0),
cert_date DATE,
achievement_id NUMBER(10, 0),
PRIMARY KEY(certificate_id),
FOREIGN KEY(achievement_id) REFERENCES Emp_Month_Year
);
-- mapping the M-to-M relationship between products and transactions

CREATE TABLE Txns_Prods(
trans_id NUMBER(10, 0),
prod_id NUMBER(10, 0),
quantity NUMBER(4, 0),
PRIMARY KEY(trans_id, prod_id),
FOREIGN KEY(prod_id) REFERENCES PRODUCTS,
FOREIGN KEY(trans_id) REFERENCES TRANSACTIONS
);
-- Mapping the Transfer M-to-M reflexive relationship
CREATE TABLE Transfer(
from_ssn VARCHAR2(11),
to_ssn VARCHAR2(11),
transfer_date DATE,
amount NUMBER(15, 0),
PRIMARY KEY(from_ssn, to_ssn, transfer_date),
FOREIGN KEY(from_ssn) REFERENCES EMPLOYEES (SSN),
FOREIGN KEY(to_ssn) REFERENCES EMPLOYEES (SSN)
);
--Mapping the M-to-M relation between Employees and Awards in the aggregation.
--Moreover, It also maps the relationship with Award_Centers and Emp_Month_Year.

CREATE TABLE GRANTED(
ssn VARCHAR2(11),
award_id NUMBER(10, 0),
award_date DATE,
quantity NUMBER(4, 0),
center_id NUMBER(10, 0),
achievement_id NUMBER(10, 0),
PRIMARY KEY(ssn, award_id, award_date),
FOREIGN KEY (ssn) REFERENCES Employees(ssn),
FOREIGN KEY (award_id) REFERENCES awards (award_id),
FOREIGN KEY (center_id) REFERENCES Award_Centers (center_id),
FOREIGN KEY (achievement_id) REFERENCES Emp_Month_Year (achievement_id)
);
-- mapping the aggregation between products and inventories and then the
--relationship with Quota_Offers
CREATE TABLE Contain(
prod_id NUMBER(10, 0),
inv_id NUMBER(10, 0),
quantity NUMBER (4, 0),
increase_percent NUMBER(4, 2),
o_id NUMBER(10, 0),
PRIMARY KEY(prod_id, inv_id),
FOREIGN KEY(prod_id) REFERENCES Products (prod_id),
FOREIGN KEY(inv_id) REFERENCES Inventories (inv_id),
FOREIGN KEY (o_id) REFERENCES Quota_Offers (o_id)
);
-- Mapping the increase relationship between transactions and the products- inventories aggregation
CREATE TABLE Txns_Prod_Inv(
prod_id NUMBER(10, 0),
inv_id NUMBER(10, 0),
trans_id NUMBER(10, 0),
PRIMARY KEY(prod_id, inv_id, trans_id),
FOREIGN KEY(prod_id) REFERENCES Products (prod_id),
FOREIGN KEY(inv_id) REFERENCES Inventories (inv_id),
FOREIGN KEY (trans_id) REFERENCES Transactions (trans_id)
);















