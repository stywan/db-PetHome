--Ejemplo aplicado: buscar una cita pendiente para un cliente.
DECLARE
    v_fecha DATE;
BEGIN
    SELECT fecha_hora
    INTO v_fecha
    FROM cita
    WHERE mascota_id = 10 --EM ESTE CASO ESTA MASCOTA NO ESTA EN ESTADO PENDIENTE -CON ID 20 SI TIENE LA CITA PENDIENTE
        AND estado = 'PENDIENTE';

    DBMS_OUTPUT.PUT_LINE('La próxima cita pendiente es: ' || v_fecha);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron citas pendientes para esta mascota.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Existen múltiples citas pendientes, revise la agenda.');
END;