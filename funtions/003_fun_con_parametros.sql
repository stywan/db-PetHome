-- FUNCIÓN CON PARÁMETROS
-- Calcula el total a pagar de una cita sumando todos los servicios asociados
CREATE OR REPLACE FUNCTION fn_calcular_total_cita (
    p_cita_id IN NUMBER
) RETURN NUMBER
IS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(s.precio_base), 0)
    INTO v_total
    FROM cita_servicio cs
    JOIN veterinario_servicio vs ON cs.veterinario_servicio_id = vs.id
    JOIN servicio s ON vs.servicio_id = s.id
    WHERE cs.cita_id = p_cita_id;
    
    RETURN v_total;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20203,
            'Error al calcular total de cita: ' || SQLERRM);
END fn_calcular_total_cita;



-- FUNCIÓN CON PARÁMETROS
-- Calcula la edad en años de una mascota
CREATE OR REPLACE FUNCTION fn_calcular_edad_mascota (
    p_mascota_id IN NUMBER
) RETURN NUMBER
IS
    v_fecha_nacimiento  DATE;
    v_edad              NUMBER;
BEGIN
    SELECT fecha_nacimiento
    INTO v_fecha_nacimiento
    FROM mascota
    WHERE id = p_mascota_id;
    
    IF v_fecha_nacimiento IS NULL THEN
        RETURN NULL;
    END IF;
    
    -- Calcular edad en años
    v_edad := TRUNC(MONTHS_BETWEEN(SYSDATE, v_fecha_nacimiento) / 12, 1);
    
    RETURN v_edad;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20205,
            'Mascota con ID ' || p_mascota_id || ' no encontrada.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20206,
            'Error al calcular edad de mascota: ' || SQLERRM);
END fn_calcular_edad_mascota;
