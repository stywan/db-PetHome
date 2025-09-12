--EJEMPLO: Un VARRAY para almacenar los medicamentos recetados en una consulta veterinaria.

DECLARE
    TYPE medicamentos_array IS VARRAY(10) OF medicamento.nombre%TYPE;
    wv_meds medicamentos_array;
BEGIN
    SELECT m.nombre
    BULK COLLECT INTO v_meds
    FROM receta r
    JOIN medicamento m ON r.medicamento_id = m.id
    WHERE r.historial_id = 10; --ID

    FOR i IN 1..v_meds.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Medicamento recetado: ' || v_meds(i));
    END LOOP;
END;