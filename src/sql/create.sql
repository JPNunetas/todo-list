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
    u_email VARCHAR(100) NOT NULL,
    
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
DELIMITER $
CREATE PROCEDURE get_all()
BEGIN
	SELECT persons.p_id, persons.p_name, persons.p_lastname, persons.p_age, users.u_id, users.u_username, users.u_email, 
    passwords.pw_id, passwords.pw_code, lists.l_id, lists.u_id, lists.l_name, topics.t_id, topics.l_id, topics.t_text
	FROM accounts
	LEFT JOIN persons ON accounts.p_id = persons.p_id
	LEFT JOIN users ON accounts.u_id = users.u_id
    LEFT JOIN passwords ON accounts.pw_id = passwords.pw_id
    LEFT JOIN lists ON lists.u_id = users.u_id
    LEFT JOIN topics ON topics.l_id = lists.l_id;
END $
-- 1. Ver todos os utilizadores

DELIMITER $
CREATE PROCEDURE get_users_info()
BEGIN
	SELECT persons.p_name AS first_name, persons.p_lastname AS last_name, users.u_username AS username, users.u_email AS email, accounts.create_at AS create_at, accounts.update_at AS update_at 
	FROM accounts
	INNER JOIN persons ON accounts.p_id = persons.p_id
	INNER JOIN users ON accounts.u_id = users.u_id;
END $

-- 2. Ver um utilizador em especifico

DELIMITER $
CREATE PROCEDURE get_user(e VARCHAR(100))
BEGIN
	SET @userID = (
		SELECT get_user_id(e)
    );
    
	SELECT accounts.u_id, persons.p_name, persons.p_lastname, passwords.pw_code, accounts.create_at, accounts.update_at 
	FROM accounts
	INNER JOIN persons ON accounts.p_id = persons.p_id
	INNER JOIN users ON accounts.u_id = users.u_id
	INNER JOIN passwords ON accounts.pw_id = passwords.pw_id
	WHERE accounts.u_id = @userID;
END $

-- 3. Ver todas as listas

DELIMITER $
CREATE PROCEDURE all_lists()
BEGIN
SELECT l_id, l_name FROM lists; 
END $

-- 4. Ver uma lista em especifico e os seus respetivos tópicos

DELIMITER $
CREATE PROCEDURE get_list(e VARCHAR(255), ln VARCHAR (75))
BEGIN
	SET @u_id = (
		SELECT get_user_id(e)
    );

	SET @list_id = (
		SELECT l_id FROM lists WHERE u_id = @u_id AND l_name = ln 
    );
    
    IF @list_id IS NOT NULL THEN
		SELECT topics.t_text AS topics_columns FROM lists 
		INNER JOIN topics ON topics.l_id = lists.l_id
		WHERE lists.l_id = @list_id;
	END IF;
END $

-- 5. Mostrar um utilizador em especifico com o seu ID, Username e mostrar os ID's das Listas e o nome delas que ele possui

DELIMITER $
CREATE PROCEDURE get_user_lists(e VARCHAR (255))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );

	SELECT l_name FROM lists WHERE u_id = @user_id;
END $

DELIMITER $$
CREATE FUNCTION get_user_id(e VARCHAR(255)) RETURNS INT DETERMINISTIC
BEGIN
	SET @userID = (
		SELECT u_id FROM users WHERE u_email = e
	);
    
    RETURN @userID;
END $$
DELIMITER ;

DELIMITER $$

CREATE FUNCTION get_password(e VARCHAR(255)) RETURNS VARCHAR(255) DETERMINISTIC 
BEGIN	
    SET @pass = (
		SELECT passwords.pw_code AS password_code FROM accounts 
        INNER JOIN users ON users.u_id = accounts.u_id
        INNER JOIN passwords ON passwords.pw_id = accounts.pw_id
        WHERE u_email = e
	);
    
    RETURN @pass;
END $$
DELIMITER ;

DELIMITER $
CREATE PROCEDURE create_user(u_name VARCHAR(50), email VARCHAR(100), pass VARCHAR(255))
	BEGIN 
		INSERT INTO users(u_username,u_email) VALUES (u_name, email);
		INSERT INTO passwords(pw_code) VALUES (pass);
        SET @u_id = (SELECT u_id FROM users WHERE u_name = u_username);
        SET @pw_id = (SELECT pw_id FROM passwords WHERE pass = pw_code);
        SET @p_id = (SELECT p_id FROM accounts WHERE p_id = LAST_INSERT_ID());
        INSERT INTO persons(p_id) VALUES (@p_id);
		INSERT INTO accounts(p_id, u_id, pw_id) VALUES (LAST_INSERT_ID(), @u_id, @pw_id);
	END $
    
DELIMITER $
CREATE PROCEDURE create_list(e VARCHAR(100),list_name VARCHAR(75))
	BEGIN 
		SET @user_id = (
			SELECT get_user_id(e)
		);
        
		INSERT INTO lists( u_id, l_name) VALUES ( @user_id, list_name);
	END $

DELIMITER $
CREATE PROCEDURE create_topics(e VARCHAR(100), list_name VARCHAR(75), topic_name VARCHAR(255))
	BEGIN 
		SET @list_id = (
			SELECT lists.l_id FROM users 
            INNER JOIN lists ON lists.u_id = users.u_id
            WHERE e = users.u_email AND list_name = lists.l_name
		);
        
		INSERT INTO topics(l_id, t_text) VALUES (@list_id, topic_name);
	END $
    
DELIMITER $
CREATE PROCEDURE update_list(e VARCHAR(100),list_name VARCHAR(75))
	BEGIN
		UPDATE lists 
        INNER JOIN users ON users.u_id = lists.u_id
        SET l_name = list_name
        WHERE u_email = e;
	END $

DELIMITER $
CREATE PROCEDURE update_topics(e VARCHAR(100), list_name VARCHAR(75), topic_name VARCHAR(255), new_topic_name VARCHAR(255))
	BEGIN
		UPDATE topics 
        INNER JOIN lists ON lists.l_id = topics.l_id
        INNER JOIN users ON users.u_id = lists.u_id
        SET t_text = new_topic_name
        WHERE u_email = e AND l_name = list_name AND t_text = topic_name;
	END $
    
DELIMITER $
CREATE PROCEDURE delete_list(e VARCHAR(100), list_name VARCHAR(75))
	BEGIN
		SET @list_id = (
			SELECT lists.l_id FROM users 
            INNER JOIN lists ON lists.u_id = users.u_id
            WHERE e = users.u_email AND list_name = lists.l_name
		);
        
		DELETE topics FROM topics
        INNER JOIN lists ON lists.l_id = topics.l_id
        WHERE lists.l_id = @list_id;
        
        DELETE FROM lists 
		WHERE lists.l_id = @list_id;
	END $

DELIMITER $
CREATE PROCEDURE delete_user_lists(e VARCHAR(100))
	BEGIN
		SET @userID = (
			SELECT u_id FROM users WHERE u_email = e
		);
		DELETE topics FROM topics
        INNER JOIN lists ON lists.l_id = topics.l_id
        WHERE lists.u_id = @userID;
        
        DELETE lists 
		FROM lists 
		INNER JOIN users ON lists.u_id = users.u_id
		WHERE users.u_id = @userID;
	END $
    
DELIMITER $    
CREATE PROCEDURE delete_topic(e VARCHAR(100), list_name VARCHAR(75), topic_name VARCHAR(255))
	BEGIN
		SET @list_id = (
			SELECT lists.l_id FROM users 
            INNER JOIN lists ON lists.u_id = users.u_id
            WHERE e = users.u_email AND list_name = lists.l_name
		);
        SET @topic_id = (
			SELECT topics.t_id FROM topics 
            INNER JOIN lists ON lists.l_id = topics.l_id
            WHERE topic_name = topics.t_text AND list_name = lists.l_name
		);
		
		DELETE topics FROM topics
        INNER JOIN lists ON lists.l_id = topics.l_id
        WHERE lists.l_id = @list_id AND topics.t_id = @topic_id;
	END $
 
DELIMITER $    
CREATE PROCEDURE delete_list_topics(e VARCHAR(100), list_name VARCHAR(75))
	BEGIN
		SET @list_id = (
			SELECT lists.l_id FROM users 
            INNER JOIN lists ON lists.u_id = users.u_id
            WHERE e = users.u_email AND list_name = lists.l_name
		);
		
		DELETE topics FROM topics
        INNER JOIN lists ON lists.l_id = topics.l_id
        WHERE lists.l_id = @list_id;
	END $
    
CALL get_user_lists('henrique@gmail.com');
CALL create_user('JAlves', 'oi@gmail.com', '123');
CALL create_list('oi@gmail.com', 'O q crlh');
CALL create_topics('oi@gmail.com', 'Ora más', 'fds2');
CALL update_list('oi@gmail.com', 'Ora más');
CALL update_topics('oi@gmail.com','Ora más','fds2','fds');
CALL delete_user_lists('henrique@gmail.com');
CALL delete_list('henrique@gmail.com', 'Arrumar a casa');
CALL delete_topic('henrique@gmail.com', 'Arrumar a casa', 'Aspirar');
CALL delete_list_topics('henrique@gmail.com', 'Arrumar a casa');
CALL get_all();

