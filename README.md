# Kev Nay - Sistema POS & Reportes Financieros Avanzados

Sistema de punto de venta (POS) con códigos de barras, inventario, clientes, reportes financieros, login con roles, pagos por PayPal y envío de reportes por correo electrónico.

## Características

- **Sistema de Login con Roles**
  - **Administrador** (`admin123`): control total del sistema — inventario, productos, clientes, reportes, configuración.
  - **Cajero** (`cajero123`): ventas y cierre de caja, sin acceso a configuración ni inventario.
  - Las contraseñas se pueden cambiar desde el panel de Configuración.

- **POS / Caja**
  - Búsqueda de productos por nombre o código de barras.
  - Carrito de ventas con descuentos e IVA configurable.
  - Cálculo de vuelto/cambio automático.
  - Pagos en efectivo, tarjeta y **PayPal**.

- **Inventario**
  - CRUD de productos con imagen, código de barras, costo y precio.
  - Generación automática de códigos de barras (JsBarcode).
  - Control de stock.
  - Impresión de etiquetas con código de barras (formato 50mm).

- **Clientes & Historial**
  - Registro de clientes con NIT, cédula, teléfono y dirección.
  - Historial de compras por cliente.
  - Reimpresión de tickets.

- **Reportes & Cierre de Caja**
  - Panel contable en tiempo real (ventas efectivo, tarjeta, PayPal).
  - Cálculo de utilidad bruta y margen.
  - Movimientos de caja (ingresos/gastos).
  - Exportación a CSV (Excel).
  - Cierre financiero con impresión de ticket 50mm.
  - **Envío de reportes por correo electrónico** (EmailJS).

- **Configuración (solo Admin)**
  - Cambio de contraseñas (admin y cajero).
  - Configuración de EmailJS (Service ID, Template ID, Public Key, email destino).
  - Configuración de PayPal (Client ID, modo Sandbox/Live).

## Tecnologías

- HTML5 + JavaScript (vanilla, un solo archivo)
- [Tailwind CSS](https://tailwindcss.com/) (CDN)
- [Supabase](https://supabase.com/) (base de datos)
- [JsBarcode](https://github.com/lindell/JsBarcode) (códigos de barras)
- [EmailJS](https://www.emailjs.com/) (envío de correos)
- [PayPal Smart Buttons](https://developer.paypal.com/) (pagos)
- [FontAwesome](https://fontawesome.com/) (iconos)

## Instalación

1. Descarga `kev_nay_pos_barcode.html`.
2. Ábrelo en tu navegador (Chrome, Firefox, Edge).
3. Inicia sesión:
   - **Admin**: usuario `Administrador`, contraseña `admin123`
   - **Cajero**: usuario `Cajero`, contraseña `cajero123`

No requiere servidor ni instalación local. Toda la configuración se guarda en `localStorage` del navegador.

## Configuración

### Base de datos (Supabase)

El sistema usa Supabase con las siguientes tablas:

- `products`: id, name, code, cost_price, price, stock, image_url
- `customers`: id, name, phone, cedula, nit, address
- `sales`: id, date, payment_method, customer_id, subtotal, discount, vat_amount, total, items_snapshot, paypal_order_id
- `cash_closings`: initial_cash, total_sales, cash_sales, card_sales, paypal_sales, expected_cash, actual_cash, difference

### Correo (EmailJS)

1. Regístrate en [emailjs.com](https://www.emailjs.com/).
2. **Email Services** → Add New Service → conecta tu proveedor (Gmail, Outlook, etc.) → copia el **Service ID**.
3. **Email Templates** → Create New Template. Usa estas variables en el cuerpo:
   - `{{to_email}}` — correo destino
   - `{{subject}}` — asunto
   - `{{message}}` — contenido del reporte
   - `{{total_ventas}}` — total facturado
   - `{{fecha}}` — fecha del reporte
   En el campo "To Email" del template pon `{{to_email}}`.
4. **Account** → General → copia tu **Public Key**.
5. En el POS: Configuración → pega Service ID, Template ID, Public Key y tu correo destino → Guardar.
6. Usa "Enviar Correo de Prueba" para verificar.

### PayPal

1. Ve a [developer.paypal.com](https://developer.paypal.com/) → **Applications** → Create App.
2. Nombra la app y selecciona **Sandbox** (pruebas) o **Live** (producción).
3. Copia el **Client ID**.
4. (Opcional) Crea cuentas sandbox de comprador en **Sandbox → Accounts** para probar.
5. En el POS: Configuración → pega el Client ID y selecciona el modo → Guardar.

## Uso

### Como Administrador
1. Inicia sesión como Admin.
2. Ve a **Inventario** para registrar productos.
3. Ve a **Configuración** para ajustar contraseñas, correo y PayPal.
4. Usa **Reportes & Cierre** para ver el panel contable y enviar reportes por correo.

### Como Cajero
1. Inicia sesión como Cajero.
2. Busca productos y agrégalos al carrito.
3. Cobra en efectivo, tarjeta o PayPal.
4. Al final del turno, usa **Reportes & Cierre** para hacer el cierre de caja.

## Licencia

Proyecto privado — Kev Nay Business Hub.
