--FUNCION PERSONALIZADA
CREATE OR REPLACE FUNCTION promedio_calificaciones (
    p_veterinario_id IN NUMBER
) RETURN NUMBER IS
    v_promedio NUMBER;
BEGIN
    SELECT AVG(puntuacion)
    INTO v_promedio
    FROM calificacion
    WHERE veterinario_id = p_veterinario_id;

    RETURN NVL(v_promedio, 0);
END;