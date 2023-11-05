USE bookstore;

INSERT INTO language (name)
VALUES ('ENGLISH'),
       ('SPANISH'),
       ('GERMAN'),
       ('FRENCH'),
       ('SWEDISH')
;

INSERT INTO author (first_name, last_name, birth_date)
VALUES
    ('John', 'Smith', '1980-05-15'),
    ('Maria', 'Garcia', '1988-07-03'),
    ('Hannah', 'Müller', '1985-09-07'),
    ('Claire', 'Dubois', '1978-03-12'),
    ('Erik', 'Andersson', '1990-08-14')
;

INSERT INTO book(isbn, title, price, publication_date, language_id, author_id)
VALUES
    ('9780321965516', 'English Book', 45, '2001-06-07', 1, 1),
    ('9789144134932', 'Libro Espanol', 33, '2011-03-16', 2, 2),
    ('9781398527492', 'Deutsches Buch', 40, '2017-05-07', 3, 3),
    ('9781260457681', 'Livre Français', 25, '2015-04-01', 4, 4),
    ('9781847927484', 'Svensk Bok', 20, '1999-04-13', 5, 5)
;

INSERT INTO bookstore(name, town)
VALUES
    ('Borås stadsbibliotek', 'Borås'),
    ('Stockholms universitetsbibliotek', 'Stockholm'),
    ('Umeå stadsbibliotek', 'Umeå')
;

INSERT INTO inventory(store_id, book_isbn, amount)
VALUES
    (1, '9780321965516', 3),
    (1, '9789144134932', 6),
    (1, '9781398527492', 1),

    (2, '9780321965516', 7),
    (2, '9789144134932', 8),
    (2, '9781398527492', 4),
    (2, '9781260457681', 6),
    (2, '9781847927484', 3),

    (3, '9781260457681', 2),
    (3, '9781847927484', 1)
;
