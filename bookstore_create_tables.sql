DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore;
USE bookstore;

CREATE TABLE author (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    birth_date DATE
);

CREATE TABLE language (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

CREATE TABLE bookstore (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    town VARCHAR(255)
);

CREATE TABLE book (
    isbn VARCHAR(255) PRIMARY KEY,
    title VARCHAR(255),
    price INT,
    publication_date DATE,
    fk_language_id INT,
    fk_author_id INT,
    CONSTRAINT FK_Book_Language FOREIGN KEY (fk_language_id) REFERENCES language(id),
    CONSTRAINT FK_Book_Author FOREIGN KEY (fk_author_id) REFERENCES author(id)
);

CREATE TABLE inventory (
    fk_store_id INT,
    fk_book_isbn VARCHAR(255),
    amount INT,
    CONSTRAINT FK_BookStore_Id FOREIGN KEY (fk_store_id) REFERENCES bookstore(id),
    CONSTRAINT FK_Book_Isbn FOREIGN KEY (fk_book_isbn) REFERENCES book(isbn),
    PRIMARY KEY(fk_store_id, fk_book_isbn)
);


DELIMITER //
CREATE FUNCTION check_isbn(ISBN VARCHAR(13))
RETURNS BOOLEAN
    DETERMINISTIC
    NO SQL
BEGIN
  DECLARE total INT;
  DECLARE i INT;

  -- Remove hyphens or spaces from the input ISBN
  SET ISBN = REPLACE(REPLACE(ISBN, '-', ''), ' ', '');

  -- Check if the ISBN is exactly 13 characters long
  IF LENGTH(ISBN) != 13 THEN
    RETURN FALSE;
  END IF;

  -- Check if the ISBN contains only numeric characters
  SET i = 1;
  WHILE i <= 13 DO
    IF NOT (SUBSTRING(ISBN, i, 1) BETWEEN '0' AND '9') THEN
      RETURN FALSE;
    END IF;
    SET i = i + 1;
  END WHILE;

  -- Calculate the ISBN-13 check digit
  SET total = 0;
  SET i = 1;
  WHILE i <= 12 DO
    IF i % 2 = 0 THEN
      SET total = total + SUBSTRING(ISBN, i, 1) * 3;
    ELSE
      SET total = total + SUBSTRING(ISBN, i, 1);
    END IF;
    SET i = i + 1;
  END WHILE;

  SET total = total % 10;
  SET total = 10 - total;

  IF total = 10 THEN
    SET total = 0;
  END IF;

  -- Compare the calculated check digit with the last character of the ISBN
  IF total = SUBSTRING(ISBN, 13, 1) THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END;
//

DROP TRIGGER if exists check_value;
-- Applicera funktionen ovan via TRIGGER
DELIMITER //
CREATE TRIGGER check_value BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    IF check_isbn(NEW.isbn) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid value for isbn_column';
    END IF;
END;//
DELIMITER ;