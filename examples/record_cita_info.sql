--Almacena los datos principales de una cita veterinaria,
-- combinando información de la mascota, el dueño y el veterinario

DECLARE
   TYPE cita_record IS RECORD (
      id_cita        cita.id%TYPE,
      fecha_hora     cita.fecha_hora%TYPE,
      estado         cita.estado%TYPE,
      mascota_nombre mascota.nombre%TYPE,
      dueno_nombre   persona.nombres%TYPE,
      vet_nombre     persona.nombres%TYPE
   );

   v_cita cita_record;
BEGIN
   SELECT c.id, c.fecha_hora, c.estado, m.nombre, p.nombres, vper.nombres
   INTO v_cita
   FROM cita c
   JOIN mascota m ON c.mascota_id = m.id
   JOIN usuario u ON m.dueno_id = u.id
   JOIN persona p ON u.persona_id = p.id
   JOIN veterinario v ON c.veterinario_id = v.id
   JOIN persona vper ON v.persona_id = vper.id
   WHERE c.id = 10;

   DBMS_OUTPUT.PUT_LINE('Cita: ' || v_cita.id_cita ||
                        ' Mascota: ' || v_cita.mascota_nombre ||
                        ' Dueño: ' || v_cita.dueno_nombre ||
                        ' Veterinario: ' || v_cita.vet_nombre);
END;
