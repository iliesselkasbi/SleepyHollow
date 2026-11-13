-- 1. EMPLOYEES (5 Entries)



INSERT INTO Employees (ssn, dob, name, marital_status, dependent#, sex)
VALUES ('123-45-6789', TO_DATE('15-May-90', 'DD-MON-RR'), 'Alice Smith', 'Married', 2, 'F');

INSERT INTO Employees (ssn, dob, name, marital_status, dependent#, sex)
VALUES ('987-65-4321', TO_DATE('22-Nov-95', 'DD-MON-RR'), 'Bob Jones', 'Single', 0, 'M');

INSERT INTO Employees (ssn, dob, name, marital_status, dependent#, sex)
VALUES ('555-55-5555', TO_DATE('08-Aug-88', 'DD-MON-RR'), 'Charlie Brown', 'Single', 1, 'M');

INSERT INTO Employees (ssn, dob, name, marital_status, dependent#, sex)
VALUES ('98765432111', TO_DATE('22-Nov-95', 'DD-MON-RR'), 'Bob Second', 'Single', 0, 'M');

INSERT INTO Employees (ssn, dob, name, marital_status, dependent#, sex)
VALUES ('111-22-3333', TO_DATE('24-Mar-92', 'DD-MON-RR'), 'Diana Prince', 'Single', 0, 'F');

-- ==========================================
-- 2. LOGIN (Tracks 4 accounts for testing logins)
-- ==========================================
INSERT INTO Login (username, passwd, ssn) VALUES ('jdoe', 'password123', '123-45-6789');
INSERT INTO Login (username, passwd, ssn) VALUES ('jsmith', 'secure456', '987-65-4321');
INSERT INTO Login (username, passwd, ssn) VALUES ('cbrown', 'goodgrief789', '555-55-5555');
INSERT INTO Login (username, passwd, ssn) VALUES ('dprince', 'amazon999', '111-22-3333');

-- ==========================================
-- 3. CUSTOMERS
-- ==========================================
INSERT INTO Customers (cust_id, cust_name, phone_num) VALUES (2001, 'Diamond Gym', 5551112222);
INSERT INTO Customers (cust_id, cust_name, phone_num) VALUES (2002, 'Shark Gym', 5553334444);
INSERT INTO Customers (cust_id, cust_name, phone_num) VALUES (2003, 'Big Guy Enterprise', 5555556666);

-- ==========================================
-- 4. PRODUCTS (All <= 20 Character Names)
-- ==========================================
INSERT INTO Products (prod_id, prod_name, p_price) VALUES (3001, 'Dumbbell', 500.00);
INSERT INTO Products (prod_id, prod_name, p_price) VALUES (3002, 'Smith Machine', 1200.00);
INSERT INTO Products (prod_id, prod_name, p_price) VALUES (3003, 'Bench', 350.00);

-- ==========================================
-- 5. INVENTORIES
-- ==========================================
INSERT INTO Inventories (inv_id, inv_location, inv_name) VALUES (4001, 'Virginia Gym World', 'VA_INV_01');
INSERT INTO Inventories (inv_id, inv_location, inv_name) VALUES (4002, 'California Iron', 'CA_INV_02');
INSERT INTO Inventories (inv_id, inv_location, inv_name) VALUES (4003, 'Ohio Fitness', 'OH_INV_03');

-- ==========================================
-- 6. QUOTA_OFFERS
-- ==========================================
INSERT INTO Quota_Offers (o_id, o_date, o_description) VALUES (5001, TO_DATE('01-Jan-26', 'DD-MON-RR'), 'Q1 Flash Inventory Markdown');
INSERT INTO Quota_Offers (o_id, o_date, o_description) VALUES (5002, TO_DATE('01-Apr-26', 'DD-MON-RR'), 'Spring Bundle Promotion');
INSERT INTO Quota_Offers (o_id, o_date, o_description) VALUES (5003, TO_DATE('01-Jul-26', 'DD-MON-RR'), 'Mid-Year Enterprise Quota Push');

-- ==========================================
-- 7. AWARDS
-- ==========================================
INSERT INTO Awards (award_id, max_sale, min_sale, type) VALUES (6001, 200000.00, 100000.00, 'Diamond Sales Certificate');
INSERT INTO Awards (award_id, max_sale, min_sale, type) VALUES (6002, 99999.99, 40000.00, 'Gold Circle Award');
INSERT INTO Awards (award_id, max_sale, min_sale, type) VALUES (6003, 39999.99, 10000.00, 'Rising Star Bonus');

-- ==========================================
-- 8. AWARD_CENTERS
-- ==========================================
INSERT INTO Award_Centers (center_id, center_name, center_location) VALUES (7001, 'East Coast HQ Awards', 'Fairfax, VA');
INSERT INTO Award_Centers (center_id, center_name, center_location) VALUES (7002, 'West Coast Gala Center', 'Los Angeles, CA');
INSERT INTO Award_Centers (center_id, center_name, center_location) VALUES (7003, 'Corporate Virtual Portal', 'Cincinnati, OH');

-- ==========================================
-- 9. PHONES
-- ==========================================
INSERT INTO Phones (phone_num, ssn) VALUES (7035550191, '123-45-6789');
INSERT INTO Phones (phone_num, ssn) VALUES (7035550192, '987-65-4321');
INSERT INTO Phones (phone_num, ssn) VALUES (2025550193, '555-55-5555');

-- ==========================================
-- 10. ADDRESSES
-- ==========================================
INSERT INTO Addresses (bldg#, street, city, state, zip, ssn) VALUES (4400, 'University Dr', 'Fairfax', 'VA', 22030, '123-45-6789');
INSERT INTO Addresses (bldg#, street, city, state, zip, ssn) VALUES (100, 'Main Street', 'Los Angeles', 'CA', 90001, '987-65-4321');
INSERT INTO Addresses (bldg#, street, city, state, zip, ssn) VALUES (500, 'Broadway Ave', 'New York', 'NY', 10001, '555-55-5555');

-- ==========================================
-- 11. CALLS
-- ==========================================
INSERT INTO Calls (c_id, c_time, c_date, c_duration, c_status, cust_id, ssn) 
VALUES (8001, TO_TIMESTAMP('2026-06-22 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('22-Jun-26', 'DD-MON-RR'), 120, 'Completed', 2001, '123-45-6789');

INSERT INTO Calls (c_id, c_time, c_date, c_duration, c_status, cust_id, ssn) 
VALUES (8002, TO_TIMESTAMP('2026-06-22 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('22-Jun-26', 'DD-MON-RR'), 45, 'Missed', 2002, '987-65-4321');

INSERT INTO Calls (c_id, c_time, c_date, c_duration, c_status, cust_id, ssn) 
VALUES (8003, TO_TIMESTAMP('2026-06-22 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('22-Jun-26', 'DD-MON-RR'), 300, 'Completed', 2003, '555-55-5555');

-- ==========================================
-- 12. TRANSFER
-- ==========================================
INSERT INTO Transfer (from_ssn, to_ssn, transfer_date, amount) 
VALUES ('123-45-6789', '987-65-4321', TO_DATE('14-Feb-26', 'DD-MON-RR'), 500);

INSERT INTO Transfer (from_ssn, to_ssn, transfer_date, amount) 
VALUES ('555-55-5555', '123-45-6789', TO_DATE('01-Mar-26', 'DD-MON-RR'), 1200);

INSERT INTO Transfer (from_ssn, to_ssn, transfer_date, amount) 
VALUES ('987-65-4321', '98765432111', TO_DATE('20-May-26', 'DD-MON-RR'), 250);

-- ==========================================
-- 13. EMP_SALES
-- ==========================================
INSERT INTO Emp_Sales (account_id, Year, total_sales, ssn) VALUES (1001, 2025, 4500.00, '123-45-6789');
INSERT INTO Emp_Sales (account_id, Year, total_sales, ssn) VALUES (1002, 2026, 30000.00, '123-45-6789');
INSERT INTO Emp_Sales (account_id, Year, total_sales, ssn) VALUES (1003, 2026, 92750.00, '555-55-5555');

-- ==========================================
-- 14. EMP_MONTH_YEAR
-- ==========================================
INSERT INTO Emp_Month_Year (achievement_id, sales_amount, date_of_achvmnt, type_of_achvmnt, account_id, Year) 
VALUES (9001, 4500.00, 2025, 'ANNUAL_TOP', 1001, 2025);

INSERT INTO Emp_Month_Year (achievement_id, sales_amount, date_of_achvmnt, type_of_achvmnt, account_id, Year) 
VALUES (9002, 30000.00, 2026, 'MIDYEAR_OK', 1002, 2026);

INSERT INTO Emp_Month_Year (achievement_id, sales_amount, date_of_achvmnt, type_of_achvmnt, account_id, Year) 
VALUES (9003, 92750.00, 2026, 'LEGENDARY', 1003, 2026);

-- ==========================================
-- 15. TRANSACTIONS
-- ==========================================
INSERT INTO Transactions (trans_id, t_date, amount, t_description, ssn, account_id, Year)
VALUES (10001, TO_DATE('15-Jun-25', 'DD-MON-RR'), 4500.00, 'Smith Machine Sale', '123-45-6789', 1001, 2025);

INSERT INTO Transactions (trans_id, t_date, amount, t_description, ssn, account_id, Year)
VALUES (10002, TO_DATE('10-Feb-26', 'DD-MON-RR'), 30000.00, 'Multi-Pack Benches', '123-45-6789', 1002, 2026);

INSERT INTO Transactions (trans_id, t_date, amount, t_description, ssn, account_id, Year)
VALUES (10003, TO_DATE('12-Apr-26', 'DD-MON-RR'), 92750.00, 'Dumbbells sale', '555-55-5555', 1003, 2026);

-- ==========================================
-- 16. CERTIFICATE
-- ==========================================
INSERT INTO Certificate (certificate_id, cert_date, achievement_id) VALUES (1101, TO_DATE('31-Dec-25', 'DD-MON-RR'), 9001);
INSERT INTO Certificate (certificate_id, cert_date, achievement_id) VALUES (1102, TO_DATE('30-Jun-26', 'DD-MON-RR'), 9002);
INSERT INTO Certificate (certificate_id, cert_date, achievement_id) VALUES (1103, TO_DATE('01-May-26', 'DD-MON-RR'), 9003);

-- ==========================================
-- 17. TXNS_PRODS
-- ==========================================
INSERT INTO Txns_Prods (trans_id, prod_id, quantity) VALUES (10001, 3001, 9);
INSERT INTO Txns_Prods (trans_id, prod_id, quantity) VALUES (10002, 3002, 25);
INSERT INTO Txns_Prods (trans_id, prod_id, quantity) VALUES (10003, 3003, 265);

-- ==========================================
-- 18. GRANTED
-- ==========================================
INSERT INTO GRANTED (ssn, award_id, award_date, quantity, center_id, achievement_id)
VALUES ('123-45-6789', 6002, TO_DATE('25-Dec-25', 'DD-MON-RR'), 1, 7001, 9001);

INSERT INTO GRANTED (ssn, award_id, award_date, quantity, center_id, achievement_id)
VALUES ('123-45-6789', 6003, TO_DATE('20-Jun-26', 'DD-MON-RR'), 1, 7003, 9002);

INSERT INTO GRANTED (ssn, award_id, award_date, quantity, center_id, achievement_id)
VALUES ('555-55-5555', 6001, TO_DATE('01-May-26', 'DD-MON-RR'), 1, 7002, 9003);

-- ==========================================
-- 19. CONTAIN
-- ==========================================
INSERT INTO Contain (prod_id, inv_id, quantity, increase_percent, o_id) VALUES (3001, 4001, 100, 5.50, 5001);
INSERT INTO Contain (prod_id, inv_id, quantity, increase_percent, o_id) VALUES (3002, 4002, 500, 12.00, 5002);
INSERT INTO Contain (prod_id, inv_id, quantity, increase_percent, o_id) VALUES (3003, 4003, 1500, 0.00, 5003);

-- ==========================================
-- 20. TXNS_PROD_INV
-- ==========================================
INSERT INTO Txns_Prod_Inv (prod_id, inv_id, trans_id) VALUES (3001, 4001, 10001);
INSERT INTO Txns_Prod_Inv (prod_id, inv_id, trans_id) VALUES (3002, 4002, 10002);
INSERT INTO Txns_Prod_Inv (prod_id, inv_id, trans_id) VALUES (3003, 4003, 10003);

-- ==========================================
-- FINAL SAVE
-- ==========================================
COMMIT;




select * from employees;









