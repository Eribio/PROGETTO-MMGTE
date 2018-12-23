drop database if exists ospedale;

create database ospedale;
use ospedale;

create table edificio (
	ID integer unsigned not null primary key auto_increment,
    nome varchar(100) not null,
    numero_piani integer unsigned not null
);

create table area (
	ID integer unsigned not null primary key auto_increment,
    IDedificio integer unsigned not null,
    nome varchar(100) not null,
    piano tinyint,
    priorita enum ('bassa','alta') default 'bassa',
    constraint area_edificio foreign key(IDedificio) references edificio(ID) on update cascade
);

create table zona (
	ID integer unsigned not null primary key auto_increment,
    IDarea integer unsigned not null,
    nome varchar(100),
    piano tinyint,
    numero integer unsigned not null,
    constraint zona_area foreign key(IDarea) references area(ID) on update cascade
);

create table sensore (
	ID integer unsigned not null primary key auto_increment,
    IDzona integer unsigned not null,
    tipo enum ('temperatura','umidita','pressione'),
    timer_secondi enum ('30' ,'60') default '60',
    funzionamento enum ('0','1') default '1',
    constraint sensore_zona foreign key(IDzona) references zona(ID) on update cascade
);

create table dato (
	ID integer unsigned not null primary key auto_increment,
    IDsensore integer unsigned not null,
    valore integer not null,
    data_rilevamento datetime not null default current_timestamp,
    constraint dato_sensore foreign key(IDsensore) references sensore(ID)
);







create table responsabile (
	ID integer unsigned not null primary key auto_increment,
    IDarea integer unsigned not null,
    IDedificio integer unsigned not null,
    nome varchar(100) not null,
    cognome varchar(100) not null,
    identificativo varchar(10) not null unique,
    inizio_turno datetime not null,
    fine_turno datetime not null,
    data_turno date not null,
    constraint turno_unico unique(identificativo,inizio_turno,fine_turno),
    constraint responsabile_area foreign key(IDarea) references area(ID),
    constraint responsabile_edificio foreign key(IDedificio) references edificio(ID)
);

create table amministratore (
	ID integer unsigned not null primary key auto_increment,
    nome varchar(100) not null,
    cognome varchar(100) not null,
    identificativo varchar(10) not null unique,
    inizio_turno datetime not null,
    fine_turno datetime not null,
    data_turno date not null
);


    