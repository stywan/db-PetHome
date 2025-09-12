--Ejemplo aplicado: validar que una mascota no tenga más de 3 citas pendientes.

DECLARE
    e_demasiadas_citas EXCEPTION; -- Definición
    v_total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM cita
    WHERE mascota_id = 20 --EM ESTE CASO LA MASCOTA SOLO TIENE 1 CITA PENDIENTE
        AND estado = 'PENDIENTE';

    IF v_total > 3 THEN
        RAISE e_demasiadas_citas;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Mascota con citas pendientes dentro del límite permitido.');

EXCEPTION
    WHEN e_demasiadas_citas THEN
        DBMS_OUTPUT.PUT_LINE('Error: La mascota tiene más de 3 citas pendientes. Contactar al administrador.');
END;
