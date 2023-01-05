/*
    CNIT 372 Group 1 - Milestone 3
    Doyoon Kim, Estevan Becerra, Jamil Morgan, Kyle Hanley, Lanyu He.
    
    Due date: May 1st, 2022
*/
/*
    Package Sales Statistics
    This package contains numbers of public procedure and function
    whose task is closely related to a sales information.
*/
CREATE OR REPLACE PACKAGE SALES_STATISTICS
IS

    -- Question 1
    PROCEDURE average_Discount;
    
    -- Question 3
    FUNCTION avgCostPerOrderByCustomer(
        p_customerid    CUSTOMER_MILESTONE.customerid%TYPE
    ) RETURN NUMBER;
    
    -- Question 6
    PROCEDURE MostSalesInYear;
    
    -- Question 9
    PROCEDURE DiscountNow;
    
END SALES_STATISTICS;
/

CREATE OR REPLACE PACKAGE BODY SALES_STATISTICS
IS

    -- Question 1
        PROCEDURE average_discount AS

        CURSOR orderlines IS
        SELECT
            *
        FROM
            orderline_milestone;

        CURSOR brands IS
        SELECT DISTINCT
            brand
        FROM
            icecream_milestone;

        v_rawtotal           NUMBER := 0;
        v_cumulativetotal    NUMBER := 0;
        v_tempdate           DATE;
        v_tempcounter        INTEGER := 0;
        v_tempbrand          icecream_milestone.brand%TYPE;
        v_tempdiscountamount NUMBER := 0;
    BEGIN
        FOR eachbrand IN brands LOOP
            FOR eachorderline IN orderlines LOOP
                -- Check Dates
                SELECT
                    orderdate
                INTO v_tempdate
                FROM
                    order_milestone
                WHERE
                    orderid = eachorderline.orderid;

                IF to_char(v_tempdate, 'fmMonth') = to_char(add_months(sysdate, -1), 'fmMonth') THEN
                    SELECT
                        brand
                    INTO v_tempbrand
                    FROM
                        icecream_milestone
                    WHERE
                        icecreamid = eachorderline.icecreamid;

                    IF v_tempbrand = eachbrand.brand THEN
                        IF eachorderline.discountid IS NOT NULL THEN
                            SELECT
                                discountamount
                            INTO v_tempdiscountamount
                            FROM
                                discount_milestone
                            WHERE
                                discountid = eachorderline.discountid;

                            v_rawtotal := v_rawtotal + v_tempdiscountamount;
                            v_tempcounter := v_tempcounter + 1;
                        END IF;

                    END IF;

                END IF; -- Outer IF    
                v_tempdiscountamount := 0;
            END LOOP; -- Inner Loop   
            IF v_tempcounter > 0 THEN
                dbms_output.put_line('Average Discount Amount Applied to ' || eachbrand.brand);
                dbms_output.put_line(v_rawtotal / v_tempcounter);
                v_cumulativetotal := v_cumulativetotal + v_rawtotal;
            END IF;

            v_rawtotal := 0;
            v_tempcounter := 0;
        END LOOP;

        dbms_output.put_line('Grand Total of Applied Discount on month '
                             || to_char(add_months(sysdate, -1), 'fmMonth'));

        dbms_output.put_line(v_cumulativetotal);
    END average_discount;
    
    --Question 3
        FUNCTION avgcostperorderbycustomer (
        p_customerid customer_milestone.customerid%TYPE
    ) RETURN NUMBER AS

        CURSOR orders IS
        SELECT
            icecreamid,
            quantity
        FROM
            orderline_milestone
        WHERE
            customerid = p_customerid;

        v_counter      INTEGER := 0;
        v_rawtotalcost NUMBER := 0;
        vl_tempcost    NUMBER := 0;
        invaliddivisionexception EXCEPTION;
    BEGIN
        FOR customerorder IN orders LOOP
            SELECT
                cost
            INTO vl_tempcost
            FROM
                icecream_milestone
            WHERE
                icecreamid = customerorder.icecreamid;

            v_rawtotalcost := v_rawtotalcost + ( vl_tempcost * customerorder.quantity );
            v_counter := v_counter + 1;
            vl_tempcost := 0;
        END LOOP;

        IF v_counter = 0 THEN
            RAISE invaliddivisionexception;
        END IF;
        RETURN v_rawtotalcost / v_counter;
    EXCEPTION
        WHEN invaliddivisionexception THEN
            RETURN 0;
        WHEN OTHERS THEN
            dbms_output.put(sqlcode);
            dbms_output.put(':');
            dbms_output.put_line(substr(sqlerrm, 1, 100));
    END avgcostperorderbycustomer;
    
    --Question 6 (Target)
    PROCEDURE mostsalesinyear AS
        v_time VARCHAR2(20);
    BEGIN
        SELECT
            timeofyear
        INTO v_time
        FROM
            (
                SELECT
                    timeofyear
                FROM
                    (
                        SELECT
                            COUNT(orderid)              AS amountsold,
                            to_char(orderdate, 'MONTH') AS timeofyear
                        FROM
                            order_milestone
                        GROUP BY
                            to_char(orderdate, 'MONTH')
                    )
                ORDER BY
                    amountsold DESC
            )
        WHERE
            ROWNUM = 1;

        dbms_output.put_line('Most Popular time of year is ' || v_time);
    END mostsalesinyear;
    
    --Question 9
    PROCEDURE DiscountNow AS
        v_discounts VARCHAR2(30);
    BEGIN
        FOR discounts IN (
            SELECT
                discountname
            FROM
                discount_milestone
            WHERE
                expiration > sysdate
        ) LOOP
            v_discounts := discounts.discountname;
            dbms_output.put_line(v_discounts);
        END LOOP;
    END DiscountNow;


END SALES_STATISTICS;
/

/*
    Package ORDER_STATISTICS
    This package contains numbers of public Function and procedures whose
    task is closely related to Order information.
*/
CREATE OR REPLACE PACKAGE ORDER_STATISTICS
IS
    
    -- Question 2
    FUNCTION cust_in_bigcity
    RETURN NUMBER;
    
    -- Question 4
    FUNCTION best_selling_icecream(
        month DATE
    ) RETURN icecream_milestone.brand%TYPE;
    
    -- Question 5
    PROCEDURE PopularFlavorPerAge(
        p_Age IN NUMBER);
    
    -- Question 7
    PROCEDURE PopularBrand;
    
    -- Question 8
    PROCEDURE EmployeeOfTheYear;
    
    -- Question 10
    PROCEDURE AverageQuantity;
    
    -- Question 11
    PROCEDURE applyDiscountToExistingOrder(
        p_icecreamId IN VARCHAR2,
        p_orderId IN VARCHAR2,
        p_customerId IN VARCHAR2,
        p_discountId IN VARCHAR2
    );

END ORDER_STATISTICS;
/

CREATE OR REPLACE PACKAGE BODY ORDER_STATISTICS
IS
    
    -- Question 2
    FUNCTION cust_in_bigcity RETURN NUMBER AS
        v_number_of_customer NUMBER;
    BEGIN
        SELECT DISTINCT
            ( COUNT(c.customerid) ) AS customer_number
        INTO v_number_of_customer
        FROM
                 customer_milestone c
            INNER JOIN order_milestone o ON o.customerid = c.customerid
        GROUP BY
            c.custcity
        HAVING
            COUNT(o.orderid) = (
                SELECT
                    MAX(COUNT(o.orderid))
                FROM
                         customer_milestone c
                    INNER JOIN order_milestone o ON o.customerid = c.customerid
                GROUP BY
                    c.custcity
            );

        RETURN v_number_of_customer;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put(sqlcode);
            dbms_output.put(': ');
            dbms_output.put_line(substr(sqlerrm, 1, 100));
    END cust_in_bigcity;
    
    -- Question 4
    FUNCTION best_selling_icecream (
        month DATE
    ) RETURN icecream_milestone.brand%TYPE AS
        v_brand icecream_milestone.brand%TYPE;
    BEGIN
        SELECT
            brand
        INTO v_brand
        FROM
                 icecream_milestone i
            INNER JOIN orderline_milestone ol ON ol.icecreamid = i.icecreamid
        GROUP BY
            i.brand
        HAVING
            SUM(i.cost * ol.quantity) = (
                SELECT
                    MAX(SUM(i.cost * ol.quantity))
                FROM
                         icecream_milestone i
                    INNER JOIN orderline_milestone ol ON ol.icecreamid = i.icecreamid
                GROUP BY
                    i.brand
            );

        RETURN v_brand;
    END best_selling_icecream;
    
    -- Question 5
    PROCEDURE popularflavorperage (
        p_age IN NUMBER
    ) AS
        v_flavor VARCHAR2(30);
    BEGIN
        SELECT
            flavor
        INTO v_flavor
        FROM
            (
                SELECT
                    flavor,
                    COUNT(orderline_milestone.icecreamid) AS flavorcount
                FROM
                         customer_milestone
                    INNER JOIN orderline_milestone ON customer_milestone.customerid = orderline_milestone.customerid
                    INNER JOIN icecream_milestone ON icecream_milestone.icecreamid = orderline_milestone.icecreamid
                WHERE
                    age = p_age
                GROUP BY
                    flavor
                ORDER BY
                    flavorcount DESC
            );

        dbms_output.put_line('Most Popular flavor for '
                             || p_age
                             || ' year olds is '
                             || v_flavor);
    END popularflavorperage;
    
    -- Question 7
    PROCEDURE popularbrand AS
        v_popular VARCHAR2(30);
    BEGIN
        SELECT
            brand
        INTO v_popular
        FROM
            (
                SELECT
                    brand,
                    COUNT(orderline_milestone.icecreamid) AS icecreamcount
                FROM
                         icecream_milestone
                    INNER JOIN orderline_milestone ON icecream_milestone.icecreamid = orderline_milestone.icecreamid
                GROUP BY
                    brand
                ORDER BY
                    icecreamcount DESC
            )
        WHERE
            ROWNUM = 1;

        dbms_output.put_line('Most popular brand is ' || v_popular);
    END popularbrand;
    
    -- Question 8
    PROCEDURE employeeoftheyear AS
        v_employee VARCHAR2(50);
    BEGIN
        SELECT
            employeefirstname
            || ' '
            || employeelastname
        INTO v_employee
        FROM
            (
                SELECT
                    employeefirstname,
                    employeelastname,
                    employee_milestone.employeeid,
                    COUNT(order_milestone.employeeid) AS ordercount
                FROM
                         employee_milestone
                    INNER JOIN order_milestone ON employee_milestone.employeeid = order_milestone.employeeid
                GROUP BY
                    employeefirstname,
                    employeelastname,
                    employee_milestone.employeeid
                ORDER BY
                    ordercount DESC
            )
        WHERE
            ROWNUM = 1;

        dbms_output.put_line('Employee of the Year is ' || v_employee);
    END employeeoftheyear;
    
    -- Question 10
    PROCEDURE averagequantity AS
        v_averagequantity VARCHAR2(30);
    BEGIN
        SELECT
            AVG(quantity)
        INTO v_averagequantity
        FROM
            orderline_milestone;

        dbms_output.put_line('Average Quantity per order: ' || v_averagequantity);
    END averagequantity;
    
    
    PROCEDURE applyDiscountToExistingOrder(
        p_icecreamId IN VARCHAR2,
        p_orderId IN VARCHAR2,
        p_customerId IN VARCHAR2,
        p_discountId IN VARCHAR2
    ) AS
    BEGIN
        
        UPDATE ORDERLINE_MILESTONE
            SET DISCOUNTID = p_discountId
            WHERE ICECREAMID = p_icecreamId AND ORDERID = p_orderId AND CUSTOMERID = p_customerId;
        
    END applyDiscountToExistingOrder;

END ORDER_STATISTICS;
/

/*  
    Comment: (Question 11)
    
    INSERT INTO ORDERLINE_MILESTONE (ICECREAMID, ORDERID, CUSTOMERID, QUANTITY)
    VALUES ('I1008', 'O100000005', 'C100000005', 2);
    
    This order has been made on 29-MAR-2022.
    
    INSERT INTO DISCOUNT_MILESTONE
    VALUES ('D1006', 15.00, 'Etc', 'Grand Open Discount', '31-JAN-2022');
    
    This discount has been expired on 31-JAN-2022.
    
    Therefore, if employee attempt to add DISCOUNT D1006 to above ORDERLINE,
    trigger will throw an error message and won't apply changes.
    
    Described functionality can be verified using query below:
    
    EXECUTE ORDER_STATISTICS.applyDiscountToExistingOrder('I1008', 'O100000005', 'C100000005', 'D1006');
*/

/*
    Comment:
    In order to use trigger to answer the question, we decided to add one addition
    business question. 
    
    Question 11
    "Can application apply new discount to existing order where discount is not
    applied yet?"
*/


-- Question 11 (Trigger)
CREATE OR REPLACE TRIGGER RESTRICT_APPLY_DISCOUNT
BEFORE UPDATE OF DISCOUNTID ON ORDERLINE_MILESTONE
FOR EACH ROW
DECLARE
    v_orderId   ORDERLINE_MILESTONE.ORDERID%TYPE;
    v_disId   DISCOUNT_MILESTONE.DISCOUNTID%TYPE;
    
    v_orderDate     DATE;
    v_expDate       DATE;
BEGIN

    v_orderId := :OLD.ORDERID;
    
    IF :NEW.DISCOUNTID IS NULL THEN
        v_disId := NULL;
    ELSE
        v_disId := :NEW.DISCOUNTID;
    END IF;
    
    IF v_orderId IS NULL THEN
        dbms_output.put_line('Invalid Operation request');
    ELSE
    
        IF v_disId IS NOT NULL THEN
            SELECT ORDERDATE
                INTO v_orderDate
            FROM ORDER_MILESTONE
            WHERE ORDERID = v_orderId;
            
            SELECT EXPIRATION
                INTO v_expDate
            FROM DISCOUNT_MILESTONE
            WHERE DISCOUNTID = v_disId;
                
            IF v_orderDate > v_expDate THEN
                dbms_output.put_line('It is not possible to add ' || v_disId || ' to this orderline.');
                
                :NEW.DISCOUNTID := NULL;
                
            END IF;
            
        END IF;

    END IF;

END;
/

