-- Create the database
CREATE DATABASE books_database;
USE books_database;

-- Create the books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher ENUM('Print House', 'Reader Series', 'Rainbook', 'Glassowl', 'Wooden Letters') NOT NULL,
    genre ENUM('Fiction', 'Mystery', 'Thriller', 'Fantasy', 'Biography') NOT NULL,
    lang ENUM('English', 'Russian', 'Japanese', 'German', 'Chinese') NOT NULL,
    price INT CHECK (price BETWEEN 10 AND 50),
    stock_quantity INT NOT NULL,
    UNIQUE KEY publisher_genre_lang (publisher, genre, lang)
);

-- Create the discounts table
CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    pct_discount DECIMAL(5,2) CHECK (pct_discount BETWEEN 0 AND 100),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Create a stored procedure to populate the books table
DELIMITER $$
CREATE PROCEDURE PopulateBooks()
BEGIN
    DECLARE counter INT DEFAULT 0;
    DECLARE max_records INT DEFAULT 100;
    DECLARE publisher ENUM('Print House', 'Reader Series', 'Rainbook', 'Glassowl', 'Wooden Letters');
    DECLARE genre ENUM('Fiction', 'Mystery', 'Thriller', 'Fantasy', 'Biography');
    DECLARE lang ENUM('English', 'Russian', 'Japanese', 'German', 'Chinese');
    DECLARE price INT;
    DECLARE stock INT;

    -- Seed the random number generator
    SET SESSION rand_seed1 = UNIX_TIMESTAMP();

    WHILE counter < max_records DO
        -- Generate random values
        SET publisher = ELT(FLOOR(1 + RAND() * 5), 'Print House', 'Reader Series', 'Rainbook', 'Glassowl', 'Wooden Letters');
        SET genre = ELT(FLOOR(1 + RAND() * 5), 'Fiction', 'Mystery', 'Thriller', 'Fantasy', 'Biography');
        SET lang = ELT(FLOOR(1 + RAND() * 5), 'English', 'Russian', 'Japanese', 'German', 'Chinese');
        SET price = FLOOR(10 + RAND() * 41);
        SET stock = FLOOR(10 + RAND() * 91);

        -- Attempt to insert a new record
        -- Duplicate publisher, genre, age_group combinations will be ignored due to the unique constraint
        BEGIN
            DECLARE CONTINUE HANDLER FOR 1062 BEGIN END;  -- Handle duplicate key error
            INSERT INTO books (publisher, genre, lang, price, stock_quantity)
            VALUES (publisher, genre, lang, price, stock);
            SET counter = counter + 1;
        END;
    END WHILE;
END$$
DELIMITER ;

-- Call the stored procedure to populate the books table
CALL PopulateBooks();

-- Insert at least 10 records into the discounts table
INSERT INTO discounts (book_id, pct_discount)
VALUES
(1, 10.00),
(2, 15.00),
(3, 20.00),
(4, 5.00),
(5, 25.00),
(6, 10.00),
(7, 30.00),
(8, 35.00),
(9, 40.00),
(10, 45.00);