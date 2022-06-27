-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. 
-- Агрегация данных”. Работаем с БД vk и данными, которые вы сгенерировали ранее:
-- 1.Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT
	from_user_id, 
	count(*) AS number_of_sent_messages
FROM messages m
WHERE  to_user_id = 1
GROUP BY from_user_id
ORDER BY from_user_id DESC
LIMIT 1;

-- или можно еще вместо id отправителя вывести имя

SELECT
	concat((SELECT firstname FROM users WHERE users.id = from_user_id), ' ', 
	(SELECT lastname FROM users WHERE users.id = from_user_id)) AS sender,
	count(*) AS number_of_sent_messages
FROM messages m
WHERE  to_user_id = 1
GROUP BY from_user_id
ORDER BY number_of_sent_messages DESC
LIMIT 1;


-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
-- 2.1. находим пользователей
-- 2.2. находим посты этих пользователей
-- 2.3. считаем лайки к постам из пункта 2


SELECT
	count(like_type) AS total_likes
FROM posts_likes
WHERE post_id IN (
SELECT 
	id FROM posts WHERE user_id IN 
(SELECT user_id FROM profiles p WHERE timestampdiff(YEAR, birthday, now()) < 10));



-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.


SELECT 
	count(like_type) AS total_likes,
	(SELECT gender FROM profiles WHERE user_id = posts_likes.user_id) AS gender
FROM posts_likes
WHERE like_type = 1
GROUP BY gender
ORDER BY total_likes DESC 
LIMIT 1;
