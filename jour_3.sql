DROP TABLE IF EXISTS books_authors;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;


CREATE TABLE IF NOT EXISTS books (
	id SERIAL PRIMARY KEY,
	title VARCHAR(150) NOT NULL,
	year_published SMALLINT NOT NULL,
	publisher VARCHAR(50) NOT NULL,
	price NUMERIC(6,2) NOT NULL CHECK(price>0)
);

CREATE TABLE IF NOT EXISTS authors (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS books_authors (
	book_id INTEGER REFERENCES books,
	author_id INTEGER REFERENCES authors
);


INSERT INTO books (title, year_published, publisher, price) VALUES 
('Introduction au SQL', 2000, 'Packt', 15.49),
('La methode Agile', 2005, 'Oreilly', 23.99),
('Git & GitHub', 2020, 'Oreilly', 41.99),
('SQL pour l''analyse des données', 2021, 'Oreilly', 59.99),
('Le CSS', 2014, 'Wiley', 15.99),
('SQL : éléments internes de la base de données', 2018, 'Packt', 63.75),
('Java: Introduction', 2014,'Wiley', 11.99),
('Laravel pour les nuls', 2012, 'Apress', 23.99),
('L''art du SQL', 2015, 'Wiley', 27.75);


INSERT INTO authors (first_name, last_name) VALUES ('Xavier', 'Dupont'), ('Christophe', 'Laporte'), ('Pascal', 'Louis'), ('Claire', 'Martin');
INSERT INTO books_authors (book_id, author_id) VALUES (1, 3), (4, 4),(5, 4),(3, 1),(7, 3),(8, 3),(6, 3),(8, 3);

-- RETURNING *
SELECT * FROM books;
UPDATE books SET price=17.49 WHERE id =1
UPDATE books SET price=17.49 WHERE id =1 RETURNING *

INSERT INTO authors (first_name, last_name) VALUES ('Nicolas', 'Guerin')
INSERT INTO authors (first_name, last_name) VALUES ('Wahiba', 'Ghezali') RETURNING *

-- JOINTURES
-- Modifiez la table books en remplacant la colone publisher par publisher_id INTEGER
-- Puis crer une table publishers telles que:
DROP TABLE IF EXISTS publishers;
CREATE TABLE IF NOT EXISTS publishers (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);
INSERT INTO publishers (name) VALUES ('Packt'), ('Oreilly'), ('Wiley'), ('Apress');


SELECT * FROM publishers;

/*
SELECT [columns] premierer_table
JOIN deuxieme_table
ON condition
....
*/

-- INNER JOIN

SELECT publishers.name FROM books
INNER JOIN publishers
ON books.publisher_id = publishers.id
WHERE books.id = 1

-- Condition du join telle que books.publisher_id > publishers.id. Ceci n'a pas trop de sense
SELECT * FROM books
INNER JOIN publishers
ON books.publisher_id > publishers.id

-- LEFT JOIN
SELECT * FROM books
LEFT JOIN publishers
ON books.publisher_id = publishers.id

-- La commande precedednte ramenre le meme resultat. Et si on ajouter un novel edieteur sans lui attribuer des livres.
INSERT INTO publishers (name) VALUES ('m2i')

-- Reessayons le LEFT JOIN cette fois, mais inversons l'ordre des tables. publishers devient la premiere table(gauche)
SELECT * FROM publishers
LEFT JOIN books
ON books.publisher_id = publishers.id

-- LEFT OUTER JOIN
SELECT * FROM publishers
LEFT JOIN books
ON books.publisher_id = publishers.id
WHERE books.publisher_id IS NULL

-- JOIN sur 3 tables
SELECT * FROM books
JOIN books_authors
ON books.id = books_authors.book_id
JOIN authors
ON authors.id = books_authors.author_id

-- JOIN en selectionnant des colonnes specifiques
SELECT authors.id, title, author_id, first_name, last_name FROM books
JOIN books_authors
ON books.id = books_authors.book_id
JOIN authors
ON authors.id = books_authors.author_id

-- Les alias avec les jointures
SELECT a.id, b.title, ba.author_id, a.first_name, a.last_name FROM books AS b
JOIN books_authors AS ba
ON b.id = ba.book_id
JOIN authors AS a
ON a.id = ba.author_id

