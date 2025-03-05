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
INSERT INTO passwords(pw_code) VALUES ('hq123456789');
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

-- ====== VIEWS ======

-- 1.Get all users

CREATE VIEW get_all_users AS
SELECT persons.p_name AS first_name, persons.p_lastname AS last_name, users.u_username AS username, users.u_email AS email, accounts.create_at AS create_at, accounts.update_at AS update_at 
FROM accounts
INNER JOIN persons ON accounts.p_id = persons.p_id
INNER JOIN users ON accounts.u_id = users.u_id;

-- 2.Get all lists

CREATE VIEW get_all_lists AS
SELECT l_id, l_name FROM lists;

-- ====== FUNCTIONS ======

-- 1. GET USER ID

DELIMITER $$
CREATE FUNCTION get_user_id(e VARCHAR(100)) RETURNS INT DETERMINISTIC
BEGIN
	SET @userID = (
		SELECT u_id FROM users WHERE u_email = e
	);
    
    RETURN @userID;
END $$
DELIMITER ;

-- 2. GET PASSWORD ID

DELIMITER $$
CREATE FUNCTION get_password(e VARCHAR(100)) RETURNS VARCHAR(255) DETERMINISTIC 
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

-- ====== PROCEDURES ======

-- 1. Ver um utilizador em especifico

DELIMITER $
CREATE PROCEDURE get_user(e VARCHAR(100))
BEGIN    
	SELECT * FROM get_all_users WHERE email = e;
END $

-- 2. Ver uma lista em especifico e os seus respetivos tópicos

DELIMITER $
CREATE PROCEDURE get_list(e VARCHAR(100), ln VARCHAR (75))
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

-- 3. Mostrar um utilizador em especifico com o seu ID, Username e mostrar os ID's das Listas e o nome delas que ele possui

DELIMITER $
CREATE PROCEDURE get_user_lists(e VARCHAR (100))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );

	SELECT l_name FROM lists WHERE u_id = @user_id;
END $

-- 4. CREATE USER

DELIMITER $
CREATE PROCEDURE create_user(username VARCHAR(50), e VARCHAR (100), pw VARCHAR(255))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );

	IF @user_id IS NULL THEN
		INSERT INTO persons(p_name, p_lastname, p_age) VALUES('', '', NULL);
        SET @persons_id = (LAST_INSERT_ID());
        
		INSERT INTO users(u_username, u_email) VALUES(username, e);
        SET @user_inserted_id = (LAST_INSERT_ID());
        
        INSERT INTO passwords(pw_code) VALUES(pw);
        INSERT INTO accounts(p_id, u_id, pw_id) VALUES(@persons_id, @user_inserted_id, LAST_INSERT_ID());
    END IF;
END $

-- 5. CREATE LIST

DELIMITER $
CREATE PROCEDURE create_list(e VARCHAR (100), li VARCHAR(75))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );

	IF @user_id IS NOT NULL THEN
		INSERT INTO lists(l_name, u_id) VALUES (li, @user_id);
    END IF;
END $



-- 6. CREATE TOPICS

DELIMITER $
CREATE PROCEDURE create_topics(e VARCHAR (100), li VARCHAR(75), top VARCHAR(255))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );
    SET @list_id = (
		SELECT l_id FROM lists WHERE u_id = @user_id AND l_name = li
    );

	IF @user_id AND @list_id IS NOT NULL THEN
		INSERT INTO topics(l_id, t_text) VALUES (@list_id, top);
    END IF;
END $

-- 7. UPDATE LIST

DELIMITER $
CREATE PROCEDURE update_list(e VARCHAR (100), li VARCHAR(75), new_li VARCHAR(75))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );
    SET @list_id = (
		SELECT l_id FROM lists WHERE u_id = @user_id AND l_name = li
    );

	IF @user_id AND @list_id IS NOT NULL THEN
		UPDATE lists
		SET l_name = new_li
		WHERE l_id = @list_id;
    END IF;
END $

-- 8. DELETE LIST

DELIMITER $
CREATE PROCEDURE delete_list(e VARCHAR (100), li VARCHAR(75))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );
    SET @list_id = (
		SELECT l_id FROM lists WHERE u_id = @user_id AND l_name = li
    );
    
	IF @user_id AND @list_id IS NOT NULL THEN
		DELETE FROM topics
		WHERE l_id IN (@list_id);
		DELETE FROM lists
		WHERE l_id = @list_id;
    END IF;
END $

-- 9. DELETE USER LISTS

DELIMITER $
CREATE PROCEDURE delete_user_lists(e VARCHAR (100))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );
    
	IF @user_id IS NOT NULL THEN
		DELETE t
        FROM topics t
        JOIN lists l ON t.l_id = l.l_id
        WHERE l.u_id = @user_id;
        
		DELETE FROM lists
		WHERE u_id = @user_id;
    END IF;
END $

-- 10. DELETE TOPIC

DELIMITER $
CREATE PROCEDURE delete_topic(e VARCHAR (100), li VARCHAR(75), top VARCHAR(255))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );
    SET @list_id = (
		SELECT l_id FROM lists WHERE u_id = @user_id AND l_name = li
    );

	IF @user_id AND @list_id IS NOT NULL THEN
		DELETE FROM topics 
        WHERE t_text = top;
    END IF;
END $

-- 11. DELETE LIST TOPICS

DELIMITER $
CREATE PROCEDURE delete_list_topics(e VARCHAR (100), li VARCHAR(75))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );
    SET @list_id = (
		SELECT l_id FROM lists WHERE u_id = @user_id AND l_name = li
    );

	IF @user_id AND @list_id IS NOT NULL THEN
		DELETE FROM topics 
        WHERE l_id = @list_id;
    END IF;
END $

-- 12. GET LIST TOPICS

DELIMITER $
CREATE PROCEDURE get_list_topics(e VARCHAR (100), ln VARCHAR(75))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );
    
    SET @list_id = (
		SELECT l_id FROM lists WHERE u_id = @user_id AND l_name = ln
    );

	SELECT topics.t_text AS t_text
    FROM lists
    INNER JOIN topics ON topics.l_id = lists.l_id
    WHERE lists.l_id = @list_id;
END $

-- 13. UPDATE TOPICS 

DELIMITER $
CREATE PROCEDURE update_topic(e VARCHAR (100), li VARCHAR(75), top VARCHAR(255), new_top VARCHAR(255))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );
    SET @list_id = (
		SELECT l_id FROM lists WHERE u_id = @user_id AND l_name = li
    );

	IF @user_id AND @list_id IS NOT NULL THEN
		UPDATE topics
		SET t_text = new_top
		WHERE t_text = top;
    END IF;
END $

-- 14. UPDATE USER INFO

DELIMITER $
CREATE PROCEDURE update_user_info(e VARCHAR (100), firstname VARCHAR(30), lastname VARCHAR(30), username VARCHAR(50), pw VARCHAR(255))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );
    
    SET @persons_id = (
		SELECT p_id FROM accounts WHERE u_id = @user_id
    );

	SET @password_id = (
		SELECT pw_id FROM accounts WHERE u_id = @user_id
    );
    
	IF @user_id IS NOT NULL THEN
		IF firstname IS NOT NULL THEN
			UPDATE persons
            SET p_name = firstname
            WHERE p_id = @persons_id;
        END IF;
        
        IF lastname IS NOT NULL THEN
			UPDATE persons
            SET p_lastname = lastname
            WHERE p_id = @persons_id;
        END IF;
        
        IF username IS NOT NULL THEN
			UPDATE users
            SET u_username = username
            WHERE u_id = @user_id;
        END IF;
        
        IF pw IS NOT NULL THEN
			UPDATE passwords
            SET pw_code = pw
            WHERE pw_id = @password_id;
        END IF;
    END IF;
END $

-- 15. DELETE USER

DELIMITER $
CREATE PROCEDURE delete_user(e VARCHAR (100))
BEGIN
	SET @user_id = (
		SELECT get_user_id(e)
    );
    
    SET @list_id = (
		SELECT l_id FROM lists WHERE u_id = @user_id
	);
    
	DELETE FROM topics
	WHERE l_id = @list_id;
    
	DELETE FROM lists
	WHERE u_id = @user_id;
    
    DELETE FROM accounts
    WHERE u_id = @user_id;
END $