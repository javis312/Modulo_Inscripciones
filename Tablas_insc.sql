# tabla de alumnos 
CREATE TABLE alumnos(
	num_control varchar(13) NOT NULL PRIMARY KEY,
	id_persona number,
	constraint per_alu FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
	ON DELETE CASCADE
);

 #Tabla materias
 CREATE TABLE materias( 
	clave_materia int NOT NULL, 
	nombre varchar(30), 
	unidades int, 
	creditos int, 
	horas_practicas int, 
	horas_teoricas int, 
	CONSTRAINT materias_pk PRIMARY KEY (clave_materia), 
	CONSTRAINT materias_fk1 FOREIGN KEY(id_docente) REFERENCES docente(id_docente),
	CONSTRAINT materias_fk2 FOREIGN KEY (id_semestre) REFERENCES semestre (id_semestre)  ON DELETE CASCADE
);

CREATE TABLE Semestre(
	id_semestre int NOT NULL,
	Nombre varchar(30) NOT NULL,
	Periodo varchar(30) NOT NULL,
	clave_carrera varchar (10) NOT NULL,
	CONSTRAINT fk_carrera_semestre FOREIGN KEY clave_carrera REFERENCES carreras (clave_carrera),
	CONSTRAINT pk_semestre PRIMARY KEY (id_semestre)
	ON DELETE CASCADE
);

CREATE TABLE GRUPO (
ID_GRUPO INT NOT NULL,
EDIFICIO VARCHAR2(5),
NUM_GRUPO VARCHAR2(10),
ID_SEMESTRE INT NOT NULL,
CONSTRAINT PK_GRUPO PRIMARY KEY (ID_GRUPO),
CONSTRAINT FK_SEMESTRE FOREIGN KEY (ID_SEMESTRE) REFERENCES SEMESTRE(ID_SEMESTRE)
);


 ################### MODULO INSCRIPCIONES ###################
# Tabla Pagos
CREATE TABLE Pagos(
	id_pago int NOT NULL,
	Folio varchar(30) NOT NULL,
	TipoPago varchar(30) NOT NULL,
	Cantidad int NOT NULL,
	CONSTRAINT pk_pago PRIMARY KEY (id_pago)
	ON DELETE CASCADE
);


# Tabla CargaAcademica
CREATE TABLE CargaAcademica(
	id_cargaAcad int NOT NULL,
	num_control	int NOT NULL,
	id_grupo int NOT NULL,
	id_semestre int NOT NULL,
	CONSTRAINT pk_carga PRIMARY KEY (id_cargaAcad),
	CONSTRAINT fk_control_carga FOREIGN KEY (num_control) REFERENCES alumnos (num_control),
	CONSTRAINT fk_grupo_carga FOREIGN KEY (id_grupo) REFERENCES grupo (id_grupo),
	CONSTRAINT fk_semestre_carga FOREIGN KEY (id_semestre) REFERENCES Semestre(id_semestre)
	ON DELETE CASCADE
);

# Tabla MateriasCarga
CREATE TABLE Materias_Carga(
	id_cargaAcad int NOT NULL,
	clave_materia int NOT NULL,
	CONSTRAINT fk_carga_materia FOREIGN KEY (id_cargaAcad) REFERENCES CargaAcademica (id_cargaAcad),
	CONSTRAINT fk_materia_carga FOREIGN KEY (clave_materia) REFERENCES Materias(clave_materia),
	PRIMARY KEY(id_cargaAcad, clave_materia)
	ON DELETE CASCADE
);

# Tabla Inscripciones
CREATE TABLE Inscripciones(
	id_inscripcion int,
	id_cargaAcad int,
	PRIMARY KEY (id_inscripcion),
	CONSTRAINT fk_carga_inscr FOREIGN KEY (id_cargaAcad) REFERENCES CargaAcademica (id_cargaAcad),
	ON DELETE CASCADE
);

CREATE TABLE Inscripciones_Pago(
	id_inscripcion int NOT NULL,
	id_pago int NOT NULL,
	CONSTRAINT fk_insc_pago FOREIGN KEY (id_inscripcion) REFERENCES Inscripciones (id_inscripcion),
	CONSTRAINT fk_pago_insc FOREIGN KEY (id_pago) REFERENCES Pagos (id_pago),
	PRIMARY KEY(id_inscripcion, id_pago)
	ON DELETE CASCADE

);