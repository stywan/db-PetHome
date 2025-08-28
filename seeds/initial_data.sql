-- Población inicial para la base de datos PetHome
-- -----------------------------------------------------------
-- Insertar datos en la tabla persona
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (HEXTORAW('1A1B1C1D1E1F10111213141516171819'), 'Juan', 'Pérez', 'juan.perez@example.com', '123456789', 'http://foto.com/juan');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (HEXTORAW('2B2C2D2E2F202122232425262728293A'), 'María', 'García', 'maria.garcia@example.com', '987654321', 'http://foto.com/maria');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (HEXTORAW('3C3D3E3F303132333435363738394A4B'), 'Dr. Carlos', 'López', 'carlos.lopez@vet.com', '555111222', 'http://foto.com/carlos');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (HEXTORAW('4D4E4F404142434445464748494A4B4C'), 'Ana', 'Martínez', 'ana.martinez@vet.com', '555333444', 'http://foto.com/ana');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (HEXTORAW('5E5F505152535455565758595A5B5C5D'), 'Daniela', 'Rodríguez', 'daniela.rodriguez@example.com', '123123123', 'http://foto.com/daniela');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (HEXTORAW('6F606162636465666768696A6B6C6D6E'), 'Pedro', 'Sánchez', 'pedro.sanchez@example.com', '321321321', 'http://foto.com/pedro');

-- -----------------------------------------------------------
-- Insertar datos en la tabla usuario
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (HEXTORAW('7A7B7C7D7E7F80818283848586878889'), HEXTORAW('1A1B1C1D1E1F10111213141516171819'), 'hash_juan', 'CLIENTE', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (HEXTORAW('8B8C8D8E8F909192939495969798999A'), HEXTORAW('2B2C2D2E2F202122232425262728293A'), 'hash_maria', 'CLIENTE', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (HEXTORAW('9C9D9E9F90A1A2A3A4A5A6A7A8A9ABAC'), HEXTORAW('3C3D3E3F303132333435363738394A4B'), 'hash_carlos', 'VETERINARIO', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (HEXTORAW('ADB0B1B2B3B4B5B6B7B8B9BABBBDBCBE'), HEXTORAW('4D4E4F404142434445464748494A4B4C'), 'hash_ana', 'VETERINARIO', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (HEXTORAW('CFC0C1C2C3C4C5C6C7C8C9CACBCCCDCE'), HEXTORAW('5E5F505152535455565758595A5B5C5D'), 'hash_daniela', 'CLIENTE', '1', '0');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (HEXTORAW('DFD0D1D2D3D4D5D6D7D8D9DADBDCDDEE'), HEXTORAW('6F606162636465666768696A6B6C6D6E'), 'hash_pedro', 'CLIENTE', '1', '1');

-- -----------------------------------------------------------
-- Insertar datos en la tabla veterinario
INSERT INTO veterinario (id, persona_id, nro_licencia, anios_experiencia, biografia) VALUES (HEXTORAW('A1A2A3A4A5A6A7A8A9AAABACADAEAFB0'), HEXTORAW('3C3D3E3F303132333435363738394A4B'), 'LIC-1001', 10, 'Especialista en cirugía y medicina interna.');
INSERT INTO veterinario (id, persona_id, nro_licencia, anios_experiencia, biografia) VALUES (HEXTORAW('B1B2B3B4B5B6B7B8B9BABBBBCBDCBEBF'), HEXTORAW('4D4E4F404142434445464748494A4B4C'), 'LIC-1002', 5, 'Especialista en dermatología y comportamiento animal.');

-- -----------------------------------------------------------
-- Insertar datos en la tabla especializacion
INSERT INTO especializacion (id, nombre, activa) VALUES (HEXTORAW('C1C2C3C4C5C6C7C8C9CACBCBDCECFD0D'), 'Cirugía', '1');
INSERT INTO especializacion (id, nombre, activa) VALUES (HEXTORAW('D1D2D3D4D5D6D7D8D9DADBDCDDEDFE0F'), 'Medicina Interna', '1');
INSERT INTO especializacion (id, nombre, activa) VALUES (HEXTORAW('E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0'), 'Dermatología', '1');
INSERT INTO especializacion (id, nombre, activa) VALUES (HEXTORAW('F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF11'), 'Comportamiento Animal', '1');

-- -----------------------------------------------------------
-- Insertar datos en la tabla veterinario_especializacion
INSERT INTO veterinario_especializacion (veterinario_id, especializacion_id) VALUES (HEXTORAW('A1A2A3A4A5A6A7A8A9AAABACADAEAFB0'), HEXTORAW('C1C2C3C4C5C6C7C8C9CACBCBDCECFD0D'));
INSERT INTO veterinario_especializacion (veterinario_id, especializacion_id) VALUES (HEXTORAW('A1A2A3A4A5A6A7A8A9AAABACADAEAFB0'), HEXTORAW('D1D2D3D4D5D6D7D8D9DADBDCDDEDFE0F'));
INSERT INTO veterinario_especializacion (veterinario_id, especializacion_id) VALUES (HEXTORAW('B1B2B3B4B5B6B7B8B9BABBBBCBDCBEBF'), HEXTORAW('E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0'));

-- -----------------------------------------------------------
-- Insertar datos en la tabla especie
INSERT INTO especie (id, nombre) VALUES (HEXTORAW('1B1C1D1E1F101112131415161718192A'), 'Perro');
INSERT INTO especie (id, nombre) VALUES (HEXTORAW('2B2C2D2E2F202122232425262728293B'), 'Gato');

-- -----------------------------------------------------------
-- Insertar datos en la tabla raza
INSERT INTO raza (id, especie_id, nombre) VALUES (HEXTORAW('3C3D3E3F303132333435363738394A4C'), HEXTORAW('1B1C1D1E1F101112131415161718192A'), 'Golden Retriever');
INSERT INTO raza (id, especie_id, nombre) VALUES (HEXTORAW('4D4E4F404142434445464748494A4B4D'), HEXTORAW('1B1C1D1E1F101112131415161718192A'), 'Pastor Alemán');
INSERT INTO raza (id, especie_id, nombre) VALUES (HEXTORAW('5E5F505152535455565758595A5B5C5E'), HEXTORAW('2B2C2D2E2F202122232425262728293B'), 'Siamés');
INSERT INTO raza (id, especie_id, nombre) VALUES (HEXTORAW('6F606162636465666768696A6B6C6D6F'), HEXTORAW('2B2C2D2E2F202122232425262728293B'), 'Persa');

-- -----------------------------------------------------------
-- Insertar datos en la tabla mascota
INSERT INTO mascota (id, dueno_id, nombre, especie_id, raza_id, fecha_nacimiento, genero, esterilizado, url_foto) VALUES (HEXTORAW('A1A2A3A4A5A6A7A8A9AAABACADAEAFB1'), HEXTORAW('7A7B7C7D7E7F80818283848586878889'), 'Fido', HEXTORAW('1B1C1D1E1F101112131415161718192A'), HEXTORAW('3C3D3E3F303132333435363738394A4C'), TO_DATE('2020-05-15', 'YYYY-MM-DD'), 'MACHO', '1', 'http://foto.com/fido');
INSERT INTO mascota (id, dueno_id, nombre, especie_id, raza_id, fecha_nacimiento, genero, esterilizado, url_foto) VALUES (HEXTORAW('B1B2B3B4B5B6B7B8B9BABBBBCBDCBEF2'), HEXTORAW('8B8C8D8E8F909192939495969798999A'), 'Misi', HEXTORAW('2B2C2D2E2F202122232425262728293B'), HEXTORAW('5E5F505152535455565758595A5B5C5E'), TO_DATE('2019-08-20', 'YYYY-MM-DD'), 'HEMBRA', '1', 'http://foto.com/misi');

-- -----------------------------------------------------------
-- Insertar datos en la tabla medicamento
INSERT INTO medicamento (id, nombre, principio_activo, forma) VALUES (HEXTORAW('C1C2C3C4C5C6C7C8C9CACBCBDCECFD13'), 'Amoxicilina', 'Amoxicilina', 'Tableta');
INSERT INTO medicamento (id, nombre, principio_activo, forma) VALUES (HEXTORAW('D1D2D3D4D5D6D7D8D9DADBDCDDEDFE24'), 'Frontline', 'Fipronil', 'Pipeta');

-- -----------------------------------------------------------
-- Insertar datos en la tabla mascota_medicamento
INSERT INTO mascota_medicamento (id, mascota_id, medicamento_id, dosis, frecuencia, fecha_inicio) VALUES (HEXTORAW('E1E2E3E4E5E6E7E8E9EAEBECEDEEFF35'), HEXTORAW('A1A2A3A4A5A6A7A8A9AAABACADAEAFB1'), HEXTORAW('C1C2C3C4C5C6C7C8C9CACBCBDCECFD13'), '250mg', 'Cada 12 horas', TO_DATE('2024-06-01', 'YYYY-MM-DD'));

-- -----------------------------------------------------------
-- Insertar datos en la tabla servicio
INSERT INTO servicio (id, nombre, descripcion, precio_base) VALUES (HEXTORAW('F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF46'), 'Consulta General', 'Revisión anual de salud y chequeo general.', 30000.00);
INSERT INTO servicio (id, nombre, descripcion, precio_base) VALUES (HEXTORAW('112233445566778899AABBCCDDEEFF57'), 'Vacunación', 'Aplicación de vacunas según calendario.', 25000.00);

-- -----------------------------------------------------------
-- Insertar datos en la tabla veterinario_servicio
INSERT INTO veterinario_servicio (id, veterinario_id, servicio_id) VALUES (HEXTORAW('112233445566778899AABBCCDDEEFF68'), HEXTORAW('A1A2A3A4A5A6A7A8A9AAABACADAEAFB0'), HEXTORAW('F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF46'));
INSERT INTO veterinario_servicio (id, veterinario_id, servicio_id) VALUES (HEXTORAW('2233445566778899AABBCCDDEEFF7980'), HEXTORAW('A1A2A3A4A5A6A7A8A9AAABACADAEAFB0'), HEXTORAW('112233445566778899AABBCCDDEEFF57'));
INSERT INTO veterinario_servicio (id, veterinario_id, servicio_id) VALUES (HEXTORAW('33445566778899AABBCCDDEEFF8A9B81'), HEXTORAW('B1B2B3B4B5B6B7B8B9BABBBBCBDCBEBF'), HEXTORAW('F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF46'));

-- -----------------------------------------------------------
-- Insertar datos en la tabla cita
INSERT INTO cita (id, mascota_id, veterinario_id, fecha_hora, estado, notas) VALUES (HEXTORAW('A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6'), HEXTORAW('A1A2A3A4A5A6A7A8A9AAABACADAEAFB1'), HEXTORAW('A1A2A3A4A5A6A7A8A9AAABACADAEAFB0'), TO_TIMESTAMP('2024-07-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETADA', 'Chequeo general, Fido está sano.');

-- -----------------------------------------------------------
-- Insertar datos en la tabla cita_servicio
INSERT INTO cita_servicio (id, cita_id, veterinario_servicio_id) VALUES (HEXTORAW('B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6E7'), HEXTORAW('A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6'), HEXTORAW('112233445566778899AABBCCDDEEFF68'));

-- -----------------------------------------------------------
-- Insertar datos en la tabla historial_medico
INSERT INTO historial_medico (id, mascota_id, veterinario_id, cita_id, diagnostico, tratamiento, recomendaciones, proxima_visita) VALUES (HEXTORAW('C3D4E5F6A7B8C9D0E1F2A3B4C5D6E7F8'), HEXTORAW('A1A2A3A4A5A6A7A8A9AAABACADAEAFB1'), HEXTORAW('A1A2A3A4A5A6A7A8A9AAABACADAEAFB0'), HEXTORAW('A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6'), 'Chequeo anual de rutina.', 'Dieta balanceada y ejercicio regular.', 'Revisión en 6 meses.', TO_DATE('2025-01-01', 'YYYY-MM-DD'));

-- -----------------------------------------------------------
-- Insertar datos en la tabla receta
INSERT INTO receta (id, historial_id, medicamento_id, dosis, frecuencia, duracion) VALUES (HEXTORAW('D4E5F6A7B8C9D0E1F2A3B4C5D6E7F8F9'), HEXTORAW('C3D4E5F6A7B8C9D0E1F2A3B4C5D6E7F8'), HEXTORAW('C1C2C3C4C5C6C7C8C9CACBCBDCECFD13'), '250mg', 'Cada 12 horas', '7 días');

-- -----------------------------------------------------------
-- Insertar datos en la tabla calificacion
INSERT INTO calificacion (id, cita_id, usuario_id, veterinario_id, puntuacion, comentario) VALUES (HEXTORAW('E5F6A7B8C9D0E1F2A3B4C5D6E7F8F90A'), HEXTORAW('A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6'), HEXTORAW('7A7B7C7D7E7F80818283848586878889'), HEXTORAW('A1A2A3A4A5A6A7A8A9AAABACADAEAFB0'), 5, 'Excelente servicio y atención.');

-- -----------------------------------------------------------
-- Insertar datos en la tabla pago
INSERT INTO pago (id, cita_id, monto, moneda, estado, metodo) VALUES (HEXTORAW('F6A7B8C9D0E1F2A3B4C5D6E7F8F90A1B'), HEXTORAW('A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6'), 30000.00, 'CLP', 'COMPLETADO', 'TARJETA');

-- -----------------------------------------------------------
-- Insertar datos en la tabla notificacion
--INSERT INTO notificacion (id, usuario_id, evento_tipo, canal, destinatario, contenido, estado) VALUES (HEXTORAW('A7B8C9D0E1F2A3B4C5D6E7F8F90A1B2C'), HEXTORAW('7A7B7C7D7E7F80818283848586878889'), 'appointment.confirmed', 'EMAIL', 'juan.perez@example.com', '{"asunto": "Cita Confirmada", "mensaje": "Su cita ha sido confirmada para el 01/07/2024"}', 'PENDIENTE');
