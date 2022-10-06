
DROP DATABASE IF EXISTS shop;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE manufacturer (
  id_manufacturer INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  manufacturer_name VARCHAR(100) NOT NULL
);

CREATE TABLE product (
  id_product INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  product_price DOUBLE NOT NULL,
  id_manufacturer INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_manufacturer) REFERENCES manufacturer(id_manufacturer)
);

INSERT INTO manufacturer VALUES(1, 'Asus');
INSERT INTO manufacturer VALUES(2, 'Lenovo');
INSERT INTO manufacturer VALUES(3, 'Hewlett-Packard');
INSERT INTO manufacturer VALUES(4, 'Samsung');
INSERT INTO manufacturer VALUES(5, 'Seagate');
INSERT INTO manufacturer VALUES(6, 'Crucial');
INSERT INTO manufacturer VALUES(7, 'Gigabyte');
INSERT INTO manufacturer VALUES(8, 'Huawei');
INSERT INTO manufacturer VALUES(9, 'Xiaomi');

INSERT INTO product VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO product VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO product VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO product VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO product VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO product VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO product VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO product VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO product VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO product VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO product VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);


-- -----------------------------------------------------
-- 1. List the name of all the products in the product table.
-- -----------------------------------------------------
SELECT product_name 'Products' 
FROM product;

-- -----------------------------------------------------
-- 2. List the name and price of all the products in the product table.
-- -----------------------------------------------------
SELECT product_name 'Products', CONCAT(product_price,'€') 'Price' 
FROM product;

-- -----------------------------------------------------
-- 3. List the entire product table.
-- -----------------------------------------------------
SELECT * 
FROM product;

-- -----------------------------------------------------
-- 4. List the name of the products, the price in euros and the price in US dollars (USD) 
-- -----------------------------------------------------
SELECT product_name, 
CONCAT(product_price ,"€"),  
CONCAT(FORMAT (product_price * 0.955382, 2,'de_DE') ,"$" ) 
FROM product;

-- -----------------------------------------------------
-- 5. Use the following aliases for the columns: product name, euros, dollars.
-- -----------------------------------------------------
SELECT product_name AS 'Product name', 
CONCAT(product_price ,"€") AS 'Euros',  
CONCAT(FORMAT (product_price * 0.955382, 2,'de_DE') ,"$" ) AS 'Dollars' 
FROM product;

-- -----------------------------------------------------
-- 6. List the names and prices of all products in the product table, converting the names to UPPERCASE.
-- -----------------------------------------------------
SELECT UPPER(product_name) 'Product name', 
CONCAT(product_price,"€") 'Price' 
FROM product;

-- -----------------------------------------------------
-- 7. List the names and prices of all products in the product table, converting the names to LOWERCASE.
-- -----------------------------------------------------
SELECT LOWER(product_name) 'Product name', 
CONCAT(product_price,"€") 'Price' 
FROM product;

-- -----------------------------------------------------
-- 8. List the name of all manufacturers in one column, and in another column capitalize the first two characters of the manufacturer's name.
-- -----------------------------------------------------
SELECT manufacturer_name 'Manufacturer Name', 
CONCAT( UPPER(LEFT(manufacturer_name,2)), LOWER(SUBSTRING(manufacturer_name,3))) 'Capitalized first 2 letters'
FROM manufacturer;

-- -----------------------------------------------------
-- 9. List the names and prices of all products in the product table, rounding the price value.
-- -----------------------------------------------------
SELECT product_name 'Product',
CONCAT(ROUND(product_price),"€") 'Rounded price'
FROM product;

-- -----------------------------------------------------
-- 10.Lists the names and prices of all products in the product table, truncating the price value to display it without any decimal places.
-- -----------------------------------------------------
SELECT product_name 'Product',
CONCAT(TRUNCATE(product_price, 0),"€") 'Trucated price'
FROM product;

-- -----------------------------------------------------
-- 11. List the code of the manufacturers that have products in the product table.
-- -----------------------------------------------------
SELECT id_manufacturer 'Manufacturer\'s Code'
FROM product;

-- -----------------------------------------------------
-- 12. List the code of the manufacturers that have products in the product table, eliminating the codes that appear repeatedly.
-- -----------------------------------------------------
SELECT DISTINCT id_manufacturer 'Manufacturer\'s code'
FROM product;

-- -----------------------------------------------------
-- 13. List manufacturer names in ASC order.
-- -----------------------------------------------------
SELECT manufacturer_name 'Manufacturer'
FROM manufacturer
ORDER BY manufacturer_name ASC;

-- -----------------------------------------------------
-- 14. List manufacturer names in DESC order.
-- -----------------------------------------------------
SELECT manufacturer_name 'Manufacturer'
FROM manufacturer
ORDER BY manufacturer_name DESC;

-- -----------------------------------------------------
-- 15. Lists product names sorted first by name in ascending order and second by price in descending order.
-- -----------------------------------------------------
SELECT product_name 'Product' , CONCAT(product_price ,"€") 'Price'
FROM product
ORDER BY product_name ASC, product_price DESC ;

-- -----------------------------------------------------
-- 16. Returns a list with the first 5 rows of the manufacturer table.
-- -----------------------------------------------------
SELECT * 
FROM manufacturer
ORDER BY id_manufacturer ASC
LIMIT 5;

-- -----------------------------------------------------
-- 17. Returns a list with 2 rows starting from the fourth row of the manufacturer table. The fourth row must also be included in the answer.
-- -----------------------------------------------------
SELECT *
FROM manufacturer
WHERE id_manufacturer>=4
LIMIT 2;

-- -----------------------------------------------------
-- 18. List the cheapest product name and price. 
-- (Use only the ORDER BY and LIMIT clauses). NOTE: I couldn't use MIN(price) here, I would need GROUP BY.
-- -----------------------------------------------------
SELECT product_name 'Product', CONCAT(product_price ,"€") 'Price'
FROM product
ORDER BY product_price ASC
LIMIT 1;

-- -----------------------------------------------------
-- 19. Lists the name and price of the most expensive product. (Use only the ORDER BY and LIMIT clauses). NOTE: I could not use MAX(price) here, I would need GROUP BY.
-- -----------------------------------------------------
SELECT product_name 'Product', CONCAT(product_price ,"€") 'Price'
FROM product
ORDER BY product_price DESC
LIMIT 1;

-- -----------------------------------------------------
-- 20. List the name of all products from the manufacturer whose manufacturer code is equal to 2.
-- -----------------------------------------------------
SELECT product_name 'Products Manufacturer 2'
FROM product
WHERE id_manufacturer = 2;

-- -----------------------------------------------------
-- 21. Returns a list with the product name, price, and manufacturer name of all products in the database.
-- -----------------------------------------------------
SELECT p.product_name 'Product', CONCAT(p.product_price,'€') 'Price', m.manufacturer_name 'Manufacturer'
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer;
    
-- -----------------------------------------------------
-- 22. Returns a list with the product name, price, and manufacturer name of all products in the database. Sort the result by manufacturer name, in alphabetical order.
-- -----------------------------------------------------
SELECT p.product_name 'Product', CONCAT(p.product_price,'€') 'Price', m.manufacturer_name 'Manufacturer'
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer
ORDER BY manufacturer_name ASC;

-- -----------------------------------------------------
-- 23. Returns a list with the product code, product name, manufacturer code, and manufacturer name of all products in the database.
-- -----------------------------------------------------
SELECT p.id_product 'ID Product', p.product_name 'Product', m.id_manufacturer 'ID Manufacturer', m.manufacturer_name 'Manufacturer'
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer;
    
-- -----------------------------------------------------
-- 24. Returns the name of the product, its price and the name of its manufacturer, of the cheapest product.
-- -----------------------------------------------------
SELECT p.product_name 'Product', CONCAT(MIN(p.product_price),'€') 'Price', m.manufacturer_name 'Manufacturer'
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer;

-- -----------------------------------------------------
-- 25. Returns the name of the product, its price and the name of its manufacturer, of the most expensive product.
-- -----------------------------------------------------
SELECT p.product_name 'Product', CONCAT(MAX(p.product_price),'€') 'Price', m.manufacturer_name 'Manufacturer'
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer;

-- -----------------------------------------------------
-- 26. Returns a list of all products from the manufacturer Lenovo.
-- -----------------------------------------------------
SELECT p.*, m.manufacturer_name 
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer
WHERE m.manufacturer_name = 'Lenovo';

-- -----------------------------------------------------
-- 27. Returns a list of all products from manufacturer Crucial that have a price greater than €200.
-- -----------------------------------------------------
SELECT p.*, m.manufacturer_name 
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer
WHERE m.manufacturer_name = 'Crucial' 
AND p.product_price >= 200;

-- -----------------------------------------------------
-- 28. Returns a list with all products from manufacturers Asus, Hewlett-Packard and Seagate. Without using the IN operator.
-- -----------------------------------------------------
SELECT p.*, m.manufacturer_name
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer
WHERE m.manufacturer_name = 'Asus' 
	OR m.manufacturer_name = 'Hewlett-Packard'  
    OR m.manufacturer_name = 'Seagate';

-- -----------------------------------------------------
-- 29. Returns a list with all products from manufacturers Asus, Hewlett-Packard and Seagate. Using the IN operator.
-- -----------------------------------------------------
SELECT p.*, m.manufacturer_name
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer
WHERE m.manufacturer_name 
	IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- -----------------------------------------------------
-- 30. Returns a list with the name and price of all the products of the manufacturers whose name ends with the vowel e. (He afegit la columna del nom del manufacturer)
-- -----------------------------------------------------
SELECT p.product_name 'Name', p.product_price 'Price', m.manufacturer_name 'Manufacturer'
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer
WHERE m.manufacturer_name 
	LIKE '%e';

-- -----------------------------------------------------
-- 31. Returns a list with the name and price of all products whose manufacturer name contains the character w in their name.
-- -----------------------------------------------------
SELECT p.product_name 'Name', p.product_price 'Price', m.manufacturer_name 'Manufacturer'
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer
WHERE m.manufacturer_name 
	LIKE '%w%';

-- -----------------------------------------------------
-- 32. Returns a list with the product name, price and manufacturer name, of all products that have a price greater than or equal to €180. 
-- Sort the result first by price (in descending order) and second by name (in ascending order).
-- -----------------------------------------------------
SELECT p.product_name 'Product', p.product_price 'Price', m.manufacturer_name 'Manufacturer'
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer
WHERE p.product_price >= 180
ORDER BY p.product_price DESC, p.product_name ASC;

-- -----------------------------------------------------
-- 33. Returns a list with the manufacturer's code and name, only of those manufacturers that have associated products in the database.
-- -----------------------------------------------------
SELECT DISTINCT p.id_manufacturer 'Manufacturer\'s code', m.manufacturer_name 'Manufacturer Name'
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer;
    
-- -----------------------------------------------------
-- 34. Returns a list of all the manufacturers that exist in the database, along with the products each of them has. 
-- The list must also show those manufacturers that do not have associated products.
-- -----------------------------------------------------
SELECT m.manufacturer_name 'Manufacturer' , p.* 
FROM manufacturer m
LEFT JOIN product p
	ON m.id_manufacturer = p.id_manufacturer;
    
-- -----------------------------------------------------
-- 35. Returns a list showing only those manufacturers that do not have any associated products.
-- -----------------------------------------------------
SELECT m.*
FROM manufacturer m
LEFT JOIN product p
	ON m.id_manufacturer = p.id_manufacturer
WHERE id_product IS NULL;

-- -----------------------------------------------------
-- 36. Return all products from the manufacturer Lenovo. (Without using INNER JOIN).
-- -----------------------------------------------------
SELECT p.*
FROM product p
WHERE p.id_manufacturer = 2;

-- -----------------------------------------------------
-- 37. Returns all data for products that have the same price as the most expensive product from the manufacturer Lenovo. (Without using INNER JOIN).
-- -----------------------------------------------------
SELECT p.*
FROM product p
WHERE p.product_price = (SELECT MAX(product_price) 
		FROM product p 
		WHERE p.id_manufacturer= 2 );

-- -----------------------------------------------------
-- 38. List the name of the most expensive product of the manufacturer Lenovo.
-- -----------------------------------------------------
SELECT product_name 'Most expesive LENOVO product', CONCAT( MAX(product_price), '€') 'Price' 
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer
WHERE m.manufacturer_name = 'Lenovo'; 

-- -----------------------------------------------------
-- 39. List the name of the cheapest product of the manufacturer Hewlett-Packard.
-- -----------------------------------------------------
SELECT product_name 'Cheapest Hewlett-Packard product', CONCAT(MIN(product_price), '€') 'Price' 
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer
WHERE m.manufacturer_name = 'Hewlett-Packard';

-- -----------------------------------------------------
-- 40. Returns all products in the database that have a price greater than or equal to the most expensive product from manufacturer Lenovo.
-- -----------------------------------------------------
SELECT * 
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer
	WHERE p.product_price >= (SELECT MAX(p.product_price) 
				FROM product p
				INNER JOIN manufacturer m
					ON m.id_manufacturer = p.id_manufacturer
				WHERE m.manufacturer_name = 'Lenovo');

-- -----------------------------------------------------
-- 41. List all the products of the manufacturer Asus that have a price higher than the average price of all their products.
-- -----------------------------------------------------
SELECT * 
FROM product p
INNER JOIN manufacturer m
	ON m.id_manufacturer = p.id_manufacturer
WHERE m.manufacturer_name = 'Asus' 
AND product_price>=(
	SELECT AVG (product_price) 
		FROM product pa 
        INNER JOIN manufacturer ma
			ON ma.id_manufacturer = pa.id_manufacturer 
		WHERE ma.manufacturer_name = 'Asus');

    