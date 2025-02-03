DROP DATABASE tododb;
CREATE DATABASE tododb;
USE tododb;

-- TABLES

CREATE TABLE persons (
	p_id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
    p_name VARCHAR(30),
    p_lastname VARCHAR(30),
    p_age INT,
    
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE users (
	u_id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
    u_username VARCHAR(50) NOT NULL,
    u_email VARCHAR(255) NOT NULL,
    
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE passwords (
	pw_id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pw_code VARCHAR(255) NOT NULL,
    
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE accounts (
    p_id INT NOT NULL,
    u_id INT NOT NULL,
    pw_id INT NOT NULL,
    
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (p_id) REFERENCES persons(p_id),
    FOREIGN KEY (u_id) REFERENCES users(u_id),
    FOREIGN KEY (pw_id) REFERENCES passwords(pw_id),
    
    PRIMARY KEY (p_id, u_id, pw_id)
);

CREATE TABLE lists (
	l_id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
    u_id INT NOT NULL,
    l_name VARCHAR(75) NOT NULL,
    
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (u_id) REFERENCES accounts(u_id)
);

CREATE TABLE topics (
	t_id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
    l_id INT NOT NULL,
    t_text VARCHAR(255) NOT NULL,
    
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (l_id) REFERENCES lists(l_id)
);

-- ===== INSERTS =====

-- INSERT User João
INSERT INTO persons(p_name, p_lastname, p_age) VALUES ('João', 'Nunes', 18);
INSERT INTO users(u_username,u_email) VALUES ('Jonas', 'random@gmail.com');
INSERT INTO passwords(pw_code) VALUES ('Jp999');
INSERT INTO accounts(p_id, u_id, pw_id) VALUES (1, 1, 1);

-- INSERT User Ruben
INSERT INTO persons(p_name, p_lastname, p_age) VALUES ('Ruben', 'Costa', 20);
INSERT INTO users(u_username,u_email) VALUES ('ice', 'icesann@gmail.com');
INSERT INTO passwords(pw_code) VALUES ('ruben123');
INSERT INTO accounts(p_id, u_id, pw_id) VALUES (2, 2, 2);

-- INSERT User Henrique
INSERT INTO persons(p_name, p_lastname, p_age) VALUES ('Henrique', 'Bombado', 18);
INSERT INTO users(u_username,u_email) VALUES ('hq37', 'henrique@gmail.com');
INSERT INTO passwords(pw_code) VALUES ('hq123');
INSERT INTO accounts(p_id, u_id, pw_id) VALUES (3, 3, 3);

-- INSERT LISTS
INSERT INTO lists(u_id, l_name) VALUES (3, 'Velocidade dos animais');
INSERT INTO topics(l_id, t_text) VALUES (1, 'Cão é o mais rápido');
INSERT INTO topics(l_id, t_text) VALUES (1, 'Gato anda a velocidade normal');
INSERT INTO topics(l_id, t_text) VALUES (1, 'Tartaruga é lenta');

INSERT INTO lists(u_id, l_name) VALUES (3, 'Arrumar a casa');
INSERT INTO topics(l_id, t_text) VALUES (2, 'Limpar o quarto');
INSERT INTO topics(l_id, t_text) VALUES (2, 'Aspirar');
INSERT INTO topics(l_id, t_text) VALUES (2, 'Descansar');

-- ====== PROCEDURES ======

-- 1. Ver todos os utilizadores

DELIMITER $
CREATE PROCEDURE all_users()
BEGIN
SELECT accounts.u_id, persons.p_name, persons.p_lastname, passwords.pw_code, accounts.create_at, accounts.update_at 
FROM accounts
INNER JOIN persons ON accounts.p_id = persons.p_id
INNER JOIN users ON accounts.u_id = users.u_id
INNER JOIN passwords ON accounts.pw_id = passwords.pw_id;
END $

CALL all_users();

-- 2. Ver um utilizador em especifico

DELIMITER $
CREATE PROCEDURE get_user(u_id INT)
BEGIN
SELECT accounts.u_id, persons.p_name, persons.p_lastname, passwords.pw_code, accounts.create_at, accounts.update_at 
FROM accounts
INNER JOIN persons ON accounts.p_id = persons.p_id
INNER JOIN users ON accounts.u_id = users.u_id
INNER JOIN passwords ON accounts.pw_id = passwords.pw_id
WHERE accounts.u_id = u_id;
END $

CALL get_user(1);

-- 3. Ver todas as listas

DELIMITER $
CREATE PROCEDURE all_lists()
BEGIN
SELECT l_id, l_name FROM lists; 
END $

CALL all_lists();

-- 4. Ver uma lista em especifico e os seus respetivos tópicos

DELIMITER $
CREATE PROCEDURE get_list(lisID INT)
BEGIN
SELECT lists.l_id, lists.l_name, topics.t_id, topics.t_text 
FROM topics
INNER JOIN lists ON topics.l_id = lists.l_id
WHERE lists.l_id = lisID; 
END $

CALL get_list(1);

-- 5. Mostrar um utilizador em especifico com o seu ID, Username e mostrar os ID's das Listas e o nome delas que ele possui

DELIMITER $
CREATE PROCEDURE get_user_lists(u_id INT)
BEGIN
SELECT accounts.u_id, users.u_username, lists.l_id, lists.l_name, topics.t_id, topics.t_text 
FROM accounts
INNER JOIN persons ON accounts.p_id = persons.p_id
INNER JOIN users ON accounts.u_id = users.u_id
INNER JOIN passwords ON accounts.pw_id = passwords.pw_id
INNER JOIN lists ON lists.u_id = accounts.u_id
INNER JOIN topics ON topics.l_id = lists.l_id
WHERE accounts.u_id = u_id;
END $

DELIMITER $$
CREATE FUNCTION getUserID(e VARCHAR(255)) RETURNS INT DETERMINISTIC
BEGIN
	SET @userID = (
		SELECT u_id FROM users WHERE u_email = e
	);
    
    RETURN @userID;
END $$
DELIMITER ;

SELECT getUserID("henrique@gmail.com");

DELIMITER $$
CREATE FUNCTION getPassword(pwID INT) RETURNS VARCHAR(255) DETERMINISTIC 
BEGIN
    
    RETURN (SELECT pw_code FROM passwords WHERE pw_id = pwID);
END $$
DELIMITER ;

SELECT getPassword(2);