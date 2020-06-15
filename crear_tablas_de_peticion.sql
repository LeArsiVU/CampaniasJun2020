CREATE TABLE digitales_cuenta_activa_tem AS 
select idu_ClienteCodigoMaestro as idu_ClienteCodigo, des_CorreoElectronico, fec_FechaAltaCorreo
FROM mae_correosdatamart as t1
JOIN Rs_CategoriasEdoResultado_Rova as t2 ON
t1.idu_ClienteCodigoMaestro = t2.clientecodigo and 
t2.Segmento IN ('Activo Sin Vencido','Vencido1','Vencido2','Vencido3','Vencido +4')
where LOCATE("Z",idu_PuntualidadCodigo)=0 and
flag_registroactivo = 1 and
idu_ClienteCodigoMaestro <> 90001 and 
idu_ClienteCodigoMaestro  NOT BETWEEN 90000000 and 99999999;

CREATE TABLE digitales_cuenta_activa AS (select t1.idu_ClienteCodigo, t1.des_CorreoElectronico
 FROM digitales_cuenta_activa_tem as t1
 JOIN  digitales_cuenta_activa_tem
 on t1.idu_ClienteCodigo=digitales_cuenta_activa_tem.idu_ClienteCodigo and 
 t1.fec_FechaAltaCorreo=(select max(fec_FechaAltaCorreo) from digitales_cuenta_activa_tem  where t1.idu_ClienteCodigo=digitales_cuenta_activa_tem.idu_ClienteCodigo)
 group by t1.idu_ClienteCodigo, t1.des_CorreoElectronico);
 
DROP TABLE digitales_cuenta_activa_tem;


CREATE TABLE digitales_cuenta_sin_activar_tem AS 
select idu_ClienteCodigoMaestro  as idu_ClienteCodigo, des_CorreoElectronico, fec_FechaAltaCorreo
FROM mae_correosdatamart as t1
JOIN Rs_CategoriasEdoResultado_Rova as t2 ON
t1.idu_ClienteCodigoMaestro = t2.clientecodigo and 
t2.Segmento IN ('Activo Sin Vencido','Vencido1','Vencido2','Vencido3','Vencido +4')
where LOCATE("Z",idu_PuntualidadCodigo)=0 and
flag_registroactivo <> 1 and
idu_ClienteCodigoMaestro <> 90001 and 
idu_ClienteCodigoMaestro  NOT BETWEEN 90000000 and 99999999;

CREATE TABLE digitales_cuenta_sin_activar AS (select t1.idu_ClienteCodigo, t1.des_CorreoElectronico
 FROM digitales_cuenta_sin_activar_tem as t1
 JOIN  digitales_cuenta_sin_activar_tem
 on t1.idu_ClienteCodigo=digitales_cuenta_sin_activar_tem.idu_ClienteCodigo and 
 t1.fec_FechaAltaCorreo=(select max(fec_FechaAltaCorreo) from digitales_cuenta_sin_activar_tem  where t1.idu_ClienteCodigo=digitales_cuenta_sin_activar_tem.idu_ClienteCodigo)
 group by t1.idu_ClienteCodigo, t1.des_CorreoElectronico);
 
 DROP TABLE digitales_cuenta_sin_activar_tem;


create  TABLE Clientes_Contado_abonar_terceros_activo AS
select idu_ClienteCodigoMaestro  as idu_ClienteCodigo, des_CorreoElectronico, fec_FechaAltaCorreo
FROM mae_correosdatamart 
where LOCATE("Z",idu_PuntualidadCodigo)=0 and
flag_registroactivo = 1 and
idu_ClienteCodigoMaestro = 90001 and 
YEAR(fec_FechaAltaCorreo)>=2017;

create  TABLE Clientes_Contado_abonar_terceros_sin_activar AS
select idu_ClienteCodigoMaestro  as idu_ClienteCodigo, des_CorreoElectronico, fec_FechaAltaCorreo
FROM mae_correosdatamart 
where LOCATE("Z",idu_PuntualidadCodigo)=0 and
flag_registroactivo <> 1 and
idu_ClienteCodigoMaestro = 90001 and 
YEAR(fec_FechaAltaCorreo)>=2017;
