USE sales_xmp;

INSERT INTO customer
    (uuid, email, created_at, password_hash)
    VALUES
    ('62fdc7ca-e96c-11f0-a38a-560005d947e2', 'adam.rivera@northbridge-solutions.com',    '2020-01-17', 'e23bff44c99391fbba12e302b0e505d94be28d42bd1799a66aeb200ba8f71467'),
    ('62fdc814-e96c-11f0-a38a-560005d947e2', 'n.williams@auroraindustries.co',           '2020-03-04', 'c61a50eec16bd0eb87213247d1aa2fe6409bb7626c71f8f5fab1ba0553e17119'),
    ('62fdc81c-e96c-11f0-a38a-560005d947e2', 'maria.chen@clarion-ventures.io',           '2020-06-21', 'b664197d96bac632eb241708d3f2303f6a0872be3d6cabea193a2f6915338cc7'),
    ('62fdc824-e96c-11f0-a38a-560005d947e2', 'l.martinez@oakridgepartners.net',          '2020-10-09', '312112fee6c7062c9b4df4b62d2e06a3af8e9ef4372d4dd17fa81de384929a42'),
    ('62fdc82a-e96c-11f0-a38a-560005d947e2', 'sofia.khan@bluehaven-logistics.com',       '2021-01-15', 'cb39681aa4a3001b4c17ec3e8fd5a9775d12df9698af8364c6444af9e7dac29f'),
    ('62fdc831-e96c-11f0-a38a-560005d947e2', 'd.nguyen@sterlingfabrication.co',          '2021-03-27', '95680f30daed5becc5ed9fe7f3dc0af0923d29901a05feea07b06d037134b3f1'),
    ('62fdc838-e96c-11f0-a38a-560005d947e2', 'peter.schmidt@helios-analytics.io',        '2021-05-30', '80c3b922411889aae08f2fb69cc7cb201453dabb20fd2c5869d8b7bf534cb996'),
    ('62fdc83f-e96c-11f0-a38a-560005d947e2', 'a.morales@granite-holdings.net',           '2021-08-12', '9cc48d264df5ad66dcdd3149ac54578f53732ea6719edbbf0ec53870c942a9e4'),
    ('62fdc847-e96c-11f0-a38a-560005d947e2', 'elena.rossi@orion-systems.co',             '2021-10-28', '0f85e83f5ccc4907228e1f59b408e22144c4aa800e7cc198fd492e78663853ec'),
    ('62fdc84e-e96c-11f0-a38a-560005d947e2', 't.johnson@coppertrail-energy.com',         '2021-12-19', '65103efdfe37aa50777c7f89dca0d1430f5510edca7628971f6448f1967fd85b'),
    ('62fdc855-e96c-11f0-a38a-560005d947e2', 'lucas.moreau@mariner-consulting.io',       '2022-02-03', 'e0f5b6b20dfc3948d0dc52b5ee2e0e3a8e2a92f5e60130d2c347366ea435c88a'),
    ('62fdc85c-e96c-11f0-a38a-560005d947e2', 'c.garcia@silverline-retail.co',            '2022-03-18', '6bc50ffbe22c9ff1d6c892be92ed272943c1c25d65a4961fc3e965038055cfaf'),
    ('62fdc863-e96c-11f0-a38a-560005d947e2', 'isabella.ferraro@horizonfoundry.net',      '2022-05-07', '41c23dce193ae9394e4ab358f5626dee5efb4098fd89fc58df67bba73696c999'),
    ('62fdc86a-e96c-11f0-a38a-560005d947e2', 'm.dubois@terraforge-manufacturing.com',    '2022-06-25', '258be1aff303d23cdd8e7f5971754215950f661fa7f838a456de476f3eb404ce'),
    ('62fdc871-e96c-11f0-a38a-560005d947e2', 'olga.ivanova@polarcrest-labs.io',          '2022-08-14', '0c566e0b704d3255cf28878233fe3a5f183514b1f3a8486be9f0fddb881d9251'),
    ('62fdc878-e96c-11f0-a38a-560005d947e2', 'r.patel@ridgefield-capital.co',            '2022-09-30', 'bf4e8d94ee049d0d7f925f521ac2d12207933095c4c7e14c5c24649aed0bf888'),
    ('62fdc87e-e96c-11f0-a38a-560005d947e2', 'daniel.sato@suncrest-instruments.net',     '2022-10-22', 'f46400ff70e799a3981729f45e9f5389a6448006f37fae33b9e49c7721545695'),
    ('62fdc885-e96c-11f0-a38a-560005d947e2', 'k.brown@evergreen-supply.co',              '2022-11-11', 'c2a13ced75b593095d27548e91a98e13792bc329ec93be410ded8c3700e63a91'),
    ('62fdc88b-e96c-11f0-a38a-560005d947e2', 'julia.kowalski@novapath-biotech.com',      '2022-12-05', '645a389fa0c1166db0344ae67c223021c8289385d75690c41f638fba08d8083d'),
    ('62fdc892-e96c-11f0-a38a-560005d947e2', 's.lewis@ironpeak-engineering.io',          '2022-12-20', '259b63e0063f091920c81885197ca1f16d009bc41e9916bb5409c966de9748d2')
;

INSERT INTO company
    (customer_uuid, company_name, tax_id, registration_number)
    VALUES
    -- Companies from Scotland
    ('62fdc7ca-e96c-11f0-a38a-560005d947e2', 'Highland Tech Solutions Ltd', 'GB123456789', 'SC123456'),
    ('62fdc814-e96c-11f0-a38a-560005d947e2', 'Edinburgh Digital Services Ltd', 'GB234567890', 'SC234567'),
    ('62fdc81c-e96c-11f0-a38a-560005d947e2', 'Glasgow Innovation Partners Ltd', 'GB345678901', 'SC345678'),
    -- Companies from France
    ('62fdc824-e96c-11f0-a38a-560005d947e2', 'Société Parisienne de Technologie SARL', 'FR12345678901', '123 456 789 RCS Paris'),
    ('62fdc82a-e96c-11f0-a38a-560005d947e2', 'Lyon Consulting SA', 'FR23456789012', '234 567 890 RCS Lyon'),
    -- Companies from Germany
    ('62fdc831-e96c-11f0-a38a-560005d947e2', 'Berliner Technologie GmbH', 'DE123456789', 'HRB 12345'),
    ('62fdc838-e96c-11f0-a38a-560005d947e2', 'München Software AG', 'DE234567890', 'HRB 23456'),
    ('62fdc83f-e96c-11f0-a38a-560005d947e2', 'Hamburg Digital Systems GmbH', 'DE345678901', 'HRB 34567'),
    -- Companies from Spain
    ('62fdc847-e96c-11f0-a38a-560005d947e2', 'Soluciones Tecnológicas Barcelona SL', 'ESB12345678', 'B-12345678'),
    -- Companies from Italy
    ('62fdc84e-e96c-11f0-a38a-560005d947e2', 'Roma Innovazione SRL', 'IT12345678901', 'RM-123456')
;
