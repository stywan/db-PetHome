
DECLARE
    e_mascota_no_existe EXCEPTION; -- Excepción personalizada
    v_count NUMBER;
    v_mascota_id NUMBER := 999; -- ejemplo: mascota inexistente
    v_veterinario_id NUMBER := 20;
    v_cita_id NUMBER := 100;
BEGIN
    -- Verificar si existe la mascota
    SELECT COUNT(*)
    INTO v_count
    FROM mascota
    WHERE id = v_mascota_id;

    IF v_count = 0 THEN
        RAISE e_mascota_no_existe;
    END IF;

    -- Insertar historial médico si la mascota existe
    INSERT INTO historial_medico (id, mascota_id, veterinario_id, cita_id, diagnostico, tratamiento, recomendaciones)
    VALUES (seq_historial_medico.NEXTVAL, v_mascota_id, v_veterinario_id, v_cita_id,
            'Diagnóstico ejemplo', 'Tratamiento ejemplo', 'Recomendaciones ejemplo');

    DBMS_OUTPUT.PUT_LINE('Historial médico registrado exitosamente.');

EXCEPTION
    WHEN e_mascota_no_existe THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se puede registrar historial, la mascota no existe.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró información de la mascota.');
    WHEN OTHERS THEN
        wDBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END;