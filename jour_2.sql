/* 
	Correction TP1 
*/
-- Création de la table telephones
DROP TABLE IF EXISTS telephones;
CREATE TABLE IF NOT EXISTS telephones (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150),
    manufacturer VARCHAR(150),
    price NUMERIC(6,2), --- 8524,76
    units_sold INTEGER
);

INSERT INTO telephones (name, manufacturer, price, units_sold) VALUES
('N1280', 'Nokia', 199, 1925),
('Iphone 4', 'Apple', 399, 9436),
('Galaxy S 5', 'Samsung', 299, 2359),
('S5620 Monte', 'Samsung', 250, 2385),
('N8', 'Nokia', 150, 7543),
('Droid', 'Motorola', 150, 8395),
('Iphone 13 Pro Max', 'Apple', 1300, 12849),
('Galaxy Note 20', 'Samsung', 1100, 10353),
('Lumia 920', 'Nokia', 299, 5847),
('Iphone SE', 'Apple', 499, 9726),
('Galaxy S20', 'Samsung', 899, 7435),
('P40 Pro', 'Huawei', 799, 5382),
('Moto G7', 'Motorola', 199, 6903),
('Redmi Note 9 Pro', 'Xiaomi', 299, 4208),
('Pixel 5', 'Google', 699, 3121),
('Xperia 1 II', 'Sony', 1099, 1923),
('3310', 'Nokia', 99, 12568),
('Iphone 12', 'Apple', 1099, 10548),
('Galaxy A51', 'Samsung', 399, 8620),
('P30 Pro', 'Huawei', 899, 6741),
('Moto G8', 'Motorola', 249, 5947),
('Redmi Note 8 Pro', 'Xiaomi', 249, 5184),
('Pixel 4a', 'Google', 499, 3129),
('Xperia 5 II', 'Sony', 899, 2387),
('6.2', 'Nokia', 179, 8412),
('Iphone 11', 'Apple', 799, 10962),
('Galaxy A71', 'Samsung', 499, 7692),
('P20 Pro', 'Huawei', 699, 4510),
('Moto E6 Plus', 'Motorola', 149, 6934),
('Redmi Note 7', 'Xiaomi', 199, 4367),
('Pixel 3a', 'Google', 399, 2296),
('Xperia 10 II', 'Sony', 399, 1715),
('Nokia 7.2', 'Nokia', 349, 4598),
('Iphone X', 'Apple', 999, 8765),
('Galaxy S10', 'Samsung', 799, 6543),
('P30 Lite', 'Huawei', 299, 3812),
('Moto G6', 'Motorola', 199, 5291),
('Redmi Note 6 Pro', 'Xiaomi', 249, 3719),
('Pixel 2 XL', 'Google', 599, 2098),
('Xperia XZ2', 'Sony', 699, 1543),
('Nokia 6.1', 'Nokia', 249, 3127),
('Iphone XR', 'Apple', 799, 7392),
('Galaxy A50', 'Samsung', 349, 5967),
('P20 Lite', 'Huawei', 349, 4210),
('Moto G5 Plus', 'Motorola', 179, 4923),
('Redmi Note 5', 'Xiaomi', 199, 3176),
('Pixel XL', 'Google', 499, 1823),
('Xperia XZ3', 'Sony', 799, 1287),
('Nokia 5.3', 'Nokia', 199, 2587),
('Iphone 8', 'Apple', 699, 6098);

SELECT * FROM telephones;

-- Q1 => Ecrire une requête pour liste tous les modèles de téléphones
SELECT DISTINCT  telephones.manufacturer FROM telephones ORDER BY manufacturer ASC;

-- Q1. Seconde option
-- SELECT telephones.manufacturer FROM telephones GROUP BY telephones.manufacturer ORDER BY manufacturer;

-- Q2.Ecrire une requête pour lister tous les détails(name, manufacturer) de tous les téléphone dont le prix est supérieur à 200€
SELECT name, manufacturer FROM telephones WHERE price >200;

-- Q3. Ecrire une requête pour lister les détails(name, manufacturer) de tous les téléphone dont le prix varie entre 150 et 200€
SELECT name,manufacturer, price FROM telephones WHERE price<200 AND price>150;
SELECT name,manufacturer, price FROM telephones WHERE price BETWEEN 150 AND 200;

-- Q4. Lister tous les téléphones de marque samsung et Apple
SELECT * FROM telephones WHERE manufacturer = 'Apple' OR manufacturer = 'Samsung';
SELECT * FROM telephones WHERE manufacturer ILIKE 'samsung' OR manufacturer ILIKE 'Apple';
SELECT * FROM telephones WHERE manufacturer ILIKE '%Samsung%' OR manufacturer ILIKE '%Apple%' ;

-- Q5. Afficher le revenu total pour les téléphones vendues.Pour chaque téléphone, vous avez le prix et la quantité vendu
SELECT *, price*units_sold AS total FROM telephones;

-- Q6. Interpretation 1 : Afficher le nombre des téléphones vendus Apple
SELECT SUM(units_sold) FROM telephones WHERE manufacturer = 'Apple';

-- Q6. Interpretation 2 : Afficher le nombre de modèles de Apple
SELECT COUNT(*) AS apple_phones_count FROM telephones WHERE manufacturer = 'Apple';

-- Q7. Afficher toutes les données de la table téléphone en renommant les champs de la manière suivante:
-- name=>modèle, manufacturer => fabricant, price => prix, units_sold => quantité vendue
SELECT name AS modèle,
  manufacturer AS fabricant,
  price AS prix,
  units_sold AS quantité_vendue 
  FROM telephones;

-- Q8. Afficher tous les téléphones dont le prix total des ventes est supérieur à 1300000€.
SELECT name AS telephone,
  price * units_sold AS revenu_total FROM telephones WHERE (price * units_sold) > 1300000;
  
  
-- GOUP BY
SELECT manufacturer FROM telephones;
SELECT * FROM telephones ORDER BY manufacturer;

SELECT manufacturer FROM telephones GROUP BY manufacturer;
SELECT name, manufacturer FROM telephones GROUP BY manufacturer;

SELECT manufacturer, SUM(units_sold)  FROM telephones GROUP BY manufacturer;
SELECT manufacturer, SUM(units_sold) AS quantity, COUNT(id)  FROM telephones GROUP BY manufacturer;


-- groupe dont unit solde is greater than 10000
SELECT 
	manufacturer,
	SUM(units_sold),
	COUNT(id) 
FROM telephones 
GROUP BY manufacturer
HAVING SUM(units_sold) > 10000;

SELECT 
	manufacturer,
	SUM(units_sold),
	COUNT(id)  
FROM telephones
GROUP BY manufacturer 
HAVING manufacturer = 'Apple' OR manufacturer = 'Google' 
ORDER BY COUNT(id);

-- Sous-requetes
SELECT * FROM books;

DROP TABLE IF EXISTS books;
CREATE TABLE IF NOT EXISTS books (
	id SERIAL,
	title VARCHAR(150),
	year_published SMALLINT,
	publisher VARCHAR(50),
	price NUMERIC(6,2)
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

SELECT * FROM books WHERE title ILIKE '%SQL%';
SELECT * FROM books WHERE price > 20;

SELECT * FROM books WHERE title ILIKE '%SQL%' AND price > 20;

SELECT * FROM books WHERE title ILIKE '%SQL%' AND id IN (SELECT id FROM books WHERE price > 20);

-- 1
SELECT id FROM books WHERE price > 20
-- 2
SELECT * FROM books WHERE title ILIKE '%SQL%' AND id IN (2, 3, 4, 6, 8, 9);

-- CASE: Pour les colonnes conditionelles
SELECT *, 
CASE
	WHEN price > 20 THEN 'Tres Cher'
	WHEN price > 15 THEN 'Pas mal'
	WHEN price > 12 THEN 'Abordable'
	ELSE 'Moins cher'
END
AS "Avis sur prix" FROM

--- Contraintes
DROP TABLE IF EXISTS books_authors;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS books;

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

SELECT * FROM books;
SELECT * FROM authors;
SELECT * FROM books_authors;

SELECT * FROM books WHERE id = 3;

INSERT INTO books_authors (book_id, author_id) VALUES (1, 3), (4, 4),(5, 4),(3, 1),(7, 3),(8, 3),(6, 3),(8, 3);

-- Suppression avec contraintes
DELETE FROM books WHERE id = 1;

-- Suppression de la contrainte FKEY: suppression de la refernce
ALTER TABLE books_authors
DROP CONSTRAINT books_authors_book_id_fkey,
ADD CONSTRAINT books_authors_book_id_fkey 
FOREIGN KEY(book_id) REFERENCES books
ON DELETE CASCADE

DELETE FROM books WHERE id = 1;

SELECT * FROM books;
SELECT * FROM books_authors;

-- Suppression de la contrainte FKEY: modification de la refernce
ALTER TABLE books_authors
DROP CONSTRAINT books_authors_book_id_fkey,
ADD CONSTRAINT books_authors_book_id_fkey 
FOREIGN KEY(book_id) REFERENCES books
ON DELETE SET NULL(book_id);

DELETE FROM books WHERE id = 4;

-- tables temporaires
/*
-- 1
SELECT id FROM books WHERE price > 20
-- 2
SELECT * FROM books WHERE title ILIKE '%SQL%' AND id IN (2, 3, 4, 6, 8, 9);
*/

WITH
	expensive_books AS (SELECT * FROM books WHERE price > 30),
	sql_books AS (SELECT * FROM books WHERE title ILIKE '%sql%')
SELECT * FROM sql_books WHERE id in (SELECT id FROM expensive_books);


SELECT * FROM books;


CREATE TABLE IF NOT EXISTS error_books (
	id SERIAL PRIMARY KEY,
	title VARCHAR(150) NOT NULL,
	year_published SMALLINT NOT NULL,
	publisher VARCHAR(50) NOT NULL,
	price NUMERIC(6,2) NOT NULL CHECK(price>0)
);

WITH
	error_rows AS (DELETE FROM books WHERE title ILIKE '%sql%' RETURNING *)
INSERT INTO error_books (SELECT * FROM error_rows)

SELECT title, price AS Prix FROM books;
SELECT * FROM error_books;
