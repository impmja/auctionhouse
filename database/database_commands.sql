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
GRANT ALL PRIVILEGES ON SEQUENCE bid_id_seq TO auctionhouse_root;



-- Create Purchases Table
CREATE TABLE Purchases (
  id SERIAL PRIMARY KEY ,
  user_id INT REFERENCES Users(id) ON DELETE SET NULL,
  article_id INT REFERENCES Article(id) ON DELETE SET NULL,
  price INT NULL DEFAULT 0,
  purchase_date TIMESTAMP NULL DEFAULT current_timestamp
 );

GRANT ALL PRIVILEGES ON Purchases TO auctionhouse_root;
GRANT ALL PRIVILEGES ON SEQUENCE purchases_id_seq TO auctionhouse_root;

-- No Test Data, will be created in use



-- Create Comments Table
CREATE TABLE Comments (
  id SERIAL PRIMARY KEY ,
  article_id INT REFERENCES Article(id) ON DELETE SET NULL,
  user_id INT REFERENCES Users(id) ON DELETE SET NULL,
  comment VARCHAR(256) NOT NULL,
  creation_date TIMESTAMP NULL DEFAULT current_timestamp
 );

GRANT ALL PRIVILEGES ON Comments TO auctionhouse_root;
GRANT ALL PRIVILEGES ON SEQUENCE comments_id_seq TO auctionhouse_root;


-- Insert Test User
INSERT INTO Users (id, email, password, first_name, last_name, street_name, zip_code, city, state, country, creation_date) 
VALUES (DEFAULT, 'info@herwig-hensler.de', '1234', 'Herwig', 'Henseler', 'Lehms 9', '26197', 'Großenkneten', 'Niedersachsen', 'Deutschland', DEFAULT);
INSERT INTO Users (id, email, password, first_name, last_name, street_name, zip_code, city, state, country, creation_date) 
VALUES (DEFAULT, 'impmja@gmx.de', '4321', 'Jan', 'Schulte', 'Spittaler Str. 1B', '28359', 'Bremen', 'Bremen', 'Deutschland', DEFAULT);
INSERT INTO Users (id, email, password, first_name, last_name, street_name, zip_code, city, state, country, creation_date) 
VALUES (DEFAULT, 'm.palser@gmx.de', 'yxcv1234', 'Marvin', 'Palser', 'Thomas-Mann-Straße 5', '29614', 'Soltau', 'Niedersachsen', 'Deutschland', DEFAULT);
INSERT INTO Users (id, email, password, first_name, last_name, street_name, zip_code, city, state, country, creation_date) 
VALUES (DEFAULT, 'admin@ebay2.de', 'yxcv', 'Admin', 'Admin', 'none', '11111', 'none', 'none', 'none', DEFAULT);
INSERT INTO Users (id, email, password, first_name, last_name, street_name, zip_code, city, state, country, creation_date) 
VALUES (DEFAULT, 'beate@web.de', 'vcxy', 'Beate', 'Bringer', 'Freier von Stein 17', '12345', 'Oldenburg', 'Niedersachsen', 'Deutschland', DEFAULT);
INSERT INTO Users (id, email, password, first_name, last_name, street_name, zip_code, city, state, country, creation_date) 
VALUES (DEFAULT, 'jens@freemail.com', 'jens', 'Jens', 'Jensen', 'Bremer Straße 50a', '54321', 'Bremerhaven', 'Niedersachsen', 'Deutschland', DEFAULT);


-- Insert Test Article
INSERT INTO Article(id, seller_id, image_id, title, description, is_direct_buy, start_price, end_date, creation_date)
VALUES (DEFAULT, 1, 1, 'Vorlesungsscript', 'Datenbank und Web - Vorlesungsscript. Zustand: Gut erhalten (leichte Gebrauchsspuren)!', FALSE, 100, '2013-06-25 17:00:00', DEFAULT);
INSERT INTO Article(id, seller_id, image_id, title, description, is_direct_buy, start_price, end_date, creation_date)
VALUES (DEFAULT, 1, 2, 'Db und Web - Gute Note', 'Datenbank und Web - Verkaufe gute Noten gegen Bares!', TRUE, 10000, '2013-06-25 17:00:00', DEFAULT);
INSERT INTO Article(id, seller_id, image_id, title, description, is_direct_buy, start_price, end_date, creation_date)
VALUES (DEFAULT, 2, 3, 'Code for Food', 'Programmiere fuer futerale Gegenleistungen!', TRUE, 1000, '2013-06-25 17:00:00', DEFAULT);
INSERT INTO Article(id, seller_id, image_id, title, description, is_direct_buy, start_price, end_date, creation_date)
VALUES (DEFAULT, 3, 4, 'Fish & Chips', 'Njom njom njom', TRUE, 300, '2013-06-25 17:00:00', DEFAULT);
INSERT INTO Article(id, seller_id, image_id, title, description, is_direct_buy, start_price, end_date, creation_date)
VALUES (DEFAULT, 5, 5, 'Puppies', 'Really sweet puppies for sale!', TRUE, 5000, '2013-06-24 12:00:00', DEFAULT);
INSERT INTO Article(id, seller_id, image_id, title, description, is_direct_buy, start_price, end_date, creation_date)
VALUES (DEFAULT, 6, 6, 'Flash-Kueche', 'Verkaufe meine einzigartige Flash-Kueche mit Rezepten zum Nachkochen ;)', FALSE, 100, '2013-06-23 23:30:00', DEFAULT);


-- Insert Test Bids
INSERT INTO Bid(id, bidder_id, article_id, bid, bid_date)
VALUES (DEFAULT, 2, 1, 101, '2013-06-23 17:00:00');
INSERT INTO Bid(id, bidder_id, article_id, bid, bid_date)
VALUES (DEFAULT, 3, 1, 110, '2013-06-23 17:10:00');
INSERT INTO Bid(id, bidder_id, article_id, bid, bid_date)
VALUES (DEFAULT, 2, 1, 120, '2013-06-23 17:30:00');

INSERT INTO Bid(id, bidder_id, article_id, bid, bid_date)
VALUES (DEFAULT, 2, 2, 10001, '2013-06-23 17:30:00');
INSERT INTO Bid(id, bidder_id, article_id, bid, bid_date)
VALUES (DEFAULT, 3, 2, 10101, '2013-06-23 17:56:00');
INSERT INTO Bid(id, bidder_id, article_id, bid, bid_date)
VALUES (DEFAULT, 2, 2, 10216, '2013-06-23 18:01:00');
INSERT INTO Bid(id, bidder_id, article_id, bid, bid_date)
VALUES (DEFAULT, 3, 2, 10520, '2013-06-23 18:11:10');


-- Insert Test Images
INSERT INTO Image(id, article_id, uri, creation_date)
VALUES (DEFAULT, 1, 'skript.png', DEFAULT);
INSERT INTO Image(id, article_id, uri, creation_date)
VALUES (DEFAULT, 2, 'note.png', DEFAULT);
INSERT INTO Image(id, article_id, uri, creation_date)
VALUES (DEFAULT, 3, 'codefood.png', DEFAULT);
INSERT INTO Image(id, article_id, uri, creation_date)
VALUES (DEFAULT, 4, 'fishchips.png', DEFAULT);
INSERT INTO Image(id, article_id, uri, creation_date)
VALUES (DEFAULT, 5, 'puppies.png', DEFAULT);
INSERT INTO Image(id, article_id, uri, creation_date)
VALUES (DEFAULT, 6, 'kueche.png', DEFAULT);


-- Insert Test Comments
INSERT INTO Comments(id, article_id, user_id, comment, creation_date)
VALUES (DEFAULT, 2, 2, 'Geht nicht guenstiger? :D', DEFAULT);
INSERT INTO Comments(id, article_id, user_id, comment, creation_date)
VALUES (DEFAULT, 2, 1, 'Nope', DEFAULT);
INSERT INTO Comments(id, article_id, user_id, comment, creation_date)
VALUES (DEFAULT, 2, 3, 'Fuer nen 5er bin ich dabei ;)', DEFAULT);
INSERT INTO Comments(id, article_id, user_id, comment, creation_date)
VALUES (DEFAULT, 2, 1, '100 - nicht mehr, nicht weniger!', DEFAULT);
INSERT INTO Comments(id, article_id, user_id, comment, creation_date)
VALUES (DEFAULT, 2, 1, 'Ueberlegen Sie es sich gut, immerhin investieren Sie damit in Ihre Zukunft...', DEFAULT);
INSERT INTO Comments(id, article_id, user_id, comment, creation_date)
VALUES (DEFAULT, 2, 6, 'Top Ebayer! Alles super schnell und Ware wie beschrieben! Danke, 5 Sternchen von mir!', DEFAULT);






