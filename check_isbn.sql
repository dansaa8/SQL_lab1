DELIMITER ///
CREATE FUNCTION check_isbn (isbn VARCHAR(13)) RETURNS BOOL DETERMINISTIC
BEGIN
    DECLARE checksum INT;
    DECLARE loop_count INT;


-- Kontrollera att ISBN-koden är 13 lång
IF CHAR_LENGTH(isbn) != 13 THEN
    RETURN FALSE;
END IF;

-- Kontrollera att ISBN-koden börjar med 978 eller 979
IF SUBSTRING(isbn, 1, 3) NOT IN ('978', '979') THEN
    RETURN FALSE;
END IF;

-- Räkna ut checksumman
SET checksum = 0;

SET loop_count = 1;
WHILE loop_count <= 12 DO
    SET checksum = checksum + MOD(SUBSTRING(isbn, loop_count, 1), 10);
    SET loop_count = loop_count + 1;
END WHILE;

-- Kontrollera att checksumman är korrekt
IF (checksum + 1) % 11 != 0 THEN
    RETURN FALSE;
END IF;

RETURN TRUE;

END;