
CREATE USER 'developer'@'%' IDENTIFIED BY 'developer';
GRANT CREATE, ALTER, DROP ON bookstore.* TO 'developer'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.* TO 'developer'@'%';

CREATE USER 'web_server'@'%' IDENTIFIED BY 'web_server';
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.* TO 'web_server'@'%';
