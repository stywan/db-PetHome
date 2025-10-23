
-- PACKAGE: PKG_REPORTES
-- Agrupa funcionalidades para generación de reportes

CREATE OR REPLACE PACKAGE pkg_reportes AS
    
    -- TIPOS PÚBLICOS 
    TYPE t_reporte_veterinario IS RECORD (
        veterinario_id      NUMBER,
        nombre_completo     VARCHAR2(200),
        nro_licencia        VARCHAR2(50),
        total_citas         NUMBER,
        promedio_calif      NUMBER,
        ingresos_generados  NUMBER
    );
    
    TYPE t_tabla_reporte_vet IS TABLE OF t_reporte_veterinario;
    
    --  PROCEDIMIENTOS PÚBLICOS 
    
    -- Generar reporte de rendimiento de veterinarios
    PROCEDURE generar_reporte_veterinarios(
        p_fecha_inicio IN DATE,
        p_fecha_fin    IN DATE
    );
    
    -- Generar reporte de mascotas más atendidas
    PROCEDURE generar_reporte_mascotas_frecuentes(
        p_top_n IN NUMBER DEFAULT 10
    );
    
    -- FUNCIONES PÚBLICAS
    
    -- Obtener datos de veterinarios para reporte
    FUNCTION obtener_datos_veterinarios(
        p_fecha_inicio IN DATE,
        p_fecha_fin    IN DATE
    ) RETURN SYS_REFCURSOR;
    
    -- Calcular tasa de ocupación de veterinario
    FUNCTION calcular_tasa_ocupacion(
        p_veterinario_id IN NUMBER,
        p_mes            IN NUMBER,
        p_anio           IN NUMBER
    ) RETURN NUMBER;
    
END pkg_reportes;
/

-- PACKAGE BODY: PKG_REPORTES

CREATE OR REPLACE PACKAGE BODY pkg_reportes AS
    
    -- PROCEDIMIENTOS PÚBLICOS
    
    PROCEDURE generar_reporte_veterinarios(
        p_fecha_inicio IN DATE,
        p_fecha_fin    IN DATE
    ) IS
        CURSOR cur_veterinarios IS
            SELECT
                v.id,
                p.nombres || ' ' || p.apellidos AS nombre,
                v.nro_licencia,
                COUNT(c.id) AS total_citas,
                NVL(AVG(cal.puntuacion), 0) AS promedio,
                NVL(SUM(pag.monto), 0) AS ingresos
            FROM veterinario v
            JOIN persona p ON v.persona_id = p.id
            LEFT JOIN cita c ON v.id = c.veterinario_id
                AND TRUNC(c.fecha_hora) BETWEEN p_fecha_inicio AND p_fecha_fin
            LEFT JOIN calificacion cal ON v.id = cal.veterinario_id
                AND TRUNC(cal.creada_en) BETWEEN p_fecha_inicio AND p_fecha_fin
            LEFT JOIN pago pag ON c.id = pag.cita_id
                AND pag.estado = 'COMPLETADO'
            GROUP BY v.id, p.nombres, p.apellidos, v.nro_licencia
            ORDER BY total_citas DESC;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('====================================================');
        DBMS_OUTPUT.PUT_LINE('   REPORTE DE RENDIMIENTO DE VETERINARIOS');
        DBMS_OUTPUT.PUT_LINE('   Período: ' || TO_CHAR(p_fecha_inicio, 'DD/MM/YYYY') || 
                            ' - ' || TO_CHAR(p_fecha_fin, 'DD/MM/YYYY'));
        DBMS_OUTPUT.PUT_LINE('====================================================');
        DBMS_OUTPUT.PUT_LINE('');
        
        FOR vet_rec IN cur_veterinarios LOOP
            DBMS_OUTPUT.PUT_LINE('Veterinario: ' || vet_rec.nombre);
            DBMS_OUTPUT.PUT_LINE('  Licencia: ' || vet_rec.nro_licencia);
            DBMS_OUTPUT.PUT_LINE('  Total Citas: ' || vet_rec.total_citas);
            DBMS_OUTPUT.PUT_LINE('  Promedio Calificación: ' || 
                                ROUND(vet_rec.promedio, 2));
            DBMS_OUTPUT.PUT_LINE('  Ingresos Generados: $' || 
                                TO_CHAR(vet_rec.ingresos, '999,999,999'));
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('====================================================');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
            RAISE;
    END generar_reporte_veterinarios;
    
    
    PROCEDURE generar_reporte_mascotas_frecuentes(
        p_top_n IN NUMBER DEFAULT 10
    ) IS
        CURSOR cur_mascotas IS
            SELECT 
                m.id,
                m.nombre,
                e.nombre AS especie,
                r.nombre AS raza,
                p.nombres || ' ' || p.apellidos AS dueno,
                COUNT(c.id) AS total_citas
            FROM mascota m
            JOIN especie e ON m.especie_id = e.id
            LEFT JOIN raza r ON m.raza_id = r.id
            JOIN usuario u ON m.dueno_id = u.id
            JOIN persona p ON u.persona_id = p.id
            LEFT JOIN cita c ON m.id = c.mascota_id
            GROUP BY m.id, m.nombre, e.nombre, r.nombre, 
                     p.nombres, p.apellidos
            ORDER BY total_citas DESC
            FETCH FIRST p_top_n ROWS ONLY;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('====================================================');
        DBMS_OUTPUT.PUT_LINE('   TOP ' || p_top_n || ' MASCOTAS MÁS ATENDIDAS');
        DBMS_OUTPUT.PUT_LINE('====================================================');
        DBMS_OUTPUT.PUT_LINE('');
        
        FOR pet_rec IN cur_mascotas LOOP
            DBMS_OUTPUT.PUT_LINE('Mascota: ' || pet_rec.nombre);
            DBMS_OUTPUT.PUT_LINE('  Especie: ' || pet_rec.especie ||
                                CASE WHEN pet_rec.raza IS NOT NULL
                                     THEN ' - Raza: ' || pet_rec.raza
                                     ELSE '' END);
            DBMS_OUTPUT.PUT_LINE('  Dueño: ' || pet_rec.dueno);
            DBMS_OUTPUT.PUT_LINE('  Total Citas: ' || pet_rec.total_citas);
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('====================================================');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
            RAISE;
    END generar_reporte_mascotas_frecuentes;
    
    -- FUNCIONES PÚBLICAS
    
    FUNCTION obtener_datos_veterinarios(
        p_fecha_inicio IN DATE,
        p_fecha_fin    IN DATE
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT
                v.id AS veterinario_id,
                p.nombres || ' ' || p.apellidos AS nombre_completo,
                v.nro_licencia,
                COUNT(DISTINCT c.id) AS total_citas,
                NVL(AVG(cal.puntuacion), 0) AS promedio_calificacion,
                NVL(SUM(pag.monto), 0) AS ingresos_totales
            FROM veterinario v
            JOIN persona p ON v.persona_id = p.id
            LEFT JOIN cita c ON v.id = c.veterinario_id
                AND TRUNC(c.fecha_hora) BETWEEN p_fecha_inicio AND p_fecha_fin
            LEFT JOIN calificacion cal ON v.id = cal.veterinario_id
            LEFT JOIN pago pag ON c.id = pag.cita_id
                AND pag.estado = 'COMPLETADO'
            GROUP BY v.id, p.nombres, p.apellidos, v.nro_licencia
            ORDER BY total_citas DESC;
        
        RETURN v_cursor;
    END obtener_datos_veterinarios;
    
    
    FUNCTION calcular_tasa_ocupacion(
        p_veterinario_id IN NUMBER,
        p_mes            IN NUMBER,
        p_anio           IN NUMBER
    ) RETURN NUMBER IS
        v_citas_realizadas  NUMBER;
        v_dias_habiles      NUMBER;
        v_citas_maximas     NUMBER;
        v_tasa              NUMBER;
    BEGIN
        -- Calcular días hábiles del mes (aproximado: 22 días)
        v_dias_habiles := 22;
        
        -- Asumir máximo 8 citas por día
        v_citas_maximas := v_dias_habiles * 8;
        
        -- Contar citas realizadas
        SELECT COUNT(*)
        INTO v_citas_realizadas
        FROM cita
        WHERE veterinario_id = p_veterinario_id
          AND EXTRACT(MONTH FROM fecha_hora) = p_mes
          AND EXTRACT(YEAR FROM fecha_hora) = p_anio
          AND estado IN ('COMPLETADA', 'PENDIENTE');
        
        -- Calcular tasa como porcentaje
        IF v_citas_maximas > 0 THEN
            v_tasa := (v_citas_realizadas / v_citas_maximas) * 100;
        ELSE
            v_tasa := 0;
        END IF;
        
        RETURN ROUND(v_tasa, 2);
        
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END calcular_tasa_ocupacion;
    
END pkg_reportes;