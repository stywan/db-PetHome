
DECLARE
    -- Cursor principal: todas las citas de un veterinario en una fecha
    CURSOR cur_citas(p_vet_id NUMBER, p_fecha DATE) IS
        SELECT c.id, c.fecha_hora, m.nombre AS mascota
        FROM cita c
        JOIN mascota m ON c.mascota_id = m.id
        WHERE c.veterinario_id = p_vet_id
        AND TRUNC(c.fecha_hora) = p_fecha;

    -- Cursor secundario: servicios asociados a una cita
    CURSOR cur_servicios(p_cita_id NUMBER) IS
        SELECT s.nombre, s.precio_base
        FROM cita_servicio cs
        JOIN veterinario_servicio vs ON cs.veterinario_servicio_id = vs.id
        JOIN servicio s ON vs.servicio_id = s.id
        WHERE cs.cita_id = p_cita_id;

BEGIN
    FOR cita_rec IN cur_citas(20, TO_DATE('2024-09-16', 'YYYY-MM-DD')) LOOP --SE PARA LA FECHA PARA VERIFICAR TODAS LAS CITAS DE ESA FECHA
        DBMS_OUTPUT.PUT_LINE('Cita ID: ' || cita_rec.id ||
                            ' Mascota: ' || cita_rec.mascota ||
                            ' Fecha: ' || cita_rec.fecha_hora);

        -- Loop anidado: recorrer los servicios de cada cita
        FOR serv_rec IN cur_servicios(cita_rec.id) LOOP
            DBMS_OUTPUT.PUT_LINE('   Servicio: ' || serv_rec.nombre ||
                                ' Precio: ' || serv_rec.precio_base);
        END LOOP;
    END LOOP;
END;
