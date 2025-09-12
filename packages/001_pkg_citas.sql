
--PAQUETE
CREATE OR REPLACE PACKAGE pkg_citas AS
    -- Procedimiento para agendar citas
    PROCEDURE agendar_cita(
        p_mascota_id     IN NUMBER,
        p_veterinario_id IN NUMBER,
        p_fecha          IN TIMESTAMP
    );

    -- Función para obtener citas pendientes de un cliente
    FUNCTION citas_pendientes(
        p_cliente_id NUMBER
    ) RETURN SYS_REFCURSOR;
END pkg_citas;
/

--CUERPO DEL PAQUETE
CREATE OR REPLACE PACKAGE BODY pkg_citas AS

    PROCEDURE agendar_cita(
        p_mascota_id     IN NUMBER,
        p_veterinario_id IN NUMBER,
        p_fecha          IN TIMESTAMP
    ) IS
        v_count NUMBER;
    BEGIN
        -- Verificar si ya existe una cita en ese horario con el mismo veterinario y mascota
        SELECT COUNT(*)
        INTO v_count
        FROM cita
        WHERE mascota_id = p_mascota_id
            AND veterinario_id = p_veterinario_id
            AND fecha_hora = p_fecha
            AND estado = 'PENDIENTE';

        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Ya existe una cita pendiente en ese horario.');
        ELSE
            INSERT INTO cita (id, mascota_id, veterinario_id, fecha_hora, estado)
            VALUES (seq_cita.NEXTVAL, p_mascota_id, p_veterinario_id, p_fecha, 'PENDIENTE');
        END IF;
    END agendar_cita;


    FUNCTION citas_pendientes(p_cliente_id NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT c.id,
                    c.fecha_hora,
                    v.nro_licencia,
                    p.nombres || ' ' || p.apellidos AS veterinario,
                    m.nombre AS mascota
            FROM cita c
            JOIN veterinario v ON c.veterinario_id = v.id
            JOIN persona p ON v.persona_id = p.id
            JOIN mascota m ON c.mascota_id = m.id
            WHERE m.dueno_id = p_cliente_id
                AND c.estado = 'PENDIENTE'
            ORDER BY c.fecha_hora;

        RETURN v_cursor;
    END citas_pendientes;

END pkg_citas;
/
