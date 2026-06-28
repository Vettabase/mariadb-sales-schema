--  SPDX-License-Identifier: AGPL-3.0-only
--  Copyright (C) 2025 Vettabase info@vettabase.com


--  MariaDB Sales Schema
--  ====================
--
--  This is a MariaDB schema for tests and examples,
--  maintained by Vettabase (vettabase.com).
--  Have fun with it and please contribute.


SET sql_mode := CONCAT(@@session.sql_mode, ',NO_ZERO_DATE,NO_ZERO_IN_DATE');
SET SESSION sql_mode := REPLACE(@@session.sql_mode, ',NO_ZERO_DATE', '');
SET SESSION sql_mode := REPLACE(@@session.sql_mode, ',NO_ZERO_IN_DATE', '');


DROP SCHEMA sales_xmp;
CREATE SCHEMA sales_xmp
    DEFAULT CHARACTER SET = utf8mb4
    DEFAULT COLLATE = utf8mb4_uca1400_ai_ci
    COMMENT = 'Hypothetical online store. To be used for tests and examples.'
;
USE sales_xmp;


CREATE TABLE salutation (
    id SMALLINT UNSIGNED AUTO_INCREMENT,
    salutation VARCHAR(20) NOT NULL
        CHECK (CHAR_LENGTH(salutation) > 1),
    is_active BOOL NOT NULL DEFAULT TRUE
        COMMENT 'Inactive salutations are only used for existing persons'
        CHECK (is_active IN (FALSE, TRUE)),
    PRIMARY KEY (id),
    UNIQUE unq_salutation (salutation)
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'Salutation titles, to be used in communications'
;

INSERT INTO salutation (salutation) VALUES
    ('Mr'),
    ('Ms'),
    ('Mrs'),
    ('Mx'),
    ('Dr'),
    ('Prof')
;

CREATE TABLE customer (
    uuid UUID DEFAULT UUID_v7(),
    email VARCHAR(255) NOT NULL
        CHECK (email LIKE '%_@%_.%__'),
    username VARCHAR(255) NOT NULL
        DEFAULT CONCAT('@', SUBSTRING_INDEX(email, '@', 1), '_', SUBSTRING_INDEX(email, '@', 2))
        COMMENT 'usernames must have only 1 @ as their first character',
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (uuid),
    UNIQUE unq_email_username (email, username)
        COMMENT 'Multiple users from the same email are ok, but they must use different usernames. Usernames don''t need be unique.'
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'Any person or company that engaged with a sale process'
;

CREATE TABLE person (
    uuid UUID DEFAULT UUID_v7(),
    customer_uuid UUID NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    salutation_id SMALLINT UNSIGNED NULL,
    salutation_custom VARCHAR(20) NULL,
    date_of_birth DATE NOT NULL DEFAULT '0000-00-00',
    CONSTRAINT chk_salutation CHECK (salutation_id IS NULL XOR salutation_custom IS NULL),
    PRIMARY KEY (uuid),
    UNIQUE unq_customer_uuid (customer_uuid),
    FOREIGN KEY (customer_uuid) REFERENCES customer(uuid) ON DELETE CASCADE ON UPDATE RESTRICT,
    FOREIGN KEY (salutation_id) REFERENCES salutation (id) ON DELETE RESTRICT ON UPDATE RESTRICT
)
    WITH SYSTEM VERSIONING
    ENGINE=InnoDB
    COMMENT 'Any person who is relevant to our business'
;

CREATE TABLE company (
    uuid UUID DEFAULT UUID_v7(),
    customer_uuid UUID NOT NULL,
    company_name VARCHAR(255) NOT NULL,
    tax_id VARCHAR(50),
    registration_number VARCHAR(50) NOT NULL
        CHECK (registration_number > ''),
    PRIMARY KEY (uuid),
    UNIQUE unq_customer_uuid (customer_uuid),
    FOREIGN KEY (customer_uuid) REFERENCES customer(uuid) ON DELETE CASCADE ON UPDATE RESTRICT
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'A company who is also a customer'
;

CREATE TABLE contact_type (
    uuid UUID DEFAULT UUID_v7(),
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (uuid),
    UNIQUE unq_name (name)
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'Supported contact types, like emails or phone numbers'
;

INSERT INTO contact_type (name) VALUES
    ('email'),
    ('mobile'),
    ('sms'),
    ('phone'),
    ('fax'),
    ('linkedin'),
    ('whatsapp'),
    ('telepathy')
;

CREATE TABLE contact (
    uuid UUID DEFAULT UUID_v7(),
    contact_type_uuid UUID NOT NULL,
    contact_value VARCHAR(255) NOT NULL,
    PRIMARY KEY (uuid),
    FOREIGN KEY (contact_type_uuid) REFERENCES contact_type(uuid) ON DELETE CASCADE ON UPDATE RESTRICT,
    INDEX idx_contact_type_uuid (contact_type_uuid)
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'A contact other than the primary email, like a phone number or a messenger id'
;

CREATE TABLE person_contact (
    uuid UUID DEFAULT UUID_v7(),
    person_uuid UUID NOT NULL,
    contact_uuid UUID NOT NULL,
    PRIMARY KEY (uuid),
    UNIQUE unq_person_uuid_contact_uuid (person_uuid, contact_uuid),
    FOREIGN KEY (person_uuid) REFERENCES person(uuid) ON DELETE CASCADE ON UPDATE RESTRICT,
    FOREIGN KEY (contact_uuid) REFERENCES contact(uuid) ON DELETE CASCADE ON UPDATE RESTRICT
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'Link between a person and a contact'
;

CREATE TABLE company_contact (
    uuid UUID DEFAULT UUID_v7(),
    company_uuid UUID NOT NULL,
    contact_uuid UUID NOT NULL,
    PRIMARY KEY (uuid),
    UNIQUE unq_company_uuid_contact_uuid (company_uuid, contact_uuid),
    FOREIGN KEY (company_uuid) REFERENCES company(uuid) ON DELETE CASCADE ON UPDATE RESTRICT,
    FOREIGN KEY (contact_uuid) REFERENCES contact(uuid) ON DELETE CASCADE ON UPDATE RESTRICT
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'Link between a company and a contact'
;

CREATE TABLE category (
    id INT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
        CHECK (name > ''),
    PRIMARY KEY (id),
    UNIQUE unq_name (name)
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'Product category'
;

CREATE TABLE category_arc (
    id INT UNSIGNED AUTO_INCREMENT,
    from_category INT UNSIGNED NOT NULL,
    to_category INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    UNIQUE unq_from_category_to_category (from_category, to_category),
    FOREIGN KEY (from_category)
        REFERENCES category (id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT,
    FOREIGN KEY (to_category)
        REFERENCES category (id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'An arc in the graph representing categories hierarchies'
;

CREATE TABLE sku_format (
    id INT UNSIGNED AUTO_INCREMENT,
    category_id INT UNSIGNED NOT NULL,
    category_code CHAR(3) NOT NULL
        COLLATE ascii_bin
        CHECK (category_code REGEXP '^[A-Z0-9]{3}$'),
    format VARCHAR(100) NOT NULL
        COLLATE ascii_bin
        COMMENT 'Human-readable SKU pattern with placeholders in square brackets',
    `regexp` VARCHAR(255) NOT NULL
        COLLATE ascii_bin
        COMMENT 'Regular expression to validate SKUs for this category',
    PRIMARY KEY (id),
    UNIQUE unq_category_id (category_id),
    UNIQUE unq_category_code (category_code),
    UNIQUE unq_format (format),
    UNIQUE unq_regexp (`regexp`),
    FOREIGN KEY (category_id)
        REFERENCES category (id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'SKU format rules for each product category'
;

CREATE TABLE product (
    uuid UUID DEFAULT UUID_v7(),
    main_category_id INT UNSIGNED NOT NULL
        COMMENT 'A product can belong to more categories, but must have one main category',
    sku VARCHAR(50) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    is_in_stock BOOL AS (stock_quantity > 0) VIRTUAL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (uuid),
    UNIQUE unq_sku (sku),
    FOREIGN KEY (main_category_id)
        REFERENCES category (id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'A product that we sell'
;

CREATE TABLE product_category (
    id INT UNSIGNED AUTO_INCREMENT,
    category_id INT UNSIGNED NOT NULL,
    product_uuid UUID NOT NULL,
    PRIMARY KEY (id),
    UNIQUE unq_category_id_product_uuid (category_id, product_uuid),
    FOREIGN KEY (category_id)
        REFERENCES category (id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT,
    FOREIGN KEY (product_uuid)
        REFERENCES product (uuid)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'Relationship between product and category'
;

CREATE TABLE sales_order_status (
    uuid UUID DEFAULT UUID_v7(),
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    PRIMARY KEY (uuid),
    UNIQUE unq_name (name)
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'Status code for orders'
;

CREATE TABLE sales_order (
    uuid UUID DEFAULT UUID_v7(),
    customer_uuid UUID NOT NULL,
    order_status_uuid UUID NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (uuid),
    FOREIGN KEY (customer_uuid) REFERENCES customer (uuid) ON DELETE CASCADE ON UPDATE RESTRICT,
    FOREIGN KEY (order_status_uuid) REFERENCES sales_order_status (uuid) ON DELETE CASCADE ON UPDATE RESTRICT,
    INDEX idx_customer_uuid (customer_uuid),
    INDEX idx_order_status_uuid (order_status_uuid),
    INDEX idx_created_at (created_at)
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'An order made by a customer'
;

CREATE TABLE order_line (
    uuid UUID DEFAULT UUID_v7(),
    order_uuid UUID NOT NULL,
    product_uuid UUID NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    line_total DECIMAL(10, 2) AS (quantity * unit_price) STORED,
    PRIMARY KEY (uuid),
    UNIQUE unq_order_uuid_product_uuid (order_uuid, product_uuid),
    FOREIGN KEY (order_uuid) REFERENCES sales_order (uuid) ON DELETE CASCADE ON UPDATE RESTRICT,
    FOREIGN KEY (product_uuid) REFERENCES product (uuid) ON DELETE CASCADE ON UPDATE RESTRICT,
    INDEX idx_order_uuid (order_uuid)
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'An entry in an order: product + quantity'
;


DELIMITER ||

CREATE OR REPLACE FUNCTION get_contact_type_uuid(i_name TEXT)
    RETURNS UUID
    NOT DETERMINISTIC
    READS SQL DATA
    COMMENT
'Returns UUID of the specified contact_type.
Example: SELECT get_contact_type_uuid(''email'');'
BEGIN
    DECLARE ret UUID DEFAULT NULL;
    DECLARE error_message VARCHAR(100) DEFAULT NULL;
    SET ret := (
        SELECT uuid
            FROM contact_type
            WHERE name = i_name
    );
    IF ret IS NULL THEN
        SET error_message := CONCAT('Contact type not found: ', QUOTE(i_name));
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = error_message;
    END IF;
    RETURN ret;
END;

CREATE OR REPLACE FUNCTION get_product_uuid_by_sku(i_sku VARCHAR(50))
    RETURNS UUID
    NOT DETERMINISTIC
    READS SQL DATA
    COMMENT
'Returns UUID of the specified product by SKU.
Example: SELECT get_product_uuid_by_sku(''LPT-UB-14-I5'');'
BEGIN
    DECLARE ret UUID DEFAULT NULL;
    DECLARE error_message VARCHAR(100) DEFAULT NULL;
    IF i_sku IS NULL THEN
        RETURN NULL;
    END IF;
    SET ret := (
        SELECT uuid
            FROM product
            WHERE sku = i_sku
    );
    IF ret IS NULL THEN
        SET error_message := CONCAT('Product not found: ', QUOTE(i_sku));
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = error_message;
    END IF;
    RETURN ret;
END;

/*
Tests:
SELECT @uuid := get_product_uuid_by_sku('PRT-MF-CL-EN');
DELETE FROM product_category;
CALL insert_secondary_product_category_rel(312, 'PRT-MF-CL-EN');
DELETE FROM product_category;
CALL insert_secondary_product_category_rel(312, 'PRT-MF-CL-EN', @uuid);
DELETE FROM product_category;
CALL insert_secondary_product_category_rel(312, NULL, @uuid);
*/
CREATE OR REPLACE PROCEDURE insert_secondary_product_category_rel(
    IN i_category_id INT UNSIGNED,
    IN i_product_sku VARCHAR(50),
    IN i_product_uuid VARCHAR(50) DEFAULT NULL
)
    MODIFIES SQL DATA
    COMMENT
'Insert a secondary product category relationship.
The product''s id is found based on i_product_sku.
Examples:
    CALL insert_secondary_product_category_rel(312, ''PRT-MF-CL-EN'');
    CALL insert_secondary_product_category_rel(312, ''PRT-MF-CL-EN'', ''019beff4-5162-7558-9080-fdabde69dac2'');'
BEGIN
    -- If i_product_uuid is NULL, find it based on i_product_sku.
    -- If not possible because i_product_sku is NULL, emit an error.
    DECLARE v_product_uuid VARCHAR(50) DEFAULT i_product_uuid;
    IF i_product_uuid IS NULL THEN
        IF i_product_sku IS NULL THEN
            SIGNAL SQLSTATE '02000'
                SET MESSAGE_TEXT = 'You need to specify at least i_product_sku or i_product_uuid'
            ;
        ELSE
            SET v_product_uuid := get_product_uuid_by_sku(i_product_sku);
        END IF;
    END IF;

    -- Insert into product_category and return the inserted row
    INSERT INTO product_category (category_id, product_uuid)
        VALUES (i_category_id, v_product_uuid)
        RETURNING category_id, product_uuid
    ;

    -- i_product_sku is only useful to find the product's SKU.
    -- If both are specified, emit a warning.
    -- We must do it here, ot the INSERT would reset the diagnostic area.
    IF i_product_uuid IS NOT NULL AND i_product_sku IS NOT NULL THEN
        SIGNAL SQLSTATE '01000'
            SET MESSAGE_TEXT = 'Both product_sku and product_uuid were specified, so product_sku was ignored'
        ;
    END IF;
END;

CREATE OR REPLACE FUNCTION moo()
    RETURNS TEXT
    DETERMINISTIC
    READS SQL DATA
    COMMENT 'Implementation of apt-get''s Moo algorithm in pure SQL"'
BEGIN
    RETURN '
                 (__)
                 (oo)
           /------\/
          / |    ||
         *  /\---/\
            ~~   ~~
..."Have you mooed today?"...
';
END;

||
DELIMITER ;

