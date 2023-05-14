create table pais(
	id_pais int not null auto_increment primary key,
    nombre varchar(50) not null);
    
create table provincia(
	id_provincia int not null auto_increment primary key,
    id_pais int not null,
    nombre varchar(50) not null,
    foreign key(id_pais) references pais(id_pais));
    
create table ciudad(
	id_ciudad int not null auto_increment primary key,
    id_provincia int not null,
    nombre varchar(50) not null,
    foreign key(id_provincia) references provincia(id_provincia));
    
create table centro_salud(
	id_centro int not null auto_increment primary key,
	nombre varchar(50) not null,
	direccion varchar(50) not null,
    id_ciudad int not null,
    foreign key(id_ciudad) references ciudad(id_ciudad)
);

create table medico(
	matricula int not null unique primary key,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    dni int unique not null,
    especialidad varchar(50) not null default "clinico"
);

create table empleados(
	id_centro int not null,
    matricula int not null,
    primary key(id_centro, matricula),
    foreign key(id_centro) references centro_salud(id_centro),
    foreign key(matricula) references medico(matricula)
);

create table obra_social(
	id_os int not null auto_increment primary key,
    nombre varchar(50) not null
);

create table enfermedades(
	id_enfermedad int not null auto_increment primary key,
    nombre varchar(50) not null	
);
  
create table persona(
	id_persona int not null auto_increment primary key,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    direccion varchar(50) not null,
    fecha_nacimiento date not null,
    email varchar(150) not null,
    telefono int not null,
    id_ciudad int not null,
    id_os int not null,
    id_antecedentes int not null,
    foreign key(id_ciudad) references ciudad(id_ciudad),
    foreign key(id_os) references obra_social(id_os)
    );
    
create table antecedentes_familiares(
	id_persona int not null,
    id_enfermedad int not null,
    primary key(id_persona, id_enfermedad),
    foreign key(id_persona) references persona(id_persona),
    foreign key(id_enfermedad) references enfermedades(id_enfermedad)
);
    
create table orden_medica(
	id_orden_medica int not null auto_increment primary key,
	id_persona int not null,
	matricula int not null,
	fecha date not null,
	receta varchar(400) not null,
	foreign key(id_persona) references persona(id_persona),
	foreign key (matricula) references medico(matricula)
    );
    
create table operacion(
	id_operacion int not null auto_increment primary key,
	id_centro int not null,
	id_orden_medica int not null,
	ingreso date not null,
	causa varchar(500) not null,
	matricula int not null,
	foreign key(id_centro) references centro_salud(id_centro),
	foreign key (id_orden_medica) references orden_medica(id_orden_medica),
	foreign key(matricula) references medico(matricula)
    );
    
create table internacion(
	id_internacion int not null auto_increment primary key,
	id_centro int not null,
	id_orden_medica int not null,
	ingreso date not null,
	alta date not null,
	causa varchar(500) not null,
	foreign key(id_centro) references centro_salud(id_centro),
	foreign key(id_orden_medica) references orden_medica(id_orden_medica)
    );
    
create table analisis(
	id_analisis int not null auto_increment primary key,
	id_centro int not null,
	id_orden_medica int not null,
	fecha date not null,
	estudio varchar(3000) not null,
	foreign key(id_centro) references centro_salud(id_centro),
	foreign key(id_orden_medica) references orden_medica(id_orden_medica)
    );
    
create table imagenes(
	id_imagenes int not null auto_increment primary key,
	id_centro int not null,
	id_orden_medica int not null,
	fecha date not null,
	imagen blob not null,
	foreign key(id_centro) references centro_salud(id_centro),
	foreign key(id_orden_medica) references orden_medica(id_orden_medica)
    );