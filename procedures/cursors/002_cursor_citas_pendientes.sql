DECLARE
    CURSOR cur_citas_pendientes(p_cliente_id NUMBER) IS
        SELECT c.id AS cita_id,
            c.fecha_hora,
            m.nombre AS mascota,
            v.id AS vet_id,
            p.nombres || ' ' || p.apellidos AS veterinario
    FROM cita c
    JOIN mascota m ON c.mascota_id = m.id
    JOIN veterinario v ON c.veterinario_id = v.id
    JOIN persona p ON v.persona_id = p.id
    WHERE m.dueno_id = p_cliente_id
        AND c.estado = 'PENDIENTE';

BEGIN
    FOR cita_rec IN cur_citas_pendientes(30) LOOP -- Cliente con ID=20
        DBMS_OUTPUT.PUT_LINE('Cita ID: ' || cita_rec.cita_id ||
                            ' Mascota: ' || cita_rec.mascota ||
                            ' Fecha: ' || cita_rec.fecha_hora ||
                            ' Veterinario: ' || cita_rec.veterinario);
    END LOOP;
END;