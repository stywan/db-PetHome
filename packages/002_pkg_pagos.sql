-- PACKAGE: PKG_PAGOS
-- Agrupa toda la lógica relacionada con pagos

CREATE OR REPLACE PACKAGE pkg_pagos AS
    
    -- =============== CONSTRUCTORES PÚBLICOS ===============
    
    -- Registrar un nuevo pago
    PROCEDURE registrar_pago(
        p_cita_id   IN NUMBER,
        p_monto     IN NUMBER,
        p_moneda    IN VARCHAR2 DEFAULT 'CLP',
        p_metodo    IN VARCHAR2,
        p_pago_id   OUT NUMBER
    );
    
    -- Obtener estado de pago de una cita
    FUNCTION obtener_estado_pago(
        p_cita_id IN NUMBER
    ) RETURN VARCHAR2;
    
    -- Calcular total de ingresos en un período
    FUNCTION calcular_ingresos_periodo(
        p_fecha_inicio IN DATE,
        p_fecha_fin    IN DATE
    ) RETURN NUMBER;
    
    -- Obtener reporte de pagos pendientes
    FUNCTION obtener_pagos_pendientes
    RETURN SYS_REFCURSOR;
    
END pkg_pagos;

-- PACKAGE BODY: PKG_PAGOS

CREATE OR REPLACE PACKAGE BODY pkg_pagos AS
    
    --  CONSTANTES PRIVADAS
    c_estado_completado CONSTANT VARCHAR2(20) := 'COMPLETADO';
    c_estado_pendiente  CONSTANT VARCHAR2(20) := 'PENDIENTE';
    
    --  PROCEDIMIENTOS PRIVADOS
    
    -- Validar que la cita existe y está en estado correcto
    PROCEDURE validar_cita(
        p_cita_id     IN NUMBER,
        p_estado_cita OUT VARCHAR2
    ) IS
        v_existe NUMBER;
    BEGIN
        SELECT COUNT(*), MAX(estado)
        INTO v_existe, p_estado_cita
        FROM cita
        WHERE id = p_cita_id;
        
        IF v_existe = 0 THEN
            RAISE_APPLICATION_ERROR(-20301,
                'La cita con ID ' || p_cita_id || ' no existe.');
        END IF;
    END validar_cita;
    
    -- PROCEDIMIENTOS PÚBLICOS
    
    PROCEDURE registrar_pago(
        p_cita_id   IN NUMBER,
        p_monto     IN NUMBER,
        p_moneda    IN VARCHAR2 DEFAULT 'CLP',
        p_metodo    IN VARCHAR2,
        p_pago_id   OUT NUMBER
    ) IS
        v_estado_cita VARCHAR2(20);
        v_pago_existe NUMBER;
    BEGIN
        -- Validar monto
        IF p_monto <= 0 THEN
            RAISE_APPLICATION_ERROR(-20302, 
                'El monto debe ser mayor a cero.');
        END IF;
        
        -- Validar cita
        validar_cita(p_cita_id, v_estado_cita);
        
        IF v_estado_cita != 'COMPLETADA' THEN
            RAISE_APPLICATION_ERROR(-20303, 
                'La cita debe estar completada para registrar pago.');
        END IF;
        
        -- Verificar pago duplicado
        SELECT COUNT(*)
        INTO v_pago_existe
        FROM pago
        WHERE cita_id = p_cita_id
          AND estado = c_estado_completado;
        
        IF v_pago_existe > 0 THEN
            RAISE_APPLICATION_ERROR(-20304, 
                'Ya existe un pago completado para esta cita.');
        END IF;
        
        -- Insertar pago
        INSERT INTO pago (
            id, cita_id, monto, moneda, estado, metodo, creado_en
        ) VALUES (
            seq_pago.NEXTVAL, p_cita_id, p_monto, p_moneda, 
            c_estado_completado, p_metodo, SYSTIMESTAMP
        ) RETURNING id INTO p_pago_id;
        
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END registrar_pago;
    
    -- =============== FUNCIONES PÚBLICAS ===============
    
    FUNCTION obtener_estado_pago(
        p_cita_id IN NUMBER
    ) RETURN VARCHAR2 IS
        v_estado VARCHAR2(20);
    BEGIN
        SELECT estado
        INTO v_estado
        FROM pago
        WHERE cita_id = p_cita_id
          AND ROWNUM = 1
        ORDER BY creado_en DESC;
        
        RETURN v_estado;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'SIN_PAGO';
        WHEN OTHERS THEN
            RETURN 'ERROR';
    END obtener_estado_pago;
    
    
    FUNCTION calcular_ingresos_periodo(
        p_fecha_inicio IN DATE,
        p_fecha_fin    IN DATE
    ) RETURN NUMBER IS
        v_total NUMBER := 0;
    BEGIN
        SELECT NVL(SUM(monto), 0)
        INTO v_total
        FROM pago
        WHERE estado = c_estado_completado
          AND TRUNC(creado_en) BETWEEN p_fecha_inicio AND p_fecha_fin;
        
        RETURN v_total;
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20305, 
                'Error al calcular ingresos: ' || SQLERRM);
    END calcular_ingresos_periodo;
    
    
    FUNCTION obtener_pagos_pendientes
    RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT
                p.id AS pago_id,
                p.cita_id,
                p.monto,
                p.moneda,
                p.creado_en,
                c.fecha_hora AS fecha_cita,
                m.nombre AS mascota,
                per.nombres || ' ' || per.apellidos AS dueno
            FROM pago p
            JOIN cita c ON p.cita_id = c.id
            JOIN mascota m ON c.mascota_id = m.id
            JOIN usuario u ON m.dueno_id = u.id
            JOIN persona per ON u.persona_id = per.id
            WHERE p.estado = c_estado_pendiente
            ORDER BY p.creado_en;
        
        RETURN v_cursor;
    END obtener_pagos_pendientes;
    
END pkg_pagos;
