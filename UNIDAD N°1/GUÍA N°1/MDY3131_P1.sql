/*GUÍA N°1

CASO N°1 */

/* SENTENCIA

SELECT nombre_emp ||' '||appaterno_emp || ' '|| apmaterno_emp,
       numrut_emp ||' '|| dvrut_emp,
       sueldo_emp
FROM empleado;
SENTENCIA */

--INICIO BLOQUE ANÓNIMO
VAR b_rut NUMBER
EXEC :b_rut:=&RUT;
VAR b_dvrut VARCHAR2
EXEC :b_dvrut:='&dv_rut';
VAR b_bonif NUMBER
EXEC :b_bonif:=&bonif;

--INICIO DEL DECLARE:
DECLARE

v_nombre EMPLEADO.nombre_emp%TYPE;
v_appaterno EMPLEADO.appaterno_emp%TYPE;
v_apmaterno EMPLEADO.apmaterno_emp%TYPE;
v_sueldo EMPLEADO.sueldo_emp%TYPE;
v_total_bono NUMBER(9);

BEGIN
    SELECT nombre_emp,appaterno_emp, apmaterno_emp,
       sueldo_emp
INTO v_nombre,
     v_appaterno,
     v_apmaterno,
     v_sueldo
FROM empleado
WHERE numrut_emp = :b_rut
      AND dvrut_emp=:b_dvrut;
      
--CÁLCULO BONIFICACIÓN:
v_total_bono := (v_sueldo*:b_bonif)/100;
DBMS_OUTPUT.PUT_LINE('DATOS CALCULO BONIFICACION EXTRA DEL '||:b_bonif||'% DEL SUELDO');
DBMS_OUTPUT.PUT_LINE('Nombre Empleado: '||v_nombre||' '||v_appaterno||' '||v_apmaterno);
DBMS_OUTPUT.PUT_LINE('RUN: '||:b_rut||'-'||:b_dvrut);
DBMS_OUTPUT.PUT_LINE('Sueldo: '||v_sueldo);
DBMS_OUTPUT.PUT_LINE('Bonificación: '||v_total_bono);
END;

/* CASO N°2 || 

SENTENCIA: 

SELECT nombre_cli||' '||appaterno_cli||' ' ||apmaterno_cli AS "Nombre Completo Cliente",
       numrut_cli||' '||dvrut_cli AS "RUN CLIENTE",
       ec.id_estcivil,
       ec.desc_estcivil,
       cli.renta_cli
FROM cliente cli JOIN
     estado_civil ec ON (cli.id_estcivil=ec.id_estcivil)
*/


--DECLARACIÓN E INICICIACIÓN VARIABLES
VAR b_rut NUMBER
EXEC :b_rut:=&RUT;
VAR b_dvrut VARCHAR2
EXEC :b_dvrut:='&dv_rut';
VAR b_renta_minima NUMBER
EXEC :b_renta_minima:=&RENTA_MINIMA;

--INICIO DECLARE:

DECLARE
v_nombre    CLIENTE.nombre_cli%TYPE;
v_appaterno CLIENTE.appaterno_cli%TYPE;
v_apmaterno CLIENTE.apmaterno_cli%TYPE;
v_id_est_civil ESTADO_CIVIL.id_estcivil%TYPE;
v_est_civil ESTADI_CIVIL.desc_estcivil%TYPE;
v_renta_cli CLIENTE.renta_cli%TYPE;

BEGIN
    SELECT nombre_cli, appaterno_cli,apmaterno_cli,
       numrut_cli, dvrut_cli,
       ec.id_estcivil,
       ec.desc_estcivil,
       cli.renta_cli
    INTO v_nombre,
         v_appaterno,
         v_apmaterno,
         v_id_est_civil,
         v_est_civil,
         v_renta_cli
FROM cliente cli JOIN
     estado_civil ec ON (cli.id_estcivil=ec.id_estcivil)
WHERE numrut_cli=:b_rut AND
      dvrut_cli=:b_dvrut;
CASE WHEN v_id_est_civil=3 AND v_renta_cli < :b_renta_min OR v_id_est_civil=4 AND v_renta_cli < :b_renta_min THEN
          DBMS_OUTPUT.PUT_LINE('Cliente no cumple requisitos');
    ELSE
        DBMS_OUTPUT.PUT_LINE('DATOS DEL CLIENTE');
        DBMS_OUTPUT.PUT_LINE('-----------------');
        DBMS_OUTPUT.PUT_LINE('Nombre: '||v_nombre||' '||v_appaterno||' '||v_apmaterno);
        DBMS_OUTPUT.PUT_LINE('RUN: '||:b_rut||'-'||:b_dvrut);
        DBMS_OUTPUT.PUT_LINE('Estado civil: '||v_est_civil);
        DBMS_OUTPUT.PUT_LINE('Renta: '||TO_CHAR(v_renta_cli,'$999G999G999G999'));
END CASE;
END;

/* CASO N°3 */