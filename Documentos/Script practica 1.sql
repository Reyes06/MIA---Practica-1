/*
	MANEJO E IMPLEMENTACION DE ARCHIVOS
	ESCUELA DE VACACIONES DE JUNIO
	EDDY ARNOLDO REYES HERNANDEZ
	201612326
*/

/*1*/
CREATE TABLE profesion (
    cod_prof integer not null,
    nombre varchar(50) not null,
    CONSTRAINT pk_profesion PRIMARY KEY (cod_prof),
    CONSTRAINT uk_profesion_nombre UNIQUE (nombre)
);

CREATE TABLE pais (
    cod_pais integer not null,
    nombre varchar(50) not null,
    CONSTRAINT pk_pais PRIMARY KEY (cod_pais),
    CONSTRAINT uk_pais_nombre UNIQUE (nombre)
);

CREATE TABLE puesto (
    cod_puesto integer not null,
    nombre varchar(50) not null,
    CONSTRAINT pk_puesto PRIMARY KEY (cod_puesto),
    CONSTRAINT uk_puesto_nombre UNIQUE (nombre)
);

CREATE TABLE departamento (
    cod_depto integer not null,
    nombre varchar(50) not null,
    CONSTRAINT pk_deptartamento PRIMARY KEY (cod_depto),
    CONSTRAINT uk_departamento_nombre UNIQUE (nombre)
);

CREATE TABLE miembro (
    cod_miembro integer not null,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    edad integer not null,
    telefono integer null,
    residencia varchar(100) null,
    PAIS_cod_pais integer not null,
    PROFESION_cod_prof integer not null,
    CONSTRAINT pk_miembro PRIMARY KEY (cod_miembro),
    CONSTRAINT fk_miembro_pais FOREIGN KEY (PAIS_cod_pais) REFERENCES pais (cod_pais) ON DELETE CASCADE,
    CONSTRAINT fk_miembro_prof FOREIGN KEY (PROFESION_cod_prof) REFERENCES profesion (cod_prof) ON DELETE CASCADE
);

CREATE TABLE puesto_miembro (
    MIEMBRO_cod_miembro integer not null,
    PUESTO_cod_puesto integer not null,
    DEPARTAMENTO_cod_depto integer not null,
    fecha_inicio date not null,
    fecha_fin date null,
    CONSTRAINT pk_puesto_miembro PRIMARY KEY (MIEMBRO_cod_miembro, PUESTO_cod_puesto, DEPARTAMENTO_cod_depto),
    CONSTRAINT fk_puesto_miembro_miembro FOREIGN KEY (MIEMBRO_cod_miembro) REFERENCES miembro (cod_miembro) ON DELETE CASCADE,
    CONSTRAINT fk_puesto_miembro_puesto FOREIGN KEY (PUESTO_cod_puesto) REFERENCES puesto (cod_puesto) ON DELETE CASCADE,
    CONSTRAINT fk_puesto_miembro_depto FOREIGN KEY (DEPARTAMENTO_cod_depto) REFERENCES departamento (cod_depto) ON DELETE CASCADE
);

CREATE TABLE tipo_medalla(
    cod_tipo integer not null,
    medalla varchar(20) not null,
    CONSTRAINT pk_tipo_medalla PRIMARY KEY (cod_tipo),
    CONSTRAINT uk_tipo_medalla_medalla UNIQUE (medalla)
);

CREATE TABLE medallero(
    pais_cod_pais integer not null,
    cantidad_medallas integer not null,
    TIPO_MEDALLA_cod_tipo integer not null,
    CONSTRAINT pk_medallero PRIMARY KEY (pais_cod_pais, TIPO_MEDALLA_cod_tipo),
    CONSTRAINT fk_medallero_pais FOREIGN KEY (pais_cod_pais) REFERENCES pais (cod_pais) ON DELETE CASCADE,
    CONSTRAINT fk_medallero_tipo_medalla FOREIGN KEY (tipo_medalla_cod_tipo) REFERENCES tipo_medalla (cod_tipo) ON DELETE CASCADE
);

CREATE TABLE disciplina (
    cod_disciplina integer not null,
    nombre varchar(50) not null,
    descripcion varchar(150) null,
    CONSTRAINT pk_disciplina PRIMARY KEY (cod_disciplina)
);

CREATE TABLE atleta(
    cod_atleta integer not null,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    edad integer not null,
    participaciones varchar(100),
    DISCIPLINA_cod_disciplina integer not null,
    PAIS_cod_pais integer not null,
    CONSTRAINT pk_atleta PRIMARY KEY (cod_atleta),
    CONSTRAINT fk_atleta_disciplina FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES disciplina (cod_disciplina) ON DELETE CASCADE,
    CONSTRAINT fk_atleta_pais FOREIGN KEY (PAIS_cod_pais) REFERENCES pais (cod_pais) ON DELETE CASCADE
);

CREATE TABLE categoria(
    cod_categoria integer not null,
    categoria varchar(50) not null,
    CONSTRAINT pk_categoria PRIMARY KEY (cod_categoria)
);

CREATE TABLE tipo_participacion(
    cod_participacion integer not null,
    tipo_participacion varchar(100) not null,
    CONSTRAINT pk_tipo_participacion PRIMARY KEY (cod_participacion)
);

CREATE TABLE evento(
    cod_evento integer not null,
    fecha date not null,
    ubicacion varchar(50) not null,
    hora date not null,
    DISCIPLINA_cod_disciplina integer not null,
    TIPO_PARTICIPACION_cod_participacion integer not null,
    CATEGORIA_cod_categoria integer not null,
    CONSTRAINT pk_evento PRIMARY KEY (cod_evento),
    CONSTRAINT fk_evento_disciplina FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES disciplina (cod_disciplina) ON DELETE CASCADE,
    CONSTRAINT fk_evento_tipo_participacion FOREIGN KEY (TIPO_PARTICIPACION_cod_participacion) REFERENCES tipo_participacion (cod_participacion) ON DELETE CASCADE,
    CONSTRAINT fk_evento_categoria FOREIGN KEY (CATEGORIA_cod_categoria) REFERENCES categoria (cod_categoria) ON DELETE CASCADE
);

CREATE TABLE evento_atleta(
    atleta_cod_atleta integer not null,
    evento_cod_evento integer not null,
    CONSTRAINT pk_evento_atleta PRIMARY KEY (atleta_cod_atleta, evento_cod_evento),
    CONSTRAINT fk_evento_atleta_atleta FOREIGN KEY (atleta_cod_atleta) REFERENCES atleta (cod_atleta) ON DELETE CASCADE,
    CONSTRAINT fk_evento_atleta_evento FOREIGN KEY (evento_Cod_evento) REFERENCES evento (cod_evento) ON DELETE CASCADE
);

CREATE TABLE televisora(
    cod_televisora integer not null,
    nombre varchar(50) not null,
    CONSTRAINT pk_televisora PRIMARY KEY (cod_televisora)
);

CREATE TABLE costo_evento(
    EVENTO_cod_evento integer not null,
    TELEVISORA_cod_televisora integer not null,
    tarifa numeric not null,
    CONSTRAINT pk_costo_evento PRIMARY KEY (EVENTO_cod_evento, TELEVISORA_cod_televisora),
    CONSTRAINT fk_costo_evento_evento FOREIGN KEY (EVENTO_cod_evento) REFERENCES evento (cod_evento) ON DELETE CASCADE,
    CONSTRAINT fk_costo_evento_televisora FOREIGN KEY (TELEVISORA_cod_televisora) REFERENCES televisora (cod_televisora) ON DELETE CASCADE
);

/*2*/
ALTER TABLE evento 
DROP fecha;
ALTER TABLE evento 
DROP hora;
ALTER TABLE evento 
ADD fecha_hora timestamp not null;

/*3*/
ALTER TABLE evento
ADD CONSTRAINT ck_fecha_hora CHECK (fecha_hora BETWEEN '2020-07-24 09:00:00'::timestamp AND '2020-08-09 20:00:00'::timestamp);

/*4*/
CREATE TABLE sede(
    codigo integer NOT NULL,
    sede VARCHAR(50) NOT NULL,
    CONSTRAINT pk_sede PRIMARY KEY (codigo)
);
ALTER TABLE evento
ALTER COLUMN ubicacion TYPE integer USING ubicacion::integer,
ADD CONSTRAINT fk_evento_sede FOREIGN KEY (ubicacion) REFERENCES sede (codigo);

/*5*/
ALTER TABLE miembro
ALTER COLUMN telefono SET DEFAULT 0;

/*6*/
INSERT INTO pais (cod_pais, nombre) VALUES (1, 'Guatemala');
INSERT INTO pais (cod_pais, nombre) VALUES (2, 'Francia');
INSERT INTO pais (cod_pais, nombre) VALUES (3, 'Argentina');
INSERT INTO pais (cod_pais, nombre) VALUES (4, 'Alemania');
INSERT INTO pais (cod_pais, nombre) VALUES (5, 'Italia');
INSERT INTO pais (cod_pais, nombre) VALUES (6, 'Brasil');
INSERT INTO pais (cod_pais, nombre) VALUES (7, 'Estados Unidos');
INSERT INTO profesion (cod_prof, nombre) VALUES (1, 'Médico');
INSERT INTO profesion (cod_prof, nombre) VALUES (2, 'Arquitecto');
INSERT INTO profesion (cod_prof, nombre) VALUES (3, 'Ingeniero');
INSERT INTO profesion (cod_prof, nombre) VALUES (4, 'Secretaria');
INSERT INTO profesion (cod_prof, nombre) VALUES (5, 'Auditor');
INSERT INTO miembro (cod_miembro,nombre,apellido,edad,residencia,pais_cod_pais,profesion_cod_prof) VALUES (1,'Scott','Mitchell',32,'1092 Highland Drive Manitowoc, Wl 54220',7,3);
INSERT INTO miembro (cod_miembro,nombre,apellido,edad,telefono,residencia,pais_cod_pais,profesion_cod_prof) VALUES (2,'Fanette','Poulin',25,25075853,'49, boulevard Aristide Briand 76120 LE GRAND-QUEVILLY',2,4);
INSERT INTO miembro (cod_miembro,nombre,apellido,edad,residencia,pais_cod_pais,profesion_cod_prof) VALUES (3,'Laura','Cunha Silva',55,'Rua Onze, 86 Uberaba-MG',6,5);
INSERT INTO miembro (cod_miembro,nombre,apellido,edad,telefono,residencia,pais_cod_pais,profesion_cod_prof) VALUES (4,'Juan José','López',38,36985247,'26 calle 4-10 zona 11',1,2);
INSERT INTO miembro (cod_miembro,nombre,apellido,edad,telefono,residencia,pais_cod_pais,profesion_cod_prof) VALUES (5,'Arcangela','Panicucci',39,391664921,'Via Santa Teresa, 114 90010-Geraci Siculo PA',5,1);
INSERT INTO miembro (cod_miembro,nombre,apellido,edad,residencia,pais_cod_pais,profesion_cod_prof) VALUES (6,'Jeuel','Villalpando',31,'Acuña de Figeroa 6106 80101 Playa Pascual',3,5);
INSERT INTO disciplina (cod_disciplina,nombre,descripcion) VALUES (1,'Atletismo','Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamiento de martillo, jabalina y disco');
INSERT INTO disciplina (cod_disciplina,nombre) VALUES (2,'Bádminton');
INSERT INTO disciplina (cod_disciplina,nombre) VALUES (3,'Ciclismo');
INSERT INTO disciplina (cod_disciplina,nombre,descripcion)
VALUES (4,'Judo','Es un arte marcial que se originó en Japón alrededor de 1880');
INSERT INTO disciplina (cod_disciplina,nombre) VALUES (5,'Lucha');
INSERT INTO disciplina (cod_disciplina,nombre) VALUES (6,'Tenis de Mesa');
INSERT INTO disciplina (cod_disciplina,nombre) VALUES (7,'Boxeo');
INSERT INTO disciplina (cod_disciplina,nombre,descripcion)
VALUES (8,'Natación','Está presente como deporte en los Juegos desde la primera edición de la era moderna, en Atenas, Grecia, en 1896, donde se disputo en aguas abiertas.');
INSERT INTO disciplina (cod_disciplina,nombre) VALUES (9,'Esgrima');
INSERT INTO disciplina (cod_disciplina,nombre) VALUES (10,'Vela');
INSERT INTO tipo_medalla (cod_tipo, medalla) VALUES (1, 'Oro');
INSERT INTO tipo_medalla (cod_tipo, medalla) VALUES (2, 'Plata');
INSERT INTO tipo_medalla (cod_tipo, medalla) VALUES (3, 'Bronce');
INSERT INTO tipo_medalla (cod_tipo, medalla) VALUES (4, 'Platino');
INSERT INTO categoria (cod_categoria, categoria) VALUES (1, 'Clasificatorio');
INSERT INTO categoria (cod_categoria, categoria) VALUES (2, 'Eliminatorio');
INSERT INTO categoria (cod_categoria, categoria) VALUES (3, 'Final');
INSERT INTO tipo_participacion (cod_participacion, tipo_participacion) VALUES (1, 'Individual');
INSERT INTO tipo_participacion (cod_participacion, tipo_participacion) VALUES (2, 'Parejas');
INSERT INTO tipo_participacion (cod_participacion, tipo_participacion) VALUES (3, 'Equipos');
INSERT INTO medallero (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (5,1,3);
INSERT INTO medallero (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (2,1,5);
INSERT INTO medallero (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (6,3,4);
INSERT INTO medallero (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (4,4,3);
INSERT INTO medallero (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (7,3,10);
INSERT INTO medallero (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (3,2,8);
INSERT INTO medallero (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (1,1,2);
INSERT INTO medallero (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (1,4,5);
INSERT INTO medallero (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (5,2,7);
INSERT INTO sede (codigo, sede) VALUES (1,'Gimnasio Metropolitano de Tokio');
INSERT INTO sede (codigo, sede) VALUES (2,'Jardín del Palacio Imperial de Tokio');
INSERT INTO sede (codigo, sede) VALUES (3,'Gimnasio Nacional Yoyogi');
INSERT INTO sede (codigo, sede) VALUES (4,'Nippon Budokan');
INSERT INTO sede (codigo, sede) VALUES (5,'Estadio Olímpico');
INSERT INTO evento (cod_evento,fecha_hora,ubicacion,disciplina_cod_disciplina,tipo_participacion_cod_participacion,categoria_cod_categoria)
VALUES (1,'2020-07-24 11:00:00', 3, 2, 2, 1);
INSERT INTO evento (cod_evento,fecha_hora,ubicacion,disciplina_cod_disciplina,tipo_participacion_cod_participacion,categoria_cod_categoria)
VALUES (2,'2020-07-26 10:30:00', 1, 6, 1, 3);
INSERT INTO evento (cod_evento,fecha_hora,ubicacion,disciplina_cod_disciplina,tipo_participacion_cod_participacion,categoria_cod_categoria)
VALUES (3,'2020-07-30 18:45:00', 5, 7, 1, 2);
INSERT INTO evento (cod_evento,fecha_hora,ubicacion,disciplina_cod_disciplina,tipo_participacion_cod_participacion,categoria_cod_categoria)
VALUES (4,'2020-08-01 12:15:00', 2, 1, 1, 1);
INSERT INTO evento (cod_evento,fecha_hora,ubicacion,disciplina_cod_disciplina,tipo_participacion_cod_participacion,categoria_cod_categoria)
VALUES (5,'2020-08-08 19:35:00', 4, 10, 3, 1);

/*7*/
ALTER TABLE pais
DROP CONSTRAINT uk_pais_nombre;	
ALTER TABLE tipo_medalla
DROP CONSTRAINT uk_tipo_medalla_medalla;
ALTER TABLE departamento
DROP CONSTRAINT uk_departamento_nombre;

/*8*/
ALTER TABLE atleta
DROP CONSTRAINT fk_atleta_disciplina,
DROP COLUMN DISCIPLINA_cod_disciplina;
CREATE TABLE disciplina_atleta (
    cod_atleta integer not null,
    cod_disciplina integer not null,
    CONSTRAINT pk_disciplina_atleta PRIMARY KEY (cod_atleta, cod_disciplina),
    CONSTRAINT fk_disciplina_atleta_atleta FOREIGN KEY (cod_atleta) REFERENCES atleta (cod_atleta) ON DELETE CASCADE,
    CONSTRAINT fk_disciplina_atleta_disciplina FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina) ON DELETE CASCADE
);

/*9*/
ALTER TABLE costo_evento
ALTER COLUMN tarifa TYPE numeric(15, 2);

/*10*/
DELETE FROM tipo_medalla
WHERE cod_tipo = 4;

/*11*/
DROP TABLE costo_evento;
DROP TABLE televisora;

/*12*/
TRUNCATE disciplina CASCADE;

/*13*/
UPDATE miembro
SET telefono = 55464601
WHERE nombre = 'Laura' 
AND apellido = 'Cunha Silva';
UPDATE miembro
SET telefono = 91514243
WHERE nombre = 'Jeuel' 
AND apellido = 'Villalpando';
UPDATE miembro
SET telefono = 920686670
WHERE nombre = 'Scott' 
AND apellido = 'Mitchell';

/*14*/
ALTER TABLE atleta
ADD fotografia bytea null;

/*15*/
ALTER TABLE atleta
ADD CONSTRAINT ck_edad_maxima CHECK (edad < 25);

