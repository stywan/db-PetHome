-- Inserción de datos en la tabla `persona`
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (10, 'Admin', 'Maestro', 'admin@example.com', '1000000000', 'http://example.com/p1.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (20, 'Juan', 'Perez', 'juan.perez@example.com', '1234567890', 'http://example.com/p2.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (30, 'Maria', 'Gomez', 'maria.gomez@example.com', '1234567891', 'http://example.com/p3.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (40, 'Carlos', 'Lopez', 'carlos.lopez@example.com', '1234567892', 'http://example.com/p4.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (50, 'Ana', 'Rodriguez', 'ana.rodriguez@example.com', '1234567893', 'http://example.com/p5.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (60, 'Luis', 'Martinez', 'luis.martinez@example.com', '1234567894', 'http://example.com/p6.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (70, 'Laura', 'Diaz', 'laura.diaz@example.com', '1234567895', 'http://example.com/p7.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (80, 'Jorge', 'Hernandez', 'jorge.hernandez@example.com', '1234567896', 'http://example.com/p8.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (90, 'Sofia', 'Torres', 'sofia.torres@example.com', '1234567897', 'http://example.com/p9.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (100, 'Fernando', 'Ramirez', 'fernando.ramirez@example.com', '1234567898', 'http://example.com/p10.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (110, 'Gabriela', 'Flores', 'gabriela.flores@example.com', '1234567899', 'http://example.com/p11.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (120, 'Dr. Smith', 'Vet', 'dr.smith@example.com', '1234567800', 'http://example.com/p12.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (130, 'Dra. Johnson', 'Vet', 'dra.johnson@example.com', '1234567801', 'http://example.com/p13.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (140, 'Dr. Williams', 'Vet', 'dr.williams@example.com', '1234567802', 'http://example.com/p14.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (150, 'Dra. Brown', 'Vet', 'dra.brown@example.com', '1234567803', 'http://example.com/p15.jpg');
INSERT INTO persona (id, nombres, apellidos, correo, telefono, url_foto) VALUES (160, 'Dr. Davis', 'Vet', 'dr.davis@example.com', '1234567804', 'http://example.com/p16.jpg');

-- Inserción de datos en la tabla `usuario`
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (10, 10, 'hashed_password_1', 'ADMIN', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (20, 20, 'hashed_password_2', 'CLIENTE', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (30, 30, 'hashed_password_3', 'CLIENTE', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (40, 40, 'hashed_password_4', 'CLIENTE', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (50, 50, 'hashed_password_5', 'CLIENTE', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (60, 60, 'hashed_password_6', 'CLIENTE', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (70, 70, 'hashed_password_7', 'CLIENTE', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (80, 80, 'hashed_password_8', 'CLIENTE', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (90, 90, 'hashed_password_9', 'CLIENTE', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (100, 100, 'hashed_password_10', 'CLIENTE', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (110, 110, 'hashed_password_11', 'CLIENTE', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (120, 120, 'hashed_password_12', 'VETERINARIO', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (130, 130, 'hashed_password_13', 'VETERINARIO', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (140, 140, 'hashed_password_14', 'VETERINARIO', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (150, 150, 'hashed_password_15', 'VETERINARIO', '1', '1');
INSERT INTO usuario (id, persona_id, clave_hash, rol, activo, verificado) VALUES (160, 160, 'hashed_password_16', 'VETERINARIO', '1', '1');

-- Inserción de datos en la tabla `veterinario`
INSERT INTO veterinario (id, persona_id, nro_licencia, anios_experiencia, biografia) VALUES (10, 120, 'LIC-VET-001', 5, 'Especialista en mascotas exóticas y cirugía menor.');
INSERT INTO veterinario (id, persona_id, nro_licencia, anios_experiencia, biografia) VALUES (20, 130, 'LIC-VET-002', 8, 'Experiencia en medicina felina y canina. Me apasiona la salud animal.');
INSERT INTO veterinario (id, persona_id, nro_licencia, anios_experiencia, biografia) VALUES (30, 140, 'LIC-VET-003', 12, 'Amplia trayectoria en el campo de la dermatología veterinaria.');
INSERT INTO veterinario (id, persona_id, nro_licencia, anios_experiencia, biografia) VALUES (40, 150, 'LIC-VET-004', 3, 'Joven profesional con enfoque en nutrición y cuidados preventivos.');
INSERT INTO veterinario (id, persona_id, nro_licencia, anios_experiencia, biografia) VALUES (50, 160, 'LIC-VET-005', 10, 'Generalista con gran habilidad en diagnósticos complejos.');

-- Inserción de datos en la tabla `especializacion`
INSERT INTO especializacion (id, nombre, activa) VALUES (10, 'Cirugia', '1');
INSERT INTO especializacion (id, nombre, activa) VALUES (20, 'Dermatologia', '1');
INSERT INTO especializacion (id, nombre, activa) VALUES (30, 'Odontologia', '1');
INSERT INTO especializacion (id, nombre, activa) VALUES (40, 'Cardiologia', '1');
INSERT INTO especializacion (id, nombre, activa) VALUES (50, 'Oftalmologia', '1');
INSERT INTO especializacion (id, nombre, activa) VALUES (60, 'Medicina Interna', '1');
INSERT INTO especializacion (id, nombre, activa) VALUES (70, 'Urgencias', '1');
INSERT INTO especializacion (id, nombre, activa) VALUES (80, 'Nutricion', '1');
INSERT INTO especializacion (id, nombre, activa) VALUES (90, 'Oncologia', '1');
INSERT INTO especializacion (id, nombre, activa) VALUES (100, 'Exoticos', '1');

-- Inserción de datos en la tabla `veterinario_especializacion`
INSERT INTO veterinario_especializacion (veterinario_id, especializacion_id) VALUES (10, 10);
INSERT INTO veterinario_especializacion (veterinario_id, especializacion_id) VALUES (10, 100);
INSERT INTO veterinario_especializacion (veterinario_id, especializacion_id) VALUES (20, 20);
INSERT INTO veterinario_especializacion (veterinario_id, especializacion_id) VALUES (30, 30);
INSERT INTO veterinario_especializacion (veterinario_id, especializacion_id) VALUES (40, 80);
INSERT INTO veterinario_especializacion (veterinario_id, especializacion_id) VALUES (50, 60);

-- Inserción de datos en la tabla `especie`
INSERT INTO especie (id, nombre) VALUES (10, 'Perro');
INSERT INTO especie (id, nombre) VALUES (20, 'Gato');
INSERT INTO especie (id, nombre) VALUES (30, 'Conejo');
INSERT INTO especie (id, nombre) VALUES (40, 'Hamster');
INSERT INTO especie (id, nombre) VALUES (50, 'Pez');

-- Inserción de datos en la tabla `raza`
INSERT INTO raza (id, especie_id, nombre) VALUES (10, 10, 'Labrador Retriever');
INSERT INTO raza (id, especie_id, nombre) VALUES (20, 10, 'Bulldog Frances');
INSERT INTO raza (id, especie_id, nombre) VALUES (30, 10, 'Pastor Aleman');
INSERT INTO raza (id, especie_id, nombre) VALUES (40, 20, 'Siames');
INSERT INTO raza (id, especie_id, nombre) VALUES (50, 20, 'Persa');

-- Inserción de datos en la tabla `mascota`
INSERT INTO mascota (id, dueno_id, nombre, especie_id, raza_id, fecha_nacimiento, genero, esterilizado, url_foto) VALUES (10, 20, 'Max', 10, 10, TO_DATE('2020-05-15', 'YYYY-MM-DD'), 'MACHO', '1', 'http://example.com/mascota1.jpg');
INSERT INTO mascota (id, dueno_id, nombre, especie_id, raza_id, fecha_nacimiento, genero, esterilizado, url_foto) VALUES (20, 30, 'Luna', 20, 40, TO_DATE('2021-03-20', 'YYYY-MM-DD'), 'HEMBRA', '1', 'http://example.com/mascota2.jpg');
INSERT INTO mascota (id, dueno_id, nombre, especie_id, raza_id, fecha_nacimiento, genero, esterilizado, url_foto) VALUES (30, 40, 'Rocky', 10, 20, TO_DATE('2019-11-10', 'YYYY-MM-DD'), 'MACHO', '0', 'http://example.com/mascota3.jpg');
INSERT INTO mascota (id, dueno_id, nombre, especie_id, raza_id, fecha_nacimiento, genero, esterilizado, url_foto) VALUES (40, 50, 'Milo', 20, 50, TO_DATE('2022-08-01', 'YYYY-MM-DD'), 'MACHO', '1', 'http://example.com/mascota4.jpg');
INSERT INTO mascota (id, dueno_id, nombre, especie_id, raza_id, fecha_nacimiento, genero, esterilizado, url_foto) VALUES (50, 60, 'Daisy', 10, 30, TO_DATE('2018-02-25', 'YYYY-MM-DD'), 'HEMBRA', '1', 'http://example.com/mascota5.jpg');

-- Inserción de datos en la tabla `cita`
INSERT INTO cita (id, mascota_id, veterinario_id, fecha_hora, estado, notas) VALUES (10, 10, 10, TO_TIMESTAMP('2024-09-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETADA', 'Control de rutina y vacunación.');
INSERT INTO cita (id, mascota_id, veterinario_id, fecha_hora, estado, notas) VALUES (20, 20, 20, TO_TIMESTAMP('2024-09-16 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'PENDIENTE', 'Revisión de alergias en la piel.');
INSERT INTO cita (id, mascota_id, veterinario_id, fecha_hora, estado, notas) VALUES (30, 30, 30, TO_TIMESTAMP('2024-09-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETADA', 'Limpieza dental.');
INSERT INTO cita (id, mascota_id, veterinario_id, fecha_hora, estado, notas) VALUES (40, 40, 40, TO_TIMESTAMP('2024-09-18 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'PENDIENTE', 'Vacunación anual.');
INSERT INTO cita (id, mascota_id, veterinario_id, fecha_hora, estado, notas) VALUES (50, 50, 50, TO_TIMESTAMP('2024-09-19 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'COMPLETADA', 'Consulta por vómitos.');

-- Inserción de datos en la tabla `historial_medico`
INSERT INTO historial_medico (id, mascota_id, veterinario_id, cita_id, diagnostico, tratamiento, recomendaciones, proxima_visita) VALUES (10, 10, 10, 10, 'Control de peso satisfactorio. Vacunas al día.', 'No requiere tratamiento.', 'Mantener dieta y ejercicio regular.', TO_DATE('2025-09-15', 'YYYY-MM-DD'));
INSERT INTO historial_medico (id, mascota_id, veterinario_id, cita_id, diagnostico, tratamiento, recomendaciones, proxima_visita) VALUES (20, 30, 30, 30, 'Sarcoma dental leve. Procedimiento de limpieza exitoso.', 'Limpieza dental con ultrasonido.', 'Cepillado dental diario y revisión anual.', TO_DATE('2025-09-17', 'YYYY-MM-DD'));
INSERT INTO historial_medico (id, mascota_id, veterinario_id, cita_id, diagnostico, tratamiento, recomendaciones, proxima_visita) VALUES (30, 50, 50, 50, 'Indigestión leve, posible causa alimenticia.', 'Dieta blanda por 48 horas y medicamento para el estómago.', 'Evitar darle comida de humano. Probar con nuevo alimento para ver si mejora.', TO_DATE('2024-10-19', 'YYYY-MM-DD'));

-- Inserción de datos en la tabla `medicamento`
INSERT INTO medicamento (id, nombre, principio_activo, forma) VALUES (10, 'Amoxicilina', 'Amoxicilina', 'Tableta');
INSERT INTO medicamento (id, nombre, principio_activo, forma) VALUES (20, 'Metronidazol', 'Metronidazol', 'Solucion oral');
INSERT INTO medicamento (id, nombre, principio_activo, forma) VALUES (30, 'Prednisolona', 'Prednisolona', 'Tableta');
INSERT INTO medicamento (id, nombre, principio_activo, forma) VALUES (40, 'Flebocortid', 'Hidrocortisona', 'Inyectable');
INSERT INTO medicamento (id, nombre, principio_activo, forma) VALUES (50, 'Ivermectina', 'Ivermectina', 'Solucion oral');

-- Inserción de datos en la tabla `receta`
INSERT INTO receta (id, historial_id, medicamento_id, dosis, frecuencia, duracion) VALUES (10, 10, 10, '500 mg', 'Cada 8 horas', '7 dias');
INSERT INTO receta (id, historial_id, medicamento_id, dosis, frecuencia, duracion) VALUES (20, 20, 20, '250 mg', 'Cada 12 horas', '10 dias');
INSERT INTO receta (id, historial_id, medicamento_id, dosis, frecuencia, duracion) VALUES (30, 30, 30, '5 mg', 'Cada 24 horas', '14 dias');

-- Inserción de datos en la tabla `servicio`
INSERT INTO servicio (id, nombre, descripcion, precio_base) VALUES (10, 'Consulta General', 'Evaluacion de la salud general y control de rutina.', 25000.00);
INSERT INTO servicio (id, nombre, descripcion, precio_base) VALUES (20, 'Vacunacion', 'Aplicacion de vacunas obligatorias y de refuerzo.', 15000.00);
INSERT INTO servicio (id, nombre, descripcion, precio_base) VALUES (30, 'Cirugia Menor', 'Procedimientos quirurgicos de baja complejidad, como castracion.', 80000.00);
INSERT INTO servicio (id, nombre, descripcion, precio_base) VALUES (40, 'Limpieza Dental', 'Procedimiento para eliminar el sarro y prevenir enfermedades periodontales.', 45000.00);
INSERT INTO servicio (id, nombre, descripcion, precio_base) VALUES (50, 'Desparasitacion', 'Tratamiento para eliminar parasitos internos y externos.', 10000.00);

-- Inserción de datos en la tabla `veterinario_servicio`
INSERT INTO veterinario_servicio (id, veterinario_id, servicio_id) VALUES (10, 10, 10);
INSERT INTO veterinario_servicio (id, veterinario_id, servicio_id) VALUES (20, 20, 20);
INSERT INTO veterinario_servicio (id, veterinario_id, servicio_id) VALUES (30, 30, 30);
INSERT INTO veterinario_servicio (id, veterinario_id, servicio_id) VALUES (40, 40, 40);
INSERT INTO veterinario_servicio (id, veterinario_id, servicio_id) VALUES (50, 50, 50);

-- Inserción de datos en la tabla `calificacion`
INSERT INTO calificacion (id, cita_id, usuario_id, veterinario_id, puntuacion, comentario) VALUES (10, 10, 20, 10, 5, 'Excelente atencion, muy profesional.');
INSERT INTO calificacion (id, cita_id, usuario_id, veterinario_id, puntuacion, comentario) VALUES (20, 30, 40, 30, 4, 'Buen servicio, explicaron todo el procedimiento.');
INSERT INTO calificacion (id, cita_id, usuario_id, veterinario_id, puntuacion, comentario) VALUES (30, 50, 60, 50, 5, 'Muy atento y claro en el diagnostico.');

-- Inserción de datos en la tabla `pago`
INSERT INTO pago (id, cita_id, monto, moneda, estado, metodo) VALUES (10, 10, 25000.00, 'CLP', 'COMPLETADO', 'TARJETA');
INSERT INTO pago (id, cita_id, monto, moneda, estado, metodo) VALUES (20, 30, 45000.00, 'CLP', 'COMPLETADO', 'TRANSFERENCIA');
INSERT INTO pago (id, cita_id, monto, moneda, estado, metodo) VALUES (30, 50, 25000.00, 'CLP', 'COMPLETADO', 'TARJETA');

-- Inserción de datos en la tabla `notificacion`
INSERT INTO notificacion (id, usuario_id, evento_tipo, canal, destinatario, contenido, estado) VALUES (10, 20, 'CITA_CREADA', 'EMAIL', 'juan.perez@example.com', 'Su cita para Max ha sido agendada.', 'ENVIADA');
INSERT INTO notificacion (id, usuario_id, evento_tipo, canal, destinatario, contenido, estado) VALUES (20, 40, 'CITA_RECORDATORIO', 'SMS', '1234567892', 'Recordatorio de cita para Rocky mañana.', 'ENVIADA');
INSERT INTO notificacion (id, usuario_id, evento_tipo, canal, destinatario, contenido, estado) VALUES (30, 60, 'PAGO_COMPLETADO', 'PUSH', 'null', 'Su pago para la cita de Daisy ha sido procesado.', 'ENVIADA');

-- Inserción de datos en la tabla `cita_servicio`
INSERT INTO cita_servicio (id, cita_id, veterinario_servicio_id) VALUES (seq_cita_servicio.NEXTVAL, 20, 30);