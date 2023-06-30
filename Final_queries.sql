-- 1.
SELECT DISTINCT c.customer_id, c.first_name, c.last_name FROM 
customers c INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE payment_total > (SELECT AVG(payment_total) FROM orders
WHERE order_date<= NOW() AND order_date > NOW() - INTERVAL 1 MONTH)
ORDER BY customer_id;

-- 2.
-- view for the sum of order quantity for each album over a week.
CREATE VIEW sum_of_order_qty_view AS
SELECT a.album_name AS album_name, sum(o.order_qty) AS sum1
FROM  order_items o
INNER JOIN albums a
ON o.album_id = a.album_id
WHERE o.order_id IN ( SELECT order_id FROM orders WHERE order_date <= NOW() AND order_date > NOW() - INTERVAL 1 WEEK)
GROUP BY a.album_id;

-- view which has the maximum and minimum order quantity.
CREATE VIEW max_min_product_view AS
(SELECT album_name, sum1 FROM sum_of_order_qty_view
WHERE sum1 = (SELECT MAX(sum1) MaxProductFROMsum_of_order_qty_view)
UNION
SELECT album_name, sum1 FROM sum_of_order_qty_view
WHERE sum1 = (SELECT MIN(sum1) MinProductFROMsum_of_order_qty_view));

-- display the album name and 
-- quantity of the maximum and minimum albums ordered by the customers over a week
SELECT album_name AS 'Album Name', sum1 AS 'Total Products' FROM max_min_product_view;

-- 3.
SELECT MAX(album_price), genre_name
FROM albums a JOIN genre g ON a.genre_id = g.genre_id
GROUP BY g.genre_id;

-- 4.
SELECT COUNT(customer_id) AS no_of_customers, country_name, province_name, city_name
FROM customers c JOIN addresses a ON c.address_id = a.address_id
JOIN cities ci ON a.city_id = ci.city_id
JOIN provinces p ON p.province_id = ci.province_id
JOIN countries co ON co.country_id = p.country_id
GROUP BY co.country_id, p.province_id, ci.city_id
ORDER BY country_name, province_name, city_name;

-- 5.
SELECT MONTHNAME(o.order_date) AS Month,SUM(oi.order_qty) 
AS  Total_No_of_Sold_Product  
FROM orders o 
LEFT JOIN order_items oi  
ON o.order_id = oi.order_id 
GROUP BY month 
ORDER BY o.order_date; 

-- 6.
SELECT CONCAT(art.first_name,' ',art.last_name) AS Singer, 
COUNT(album_id) AS Number_of_songs  
FROM albums JOIN artists art  
USING(artist_id)  
GROUP BY artist_id 
ORDER BY Singer; 

-- 7.
SELECT a.artist_id, SUM(a.album_qty), ar.first_name, ar.last_name
FROM albums AS a INNER JOIN artists AS ar
ON a.artist_id = ar.artist_id
WHERE a.artist_id = '1';

-- 8. Specific scenario: display which customer ordered which album 
-- and the total payment given by the customer.
SELECT c.customer_id, c.first_name, c.last_name, o.order_id, a.album_id, a.album_name, o.payment_total
FROM customers AS c
INNER JOIN orders AS o On c.customer_id = o.customer_id
INNER JOIN order_items AS oi ON o.order_id = oi.order_id
INNER JOIN albums AS a ON a.album_id = oi.album_id
GROUP BY a.album_price > 10;

-- 9. Specific scenario: list all customers and show their city names
-- and check customers from Toronto city using the IF function. 
SELECT  first_name, last_name, city_name, 
IF(city_name = 'Toronto', 'Yes', 'No') AS Is_city_Toronto 
FROM customers JOIN addresses 
ON customers.customer_id = addresses.address_id 
JOIN cities ON addresses.address_id = cities.city_id; 

-- Procedure to display payment total of orders for customer_id = 1
DELIMITER // 
CREATE PROCEDURE GetTotalOfPayment() 
BEGIN 
    DECLARE sum_payment_total DECIMAL(9,2); 
    SELECT SUM(payment_total) INTO sum_payment_total  
    FROM orders  
    WHERE customer_id=1;     
    SELECT CONCAT('$', sum_payment_total) AS 'Total of payment'; 
END // 
DELIMITER ; 

CALL GetTotalOfPayment();

-- View to update the columns in the table order_items 
CREATE OR REPLACE VIEW order_data AS 
SELECT order_item_id, price_item, order_id, album_id FROM order_items;  
UPDATE order_data SET price_item = 200 WHERE order_item_id = 2; 

-- Trigger
DROP TRIGGER IF EXISTS countries_before_update;
DELIMITER //
CREATE TRIGGER countries_before_update
BEFORE UPDATE ON countries FOR EACH ROW
BEGIN
SET NEW.country_name = upper (NEW.country_name);
END //

UPDATE countries
SET country_name = 'Germany'
WHERE country_id = 1;

SELECT country_id, country_name
FROM countries
WHERE country_id = 1;

 




