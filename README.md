# CampaniasJun2020
Scrips de SQL para cargar y crear las tablas de los correos de los clientes.

Tablas a crear:

1- Clientes de crédito digitales_cuenta activa
- Todas las puntualidades menos Z
- Únicamente con cuenta activa 
- Con cuenta de crédito activa (saldo pendiente)
-Tomar el ultimo correo con el que abono cliente o que tiene registrado (esto debido a que en bases anteriores encontramos clientes con más de 100 correos)

2. Clientes de crédito digitales_cuenta sin activar
- Todas las puntualidades menos Z
- Cuenta sin activar
-Con cuenta de crédito activo (saldo pendiente)
- Tomar el ultimo correo con el que abono cliente o que tiene registrado

3. Clientes_Contado_abonar_terceros_activo  (abonos a terceros)
- Con cuenta activada
- Que la Fecha de captura de correo de 2017 en adelante


4. Clientes_Contado_abonar_terceros_sin_activar  (abonos a terceros)
- Con cuenta sin activar
- Que la Fecha de captura de correo de 2017 en adelante
