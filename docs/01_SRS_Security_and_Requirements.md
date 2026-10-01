# Especificación de Requisitos y Seguridad (SRS)

## 1. Requerimientos Funcionales (Core Business)
* **RF-01 (Build Check):** El sistema cruzará los datos técnicos (Socket, Tipo de RAM) en el backend al agregar ítems al carrito. Si hay incompatibilidad, se bloqueará el checkout.
* **RF-02 (Cálculo de Energía):** El sistema sumará el consumo en Watts de todos los componentes y exigirá una fuente de poder (PSU) que supere ese consumo.
* **RF-03 (Billetera Virtual):** Todo usuario nuevo recibe un saldo virtual en la base de datos para simular compras durante la evaluación técnica.

## 2. Requerimientos de Seguridad Crítica
* **SEC-01 (Protección de Credenciales):** Prohibido guardar contraseñas en texto plano. Uso obligatorio de hash criptográfico.
* **SEC-02 (Defensa contra Inyecciones):** Todas las consultas a la base de datos usarán ORM o consultas parametrizadas.
* **SEC-03 (Transacciones Atómicas):** El descuento de saldo virtual y la resta de inventario se ejecutarán en una misma transacción SQL (Commit/Rollback).