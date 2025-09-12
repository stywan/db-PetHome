-- Información personal base
CREATE TABLE persona (
    id              NUMBER PRIMARY KEY,
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
    id              NUMBER PRIMARY KEY,
    persona_id      NUMBER UNIQUE NOT NULL,
    clave_hash      VARCHAR2(255) NOT NULL,
    rol             VARCHAR2(30),
    activo          CHAR(1) DEFAULT '1',
    verificado      CHAR(1) DEFAULT '0'
);

-- Información específica de veterinarios
CREATE TABLE veterinario (
    id                  NUMBER PRIMARY KEY,
    persona_id          NUMBER UNIQUE NOT NULL,
    nro_licencia        VARCHAR2(50) UNIQUE NOT NULL,
    anios_experiencia   NUMBER,
    biografia           CLOB
);

-- Catálogo de especializaciones
CREATE TABLE especializacion (
    id          NUMBER PRIMARY KEY,
    nombre      VARCHAR2(100) UNIQUE NOT NULL,
    activa      CHAR(1) DEFAULT '1'
);

-- Relación muchos a muchos: veterinario - especializaciones
CREATE TABLE veterinario_especializacion (
    veterinario_id      NUMBER NOT NULL,
    especializacion_id  NUMBER NOT NULL,
    PRIMARY KEY (veterinario_id, especializacion_id)
);

-- Catálogo de especies
CREATE TABLE especie (
    id      NUMBER PRIMARY KEY,
    nombre  VARCHAR2(100) UNIQUE NOT NULL
);

-- Razas por especie
CREATE TABLE raza (
    id          NUMBER PRIMARY KEY,
    especie_id  NUMBER NOT NULL,
    nombre      VARCHAR2(100) NOT NULL
);

-- Registro de mascotas
CREATE TABLE mascota (
    id                  NUMBER PRIMARY KEY,
    dueno_id            NUMBER NOT NULL,
    nombre              VARCHAR2(100) NOT NULL,
    especie_id          NUMBER NOT NULL,
    raza_id             NUMBER,
    fecha_nacimiento    DATE,
    genero              VARCHAR2(15),
    esterilizado        CHAR(1),
    url_foto            VARCHAR2(255),
    creado_en           TIMESTAMP DEFAULT SYSTIMESTAMP,
    actualizado_en      TIMESTAMP
);

-- Catálogo de medicamentos
CREATE TABLE medicamento (
    id                  NUMBER PRIMARY KEY,
    nombre              VARCHAR2(150) UNIQUE NOT NULL,
    principio_activo    VARCHAR2(150),
    forma               VARCHAR2(50)
);

-- Medicamentos crónicos/permanentes por mascota
CREATE TABLE mascota_medicamento (
    id              NUMBER PRIMARY KEY,
    mascota_id      NUMBER NOT NULL,
    medicamento_id  NUMBER NOT NULL,
    dosis           VARCHAR2(100),
    frecuencia      VARCHAR2(100),
    fecha_inicio    DATE,
    fecha_fin       DATE
);

-- Catálogo general de servicios
CREATE TABLE servicio (
    id          NUMBER PRIMARY KEY,
    nombre      VARCHAR2(100) NOT NULL,
    descripcion CLOB,
    precio_base NUMBER(18,2) NOT NULL
);

-- Servicios y precios personalizados por veterinario
CREATE TABLE veterinario_servicio (
    id                  NUMBER PRIMARY KEY,
    veterinario_id      NUMBER NOT NULL,
    servicio_id         NUMBER NOT NULL
);

-- Citas principales
CREATE TABLE cita (
    id              NUMBER PRIMARY KEY,
    mascota_id      NUMBER NOT NULL,
    veterinario_id  NUMBER NOT NULL,
    fecha_hora      TIMESTAMP NOT NULL,
    estado          VARCHAR2(20) DEFAULT 'PENDIENTE',
    notas           CLOB
);

-- Servicios incluidos en cada cita
CREATE TABLE cita_servicio (
    id                      NUMBER PRIMARY KEY,
    cita_id                 NUMBER NOT NULL,
    veterinario_servicio_id NUMBER NOT NULL
);

-- Registros médicos por consulta
CREATE TABLE historial_medico (
    id              NUMBER PRIMARY KEY,
    mascota_id      NUMBER NOT NULL,
    veterinario_id  NUMBER NOT NULL,
    cita_id         NUMBER NOT NULL,
    diagnostico     CLOB,
    tratamiento     CLOB,
    recomendaciones CLOB,
    proxima_visita  DATE
);

-- Medicamentos recetados en consultas específicas
CREATE TABLE receta (
    id              NUMBER PRIMARY KEY,
    historial_id    NUMBER NOT NULL,
    medicamento_id  NUMBER NOT NULL,
    dosis           VARCHAR2(100),
    frecuencia      VARCHAR2(100),
    duracion        VARCHAR2(100)
);

-- Sistema de calificaciones
CREATE TABLE calificacion (
    id              NUMBER PRIMARY KEY,
    cita_id         NUMBER NOT NULL,
    usuario_id      NUMBER NOT NULL,
    veterinario_id  NUMBER NOT NULL,
    puntuacion      NUMBER(1),
    comentario      VARCHAR2(100),
    creada_en       TIMESTAMP DEFAULT SYSTIMESTAMP
);

-- Pagos por cita
CREATE TABLE pago (
    id          NUMBER PRIMARY KEY,
    cita_id     NUMBER NOT NULL,
    monto       NUMBER(18,2) NOT NULL,
    moneda      VARCHAR2(10) DEFAULT 'CLP',
    estado      VARCHAR2(20) DEFAULT 'PENDIENTE',
    metodo      VARCHAR2(30),
    creado_en   TIMESTAMP DEFAULT SYSTIMESTAMP
);

-- Notificaciones unificadas
CREATE TABLE notificacion (
    id              NUMBER PRIMARY KEY,
    usuario_id      NUMBER NOT NULL,
    evento_tipo     VARCHAR2(50),
    canal           VARCHAR2(20),
    destinatario    VARCHAR2(200),
    contenido       CLOB,
    estado          VARCHAR2(20) DEFAULT 'PENDIENTE',
    creada_en       TIMESTAMP DEFAULT SYSTIMESTAMP
);


CREATE TABLE auditoria_pagos (
    id             NUMBER PRIMARY KEY,
    pago_id        NUMBER NOT NULL,
    fecha_evento   DATE DEFAULT SYSDATE,
    descripcion    VARCHAR2(500),
    usuario_evento VARCHAR2(100)
);