-- Урок 8. Вебинар. Сложные запросы
-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”. 
-- Работаем с БД vk и данными, которые вы сгенерировали ранее:
-- 1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).
USE vk;
SELECT * FROM messages m ;

SELECT 
	u.id, 
	concat(u.firstname, ' ', u.lastname) AS name, 
	m.from_user_id, 
	count(*) AS from_user_count, 
	m.to_user_id
FROM users u JOIN messages m 
ON u.id = m.from_user_id  
WHERE m.to_user_id = 1
GROUP BY m.from_user_id
ORDER BY from_user_count DESC
LIMIT 1;


-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
SELECT
	count(like_type) AS total_likes
FROM 
	posts p2 
JOIN 
	posts_likes pl 
JOIN 
	profiles p 
ON p2.id = pl.post_id AND p.user_id = p2.user_id
WHERE timestampdiff(YEAR, p.birthday, now()) < 10 AND like_type IS TRUE;


-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT 
	count(like_type) AS total_likes,
	p.gender 
FROM 
	posts p2 
JOIN 
	posts_likes pl 
JOIN 
	profiles p 
ON p2.id = pl.post_id AND p.user_id = p2.user_id
WHERE pl.like_type IS TRUE 
GROUP BY gender
ORDER BY total_likes DESC
LIMIT 1;

-- Задачи необходимо решить с использованием объединения таблиц (JOIN)


