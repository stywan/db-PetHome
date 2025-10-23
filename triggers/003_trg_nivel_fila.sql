
-- TRIGGER A NIVEL DE FILA
-- Valida horario de citas antes de insertar o actualizar

CREATE OR REPLACE TRIGGER trg_validar_horario_cita
BEFORE INSERT OR UPDATE OF fecha_hora ON cita
FOR EACH ROW
DECLARE
    v_hora          NUMBER;
    v_dia_semana    VARCHAR2(10);
    v_conflicto     NUMBER;
BEGIN
    v_hora := TO_NUMBER(TO_CHAR(:NEW.fecha_hora, 'HH24'));
    
    v_dia_semana := TO_CHAR(:NEW.fecha_hora, 'DY', 'NLS_DATE_LANGUAGE=SPANISH');
    
    IF v_dia_semana IN ('SÁB', 'DOM') THEN
        RAISE_APPLICATION_ERROR(-20501,
            'No se pueden agendar citas los fines de semana.');
    END IF;
    
    IF v_hora < 8 OR v_hora >= 18 THEN
        RAISE_APPLICATION_ERROR(-20502,
            'Las citas deben ser agendadas en horario laboral (08:00 - 18:00).');
    END IF;
    
    SELECT COUNT(*)
    INTO v_conflicto
    FROM cita
    WHERE veterinario_id = :NEW.veterinario_id
      AND fecha_hora = :NEW.fecha_hora
      AND estado IN ('PENDIENTE', 'CONFIRMADA')
      AND id != NVL(:NEW.id, -1);
    
    IF v_conflicto > 0 THEN
        RAISE_APPLICATION_ERROR(-20503,
            'El veterinario ya tiene una cita programada en ese horario.');
    END IF;
    
    :NEW.fecha_hora := :NEW.fecha_hora;
    
END trg_validar_horario_cita;


-- TRIGGER A NIVEL DE FILA
-- Valida que el monto del pago sea positivo

CREATE OR REPLACE TRIGGER trg_validar_monto_pago
BEFORE INSERT OR UPDATE OF monto ON pago
FOR EACH ROW
BEGIN
    IF :NEW.monto <= 0 THEN
        RAISE_APPLICATION_ERROR(-20504,
            'El monto del pago debe ser mayor a cero. Valor ingresado: ' || :NEW.monto);
    END IF;
    
    -- Validar que no exceda un límite razonable (ej: 10 millones)
    IF :NEW.monto > 10000000 THEN
        RAISE_APPLICATION_ERROR(-20505,
            'El monto del pago excede el límite permitido ($10.000.000).');
    END IF;
END trg_validar_monto_pago;



-- TRIGGER A NIVEL DE FILA
-- Valida puntuación en calificaciones (1-5)

CREATE OR REPLACE TRIGGER trg_validar_puntuacion
BEFORE INSERT OR UPDATE OF puntuacion ON calificacion
FOR EACH ROW
BEGIN
    IF :NEW.puntuacion < 1 OR :NEW.puntuacion > 5 THEN
        RAISE_APPLICATION_ERROR(-20506,
            'La puntuación debe estar entre 1 y 5. Valor ingresado: ' || :NEW.puntuacion);
    END IF;
END trg_validar_puntuacion;
