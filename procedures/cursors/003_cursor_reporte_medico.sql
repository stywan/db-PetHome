--Reporte médico: historial clínico con recetas y medicamentos

DECLARE
    -- Cursor principal: historial médico
    CURSOR cur_historial(p_mascota_id NUMBER) IS
        SELECT h.id, h.diagnostico, h.tratamiento, h.recomendaciones, h.proxima_visita
        FROM historial_medico h
        WHERE h.mascota_id = p_mascota_id;

    -- Cursor secundario: recetas asociadas al historial
    CURSOR cur_recetas(p_historial_id NUMBER) IS
        SELECT r.id, m.nombre AS medicamento, r.dosis, r.frecuencia, r.duracion
        FROM receta r
        JOIN medicamento m ON r.medicamento_id = m.id
        WHERE r.historial_id = p_historial_id;

BEGIN
    FOR h_rec IN cur_historial(10) LOOP -- Mascota con ID=10 (Max)
        DBMS_OUTPUT.PUT_LINE('Historial ID: ' || h_rec.id ||
                            ' Diagnóstico: ' || h_rec.diagnostico ||
                            ' Próxima visita: ' || h_rec.proxima_visita);

        FOR r_rec IN cur_recetas(h_rec.id) LOOP
            DBMS_OUTPUT.PUT_LINE('   Receta ID: ' || r_rec.id ||
                                ' Medicamento: ' || r_rec.medicamento ||
                                ' Dosis: ' || r_rec.dosis ||
                                ' Frecuencia: ' || r_rec.frecuencia ||
                                ' Duración: ' || r_rec.duracion);
        END LOOP;
    END LOOP;
END;
