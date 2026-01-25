USE sales_xmp;

-- Insert contacts for companies with a single INSERT statement
-- Each company gets an email contact
-- Some companies optionally get phone contacts
-- Maximum 2 companies with fax contacts (only if they have phone)

INSERT INTO contact
    (contact_type_uuid, contact_value)
    VALUES
    /* Companies from Scotland */
    (get_contact_type_uuid('email'), 'info@highlandtech.co.uk'),
    (get_contact_type_uuid('phone'), '+44 131 555 0101'),
    (get_contact_type_uuid('fax'), '+44 131 555 0102'),
    (get_contact_type_uuid('email'), 'contact@edinburgh-digital.co.uk'),
    (get_contact_type_uuid('phone'), '+44 131 555 0201'),
    (get_contact_type_uuid('fax'), '+44 131 555 0202'),
    (get_contact_type_uuid('email'), 'hello@glasgow-innovation.co.uk'),
    /* Companies from France */
    (get_contact_type_uuid('email'), 'contact@spt-paris.fr'),
    (get_contact_type_uuid('phone'), '+33 1 55 55 01 01'),
    (get_contact_type_uuid('email'), 'info@lyon-consulting.fr'),
    /* Companies from Germany */
    (get_contact_type_uuid('email'), 'kontakt@berliner-tech.de'),
    (get_contact_type_uuid('phone'), '+49 30 5555 0101'),
    (get_contact_type_uuid('email'), 'info@muenchen-software.de'),
    (get_contact_type_uuid('phone'), '+49 89 5555 0201'),
    (get_contact_type_uuid('email'), 'service@hamburg-digital.de'),
    /* Companies from Spain */
    (get_contact_type_uuid('email'), 'info@soluciones-barcelona.es'),
    (get_contact_type_uuid('phone'), '+34 93 555 0101'),
    /* Companies from Italy */
    (get_contact_type_uuid('email'), 'info@roma-innovazione.it')
;

-- Link contacts to companies
-- We need to get the UUIDs that were just inserted
-- Since contacts don't have a unique identifier we can query on,
-- we'll use variables to store the generated UUIDs

SET @email_contact_type := get_contact_type_uuid('email');
SET @phone_contact_type := get_contact_type_uuid('phone');
SET @fax_contact_type := get_contact_type_uuid('fax');

INSERT INTO company_contact (company_uuid, contact_uuid) VALUES
    /* Companies from Scotland */
    -- Highland Tech Solutions Ltd
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc7ca-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'info@highlandtech.co.uk')),
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc7ca-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @phone_contact_type AND contact_value = '+44 131 555 0101')),
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc7ca-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @fax_contact_type AND contact_value = '+44 131 555 0102')),
    -- Edinburgh Digital Services Ltd
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc814-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'contact@edinburgh-digital.co.uk')),
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc814-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @phone_contact_type AND contact_value = '+44 131 555 0201')),
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc814-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @fax_contact_type AND contact_value = '+44 131 555 0202')),
    -- Glasgow Innovation Partners Ltd
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc81c-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'hello@glasgow-innovation.co.uk')),
    /* Companies from France */
    -- Société Parisienne de Technologie SARL
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc824-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'contact@spt-paris.fr')),
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc824-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @phone_contact_type AND contact_value = '+33 1 55 55 01 01')),
    -- Lyon Consulting SA
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc82a-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'info@lyon-consulting.fr')),
    /* Companies from Germany */
    -- Berliner Technologie GmbH
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc831-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'kontakt@berliner-tech.de')),
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc831-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @phone_contact_type AND contact_value = '+49 30 5555 0101')),
    -- München Software AG
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc838-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'info@muenchen-software.de')),
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc838-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @phone_contact_type AND contact_value = '+49 89 5555 0201')),
    -- Hamburg Digital Systems GmbH
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc83f-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'service@hamburg-digital.de')),
    /* Companies from Spain */
    -- Soluciones Tecnológicas Barcelona SL
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc847-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'info@soluciones-barcelona.es')),
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc847-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @phone_contact_type AND contact_value = '+34 93 555 0101')),
    /* Companies from Italy */
    -- Roma Innovazione SRL
    ((SELECT uuid FROM company WHERE customer_uuid = '62fdc84e-e96c-11f0-a38a-560005d947e2'), (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'info@roma-innovazione.it'))
;
