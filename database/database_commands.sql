-- Create Database & User
--DROP USER auctionhouse_root;
CREATE USER auctionhouse_root WITH PASSWORD '1234';

DROP DATABASE auctionhouse;
CREATE DATABASE auctionhouse OWNER auctionhouse_root ENCODING 'utf8';


--GRANT ALL PRIVILEGES ON DATABASE auctionhouse to auctionhouse_root;

-- Connect to database
\c auctionhouse

-- Drop Tables
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Purchases;
DROP TABLE IF EXISTS Bid;
DROP TABLE IF EXISTS Image;
DROP TABLE IF EXISTS Article;
DROP TABLE IF EXISTS Users;



-- Create User Table
CREATE TABLE Users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(256) NOT NULL ,
  password VARCHAR(256) NOT NULL ,
  first_name VARCHAR(256) NOT NULL ,
  last_name VARCHAR(256) NOT NULL ,
  street_name VARCHAR(256) NOT NULL ,
  zip_code VARCHAR(20) NOT NULL ,
  city VARCHAR(256) NOT NULL ,
  state VARCHAR(256) NOT NULL ,
  country VARCHAR(256) NOT NULL,
  creation_date TIMESTAMP NOT NULL DEFAULT current_timestamp
);

GRANT ALL PRIVILEGES ON Users TO auctionhouse_root;


-- Inser Test User
INSERT INTO Users (id, email, password, first_name, last_name, street_name, zip_code, city, state, country, creation_date) 
VALUES (DEFAULT, 'info@herwig-hensler.de', '1234', 'Herwig', 'Henseler', 'Lehms 9', '26197', 'Großenkneten', 'Niedersachsen', 'Deutschland', DEFAULT);
INSERT INTO Users (id, email, password, first_name, last_name, street_name, zip_code, city, state, country, creation_date) 
VALUES (DEFAULT, 'impmja@gmx.de', '4321', 'Jan', 'Schulte', 'Spittaler Str. 1B', '28359', 'Bremen', 'Bremen', 'Deutschland', DEFAULT);
INSERT INTO Users (id, email, password, first_name, last_name, street_name, zip_code, city, state, country, creation_date) 
VALUES (DEFAULT, 'm.palser@gmx.de', 'yxcv1234', 'Marvin', 'Palser', 'Thomas-Mann-Straße 5', '29614', 'Soltau', 'Niedersachsen', 'Deutschland', DEFAULT);



-- Create Article Table
CREATE TABLE Article (
  id SERIAL PRIMARY KEY ,
  seller_id INT REFERENCES Users(id) ON DELETE SET NULL,
  image_id INT NULL ,
  title VARCHAR(256) NOT NULL,
  description VARCHAR(256) NULL,
  is_direct_buy BOOLEAN NOT NULL DEFAULT FALSE,
  start_price INT NOT NULL DEFAULT 0,
  end_date TIMESTAMP NOT NULL DEFAULT current_timestamp,
  creation_date TIMESTAMP NOT NULL DEFAULT current_timestamp
 );

GRANT ALL PRIVILEGES ON Article TO auctionhouse_root;

-- Insert Test Article
INSERT INTO Article(id, seller_id, image_id, title, description, is_direct_buy, start_price, end_date, creation_date)
VALUES (DEFAULT, 1, NULL, 'Vorlesungsscript', 'Datenbank und Web - Vorlesungsscript. Zustand: Gut erhalten (leichte Gebrauchsspuren)!', FALSE, 100, '2013-06-25 17:00:00', DEFAULT);
INSERT INTO Article(id, seller_id, image_id, title, description, is_direct_buy, start_price, end_date, creation_date)
VALUES (DEFAULT, 1, NULL, 'Db und Web - Gute Note', 'Datenbank und Web - Verkaufe gute Noten gegen Bares!', TRUE, 10000, '2013-06-25 17:00:00', DEFAULT);
INSERT INTO Article(id, seller_id, image_id, title, description, is_direct_buy, start_price, end_date, creation_date)
VALUES (DEFAULT, 2, NULL, 'Code for Food', 'Programmiere für futerale Gegenleistungen!', TRUE, 1000, '2013-06-25 17:00:00', DEFAULT);



-- Create Image Table
CREATE TABLE Image (
  id SERIAL PRIMARY KEY ,
  article_id INT REFERENCES Article(id) ON DELETE SET NULL,
  uri VARCHAR(256) NOT NULL,
  creation_date TIMESTAMP NULL DEFAULT current_timestamp
 );

GRANT ALL PRIVILEGES ON Image TO auctionhouse_root;


-- Create Bid Table
CREATE TABLE Bid (
  id SERIAL PRIMARY KEY ,
  bidder_id INT REFERENCES Users(id) ON DELETE SET NULL,
  article_id INT REFERENCES Article(id) ON DELETE SET NULL,
  bid INT NOT NULL DEFAULT 0,
  bid_date TIMESTAMP NULL DEFAULT current_timestamp
 );

GRANT ALL PRIVILEGES ON Bid TO auctionhouse_root;



-- Create Purchases Table
CREATE TABLE Purchases (
  id SERIAL PRIMARY KEY ,
  user_id INT REFERENCES Users(id) ON DELETE SET NULL,
  article_id INT REFERENCES Article(id) ON DELETE SET NULL,
  price INT NULL DEFAULT 0,
  purchase_date TIMESTAMP NULL DEFAULT current_timestamp
 );

GRANT ALL PRIVILEGES ON Purchases TO auctionhouse_root;



-- Create Comments Table
CREATE TABLE Comments (
  id SERIAL PRIMARY KEY ,
  article_id INT REFERENCES Article(id) ON DELETE SET NULL,
  user_id INT REFERENCES Users(id) ON DELETE SET NULL,
  comment VARCHAR(256) NOT NULL,
  creation_date TIMESTAMP NULL DEFAULT current_timestamp
 );

GRANT ALL PRIVILEGES ON Comments TO auctionhouse_root;








