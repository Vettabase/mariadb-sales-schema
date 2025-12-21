--  SPDX-License-Identifier: AGPL-3.0-only
--  Copyright (C) 2025 Vettabase info@vettabase.com


--  MariaDB Sales Schema
--  ====================
--
--  This is a MariaDB schema for tests and examples,
--  maintained by Vettabase (vettabase.com).
--  Have fun with it and please contribute.


DROP SCHEMA sales_xmp;
CREATE SCHEMA sales_xmp
    DEFAULT CHARACTER SET = utf8mb4
    DEFAULT COLLATE = utf8mb4_uca1400_ai_ci
    COMMENT = 'Hypothetical online store. To be used for tests and examples.'
;
USE sales_xmp;


CREATE TABLE customer (
    uuid UUID DEFAULT UUID_v7(),
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (uuid),
    UNIQUE unq_email (email)
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'Any person or company that engaged with a sale process'
;

CREATE TABLE person (
    uuid UUID DEFAULT UUID_v7(),
    customer_uuid UUID NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    PRIMARY KEY (uuid),
    UNIQUE unq_customer_uuid (customer_uuid),
    FOREIGN KEY (customer_uuid) REFERENCES customer(uuid) ON DELETE CASCADE ON UPDATE RESTRICT
)
    WITH SYSTEM VERSIONING
    ENGINE=InnoDB
    COMMENT 'A person who is also a customer'
;

CREATE TABLE company (
    uuid UUID DEFAULT UUID_v7(),
    customer_uuid UUID NOT NULL,
    company_name VARCHAR(255) NOT NULL,
    tax_id VARCHAR(50),
    registration_number VARCHAR(50),
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

CREATE TABLE product (
    uuid UUID DEFAULT UUID_v7(),
    sku VARCHAR(50) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (uuid),
    UNIQUE unq_sku (sku)
)
    WITH SYSTEM VERSIONING
    ENGINE InnoDB
    COMMENT 'A product that we sell'
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
    line_total DECIMAL(10, 2) NOT NULL,
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
