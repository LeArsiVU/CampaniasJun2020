#!/bin/bash
# se debe ejecutar con sudo, exporta tablas (grandes) a txt y luego las transforma a csv

mysqldump -u root -pPASSWORD -t  -T /var/lib/mysql-files campaniasJun2020 Clientes_Contado_abonar_terceros_activo --fields-terminated-by=';' --lines-terminated-by='\n'

mysqldump -u root -pPASSWORD -t  -T /var/lib/mysql-files campaniasJun2020 Clientes_Contado_abonar_terceros_sin_activar --fields-terminated-by=';' --lines-terminated-by='\n'

mysqldump -u root -pPASSWORD -t  -T /var/lib/mysql-files campaniasJun2020 digitales_cuenta_activa --fields-terminated-by=';' --lines-terminated-by='\n'

mysqldump -u root -pPASSWORD -t  -T /var/lib/mysql-files campaniasJun2020 digitales_cuenta_sin_activar --fields-terminated-by=';'  --lines-terminated-by='\n'

sudo mv /var/lib/mysql-files/digitales_cuenta_activa.txt .
sudo mv /var/lib/mysql-files/digitales_cuenta_sin_activar.txt .
sudo mv /var/lib/mysql-files/Clientes_Contado_abonar_terceros_activo.txt .
sudo mv /var/lib/mysql-files/Clientes_Contado_abonar_terceros_sin_activar.txt .

sudo chmod a+rwx *.txt

sed 's/ \+/,/g' digitales_cuenta_activa.txt > digitales_cuenta_activa_tem.csv
sed 's/ \+/,/g' digitales_cuenta_sin_activar.txt > digitales_cuenta_sin_activar_tem.csv
sed 's/ \+/,/g' Clientes_Contado_abonar_terceros_activo.txt > Clientes_Contado_abonar_terceros_activo_tem.csv
sed 's/ \+/,/g' Clientes_Contado_abonar_terceros_sin_activar.txt > Clientes_Contado_abonar_terceros_sin_activar_tem.csv

echo -e "idu_ClienteCodigo;des_CorreoElectronico"> header.csv

cat header.csv digitales_cuenta_activa_tem.csv > digitales_cuenta_activa.csv
cat header.csv digitales_cuenta_sin_activar_tem.csv > digitales_cuenta_sin_activar.csv
cat header.csv Clientes_Contado_abonar_terceros_activo_tem.csv > Clientes_Contado_abonar_terceros_activo.csv
cat header.csv Clientes_Contado_abonar_terceros_sin_activar_tem.csv > Clientes_Contado_abonar_terceros_sin_activar.csv

rm *_tem.csv
sudo chmod a+rwx *.csv

rm *.txt
