
USE master;
GO

DROP DATABASE IF EXISTS salud_usm;
GO

CREATE DATABASE salud_usm;
GO

USE salud_usm;
GO

CREATE TABLE Centro_medico(
	id_centro INT PRIMARY KEY,
	nombre_centro VARCHAR(20) NOT NULL,
	comuna VARCHAR(20) NOT NULL,
	region VARCHAR(20)NOT NULL
	);

CREATE TABLE Prevision(
	id_prevision INT PRIMARY KEY,
	nombre_prevision VARCHAR(20) NOT NULL
);


CREATE TABLE Medico(
	rut_medico VARCHAR(10) PRIMARY KEY,
	nombre_completo VARCHAR(40) NOT NULL,
	email_institucional VARCHAR(30) NOT NULL
);

CREATE TABLE Estado_cita(
	id_estado INT PRIMARY KEY,
	nombre_estado VARCHAR(10) NOT NULL
);


CREATE TABLE Especialidad (
	id_especialidad INT PRIMARY KEY,
	nombre_especialidad VARCHAR(20) NOT NULL
);

CREATE TABLE Diagnostico (
	codigo_diagnostico VARCHAR(10) PRIMARY KEY,
	descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE Paciente(
	rut_paciente VARCHAR(10) PRIMARY KEY NOT NULL,
	nombre_completo VARCHAR (40) NOT NULL,
	fecha_nacimineto DATE NOT NULL,
	sexo VARCHAR(20) NOT NULL,
	telefono VARCHAR(20),
	comuna VARCHAR(20) NOT NULL,
	id_prevision INT NOT NULL,

	FOREIGN KEY (id_prevision)
		REFERENCES Prevision(id_prevision)
	);

CREATE TABLE Medico_especialidad(
	rut_medico VARCHAR(10) NOT NULL,
	id_especialidad INT NOT NULL,

	PRIMARY KEY (rut_medico, id_especialidad),
	FOREIGN KEY (rut_medico)
		REFERENCES Medico(rut_medico),

	FOREIGN KEY (id_especialidad)
		REFERENCES Especialidad(id_especialidad)
	);

CREATE TABLE Medico_Centro_Med(
	id_centro INT NOT NULL,
	rut_medico VARCHAR(10) NOT NULL,

	PRIMARY KEY (id_centro,rut_medico),
	FOREIGN KEY (rut_medico)
		REFERENCES Medico(rut_medico),

	FOREIGN KEY (id_centro)
		REFERENCES Centro_medico(id_centro)

	);

CREATE TABLE Cita(
	id_cita INT PRIMARY KEY,
	fecha_hora VARCHAR(20) NOT NULL,
	rut_paciente VARCHAR(10) NOT NULL,
	id_especialidad INT NOT NULL,
	rut_medico VARCHAR(10) NOT NULL,
	id_estado INT NOT NULL,
	id_centro INT NOT NULL,

	FOREIGN KEY (rut_paciente)
		REFERENCES Paciente(rut_paciente),

	FOREIGN KEY (id_especialidad)
		REFERENCES Especialidad(id_especialidad),

	FOREIGN KEY (rut_medico)
		REFERENCES Medico(rut_medico),

	FOREIGN KEY (id_estado)
		REFERENCES Estado_cita(id_estado),

	FOREIGN KEY (id_centro)
		REFERENCES Centro_medico(id_centro)

	);

CREATE TABLE Atencion(
	id_atencion INT PRIMARY KEY,
	motivo_consulta VARCHAR(30) NOT NULL,
	observaciones VARCHAR(30) NOT NULL,
	id_cita INT

	FOREIGN KEY (id_cita)
		REFERENCES Cita(id_cita),
	);

CREATE TABLE Detalle_diagnostico(
	id_atencion INT NOT NULL,
	codigo_diagnostico VARCHAR(10) NOT NULL,

	PRIMARY KEY (id_atencion, codigo_diagnostico),
	FOREIGN KEY (id_atencion)
		REFERENCES Atencion(id_atencion),

	FOREIGN KEY (codigo_diagnostico)
		REFERENCES Diagnostico(codigo_diagnostico)

	);

CREATE TABLE Receta(
	id_receta INT PRIMARY KEY,
	medicamento VARCHAR(15) NOT NULL,
	dosis VARCHAR(20) NOT NULL,
	cantidad_dias VARCHAR(20) NOT NULL,
	id_atencion INT NOT NULL,

	FOREIGN KEY (id_atencion)
		REFERENCES Atencion(id_atencion)
	);