CREATE TABLE digitales_cuenta_activa_tem AS -- En esta tabla van a estar todos los correos que ha dado de alta el cliente
select idu_ClienteCodigoMaestro as idu_ClienteCodigo, des_CorreoElectronico, fec_FechaAltaCorreo
FROM mae_correosdatamart as t1
JOIN Rs_CategoriasEdoResultado_Rova as t2 ON
CAST(FLOOR(t1.idu_ClienteCodigoMaestro/10) as SIGNED)= t2.clientecodigo and 
t2.Segmento IN ('Activo Sin Vencido','Vencido1','Vencido2','Vencido3','Vencido +4')
where LOCATE("Z",idu_PuntualidadCodigo)=0 and -- Excluye la puntualidad Z
flag_registroactivo = 1 and -- Cuenta activada
idu_ClienteCodigoMaestro <> 90001 and -- Excluye clientes de contado
idu_ClienteCodigoMaestro  NOT BETWEEN 90000000 and 99999999; -- Excluye empleados

CREATE TABLE digitales_cuenta_activa AS -- En esta tabla ya está sólo el correo que se ha dado de alta más recientemente
(select t1.idu_ClienteCodigo, t1.des_CorreoElectronico
 FROM digitales_cuenta_activa_tem as t1
 JOIN  digitales_cuenta_activa_tem
 on t1.idu_ClienteCodigo=digitales_cuenta_activa_tem.idu_ClienteCodigo and 
 t1.fec_FechaAltaCorreo=(select max(fec_FechaAltaCorreo) from digitales_cuenta_activa_tem  where t1.idu_ClienteCodigo=digitales_cuenta_activa_tem.idu_ClienteCodigo)
 group by t1.idu_ClienteCodigo, t1.des_CorreoElectronico);
 
DROP table digitales_cuenta_activa_tem;


CREATE TABLE digitales_cuenta_sin_activar_tem AS -- En esta tabla van a estar todos los correos que ha dado de alta el cliente
select idu_ClienteCodigoMaestro  as idu_ClienteCodigo, des_CorreoElectronico, fec_FechaAltaCorreo
FROM mae_correosdatamart as t1
JOIN Rs_CategoriasEdoResultado_Rova as t2 ON
CAST(FLOOR(t1.idu_ClienteCodigoMaestro/10) as SIGNED)= t2.clientecodigo and 
t2.Segmento IN ('Activo Sin Vencido','Vencido1','Vencido2','Vencido3','Vencido +4')
where LOCATE("Z",idu_PuntualidadCodigo)=0 and -- Excluye la puntualidad Z
flag_registroactivo <> 1 and -- Cuenta sin activar
idu_ClienteCodigoMaestro <> 90001 and -- Excluye clientes de contado
idu_ClienteCodigoMaestro  NOT BETWEEN 90000000 and 99999999; -- Excluye empleados

CREATE TABLE digitales_cuenta_sin_activar AS -- En esta tabla ya está sólo el correo que se ha dado de alta más recientemente
(select t1.idu_ClienteCodigo, t1.des_CorreoElectronico
 FROM digitales_cuenta_sin_activar_tem as t1
 JOIN  digitales_cuenta_sin_activar_tem
 on t1.idu_ClienteCodigo=digitales_cuenta_sin_activar_tem.idu_ClienteCodigo and 
 t1.fec_FechaAltaCorreo=(select max(fec_FechaAltaCorreo) from digitales_cuenta_sin_activar_tem  where t1.idu_ClienteCodigo=digitales_cuenta_sin_activar_tem.idu_ClienteCodigo)
 group by t1.idu_ClienteCodigo, t1.des_CorreoElectronico);
 
 DROP table digitales_cuenta_sin_activar_tem;

create  TABLE Clientes_Contado_abonar_terceros_activo AS
select idu_ClienteCodigoMaestro  as idu_ClienteCodigo, des_CorreoElectronico
FROM mae_correosdatamart 
where flag_registroactivo = 1 and -- Cuenta activada
idu_ClienteCodigoMaestro = 90001 and -- Cliente de contado
YEAR(fec_FechaAltaCorreo)>=2017; -- Fecha de captura del correo de 2017 en adelante

create  TABLE Clientes_Contado_abonar_terceros_sin_activar AS
select idu_ClienteCodigoMaestro  as idu_ClienteCodigo, des_CorreoElectronico
FROM mae_correosdatamart 
where flag_registroactivo <> 1 and -- Cuenta sin activar
idu_ClienteCodigoMaestro = 90001 and -- Cliente de contado
YEAR(fec_FechaAltaCorreo)>=2017; -- Fecha de captura del correo de 2017 en adelante
