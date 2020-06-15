drop table if exists mae_correosdatamart;

create table mae_correosdatamart(
idu_CorreoElectronicoCodigo varchar(30),
idu_ClienteCodigoMaestro varchar(30),
des_CorreoElectronico varchar(100),
flag_registro varchar(5),
flag_registroactivo varchar(5),
des_Estatus varchar(30),
fec_FechaAltaCorreo DATE,
fec_FechaRegistro DATETIME,
idu_PuntualidadCodigo varchar(30)
);

LOAD DATA INFILE '/var/lib/mysql-files/mae_correosdatamart.csv'
into table mae_correosdatamart
CHARACTER SET utf8
FIELDS TERMINATED BY '|'
enclosed by '"'
LINES terminated by '\n'
IGNORE 1 ROWS;

drop table if exists Rs_CategoriasEdoResultado_Rova;

-- Tabla para conocer los clientes con saldo pendiente cuando Segmento IN ('Activo Sin Vencido','Vencido1','Vencido2','Vencido3','Vencido +4')
create table Rs_CategoriasEdoResultado_Rova( 
clientecodigo varchar(30) primary key,
Segmento varchar(30),
FechaCorte DATE
);

LOAD DATA INFILE '/var/lib/mysql-files/Rs_CategoriasEdoResultado_Rova.csv'
into table Rs_CategoriasEdoResultado_Rova
CHARACTER SET utf8
FIELDS TERMINATED BY '|'
enclosed by '"'
LINES terminated by '\n'
IGNORE 1 ROWS;
