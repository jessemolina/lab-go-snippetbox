-- create utf-8 snippetbox db
-- CREATE DATABASE snippetbox CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- switch to snippetbox db
USE snippetbox;

-- create snippetbox table
CREATE TABLE snippets (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    created DATETIME NOT NULL,
    expires DATETIME NOT NULL
);

-- add an index on the created column
CREATE INDEX idx_snippets_created ON snippets(created);

-- create user
-- CREATE USER 'web'@'localhost';
-- GRANT SELECT, INSERT, UPDATE ON snippetbox.* TO 'web'@'localhost';
-- Important: Make sure to swap 'pass' with a password of your own choosing.
-- ALTER USER 'web'@'localhost' IDENTIFIED BY 'pass';
