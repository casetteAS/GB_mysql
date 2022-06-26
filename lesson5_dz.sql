-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”

-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

USE vk;
SELECT * FROM users;
UPDATE users SET created_at = current_timestamp(), updated_at = current_timestamp WHERE id >= 1; 

-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
-- и в них долгое время помещались значения в формате "20.10.2017 8:10". 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

UPDATE users 
	SET 
		created_at = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'), 
		updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i') 
	WHERE id >= 1;

ALTER TABLE users MODIFY COLUMN created_at datetime DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users MODIFY COLUMN updated_at datetime DEFAULT CURRENT_TIMESTAMP;



-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0,
-- если товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
-- Однако, нулевые запасы должны выводиться в конце, после всех записей.

SELECT * FROM storehouses_products ORDER BY value = 0 ASC, value ASC; 

-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий ('may', 'august')
 
SELECT 
	id,
	firstname,
	lastname,
	birthday,
	monthname(birthday) AS 'monthname'
FROM profiles, users
WHERE 
	monthname(birthday) IN ('may', 'august') AND user_id = id
GROUP BY id;


-- 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
USE shop;

SELECT * FROM catalogs WHERE id IN (5, 1, 2 ) ORDER BY field(id, 5, 1, 2) ;




-- Практическое задание теме “Агрегация данных”
-- 1. Подсчитайте средний возраст пользователей в таблице users
-- Так как я перенесла данные о датах рождения в таблицу profiles, то считаю по данной таблице.
SELECT avg(TIMESTAMPDIFF(YEAR, birthday, NOW())) FROM profiles p ;

-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT 
	birthday,
	dayname(date_format(birthday, '2022-%m-%d')) as 'dayofweek',  
	count(*) AS 'amount' 
FROM profiles p
GROUP BY dayname(date_format(birthday, '2022-%m-%d'));


-- 3.(по желанию) Подсчитайте произведение чисел в столбце таблицы
CREATE TABLE tbl (value int);
SELECT * FROM tbl;
INSERT INTO tbl VALUES (1), (2), (3), (4), (5);
SELECT exp(sum(LN(value))) FROM tbl;