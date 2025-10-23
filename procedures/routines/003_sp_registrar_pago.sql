
-- PROCEDIMIENTO CON PARÁMETROS
-- Registra un pago para una cita y actualiza su estado

CREATE OR REPLACE PROCEDURE sp_registrar_pago (
    p_cita_id       IN NUMBER,
    p_monto         IN NUMBER,
    p_moneda        IN VARCHAR2 DEFAULT 'CLP',
    p_metodo        IN VARCHAR2,
    p_pago_id       OUT NUMBER
) IS
    v_cita_existe   NUMBER;
    v_pago_existe   NUMBER;
    v_estado_cita   VARCHAR2(20);

    e_cita_no_existe        EXCEPTION;
    e_pago_duplicado        EXCEPTION;
    e_cita_no_completada    EXCEPTION;
    e_monto_invalido        EXCEPTION;

BEGIN
    -- Validar que el monto sea positivo
    IF p_monto <= 0 THEN
        RAISE e_monto_invalido;
    END IF;

    -- Verificar que la cita existe
    SELECT COUNT(*), MAX(estado)
    INTO v_cita_existe, v_estado_cita
    FROM cita
    WHERE id = p_cita_id;

    IF v_cita_existe = 0 THEN
        RAISE e_cita_no_existe;
    END IF;

    -- Verificar que la cita esté completada
    IF v_estado_cita != 'COMPLETADA' THEN
        RAISE e_cita_no_completada;
    END IF;

    -- Verificar que no exista ya un pago para esta cita
    SELECT COUNT(*)
    INTO v_pago_existe
    FROM pago
    WHERE cita_id = p_cita_id
      AND estado = 'COMPLETADO';

    IF v_pago_existe > 0 THEN
        RAISE e_pago_duplicado;
    END IF;

    -- Insertar el pago
    INSERT INTO pago (
        id,
        cita_id,
        monto,
        moneda,
        estado,
        metodo,
        creado_en
    ) VALUES (
        seq_pago.NEXTVAL,
        p_cita_id,
        p_monto,
        p_moneda,
        'COMPLETADO',
        p_metodo,
        SYSTIMESTAMP
    ) RETURNING id INTO p_pago_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Pago registrado exitosamente.');
    DBMS_OUTPUT.PUT_LINE('ID Pago: ' || p_pago_id);
    DBMS_OUTPUT.PUT_LINE('Monto: ' || p_monto || ' ' || p_moneda);

EXCEPTION
    WHEN e_monto_invalido THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20101, 'El monto debe ser mayor a cero.');

    WHEN e_cita_no_existe THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20102, 'La cita con ID ' || p_cita_id || ' no existe.');

    WHEN e_cita_no_completada THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20103,
            'No se puede registrar pago. La cita debe estar en estado COMPLETADA. Estado actual: ' || v_estado_cita);

    WHEN e_pago_duplicado THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20104, 'Ya existe un pago completado para esta cita.');

    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20199, 'Error al registrar el pago: ' || SQLERRM);
END sp_registrar_pago;