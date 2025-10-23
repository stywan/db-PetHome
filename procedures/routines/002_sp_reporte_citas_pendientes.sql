-- PROCEDIMIENTO SIN PARÁMETROS
-- Genera un reporte general de todas las citas pendientes
-- del sistema

CREATE OR REPLACE PROCEDURE sp_reporte_citas_pendientes_general
IS
    v_total_citas NUMBER := 0;

    CURSOR cur_citas_pendientes IS
        SELECT
            c.id AS cita_id,
            c.fecha_hora,
            m.nombre AS mascota,
            e.nombre AS especie,
            p_dueno.nombres || ' ' || p_dueno.apellidos AS dueno,
            p_vet.nombres || ' ' || p_vet.apellidos AS veterinario,
            v.nro_licencia
        FROM cita c
        JOIN mascota m ON c.mascota_id = m.id
        JOIN especie e ON m.especie_id = e.id
        JOIN usuario u ON m.dueno_id = u.id
        JOIN persona p_dueno ON u.persona_id = p_dueno.id
        JOIN veterinario v ON c.veterinario_id = v.id
        JOIN persona p_vet ON v.persona_id = p_vet.id
        WHERE c.estado = 'PENDIENTE'
        ORDER BY c.fecha_hora;

BEGIN
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('   REPORTE GENERAL DE CITAS PENDIENTES');
    DBMS_OUTPUT.PUT_LINE('   Generado: ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('');

    FOR cita_rec IN cur_citas_pendientes LOOP
        v_total_citas := v_total_citas + 1;

        DBMS_OUTPUT.PUT_LINE('Cita #' || cita_rec.cita_id);
        DBMS_OUTPUT.PUT_LINE('  Fecha/Hora: ' || TO_CHAR(cita_rec.fecha_hora, 'DD/MM/YYYY HH24:MI'));
        DBMS_OUTPUT.PUT_LINE('  Mascota: ' || cita_rec.mascota || ' (' || cita_rec.especie || ')');
        DBMS_OUTPUT.PUT_LINE('  Dueño: ' || cita_rec.dueno);
        DBMS_OUTPUT.PUT_LINE('  Veterinario: ' || cita_rec.veterinario);
        DBMS_OUTPUT.PUT_LINE('  Licencia: ' || cita_rec.nro_licencia);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('TOTAL DE CITAS PENDIENTES: ' || v_total_citas);
    DBMS_OUTPUT.PUT_LINE('=================================================');

    -- Si no hay citas pendientes
    IF v_total_citas = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No hay citas pendientes en el sistema.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        RAISE;
END sp_reporte_citas_pendientes_general;