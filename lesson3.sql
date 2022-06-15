--- Я использовала книгу "Изучаем SQL" Бейли.Л, рекомендованную к прочтению
--- Там узнала про Нормализованные формы (НФ1, Нф2, НФ3) и сделала д.з по аналогии
--- А именно, создала две таблицы о статусе пользователей и политических взглядах
--- И отдельно вынесла соединительные таблицы с id, чтобы таблицы соответствовали НФ
--- Однако, возможно, id пользователя следовало добавить в каждую из этих таблиц и не создавать соединительные

CREATE TABLE status(
	status_id SERIAL PRIMARY KEY,
	status VARCHAR(30) NOT NULL,
);

INSERT status (status)
VALUES
('не замужем'),
("есть друг"), 
("помолвлен(а)"), 
("все сложно"), 
("в активном поиске"), 
("влюблен(а)"), 
("в гражданском браке"), 
("женат"),
("замужем");

CREATE TABLE political_views(
	political_view_id SERIAL PRIMARY KEY,
	political_views VARCHAR(30) NOT NULL
);

SELECT * FROM political_views; 

INSERT political_views(political_views)
VALUES
("Коммунистические"),
("Социалистические"),
("Умеренные"),
("Либеральные"),
("Консервативные"),
("Монархичекие"),
("Ультраконсервативные"),
("Индифферентные"),
("Либертарианские");

CREATE TABLE users_political_views(
	political_view_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (political_view_id, user_id),
	CONSTRAINT fk_political_view_user_id FOREIGN KEY (user_id) REFERENCES users (id),
	CONSTRAINT fk_political_view_id FOREIGN KEY (political_view_id) REFERENCES political_views (political_view_id)
);

CREATE TABLE users_status(
	status_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (status_id, user_id),
	CONSTRAINT fk_users_user_id FOREIGN KEY (user_id) REFERENCES users (id),
	CONSTRAINT fk_status_status_id FOREIGN KEY (status_id) REFERENCES status (status_id)
);

SELECT * FROM status;
SELECT * FROM users;
SELECT * FROM users_status;
SELECT * FROM political_views;
SELECT * FROM users_political_views;


INSERT INTO users_status
VALUES (8,2), (5,1);

INSERT INTO users_political_views 
VALUES (4,1), (6,2);

SELECT u.firstname, u.lastname, s.status_id FROM users u
INNER JOIN users_status s ON u.id = s.user_id;

SELECT u.firstname, u.lastname, p.political_view_id FROM users u
INNER JOIN users_political_views p ON u.id = p.user_id;
