-- ============================================================
-- KEV NAY POS - Esquema de Base de Datos (Supabase / PostgreSQL)
-- ============================================================
-- Este script elimina las tablas existentes y crea las nuevas
-- con el esquema actualizado (incluye columnas de PayPal).
-- 
-- ADVERTENCIA: Ejecutar este script borrará todos los datos
-- existentes en las tablas. Úselo solo en instalación inicial
-- o cuando necesite reiniciar la base de datos.
-- ============================================================

-- Eliminar tablas existentes (en orden inverso por dependencias)
DROP TABLE IF EXISTS cash_closings CASCADE;
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;

-- ============================================================
-- Tabla: products
-- ============================================================
CREATE TABLE products (
    id BIGINT PRIMARY KEY,
    name TEXT NOT NULL,
    code TEXT,
    cost_price NUMERIC DEFAULT 0,
    price NUMERIC NOT NULL DEFAULT 0,
    stock INTEGER NOT NULL DEFAULT 0,
    image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- Tabla: customers
-- ============================================================
CREATE TABLE customers (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL,
    phone TEXT,
    cedula TEXT,
    nit TEXT,
    address TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- Tabla: sales
-- ============================================================
CREATE TABLE sales (
    id BIGINT PRIMARY KEY,
    date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    payment_method TEXT NOT NULL DEFAULT 'cash',
    customer_id BIGINT REFERENCES customers(id) ON DELETE SET NULL,
    subtotal NUMERIC DEFAULT 0,
    discount NUMERIC DEFAULT 0,
    vat_amount NUMERIC DEFAULT 0,
    total NUMERIC NOT NULL DEFAULT 0,
    items_snapshot JSONB,
    paypal_order_id TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- Tabla: cash_closings
-- ============================================================
CREATE TABLE cash_closings (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    initial_cash NUMERIC DEFAULT 0,
    total_sales NUMERIC DEFAULT 0,
    cash_sales NUMERIC DEFAULT 0,
    card_sales NUMERIC DEFAULT 0,
    paypal_sales NUMERIC DEFAULT 0,
    expected_cash NUMERIC DEFAULT 0,
    actual_cash NUMERIC DEFAULT 0,
    difference NUMERIC DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- Habilitar Row Level Security (RLS)
-- ============================================================
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE sales ENABLE ROW LEVEL SECURITY;
ALTER TABLE cash_closings ENABLE ROW LEVEL SECURITY;

-- Políticas: permitir acceso completo con la anon key
-- (Ajusta estas políticas según tus necesidades de seguridad)

CREATE POLICY "Public access products" ON products FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public access customers" ON customers FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public access sales" ON sales FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public access cash_closings" ON cash_closings FOR ALL USING (true) WITH CHECK (true);

-- ============================================================
-- Índices
-- ============================================================
CREATE INDEX idx_products_code ON products(code);
CREATE INDEX idx_products_name ON products(name);
CREATE INDEX idx_sales_date ON sales(date DESC);
CREATE INDEX idx_sales_customer_id ON sales(customer_id);
CREATE INDEX idx_sales_payment_method ON sales(payment_method);

-- ============================================================
-- Datos de ejemplo (productos iniciales)
-- ============================================================
INSERT INTO products (id, name, code, cost_price, price, stock, image_url) VALUES
(1001, 'Producto Demo 1', '770123456', 5000, 8000, 50, ''),
(1002, 'Producto Demo 2', '770789012', 3000, 5500, 30, ''),
(1003, 'Producto Demo 3', '770345678', 12000, 18000, 15, '');

-- ============================================================
-- Verificación
-- ============================================================
SELECT 'products' as tabla, COUNT(*) as registros FROM products
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'sales', COUNT(*) FROM sales
UNION ALL
SELECT 'cash_closings', COUNT(*) FROM cash_closings;
