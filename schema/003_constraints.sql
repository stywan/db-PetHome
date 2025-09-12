-- Restricciones de la tabla usuario
ALTER TABLE usuario ADD CONSTRAINT fk_usuario_persona FOREIGN KEY (persona_id) REFERENCES persona(id);
ALTER TABLE usuario ADD CONSTRAINT chk_usuario_rol CHECK (rol IN ('ADMIN','CLIENTE','VETERINARIO'));
ALTER TABLE usuario ADD CONSTRAINT chk_usuario_activo CHECK (activo IN ('0','1'));
ALTER TABLE usuario ADD CONSTRAINT chk_usuario_verificado CHECK (verificado IN ('0','1'));


-- Restricciones de la tabla veterinario
ALTER TABLE veterinario ADD CONSTRAINT fk_vet_persona FOREIGN KEY (persona_id) REFERENCES persona(id);


-- Restricciones de la tabla veterinario_especializacion
ALTER TABLE veterinario_especializacion ADD CONSTRAINT fk_ve_vet FOREIGN KEY (veterinario_id) REFERENCES veterinario(id);
ALTER TABLE veterinario_especializacion ADD CONSTRAINT fk_ve_esp FOREIGN KEY (especializacion_id) REFERENCES especializacion(id);


-- Restricciones de la tabla especializacion
ALTER TABLE especializacion ADD CONSTRAINT chk_espec_activa CHECK (activa IN ('0','1'));


-- Restricciones de la tabla raza
ALTER TABLE raza ADD CONSTRAINT fk_raza_especie FOREIGN KEY (especie_id) REFERENCES especie(id);
ALTER TABLE raza ADD CONSTRAINT uk_raza_especie UNIQUE (especie_id, nombre);


-- Restricciones de la tabla mascota
ALTER TABLE mascota ADD CONSTRAINT fk_mascota_dueno FOREIGN KEY (dueno_id) REFERENCES usuario(id);
ALTER TABLE mascota ADD CONSTRAINT fk_mascota_especie FOREIGN KEY (especie_id) REFERENCES especie(id);
ALTER TABLE mascota ADD CONSTRAINT fk_mascota_raza FOREIGN KEY (raza_id) REFERENCES raza(id);
ALTER TABLE mascota ADD CONSTRAINT chk_mascota_genero CHECK (genero IN ('MACHO','HEMBRA','DESCONOCIDO'));
ALTER TABLE mascota ADD CONSTRAINT chk_mascota_esterilizado CHECK (esterilizado IN ('0','1'));


-- Restricciones de la tabla mascota_medicamento
ALTER TABLE mascota_medicamento ADD CONSTRAINT fk_mm_mascota FOREIGN KEY (mascota_id) REFERENCES mascota(id);
ALTER TABLE mascota_medicamento ADD CONSTRAINT fk_mm_medicamento FOREIGN KEY (medicamento_id) REFERENCES medicamento(id);


-- Restricciones de la tabla veterinario_servicio
ALTER TABLE veterinario_servicio ADD CONSTRAINT fk_vs_vet FOREIGN KEY (veterinario_id) REFERENCES veterinario(id);
ALTER TABLE veterinario_servicio ADD CONSTRAINT fk_vs_serv FOREIGN KEY (servicio_id) REFERENCES servicio(id);
ALTER TABLE veterinario_servicio ADD CONSTRAINT uk_vs_duplicado UNIQUE (veterinario_id, servicio_id);

-- Restricciones de la tabla cita
ALTER TABLE cita ADD CONSTRAINT fk_cita_mascota FOREIGN KEY (mascota_id) REFERENCES mascota(id);
ALTER TABLE cita ADD CONSTRAINT fk_cita_vet FOREIGN KEY (veterinario_id) REFERENCES veterinario(id);
ALTER TABLE cita ADD CONSTRAINT chk_cita_estado CHECK (estado IN ('PENDIENTE','COMPLETADA','CANCELADA'));

-- Restricciones de la tabla cita_servicio
ALTER TABLE cita_servicio ADD CONSTRAINT fk_cs_cita FOREIGN KEY (cita_id) REFERENCES cita(id);
ALTER TABLE cita_servicio ADD CONSTRAINT fk_cs_vs FOREIGN KEY (veterinario_servicio_id) REFERENCES veterinario_servicio(id);
ALTER TABLE cita_servicio ADD CONSTRAINT uk_cs_duplicado UNIQUE (cita_id, veterinario_servicio_id);


-- Restricciones de la tabla historial_medico
ALTER TABLE historial_medico ADD CONSTRAINT fk_hm_mascota FOREIGN KEY (mascota_id) REFERENCES mascota(id);
ALTER TABLE historial_medico ADD CONSTRAINT fk_hm_vet FOREIGN KEY (veterinario_id) REFERENCES veterinario(id);
ALTER TABLE historial_medico ADD CONSTRAINT fk_hm_cita FOREIGN KEY (cita_id) REFERENCES cita(id);


-- Restricciones de la tabla receta
ALTER TABLE receta ADD CONSTRAINT fk_receta_hm FOREIGN KEY (historial_id) REFERENCES historial_medico(id);
ALTER TABLE receta ADD CONSTRAINT fk_receta_medic FOREIGN KEY (medicamento_id) REFERENCES medicamento(id);


-- Restricciones de la tabla calificacion
ALTER TABLE calificacion ADD CONSTRAINT fk_cal_cita FOREIGN KEY (cita_id) REFERENCES cita(id);
ALTER TABLE calificacion ADD CONSTRAINT fk_cal_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);
ALTER TABLE calificacion ADD CONSTRAINT fk_cal_vet FOREIGN KEY (veterinario_id) REFERENCES veterinario(id);
ALTER TABLE calificacion ADD CONSTRAINT chk_cal_puntuacion CHECK (puntuacion BETWEEN 1 AND 5);


-- Restricciones de la tabla pago
ALTER TABLE pago ADD CONSTRAINT fk_pago_cita FOREIGN KEY (cita_id) REFERENCES cita(id);
ALTER TABLE pago ADD CONSTRAINT chk_pago_estado CHECK (estado IN ('PENDIENTE','COMPLETADO','FALLIDO'));
ALTER TABLE pago ADD CONSTRAINT chk_pago_metodo CHECK (metodo IN ('TARJETA','TRANSFERENCIA','EFECTIVO'));


-- Restricciones de la tabla notificacion
ALTER TABLE notificacion ADD CONSTRAINT fk_notificacion_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);
ALTER TABLE notificacion ADD CONSTRAINT chk_notif_canal CHECK (canal IN ('EMAIL','SMS','PUSH'));
ALTER TABLE notificacion ADD CONSTRAINT chk_notif_estado CHECK (estado IN ('PENDIENTE','ENVIADA','FALLIDA'));
