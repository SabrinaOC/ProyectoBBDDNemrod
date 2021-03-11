drop database if exists nemrod;
create database nemrod;
use nemrod;

CREATE TABLE SEDE (
	cod_sede INT(3) PRIMARY KEY,
	dir_sede VARCHAR (30)  NOT NULL,
	fund_sede date  NOT NULL
);


CREATE TABLE EQUIPO (
	cod_eq INT(3) PRIMARY KEY,
	cod_sede INT(3),
	CONSTRAINT fk1 FOREIGN KEY (cod_sede) REFERENCES SEDE(cod_sede) ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE PROFESIONAL (
	cod_emp INT(3),
	cod_eq INT(3),
	nss INT NOT NULL,
	nom_emp VARCHAR (15) NOT NULL,
	incorp date  NOT NULL,
	CONSTRAINT pk1 PRIMARY KEY (cod_emp, cod_eq),
	CONSTRAINT fk2 FOREIGN KEY (cod_eq) REFERENCES EQUIPO(cod_eq) ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE GESTOR (
	cod_emp INT(3),
	cod_eq INT(3),
	CONSTRAINT pk2 PRIMARY KEY (cod_emp, cod_eq),
	CONSTRAINT fk3 FOREIGN KEY (cod_eq) REFERENCES EQUIPO(cod_eq) ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE TRADUCTOR (
	cod_emp INT(3),
	cod_eq INT(3),
	cantidad_proy INT(4),
	CONSTRAINT pk2 PRIMARY KEY (cod_emp, cod_eq),
	CONSTRAINT fk11 FOREIGN KEY (cod_eq) REFERENCES EQUIPO(cod_eq) ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE IDIOMA (
	cod_lang INT(3) PRIMARY KEY,
	nom_lang VARCHAR(15),
	fam_lang VARCHAR(15)
);


CREATE TABLE DOMINA (
	cod_emp INT(3),
	cod_eq INT(3),
	cod_lang INT(3),
	CONSTRAINT pk3 PRIMARY KEY (cod_emp, cod_eq, cod_lang),
	CONSTRAINT fk4 FOREIGN KEY (cod_emp, cod_eq) REFERENCES TRADUCTOR (cod_emp, cod_eq) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk5 FOREIGN KEY (cod_lang) REFERENCES IDIOMA (cod_lang)
);

CREATE TABLE PROYECTO (
	cod_proy INT(3) PRIMARY KEY, 
	cod_langOr INT(3),
	cod_langMeta INT(3),
	plazo date NOT NULL,
	cod_cliente INT(3),
	CONSTRAINT fk6 FOREIGN KEY (cod_langOr) REFERENCES IDIOMA (cod_lang),
	CONSTRAINT fk7 FOREIGN KEY (cod_langMeta) REFERENCES IDIOMA (cod_lang),
	CONSTRAINT chk1 CHECK (cod_langOr != cod_langMeta)
);


CREATE TABLE INTERVIENEN (
	cod_empT INT(3),
	cod_eqT INT(3),
	cod_proy INT(3),
	cod_empG INT(3),
	cod_eqG INT(3),
	CONSTRAINT pk4 PRIMARY KEY (cod_empT, cod_eqT, cod_proy),
	CONSTRAINT fk8 FOREIGN KEY (cod_empT, cod_eqT) REFERENCES TRADUCTOR (cod_emp, cod_eq) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk9 FOREIGN KEY (cod_proy) REFERENCES PROYECTO (cod_proy),
	CONSTRAINT fk10 FOREIGN KEY (cod_empG, cod_eqG) REFERENCES GESTOR (cod_emp, cod_eq) ON UPDATE CASCADE ON DELETE RESTRICT
);


/************ TRIGGERS **************/


CREATE TRIGGER ai_intervienen after INSERT ON INTERVIENEN for each row 
	
	UPDATE TRADUCTOR T SET cantidad_proy=cantidad_proy+1 where T.cod_emp=new.cod_empT and T.cod_eq=new.cod_eqT;


CREATE TRIGGER ad_intervienen after DELETE ON INTERVIENEN for each row 
	
	UPDATE TRADUCTOR T SET cantidad_proy=cantidad_proy-1 where T.cod_emp=old.cod_empT and T.cod_eq=old.cod_eqT;
		
	
/******** CREAR TRIGGER insertar, actualizar y borrar!! *********/



