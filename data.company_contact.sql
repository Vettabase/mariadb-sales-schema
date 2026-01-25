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
    (get_contact_type_uuid('email'), 'info@roma-innovazione.it');

-- Link contacts to companies
-- Store UUIDs in variables to avoid redundant subqueries

SET @email_contact_type := get_contact_type_uuid('email');
SET @phone_contact_type := get_contact_type_uuid('phone');
SET @fax_contact_type := get_contact_type_uuid('fax');

-- Get company UUIDs
SET @company_highland := (SELECT uuid FROM company WHERE customer_uuid = '62fdc7ca-e96c-11f0-a38a-560005d947e2');
SET @company_edinburgh := (SELECT uuid FROM company WHERE customer_uuid = '62fdc814-e96c-11f0-a38a-560005d947e2');
SET @company_glasgow := (SELECT uuid FROM company WHERE customer_uuid = '62fdc81c-e96c-11f0-a38a-560005d947e2');
SET @company_paris := (SELECT uuid FROM company WHERE customer_uuid = '62fdc824-e96c-11f0-a38a-560005d947e2');
SET @company_lyon := (SELECT uuid FROM company WHERE customer_uuid = '62fdc82a-e96c-11f0-a38a-560005d947e2');
SET @company_berlin := (SELECT uuid FROM company WHERE customer_uuid = '62fdc831-e96c-11f0-a38a-560005d947e2');
SET @company_munich := (SELECT uuid FROM company WHERE customer_uuid = '62fdc838-e96c-11f0-a38a-560005d947e2');
SET @company_hamburg := (SELECT uuid FROM company WHERE customer_uuid = '62fdc83f-e96c-11f0-a38a-560005d947e2');
SET @company_barcelona := (SELECT uuid FROM company WHERE customer_uuid = '62fdc847-e96c-11f0-a38a-560005d947e2');
SET @company_rome := (SELECT uuid FROM company WHERE customer_uuid = '62fdc84e-e96c-11f0-a38a-560005d947e2');

INSERT INTO company_contact (company_uuid, contact_uuid) VALUES
    /* Companies from Scotland */
    -- Highland Tech Solutions Ltd
    (@company_highland, (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'info@highlandtech.co.uk')),
    (@company_highland, (SELECT uuid FROM contact WHERE contact_type_uuid = @phone_contact_type AND contact_value = '+44 131 555 0101')),
    (@company_highland, (SELECT uuid FROM contact WHERE contact_type_uuid = @fax_contact_type AND contact_value = '+44 131 555 0102')),
    -- Edinburgh Digital Services Ltd
    (@company_edinburgh, (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'contact@edinburgh-digital.co.uk')),
    (@company_edinburgh, (SELECT uuid FROM contact WHERE contact_type_uuid = @phone_contact_type AND contact_value = '+44 131 555 0201')),
    (@company_edinburgh, (SELECT uuid FROM contact WHERE contact_type_uuid = @fax_contact_type AND contact_value = '+44 131 555 0202')),
    -- Glasgow Innovation Partners Ltd
    (@company_glasgow, (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'hello@glasgow-innovation.co.uk')),
    /* Companies from France */
    -- Société Parisienne de Technologie SARL
    (@company_paris, (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'contact@spt-paris.fr')),
    (@company_paris, (SELECT uuid FROM contact WHERE contact_type_uuid = @phone_contact_type AND contact_value = '+33 1 55 55 01 01')),
    -- Lyon Consulting SA
    (@company_lyon, (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'info@lyon-consulting.fr')),
    /* Companies from Germany */
    -- Berliner Technologie GmbH
    (@company_berlin, (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'kontakt@berliner-tech.de')),
    (@company_berlin, (SELECT uuid FROM contact WHERE contact_type_uuid = @phone_contact_type AND contact_value = '+49 30 5555 0101')),
    -- München Software AG
    (@company_munich, (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'info@muenchen-software.de')),
    (@company_munich, (SELECT uuid FROM contact WHERE contact_type_uuid = @phone_contact_type AND contact_value = '+49 89 5555 0201')),
    -- Hamburg Digital Systems GmbH
    (@company_hamburg, (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'service@hamburg-digital.de')),
    /* Companies from Spain */
    -- Soluciones Tecnológicas Barcelona SL
    (@company_barcelona, (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'info@soluciones-barcelona.es')),
    (@company_barcelona, (SELECT uuid FROM contact WHERE contact_type_uuid = @phone_contact_type AND contact_value = '+34 93 555 0101')),
    /* Companies from Italy */
    -- Roma Innovazione SRL
    (@company_rome, (SELECT uuid FROM contact WHERE contact_type_uuid = @email_contact_type AND contact_value = 'info@roma-innovazione.it'));
