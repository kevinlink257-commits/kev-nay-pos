# Kev Nay - Sistema POS & Reportes Financieros Avanzados

Sistema de punto de venta (POS) 

## Características

- **Sistema de Login con Roles**
  - **Administrador** : control total del sistema — inventario, productos, clientes, reportes, configuración.
  - **Cajero** : ventas y cierre de caja, sin acceso a configuración ni inventario.
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
