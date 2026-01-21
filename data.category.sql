-- To make debug and examples easier, the ID's reflect the graph structure
-- of categories: the number of digits represents the current node's depth
-- level, and the ID's prefix is the parent's ID.
-- For categories with multiple parents, this is only true for the main parent.


USE sales_xmp;

INSERT INTO category (id, name) VALUES
      (2,    'Electronics')

    , (21,   'Computers')
    , (211,  'Laptops')
    , (212,  'Gaming Computers')
    , (213,  'Peripherals')

    , (22,    'Audio & Video')
    , (221,   'TV')
    , (222,   'Wi-Fi')

    , (3,     'Office')

    , (31,    'Office Electronics')
    , (311,   'Printers')
    , (312,   'Scanners')
    , (313,   'Security Cameras')

    , (32,    'Office Furniture')
    , (321,   'Office Tables')
    , (322,   'Office Chairs')
;

INSERT INTO category_arc (to_category, from_category) VALUES
      (21,    2)
    , (211,   21)
    , (211,   31)
    , (212,   21)
    , (213,   21)

    , (22,    2)
    , (221,   22)
    , (222,   22)

    , (31,    3)
    , (311,   31)
    , (311,   213)
    , (312,   31)
    , (312,   213)
    , (313,   31)

    , (32,    3)
    , (321,   32)
    , (322,   32)
;


INSERT INTO product (main_category_id, sku, name, description, price, stock_quantity) VALUES
    -- category: 211 - Laptops
      (211,  'LT-UB-14-001',  'UltraBook Pro 14"',         'Lightweight business laptop with 16GB RAM and 512GB SSD',
      1299.99,   45)
    , (211,  'LT-GM-17-002',  'WorkStation Elite 17"',     'High-performance workstation laptop with dedicated graphics',
      2499.99,   22)
    , (211,  'LT-EC-13-003',  'EcoSlim 13"',               'Energy-efficient ultraportable with 12-hour battery life',
      899.99,    67)
    -- category: 212 - Gaming Computers
    , (212,  'GC-RX-001',     'Gaming Rig Extreme',        'RTX 4080, AMD Ryzen 9, 32GB RAM, RGB lighting',
      3299.99,   15)
    , (212,  'GC-VR-002',     'VR Gaming Station',         'VR-ready system with liquid cooling and 2TB NVMe storage',
      2799.99,   18)
    , (212,  'GC-ST-003',     'Starter Gaming PC',         'Entry-level gaming rig with GTX 1660 and 16GB RAM',
      1199.99,   34)
    -- category: 213 - Peripherals
    , (213,  'PR-KB-MX-001',  'Mechanical Keyboard Pro',   'Cherry MX switches, RGB backlighting, programmable macros',
      59.99,    120)
    , (213,  'PR-MS-WL-002',  'Wireless Precision Mouse',  'Ergonomic design with 16000 DPI sensor and 6 buttons',
      79.99,   200)
    , (213,  'PR-WC-4K-003',  '4K Webcam Ultra',           'Professional streaming webcam with dual microphones',
      249.99,   85)
    , (213,  'PR-HS-NC-004',  'Noise Cancelling Headset',  'Active noise cancellation with studio-quality sound',
      189.99,   95)
    , (213,  'PR-DK-USB-005', 'USB Docking Station',       '11-port hub with dual 4K display support and 100W charging',
      49.99,   55)
;

