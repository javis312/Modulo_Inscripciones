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
	CONSTRAINT materias_fk1 FOREIGN KEY(id_docente) REFERENCES docente(id_docente) ON DELETE CASCADE 
	CONSTRAINT materias_fk2 FOREIGN KEY (id_semestre) REFERENCES semestre (id_semestre)  ON DELETE CASCADE 
); 

################### MODULO INSCRIPCIONES ####################
# Tabla Pagos
CREATE TABLE Pagos(
	id_pago int NOT NULL,
	Folio varchar(30) NOT NULL,
	TipoPago varchar(30) NOT NULL,
	Cantidad int NOT NULL,
	CONSTRAINT pk_pago PRIMARY KEY (id_pago)
);


# Tabla CargaAcademica
CREATE TABLE CargaAcademica(
	id_cargaAcad int NOT NULL,
	num_control	varchar(13),
	CONSTRAINT pk_carga PRIMARY KEY (id_cargaAcad),
	CONSTRAINT fk_control_carga FOREIGN KEY (num_control) REFERENCES 
);

# Tabla MateriasCarga
CREATE TABLE Materias_Carga(
	id_cargaAcad int NOT NULL,
	clave_materia int NOT NULL,
	CONSTRAINT fk_carga_materia FOREIGN KEY (id_cargaAcad) REFERENCES CargaAcademica (id_cargaAcad),
	CONSTRAINT fk_materia_carga FOREIGN KEY (clave_materia) REFERENCES Materias(clave_materia),
	PRIMARY KEY(id_cargaAcad, clave_materia)
);

# Tabla Inscripciones
CREATE TABLE Inscripciones(
	id_inscripcion int,
	id_cargaAcad int,
	num_control varchar(13),
	PRIMARY KEY (id_inscripcion),
	CONSTRAINT fk_carga_inscr FOREIGN KEY (id_cargaAcad) REFERENCES CargaAcademica (id_cargaAcad),
	CONSTRAINT fk_control_inscr FOREIGN KEY (num_control) REFERENCES alumnos (num_control),
	ON DELETE CASCADE
);

CREATE TABLE Inscripcione_Pago(
	id_inscripcion int NOT NULL,
	id_pago int NOT NULL,
	CONSTRAINT fk_insc_pago FOREIGN KEY (id_inscripcion) REFERENCES Inscripciones (id_inscripcion),
	CONSTRAINT fk_pago_insc FOREIGN KEY (id_pago) REFERENCES Pagos (id_pago),
	PRIMARY KEY(id_inscripcion, id_pago)

);