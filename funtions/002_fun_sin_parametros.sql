
-- FUNCIÓN SIN PARÁMETROS
-- Retorna el total de citas pendientes en todo el sistema
CREATE OR REPLACE FUNCTION fn_total_citas_pendientes
RETURN NUMBER
IS
    v_total NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM cita
    WHERE estado = 'PENDIENTE';
    
    RETURN v_total;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20201, 'Error al contar citas pendientes: ' || SQLERRM);
END fn_total_citas_pendientes;
/


-- FUNCIÓN SIN PARÁMETROS
-- Retorna el ID del veterinario mejor calificado
CREATE OR REPLACE FUNCTION fn_veterinario_mejor_calificado
RETURN NUMBER
IS
    v_vet_id        NUMBER;
    v_promedio_max  NUMBER;
BEGIN
    SELECT veterinario_id, promedio
    INTO v_vet_id, v_promedio_max
    FROM (
        SELECT
            veterinario_id,
            AVG(puntuacion) AS promedio
        FROM calificacion
        GROUP BY veterinario_id
        ORDER BY AVG(puntuacion) DESC
    )
    WHERE ROWNUM = 1;
    
    RETURN v_vet_id;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20202,
            'Error al obtener veterinario mejor calificado: ' || SQLERRM);
END fn_veterinario_mejor_calificado;
/
