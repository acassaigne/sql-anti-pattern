CREATE TABLE account
(
    id       int PRIMARY KEY,
    identity text,
    email    text
);

SELECT *
FROM account;

SELECT REPLACE(identity, 'Antho', 'Anthony')
FROM account;

-- pas simple pour l'update
UPDATE account
SET identity = REPLACE(identity, 'Antho', 'Anthony')
WHERE id = 1;



UPDATE account
SET identity = REPLACE(identity, 'antho', 'Anth')
WHERE id = 3;

INSERT INTO account(id, identity, email)
VALUES (1, 'Antho, Cassaigne', 'antho@foo.foo');
INSERT INTO account(id, identity, email)
VALUES (2, 'Jean, Palies', 'jean@foo.foo');
INSERT INTO account(id, identity, email)
VALUES (3, 'anthony, hhhanthokkkk', 'hhh@foo.foo');
INSERT INTO account(id, identity, email)
VALUES (4, 'Chris, Anthonish', 'hhh@foo.foo');



-- how many Jean I have?
-- we are writing a parser! Again ! => we creating a structure,
-- schema we are not in schemaless technology (NoSQL)

SELECT STRPOS('hello, foo', ',');

SELECT SUBSTRING(identity, 0, STRPOS(identity, ',')) AS firstname, COUNT(*)
FROM account
GROUP BY firstname;


-- idea 2: with like '%Jean%'
SELECT COUNT(*)
FROM account
WHERE LOWER(identity) LIKE '%antho%';


-- it's the hell!!!

-- con
-- the intention it's really not clear


-- fix: 1NF
CREATE TABLE account_fix
(
    id       int PRIMARY KEY,
    identity text,
    email    text
);


-- le rendu semble complexe

CREATE TABLE template_email
(
    id       numeric,
    template text,
    email    text
);

INSERT INTO template_email(id, template, email)
VALUES (1, 'template_1', 'foo@foo.com');
INSERT INTO template_email(id, template, email)
VALUES (2, 'template_1', 'bar@foo.com');

INSERT INTO template_email(id, template, email)
VALUES (3, 'template_1', 'bar@foo.com, foo@foo.com');

SELECT *
FROM template_email
WHERE id = 3;

SELECT *
FROM template_email
WHERE id IN (1, 2);

CREATE TABLE template_email_fix
(
    id_template numeric,
    template    text
);

CREATE TABLE receiver_fix
(
    id_receiver numeric,
    id_template numeric,
    email       TEXT
);

INSERT INTO template_email_fix(id_template, template)
VALUES (1, 'template_1');

INSERT INTO receiver_fix(id_template, id_receiver, email)
VALUES (1, 1, 'foo@foo.com');

INSERT INTO receiver_fix(id_template, id_receiver, email)
VALUES (1, 2, 'bar@foo.com');


SELECT *
FROM receiver_fix;

SELECT te.template, rf.email
FROM template_email_fix te
         INNER JOIN receiver_fix rf ON te.id_template = rf.id_template;

SELECT te.template, rf.email
FROM template_email_fix te
         NATURAL JOIN receiver_fix rf;


SELECT te.id_template, te.template, rf.email
FROM template_email_fix te
         INNER JOIN receiver_fix rf ON te.id_template = rf.id_template;


SELECT te.id_template, te.template, STRING_AGG(rf.email, ', ')
FROM template_email_fix te
         INNER JOIN receiver_fix rf ON te.id_template = rf.id_template
GROUP BY te.id_template, te.template;


-- pro
-- transaction update body template => lock
-- concurrent update available, we can update email in the same time template
-- better auditability latest_update column for each table
-- create unique index on  id_template,  email


