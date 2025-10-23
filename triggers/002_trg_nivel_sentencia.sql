
-- TRIGGER A NIVEL DE SENTENCIA
-- Controla operaciones masivas sobre la tabla cita
-- Evita eliminaciones en bloque sin autorización

CREATE OR REPLACE TRIGGER trg_control_eliminaciones_masivas_citas
BEFORE DELETE ON cita
DECLARE
    v_hora_actual NUMBER;
    v_dia_semana  VARCHAR2(10);
BEGIN
    -- Obtener hora actual (0-23)
    v_hora_actual := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
    
    -- Obtener día de la semana
    v_dia_semana := TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE=SPANISH');
    
    -- Solo permitir eliminaciones masivas en horario no laboral
    -- (antes de las 8am o después de las 6pm) y en fines de semana
    IF v_dia_semana NOT IN ('SÁB', 'DOM') AND
       v_hora_actual BETWEEN 8 AND 18 THEN
        RAISE_APPLICATION_ERROR(-20401,
            'No se permiten eliminaciones masivas de citas en horario laboral. ' ||
            'Intente nuevamente fuera del horario de 8:00 - 18:00 o en fin de semana.');
    END IF;
    
    -- Registrar evento en log
    DBMS_OUTPUT.PUT_LINE('ADVERTENCIA: Se está ejecutando una eliminación masiva de citas.');
    DBMS_OUTPUT.PUT_LINE('Fecha/Hora: ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS'));
    
END trg_control_eliminaciones_masivas_citas;



-- TRIGGER A NIVEL DE SENTENCIA
-- Registra actualizaciones masivas en tabla veterinario

CREATE OR REPLACE TRIGGER trg_log_cambios_veterinarios
AFTER UPDATE ON veterinario
DECLARE
    v_timestamp TIMESTAMP := SYSTIMESTAMP;
    v_usuario   VARCHAR2(100);
BEGIN
    -- Obtener usuario actual de la sesión
    SELECT USER INTO v_usuario FROM DUAL;
    
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('ACTUALIZACIÓN MASIVA EN TABLA VETERINARIO');
    DBMS_OUTPUT.PUT_LINE('Usuario: ' || v_usuario);
    DBMS_OUTPUT.PUT_LINE('Fecha/Hora: ' || TO_CHAR(v_timestamp, 'DD/MM/YYYY HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('==============================================');
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al registrar cambios: ' || SQLERRM);
END trg_log_cambios_veterinarios;