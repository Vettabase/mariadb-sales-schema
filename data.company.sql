--  SPDX-License-Identifier: AGPL-3.0-only
--  Copyright (C) 2025 Vettabase info@vettabase.com

USE sales_xmp;

-- Companies from Scotland
INSERT INTO company
    (customer_uuid, company_name, tax_id, registration_number)
    VALUES
    ('62fdc7ca-e96c-11f0-a38a-560005d947e2', 'Highland Tech Solutions Ltd', 'GB123456789', 'SC123456'),
    ('62fdc814-e96c-11f0-a38a-560005d947e2', 'Edinburgh Digital Services Ltd', 'GB234567890', 'SC234567'),
    ('62fdc81c-e96c-11f0-a38a-560005d947e2', 'Glasgow Innovation Partners Ltd', 'GB345678901', 'SC345678')
;

-- Companies from France
INSERT INTO company
    (customer_uuid, company_name, tax_id, registration_number)
    VALUES
    ('62fdc824-e96c-11f0-a38a-560005d947e2', 'Société Parisienne de Technologie SARL', 'FR12345678901', '123 456 789 RCS Paris'),
    ('62fdc82a-e96c-11f0-a38a-560005d947e2', 'Lyon Consulting SA', 'FR23456789012', '234 567 890 RCS Lyon')
;

-- Companies from Germany
INSERT INTO company
    (customer_uuid, company_name, tax_id, registration_number)
    VALUES
    ('62fdc831-e96c-11f0-a38a-560005d947e2', 'Berliner Technologie GmbH', 'DE123456789', 'HRB 12345'),
    ('62fdc838-e96c-11f0-a38a-560005d947e2', 'München Software AG', 'DE234567890', 'HRB 23456'),
    ('62fdc83f-e96c-11f0-a38a-560005d947e2', 'Hamburg Digital Systems GmbH', 'DE345678901', 'HRB 34567')
;

-- Companies from Spain
INSERT INTO company
    (customer_uuid, company_name, tax_id, registration_number)
    VALUES
    ('62fdc847-e96c-11f0-a38a-560005d947e2', 'Soluciones Tecnológicas Barcelona SL', 'ESB12345678', 'B-12345678')
;

-- Companies from Italy
INSERT INTO company
    (customer_uuid, company_name, tax_id, registration_number)
    VALUES
    ('62fdc84e-e96c-11f0-a38a-560005d947e2', 'Roma Innovazione SRL', 'IT12345678901', 'RM-123456')
;
