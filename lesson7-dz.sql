 -- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

INSERT INTO orders (user_id) SELECT id FROM users WHERE name = "Геннадий";
INSERT INTO orders (user_id) SELECT id FROM users WHERE name = "Александр";
INSERT INTO orders_products (order_id, product_id, total) VALUES 
(1, 4, 1), (2, 2, 1);

SELECT id, name, birthday_at FROM users WHERE id IN (SELECT user_id FROM orders o) ;

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT id, name, (SELECT name FROM catalogs WHERE catalog_id = id) AS catalog_name FROM products p

-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

CREATE TABLE flights
(
id SERIAL PRIMARY KEY,
`from` VARCHAR (20),
`to` VARCHAR (20)
);

CREATE TABLE cities
(
label VARCHAR (20),
name VARCHAR (20)
);

INSERT INTO flights (`from`, `to`) VALUES
('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk', 'irkutsk'),
('moscow', 'kazan');

INSERT INTO cities (label, name) VALUES
('moscow', 'Москва'),
('novgorod', 'Новгород'),
('irkutsk', 'Иркутск'),
('omsk', 'Омск'),
('kazan', 'Казань');


SELECT 
	id, 
	(SELECT name FROM cities WHERE label = f.`from`) AS `from`, 
	(SELECT name FROM cities WHERE label = f.`to`) AS `to` 
FROM flights f;





