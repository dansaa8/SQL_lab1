CREATE USER 'developer'@'%' IDENTIFIED BY 'developer';
GRANT INSERT, DELETE, UPDATE on bookstore.* TO 'developer'@'%';

CREATE USER 'web_server'@'%' IDENTIFIED BY 'web_server';
