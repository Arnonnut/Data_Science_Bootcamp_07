--restaurant database
-- 5 tables
-- write 3-5 queries
-- 1x WITH
-- 1x SUBQUERY
-- 1x Aggregate Function

.open restaurant.db
  
DROP TABLE orders;
DROP TABLE menus;
DROP TABLE staff;
DROP TABLE customers;
DROP TABLE ratings;


CREATE TABLE orders (
    order_id int,
    order_date date,
    menu_id int,
    menu_name int,
    order_qty int,
    order_unit_qty text,
    total_price real,
    customer_id int,
    staff_id int,
    rating_id int
    
);

CREATE TABLE menus (
    menu_id int,
    menu_name text,
    menu_genre text,
    menu_per_unit,
    price_per_unit real,
    unit_price text
    
);

CREATE TABLE customers (
    customer_id int,
    customer_name text,
    customer_country text
    
);

CREATE TABLE staff (
    staff_id int,
    staff_name text,
    staff_branch text
    
);

CREATE TABLE ratings (
    rating_id int,
    rating_score real,
    rating_performance text
    
);

INSERT INTO orders VALUES
    (1, '2023-01-01', 1, 'Chocolate'  , 1, 'PK', 100, 1, 1, 1),
    (2, '2023-01-01', 2, 'Vanilla'    , 3, 'PK', 330, 2, 1, 2),
    (3, '2023-01-02', 4, 'Green Tea'  , 3, 'PK', 270, 3, 2, 1),
    (4, '2023-01-02', 3, 'Strawberry' , 2, 'PK', 240, 4, 3, 1),
    (5, '2023-01-02', 1, 'Chocolate'  , 3, 'PK', 300, 1, 4, 2);


INSERT INTO  menus VALUES
    (1, 'Chocolate' , 'Ice Cream',1 , 100, 'USD'),
    (2, 'Vanilla'   , 'Ice Cream',1 , 110, 'USD'),
    (3, 'Strawberry', 'Ice Cream',1 , 120, 'USD'),
    (4, 'Green Tea' , 'Beverage' ,1 , 90,  'USD');

INSERT INTO customers VALUES 
    (1, 'Arnonnut', 'Thailand'),
    (2, 'Noel', 'USA'),
    (3, 'Mitoma', 'Japan'),
    (4, 'Tony', 'England');

INSERT INTO staff VALUES
    (1, 'M', 101),
    (2, 'Pop', 101),
    (3, 'Moss', 102),
    (4, 'Maily', 102);

INSERT INTO ratings VALUES
    (1, 5, 'High'),
    (2, 4, 'Medium'),
    (3, 3, 'Low');

.mode box
.header on

SELECT * FROM orders;
SELECT * FROM menus;
SELECT * FROM customers;
SELECT * FROM staff;
SELECT * FROM ratings;


.print 'Query 1 Total sales'
SELECT
    menus.menu_name,
    sum(menus.price_per_unit*orders.order_qty) AS total_sales,
    menus.unit_price
FROM menus
JOIN orders ON menus.menu_id = orders.menu_id
GROUP BY menus.menu_name
ORDER BY total_sales DESC;

.print 'Query 2 Best Product'
  
SELECT
    menus.menu_name,
    sum(menus.menu_per_unit*orders.order_qty) AS total_product,
    orders.order_unit_qty
FROM menus
JOIN orders ON menus.menu_id = orders.menu_id
GROUP BY menus.menu_name
ORDER BY total_product DESC;



.print 'Query 3 Best staff'
SELECT 
  staff.staff_name,
  AVG(ratings.rating_score) AS rating,
  case
    WHEN AVG(ratings.rating_score) BETWEEN 4.6 AND 5 THEN 'High'
    WHEN AVG(ratings.rating_score) BETWEEN 4 AND 4.5 THEN 'Medium'
    ELSE 'Low'
  END AS performance
FROM ratings
JOIN orders ON orders.rating_id = ratings.rating_id
JOIN staff ON orders.staff_id = staff.staff_id
GROUP BY staff.staff_id
ORDER BY ratings.rating_score DESC
;

.print 'Query 4 WITH and SUB Query Filter Staff rating 5'
WITH sub AS (
  SELECT
  staff.staff_name AS staffname,
  AVG(ratings.rating_score) AS rating,
  case
    WHEN AVG(ratings.rating_score) BETWEEN 4.6 AND 5 THEN 'High'
    WHEN AVG(ratings.rating_score) BETWEEN 4 AND 4.5 THEN 'Medium'
    ELSE 'Low'
  END AS performance
FROM ratings
JOIN orders ON orders.rating_id = ratings.rating_id
JOIN staff ON orders.staff_id = staff.staff_id
GROUP BY staff.staff_id
ORDER BY ratings.rating_score DESC
)
SELECT 
  staffname,
  rating
FROM sub
WHERE rating = 5;
