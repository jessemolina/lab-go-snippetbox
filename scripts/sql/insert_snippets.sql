-- insert dummy records
INSERT INTO snippets (title, content, created, expires) VALUES (
       'first snippet',
       'this is the first snippet',
       UTC_TIMESTAMP(),
       DATE_ADD(UTC_TIMESTAMP(), INTERVAL 365 DAY)
);

INSERT INTO snippets (title, content, created, expires) VALUES (
       'second snippet'
       'this is the second snippet'
       UTC_TIMESTAMP(),
       DATE_ADD(UTC_TIMESTAMP(), INTERVAL 365 DAY)
);

INSERT INTO snippets (title, content, created, expires) VALUES (
       'third snippet'
       'this is the third snippet'
       UTC_TIMESTAMP(),
       DATE_ADD(UTC_TIMESTAMP(), INTERVAL 365 DAY)
);
