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