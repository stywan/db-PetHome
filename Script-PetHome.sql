-- Información personal base
CREATE TABLE persona (
    id              RAW(16) PRIMARY KEY,
    nombres         VARCHAR2(100) NOT NULL,
    apellidos       VARCHAR2(100) NOT NULL,
    correo          VARCHAR2(150) UNIQUE,
    telefono        VARCHAR2(30),
    url_foto        VARCHAR2(255),
    creado_en       TIMESTAMP DEFAULT SYSTIMESTAMP,
    actualizado_en  TIMESTAMP
);

-- Cuentas de usuario con autenticación
CREATE TABLE usuario (
    id              RAW(16) PRIMARY KEY,
    persona_id      RAW(16) UNIQUE NOT NULL,
    clave_hash      VARCHAR2(255) NOT NULL,
    rol             VARCHAR2(30) CHECK (rol IN ('ADMIN','CLIENTE','VETERINARIO')),
    activo          CHAR(1) DEFAULT '1' CHECK (activo IN ('0','1')),
    verificado      CHAR(1) DEFAULT '0' CHECK (verificado IN ('0','1')),
    CONSTRAINT fk_usuario_persona FOREIGN KEY (persona_id) REFERENCES persona(id)
);

-------------------------------------------------------------------------------------------

-- Información específica de veterinarios (ANALIZAR SI ES NECESARIO EL DATO DE APROBADO)
CREATE TABLE veterinario (
    id                  RAW(16) PRIMARY KEY,
    persona_id          RAW(16) UNIQUE NOT NULL,
    nro_licencia        VARCHAR2(50) UNIQUE NOT NULL,
    anios_experiencia   NUMBER,
    biografia           CLOB,
    --aprobado            CHAR(1) DEFAULT '0' CHECK (aprobado IN ('0','1')),
    --aprobado_por        RAW(16),
    --aprobado_en         TIMESTAMP,
    CONSTRAINT fk_vet_persona FOREIGN KEY (persona_id) REFERENCES persona(id)
    --CONSTRAINT fk_vet_aprobador FOREIGN KEY (aprobado_por) REFERENCES usuario(id)
);

-- Catálogo de especializaciones
CREATE TABLE especializacion (
    id          RAW(16) PRIMARY KEY,
    nombre      VARCHAR2(100) UNIQUE NOT NULL,
    activa      CHAR(1) DEFAULT '1' CHECK (activa IN ('0','1'))
);

-- Relación muchos a muchos: veterinario - especializaciones
CREATE TABLE veterinario_especializacion (
    veterinario_id      RAW(16) NOT NULL,
    especializacion_id  RAW(16) NOT NULL,
    PRIMARY KEY (veterinario_id, especializacion_id),
    CONSTRAINT fk_ve_vet FOREIGN KEY (veterinario_id) REFERENCES veterinario(id),
    CONSTRAINT fk_ve_esp FOREIGN KEY (especializacion_id) REFERENCES especializacion(id)
);

-------------------------------------------------------------------------------------------


-- Catálogo de especies
CREATE TABLE especie (
    id      RAW(16) PRIMARY KEY,
    nombre  VARCHAR2(100) UNIQUE NOT NULL
);

-- Razas por especie
CREATE TABLE raza (
    id          RAW(16) PRIMARY KEY,
    especie_id  RAW(16) NOT NULL,
    nombre      VARCHAR2(100) NOT NULL,
    CONSTRAINT fk_raza_especie FOREIGN KEY (especie_id) REFERENCES especie(id),
    CONSTRAINT uk_raza_especie UNIQUE (especie_id, nombre)
);

-- Registro de mascotas
CREATE TABLE mascota (
    id                  RAW(16) PRIMARY KEY,
    dueno_id            RAW(16) NOT NULL,
    nombre              VARCHAR2(100) NOT NULL,
    especie_id          RAW(16) NOT NULL,
    raza_id             RAW(16),
    fecha_nacimiento    DATE,
    genero              VARCHAR2(15) CHECK (genero IN ('MACHO','HEMBRA','DESCONOCIDO')),
    esterilizado        CHAR(1) CHECK (esterilizado IN ('0','1')),
    url_foto            VARCHAR2(255),
    creado_en           TIMESTAMP DEFAULT SYSTIMESTAMP,
    actualizado_en      TIMESTAMP,
    CONSTRAINT fk_mascota_dueno FOREIGN KEY (dueno_id) REFERENCES usuario(id),
    CONSTRAINT fk_mascota_especie FOREIGN KEY (especie_id) REFERENCES especie(id),
    CONSTRAINT fk_mascota_raza FOREIGN KEY (raza_id) REFERENCES raza(id)
);

-------------------------------------------------------------------------------------------


-- Catálogo de medicamentos
CREATE TABLE medicamento (
    id                  RAW(16) PRIMARY KEY,
    nombre              VARCHAR2(150) UNIQUE NOT NULL,
    principio_activo    VARCHAR2(150),
    forma               VARCHAR2(50) -- tableta, jarabe, inyección, etc.
);

-- Medicamentos crónicos/permanentes por mascota
CREATE TABLE mascota_medicamento (
    id              RAW(16) PRIMARY KEY,
    mascota_id      RAW(16) NOT NULL,
    medicamento_id  RAW(16) NOT NULL,
    dosis           VARCHAR2(100),
    frecuencia      VARCHAR2(100),
    fecha_inicio    DATE,
    fecha_fin       DATE,
    CONSTRAINT fk_mm_mascota FOREIGN KEY (mascota_id) REFERENCES mascota(id),
    CONSTRAINT fk_mm_medicamento FOREIGN KEY (medicamento_id) REFERENCES medicamento(id)
);

-------------------------------------------------------------------------------------------


-- Catálogo general de servicios
CREATE TABLE servicio (
    id          RAW(16) PRIMARY KEY,
    nombre      VARCHAR2(100) NOT NULL,
    descripcion CLOB,
    precio_base NUMBER(18,2) NOT NULL
);

-- Servicios y precios personalizados por veterinario
CREATE TABLE veterinario_servicio (
    id                  RAW(16) PRIMARY KEY,
    veterinario_id      RAW(16) NOT NULL,
    servicio_id         RAW(16) NOT NULL,
    CONSTRAINT fk_vs_vet FOREIGN KEY (veterinario_id) REFERENCES veterinario(id),
    CONSTRAINT fk_vs_serv FOREIGN KEY (servicio_id) REFERENCES servicio(id)
);

--------------------------------------------------------------------------------------

-- Citas principales
CREATE TABLE cita (
    id              RAW(16) PRIMARY KEY,
    mascota_id      RAW(16) NOT NULL,
    veterinario_id  RAW(16) NOT NULL,
    fecha_hora      TIMESTAMP NOT NULL,
    estado          VARCHAR2(20) DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE','CONFIRMADA','CANCELADA','COMPLETADA')),
    notas           CLOB,
    CONSTRAINT fk_cita_mascota FOREIGN KEY (mascota_id) REFERENCES mascota(id),
    CONSTRAINT fk_cita_vet FOREIGN KEY (veterinario_id) REFERENCES veterinario(id)
);

-- Servicios incluidos en cada cita
CREATE TABLE cita_servicio (
    id                      RAW(16) PRIMARY KEY,
    cita_id                 RAW(16) NOT NULL,
    veterinario_servicio_id RAW(16) NOT NULL,
    CONSTRAINT fk_cs_cita FOREIGN KEY (cita_id) REFERENCES cita(id),
    CONSTRAINT fk_cs_vs FOREIGN KEY (veterinario_servicio_id) REFERENCES veterinario_servicio(id)
);


-----------------------------------------------------------------------------------------------

-- Registros médicos por consulta
CREATE TABLE historial_medico (
    id              RAW(16) PRIMARY KEY,
    mascota_id      RAW(16) NOT NULL,
    veterinario_id  RAW(16) NOT NULL,
    cita_id         RAW(16) NOT NULL,
    diagnostico     CLOB,
    tratamiento     CLOB,
    recomendaciones CLOB,
    proxima_visita  DATE,
    CONSTRAINT fk_hm_mascota FOREIGN KEY (mascota_id) REFERENCES mascota(id),
    CONSTRAINT fk_hm_vet FOREIGN KEY (veterinario_id) REFERENCES veterinario(id),
    CONSTRAINT fk_hm_cita FOREIGN KEY (cita_id) REFERENCES cita(id)
);

-- Medicamentos recetados en consultas específicas
CREATE TABLE receta (
    id              RAW(16) PRIMARY KEY,
    historial_id    RAW(16) NOT NULL,
    medicamento_id  RAW(16) NOT NULL,
    dosis           VARCHAR2(100),
    frecuencia      VARCHAR2(100),
    duracion        VARCHAR2(100),
    CONSTRAINT fk_receta_hm FOREIGN KEY (historial_id) REFERENCES historial_medico(id),
    CONSTRAINT fk_receta_medic FOREIGN KEY (medicamento_id) REFERENCES medicamento(id)
);

---------------------------------------------------------------------------------------

-- Sistema de calificaciones
CREATE TABLE calificacion (
    id              RAW(16) PRIMARY KEY,
    cita_id         RAW(16) NOT NULL,
    usuario_id      RAW(16) NOT NULL,
    veterinario_id  RAW(16) NOT NULL,
    puntuacion      NUMBER(1) CHECK (puntuacion BETWEEN 1 AND 5),
    comentario      VARCHAR2(100),
    creada_en       TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT fk_cal_cita FOREIGN KEY (cita_id) REFERENCES cita(id),
    CONSTRAINT fk_cal_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    CONSTRAINT fk_cal_vet FOREIGN KEY (veterinario_id) REFERENCES veterinario(id)
);

---------------------------------------------------------------------------------------

-- Pagos por cita
CREATE TABLE pago (
    id          RAW(16) PRIMARY KEY,
    cita_id     RAW(16) NOT NULL,
    monto       NUMBER(18,2) NOT NULL,
    moneda      VARCHAR2(10) DEFAULT 'CLP',
    estado      VARCHAR2(20) DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE','COMPLETADO','FALLIDO')),
    metodo      VARCHAR2(30) CHECK (metodo IN ('TARJETA','TRANSFERENCIA','EFECTIVO')),
    creado_en   TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT fk_pago_cita FOREIGN KEY (cita_id) REFERENCES cita(id)
);

--------------------------------------------------------------------------------------------------------


-- Notificaciones unificadas PEDIENTE DE APROVACION

CREATE TABLE notificacion (
    id              RAW(16) PRIMARY KEY,
    usuario_id      RAW(16) NOT NULL,
    evento_tipo     VARCHAR2(50), -- 'appointment.confirmed', 'payment.completed'
    canal           VARCHAR2(20) CHECK (canal IN ('EMAIL','SMS','PUSH')),
    destinatario    VARCHAR2(200), -- email o teléfono
    contenido       CLOB, -- JSON completo con el mensaje
    estado          VARCHAR2(20) DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE','ENVIADA','FALLIDA')),
    creada_en       TIMESTAMP DEFAULT SYSTIMESTAMP
);

-----------------------------------------------------------------------------------------

-- Índices para búsquedas frecuentes
CREATE INDEX idx_usuario_correo ON persona(correo);
CREATE INDEX idx_mascota_dueno ON mascota(dueno_id);
CREATE INDEX idx_cita_fecha ON cita(fecha_hora);
CREATE INDEX idx_cita_estado ON cita(estado);
CREATE INDEX idx_cita_veterinario ON cita(veterinario_id);
CREATE INDEX idx_historial_mascota ON historial_medico(mascota_id);
CREATE INDEX idx_historial_fecha ON historial_medico(cita_id);
CREATE INDEX idx_notif_usuario ON notificacion(usuario_id);
CREATE INDEX idx_notif_estado ON notificacion(estado);
CREATE INDEX idx_calificacion_vet ON calificacion(veterinario_id);
CREATE INDEX idx_pago_estado ON pago(estado);