-- Active: 1715818054649@@127.0.0.1@3306
CREATE DATABASE Olimpicos
    DEFAULT CHARACTER SET = 'utf8mb4';

    use Olimpicos;


    create table deportes(
        id_deporte int primary key,
        nombre varchar(100) not null,
        num_jugadores int not null
    );

    create table jefes(
        id_jefe int primary key,
        nombre varchar(100),
        email varchar(100),
        titulo varchar(100)
    );

    create table sede(
        id_sede int primary key,
        nombre varchar(100),
        id_complejo int not null,
        presupuesto float not null
    );

    create table info_complejo(
        id_complejo int primary key,
        locacion varchar(100) not null,
        area_complejo float,
        id_jefe int,
        Foreign Key (id_jefe) REFERENCES jefes(id_jefe)
    );


create table equipamiento(
    id_equipamiento int primary key,
    nombre_equipos varchar(100),
    stock int not null
);


create table complejo_deportivo(
    id_complejo_deportivo int primary key,
    nombre VARCHAR(100) not null,
    id_deporte int ,
    id_info_complejo int,
    Foreign Key (id_deporte) REFERENCES deportes(id_deporte),
    Foreign Key (id_info_complejo) REFERENCES info_complejo(id_complejo) 
);


create table eventos(
    id_evento int primary key,
    nombre  varchar(100) not null,
    fecha datetime,
    duracion time,
    num_participantes int
);



create table evento_equipo(
    id_evento_equipo int primary key,
    id_evento int,
    id_equipamiento int,
    Foreign Key (id_evento) REFERENCES eventos(id_evento),
    Foreign Key (id_equipamiento) REFERENCES equipamiento(id_equipamiento)
);


create table complejo_polideportivo(
    id_complejo_polideportivo int primary key,
    nombre varchar(100) not null,
    id_deporte int,
    id_info_complejo int,
     Foreign Key (id_deporte) REFERENCES deportes(id_deporte),
    Foreign Key (id_info_complejo) REFERENCES info_complejo(id_complejo) 
);



create table comisario(
    id_comisario int primary key,
    nombre varchar(100) not null,
    email varchar(100),
    telefono varchar(20),
    tipo VARCHAR(100)
);

create table evento_comisario(
    id_evento_comisario int primary key,
    id_evento int,
    id_comisario int,
    Foreign Key (id_evento) REFERENCES eventos(id_evento),
    Foreign Key (id_comisario) REFERENCES comisario(id_comisario)
);



create table evento_complejo_deportivo(
    id_evento_complejo_deportivo int primary key,
    id_evento int ,
    id_complejo int,
      Foreign Key (id_evento) REFERENCES eventos(id_evento),
        Foreign Key (id_complejo) REFERENCES complejo_deportivo(id_complejo_deportivo)
);


create table evento_complejo_poli(
    id_evento_complejo int primary key,
    id_evento int,
    id_complejo int,
      Foreign Key (id_evento) REFERENCES eventos(id_evento),
        Foreign Key (id_complejo) REFERENCES complejo_polideportivo(id_complejo_polideportivo)
);


