-- 4 урок
-- 1 Задание
-- Заполняем таб. Пользователи
INSERT users (firstname, lastname, email, phone, gender, birthday, hometown) VALUES
("Marina", "Pronina", "pronina@gmail.com", 89509993425, 'f', '1993-12-13', 'Novosibirsk'),
("Alexey", "Rack", 'rack@gmail.com', 89773426426, 'm', '1993-12-13', 'Kemerovo'),
("Adel", "Grozdeva", 'grozd@mail.ru', 89526543457, 'f', '1997-12-13', 'Omsk'),
("Roman", 'Gorin', 'gor@gmail.com', 89346346634, 'm', '1997-12-13', 'Novosibirsk'),
('Anastasya', 'Popova', 'pop@mail.ru', 89467572254, 'f', '1999-12-13', 'Tymen'),
('Vladislav', 'Orlov', 'orl@yandex.ru', 89653426422, 'm', '1999-12-13', 'Omsk'),
('Michail', 'Astahov', 'astah@gmail.com', 89562346662, 'm', '2010-12-13', 'Voronej'),
('Evgenya', 'Borisova', 'boris@yandex.ru', 89643256333, 'f', '2017-12-13', 'Saint Peterburg');

UPDATE users
SET gender = 'm', birthday ='2012-05-20', hometown = 'Moscow'
WHERE id = 2;

ALTER TABLE users ADD COLUMN (
gender char(1) DEFAULT NULL,
birthday date  DEFAULT NULL,
hometown varchar(50) DEFAULT NULL,
photo_id bigint UNSIGNED DEFAULT NULL,
pass char(50) DEFAULT NULL
);
SELECT * FROM media;
DESCRIBE media;

UPDATE users 
SET id = 10
WHERE lastname = 'Borisova';

-- Заполняем запросы в друзья
INSERT INTO friend_requests VALUES
(3, 1, 1), (4, 5, 1), (5, 1, 0), (6, 5, 1), (7, 6, 1), (8, 4, 1), (9, 7, 1), (10, 3, 1);

-- Заполняем типы медиа
INSERT INTO media_types (name) VALUES
('видео'), ('gif'), ('место'), ("подарок"), ('Граффити'); 

-- Заполняем медиа
INSERT INTO media (user_id, media_types_id, file_name, files_size) VALUES
(1, 8, 'Beer', 4),
(2, 4, 'X men', 2300),
(3, 6, 'Museum', 8),
(4, 2, 'I wanna be yours', 66),
(5, 4, 'Travel', 256),
(5, 3, 'Report', 25),
(6, 3, 'Essay', 16),
(7, 1, 'Dress', 7),
(8, 1, 'Pokemon', 10),
(9, 2, 'Brainstorm', 56);

-- Заполняем группы
SELECT * FROM communities c ;
INSERT INTO communities (name, description, admin_id) VALUES
("Давай лучше дома посмотрим", "Фильмы", 2),
("5 лучших фильмов", "Ваша ежедневная доза кино из лучших фильмов и сериалов", 2),
("Книги", "Твоя библиотека", 5),
("Новости Китая | ЭКД", "Самое популярное интернет-издание о Китае на русском языке", 6),
("Betraveler | Добро пожаловать на Землю", "Бесконечное путешествие по планете", 3),
("#tech", "Обсуждаем самое интересное из мира высоких технологий и интернет!", 9),
("Английский для лентяев", "Английский для лентяев", 7),
("English Memes", "English Memes", 7);

-- Заполняем связи между группами
SELECT * FROM communities_users cu  ;
INSERT INTO communities_users (id_community, id_user) VALUES
(1, 6),
(1, 3),
(2, 7),
(3, 4),
(4, 1),
(5, 9),
(6, 2),
(7, 5), 
(8, 4),
(9, 3),
(10, 3),
(3, 9);

-- Добавим сообщения между пользователями в таблицу сообщения
SELECT * FROM messages m  ;
INSERT INTO messages (from_user_id, to_user_id, txt, is_delivered) VALUES
(4, 6, 'Ты планируешь встречу сегодня или нет?', TRUE),
(9, 7, 'Привет, ты там как?', TRUE),
(10, 7, "Я в отпуск в июле пойду. Я не хотела бы менять даты, извини", TRUE),
(5, 2, "Ты смотрел Дудя последнее видео?", FALSE),
(10 , 3, "Да, я за кодом сижу. Только завтра особожусь", TRUE),
(4, 8, "Если бы у тебя и было время, ты бы все равно потратил его на сериалы, а не на чтение", FALSE),
(1, 5, "Тетя завтра приезжает, надо встретить", TRUE),
(3, 1, "Переезд в Питер никто не отменял, все в силе", TRUE),
(5, 4, "Я еду в Стокгольм на пару дней, пока тепло, надо посмотреть летнюю Швецию", TRUE),
(3, 1, "А с тех курсов то мне не овтечают, кто так работает...", TRUE),
(2, 1, "Ты до клиента смог достучаться? Какие результаты?", FALSE),
(4, 8, "Перечитываю Булгакова", TRUE);

SELECT * FROM users;

-- внесем данные из таблицы пользоваетелей в таблицу профилей
INSERT INTO profiles (user_id, gender, birthday, city) SELECT id, gender , birthday , hometown FROM users;
ALTER TABLE users DROP COLUMN photo_id;

UPDATE profiles SET country = 'Russia'
WHERE user_id >= 1;

-- №2. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
SELECT DISTINCT firstname FROM users ORDER BY firstname ;

-- №3. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
-- Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)

SELECT * FROM profiles p ;
ALTER TABLE profiles ADD COLUMN is_active tinyint(1) DEFAULT '1';

UPDATE profiles 
SET is_active = 0 
WHERE (SELECT TIMESTAMPDIFF(YEAR, birthday, NOW())) < 18;

SELECT  (TIMESTAMPDIFF(YEAR, birthday, NOW())) AS age FROM profiles 

-- iv. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)

SELECT * FROM messages m ;
INSERT INTO messages (from_user_id, to_user_id, txt, created_at) VALUES
(5, 8, 'Привет!', '2022-06-22');
DELETE FROM messages WHERE created_at > current_date; 




