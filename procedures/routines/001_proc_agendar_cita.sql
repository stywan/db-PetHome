CREATE OR REPLACE PROCEDURE agendar_cita (
    p_mascota_id     IN NUMBER,
    p_veterinario_id IN NUMBER,
    p_fecha          IN TIMESTAMP
) IS
    v_count NUMBER;
BEGIN
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
END;