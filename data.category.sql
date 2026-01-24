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
    , (321,   'Office Desks')
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


/*
    SKU Format Documentation
    ========================

    SKUs follow a structured format to ensure consistency and readability:

    Format: [CATEGORY]-[CATEGORY-SPECIFIC]

    Category Prefix (3 characters):
    - LPT: Laptops (category 211)
    - GMC: Gaming Computers (category 212)
    - PER: Peripherals (category 213)
    - TVS: TV (category 221)
    - WFI: Wi-Fi (category 222)
    - PRT: Printers (category 311)
    - SCN: Scanners (category 312)
    - CAM: Security Cameras (category 313)

    Category-Specific Parts:

    1. Laptops (211): LPT-[FORM]-[SIZE]-[SPEC]
       - FORM: Form factor (UB=UltraBook, WS=WorkStation, ES=EcoSlim)
       - SIZE: Screen size in inches (13, 14, 15, 17)
       - SPEC: Key specification (I5=Intel i5, I7=Intel i7, R9=Ryzen 9)
       Example: LPT-UB-14-I5

    2. Gaming Computers (212): GMC-[TIER]-[GPU]-[CPU]
       - TIER: Performance tier (ST=Starter, PR=Pro, EX=Extreme)
       - GPU: Graphics card series (1660, 4070, 4080)
       - CPU: Processor series (R5=Ryzen 5, R7=Ryzen 7, R9=Ryzen 9)
       Example: GMC-EX-4080-R9

    3. Peripherals (213): PER-[TYPE]-[FEATURE]-[TIER]
       - TYPE: Device type (KB=Keyboard, MS=Mouse, WC=Webcam, HS=Headset, DK=Dock)
       - FEATURE: Main feature (MX=Mechanical, WL=Wireless, 4K, NC=Noise Cancelling)
       - TIER: Quality tier (ST=Standard, PR=Pro, UL=Ultra)
       Example: PER-KB-MX-PR

    4. TV (221): TVS-[SIZE]-[TECH]-[RES]
       - SIZE: Screen size in inches (32, 43, 55, 65, 75)
       - TECH: Display technology (LE=LED, QL=QLED, OL=OLED)
       - RES: Resolution (HD, FH=Full HD, 4K, 8K)
       Example: TVS-55-QL-4K

    5. Wi-Fi (222): WFI-[TYPE]-[SPEED]-[BAND]
       - TYPE: Device type (RT=Router, EX=Extender, ME=Mesh)
       - SPEED: WiFi speed class (AC12=AC1200, AX6=AX6000, AX11=AX11000)
       - BAND: Band support (SG=Single, DL=Dual, TR=Tri-band)
       Example: WFI-RT-AX6-DL

    6. Printers (311): PRT-[TYPE]-[TECH]-[TIER]
       - TYPE: Printer type (LS=Laser, IK=Inkjet, MF=Multifunction)
       - TECH: Technology/feature (CL=Color, BW=Black&White, 3D)
       - TIER: Performance tier (HM=Home, OF=Office, EN=Enterprise)
       Example: PRT-LS-CL-OF

    7. Scanners (312): SCN-[TYPE]-[RES]-[FEAT]
       - TYPE: Scanner type (FL=Flatbed, SH=Sheet-fed, PT=Portable)
       - RES: Resolution class (HD=High Def, UH=Ultra High, PR=Pro)
       - FEAT: Feature set (BS=Basic, AD=Advanced, NW=Network)
       Example: SCN-FL-UH-AD

    8. Security Cameras (313): CAM-[TYPE]-[RES]-[FEAT]
       - TYPE: Camera type (DM=Dome, BL=Bullet, PT=PTZ)
       - RES: Resolution (HD=720p, FH=1080p, 4K, 8K)
       - FEAT: Features (IR=Infrared, WF=WiFi, PT=Pan-Tilt)
       Example: CAM-DM-4K-IR

    Validation:
    - Laptops: ^LPT-[A-Z]{2}-[0-9]{2}-[A-Z0-9]{2,3}$
    - Gaming: ^GMC-[A-Z]{2}-[0-9]{4}-[A-Z0-9]{2,3}$
    - Peripherals: ^PER-[A-Z]{2}-[A-Z0-9]{2,3}-[A-Z]{2}$
    - TV: ^TVS-[0-9]{2}-[A-Z]{2}-[A-Z0-9]{2,3}$
    - Wi-Fi: ^WFI-[A-Z]{2}-[A-Z0-9]{2,4}-[A-Z]{2}$
    - Printers: ^PRT-[A-Z]{2}-[A-Z0-9]{2}-[A-Z]{2}$
    - Scanners: ^SCN-[A-Z]{2}-[A-Z]{2}-[A-Z]{2}$
    - Security Cameras: ^CAM-[A-Z]{2}-[A-Z0-9]{2}-[A-Z]{2}$

    Design rationale:
    - Category prefix enables immediate product classification
    - Each component conveys meaningful product information
    - Category-specific patterns reflect what matters for each product type
    - Human-readable codes enable quick product identification without database lookup
    - Prevents SKU collisions through distinct category patterns
*/

INSERT INTO sku_format (category_id, category_code, format, `regexp`) VALUES
      (211,  'LPT',  'LPT-[FORM]-[SIZE]-[SPEC]',     '^LPT-[A-Z]{2}-[0-9]{2}-[A-Z0-9]{2,3}$')
    , (212,  'GMC',  'GMC-[TIER]-[GPU]-[CPU]',       '^GMC-[A-Z]{2}-[0-9]{4}-[A-Z0-9]{2,3}$')
    , (213,  'PER',  'PER-[TYPE]-[FEATURE]-[TIER]',  '^PER-[A-Z]{2}-[A-Z0-9]{2,3}-[A-Z]{2}$')
    , (221,  'TVS',  'TVS-[SIZE]-[TECH]-[RES]',      '^TVS-[0-9]{2}-[A-Z]{2}-[A-Z0-9]{2,3}$')
    , (222,  'WFI',  'WFI-[TYPE]-[SPEED]-[BAND]',    '^WFI-[A-Z]{2}-[A-Z0-9]{2,4}-[A-Z]{2}$')
    , (311,  'PRT',  'PRT-[TYPE]-[TECH]-[TIER]',     '^PRT-[A-Z]{2}-[A-Z0-9]{2}-[A-Z]{2}$')
    , (312,  'SCN',  'SCN-[TYPE]-[RES]-[FEAT]',      '^SCN-[A-Z]{2}-[A-Z]{2}-[A-Z]{2}$')
    , (313,  'CAM',  'CAM-[TYPE]-[RES]-[FEAT]',      '^CAM-[A-Z]{2}-[A-Z0-9]{2}-[A-Z]{2}$')
;

INSERT INTO product (main_category_id, sku, name, description, price, stock_quantity) VALUES
    -- category: 211 - Laptops
      (211,  'LPT-UB-14-I5',    'UltraBook Pro 14"',         'Lightweight business laptop with 16GB RAM and 512GB SSD',
      1299.99,   45)
    , (211,  'LPT-WS-17-I7',    'WorkStation Elite 17"',     'High-performance workstation laptop with dedicated graphics',
      2499.99,   22)
    , (211,  'LPT-ES-13-I5',    'EcoSlim 13"',               'Energy-efficient ultraportable with 12-hour battery life',
      899.99,    67)
    -- category: 212 - Gaming Computers
    , (212,  'GMC-EX-4080-R9',  'Gaming Rig Extreme',        'RTX 4080, AMD Ryzen 9, 32GB RAM, RGB lighting',
      3299.99,   15)
    , (212,  'GMC-PR-4070-R7',  'VR Gaming Station',         'VR-ready system with liquid cooling and 2TB NVMe storage',
      2799.99,   18)
    , (212,  'GMC-ST-1660-R5',  'Starter Gaming PC',         'Entry-level gaming rig with GTX 1660 and 16GB RAM',
      1199.99,   34)
    -- category: 213 - Peripherals
    , (213,  'PER-KB-MX-PR',    'Mechanical Keyboard Pro',   'Cherry MX switches, RGB backlighting, programmable macros',
      59.99,    120)
    , (213,  'PER-MS-WL-PR',    'Wireless Precision Mouse',  'Ergonomic design with 16000 DPI sensor and 6 buttons',
      79.99,   200)
    , (213,  'PER-WC-4K-UL',    '4K Webcam Ultra',           'Professional streaming webcam with dual microphones',
      249.99,   85)
    , (213,  'PER-HS-NC-PR',    'Noise Cancelling Headset',  'Active noise cancellation with studio-quality sound',
      189.99,   95)
    , (213,  'PER-DK-USB-PR',   'USB Docking Station',       '11-port hub with dual 4K display support and 100W charging',
      49.99,   55)
    -- category: 221 - TV
    , (221,  'TVS-55-QL-4K',    'QLED 4K Smart TV 55"',      '55-inch QLED display with 4K resolution and smart features',
      1499.99,   28)
    , (221,  'TVS-65-OL-4K',    'OLED 4K Premium TV 65"',    '65-inch OLED panel with perfect blacks and HDR10+ support',
      2799.99,   12)
    -- category: 222 - Wi-Fi
    , (222,  'WFI-RT-AX6-DL',   'WiFi 6 Router Dual-Band',   'AX6000 dual-band router with MU-MIMO and 8 antennas',
      299.99,   42)
    , (222,  'WFI-ME-AX11-TR',  'WiFi 6E Mesh System',       'AX11000 tri-band mesh system with 3-pack coverage',
      799.99,   18)
    -- category: 311 - Printers
    , (311,  'PRT-LS-CL-OF',    'Color Laser Printer',       'Professional color laser printer with duplex and 40ppm',
      599.99,   32)
    , (311,  'PRT-MF-CL-EN',    'Enterprise Multifunction',  'All-in-one color laser with print, scan, copy, fax',
      1299.99,   15)
    -- category: 312 - Scanners
    , (312,  'SCN-FL-UH-AD',    'Ultra High-Res Flatbed',    'A3 flatbed scanner with 4800 DPI and OCR software',
      449.99,   24)
    , (312,  'SCN-SH-PR-NW',    'Professional Sheet Scanner','High-speed network scanner with 80ppm and auto-feed',
      899.99,   18)
;

-- Add secondary category relationships
INSERT INTO product_category
    (category_id, product_uuid)
    VALUES
    -- Enterprise Multifunction printer is also a scanner
    (312, get_product_uuid_by_sku('PRT-MF-CL-EN'))
;

