set autocommit off;
set transaction isolation level serializable;


savepoint inicializacion;
--PRIMERO DROPEO TODAS LAS TABLAS POR SI EXISTEN *******************************************************************************************************
drop table socio CASCADE constraints;
drop table soc_titular CASCADE constraints;
drop table soc_notitular CASCADE constraints;
drop table categoria CASCADE constraints;
drop table destinada_a CASCADE constraints;
drop table puede_inscribirse_a CASCADE constraints;
drop table pago_actividad CASCADE constraints;
drop table actividad CASCADE constraints;
drop table actividad_arancelada CASCADE constraints;
drop table actividad_gratuita CASCADE constraints;
drop table arancel_actividad CASCADE constraints;
drop table paga CASCADE constraints;
drop table actividad_general CASCADE constraints;
drop table actividad_especifica CASCADE constraints;
drop table zona CASCADE constraints;
drop table puede_desarrollarse CASCADE constraints;
drop table esta_a_cargo CASCADE constraints;
drop table puede_desempeñarla CASCADE constraints;
drop table profesional CASCADE constraints;
drop table grupo_familiar cascade constraints;
drop table cuota_mensual CASCADE constraints;
drop table pago_cuota CASCADE constraints;
drop table abona CASCADE constraints;


-- DEFINO TODAS LAS TABLAS Y LAS CLAVES PRIMARIAS *******************************************************************************************************
--EL N_SOCIO NO SE AUTOINCREMENTA YA QUE SERIA PARA TODA LA TABLA Y NO PARA CADA GRUPO FAMILLIAR, POR ENDE NO SERVIRIA
create table socio(n_grupo int, n_socio int, nombre varchar(50), domicilio varchar(20), telefono varchar(15), correo_electronico varchar(50),
fecha_nacimiento date, cargo varchar(20) not null, ID_categoria int not null, primary key(n_grupo,n_socio));

create table soc_titular(n_grupo int not null, n_socio int not null, primary key(n_grupo, n_socio));

create table soc_notitular(n_grupo int not null, n_socio int not null, primary key(n_grupo, n_socio));

create table categoria(id_categoria int, tipo varchar(15) unique, incremento_descuento float, primary key(id_categoria));

create table destinada_a(id_categoria int not null, id_actividad int not null, primary key(id_categoria, id_actividad));

create table puede_inscribirse_a(n_grupo int not null, n_socio int not null, id_actividad int not null, id_zona int not null, dia varchar(30) not null, horario varchar(8) not null,
fecha_inscripcion date not null, primary key(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion));

create table pago_actividad(id_pago int, fecha_pagoactividad date, monto_abonado float, primary key(id_pago));

create table actividad(id_actividad int, descripcion varchar(30), tipo varchar(30), costo varchar(30), primary key(id_actividad));

create table actividad_arancelada(id_actividad int not null, periodo_de_pago varchar(15), importe float, primary key(id_actividad));

create table actividad_gratuita(id_actividad int not null, primary key(id_actividad));

create table arancel_actividad(id_arancel_actividad int, fecha_emision date, descripcion_pago varchar(3), id_actividad int, primary key(id_arancel_actividad));

create table paga(n_grupo int not null, n_socio int not null, id_pago int not null, id_arancel_actividad int not null, primary key(n_grupo, n_socio, id_pago, id_arancel_actividad));

create table actividad_general(id_actividad int not null, primary key(id_actividad));

create table actividad_especifica(id_actividad int not null, primary key(id_actividad));

create table zona(id_zona int, ubicacion varchar(30), capacidad int, estado_mantenimiento varchar(30), primary key(id_zona));

create table puede_desarrollarse(id_actividad int not null, id_zona int not null, dia varchar(30) not null, horario varchar(8) not null, periodo varchar(40), primary key(id_actividad,id_zona,dia,horario));

create table esta_a_cargo(legajo int not null, id_actividad int not null, id_zona int not null, dia varchar(30) not null, horario varchar(8) not null, primary key(legajo,id_actividad,id_zona,dia,horario));

create table puede_desempeñarla(legajo int not null, id_actividad int not null, primary key(legajo,id_actividad));

create table profesional(legajo int, nombre varchar(25), apellido varchar(25), documento int, domicilio varchar(20), telefono varchar(15), primary key(legajo));

create table grupo_familiar(n_grupo int not null, domicilio varchar(20), telefono varchar(15), primary key(n_grupo));

create table cuota_mensual(id_cuotamensual int, monto_base float, monto_total float, periodo_vigencia varchar(20), descripcion_pago varchar(3), fecha_emision date,
n_grupo int not null, primary key(id_cuotamensual));

create table pago_cuota(id_pagocuota int, fecha_pago date, monto_abonadocuota float, primary key(id_pagocuota));

create table abona(id_pagocuota int not null, n_grupo int not null, n_socio int not null, id_cuotamensual int not null, primary key(id_cuotamensual,id_pagocuota));


-- ALTER TABLE PARA AÑADIR LAS CLAVES FORANEAS *******************************************************************************************************
alter table socio add constraint fk1 foreign key (n_grupo) references grupo_familiar(n_grupo) ON DELETE CASCADE;
alter table socio add constraint fk2 foreign key (id_categoria) references categoria(id_categoria) ON DELETE CASCADE;

alter table soc_titular add constraint fk3 foreign key (n_grupo,n_socio) references socio(n_grupo,n_socio) ON DELETE CASCADE;

alter table soc_notitular add constraint fk4 foreign key (n_grupo,n_socio) references socio(n_grupo,n_socio) ON DELETE CASCADE;

alter table destinada_a add constraint fk5 foreign key (id_categoria) references categoria(id_categoria) ON DELETE CASCADE;
alter table destinada_a add constraint fk6 foreign key (id_actividad) references actividad(id_actividad) ON DELETE CASCADE;

alter table puede_inscribirse_a add constraint fk7 foreign key (n_grupo,n_socio) references socio(n_grupo,n_socio) ON DELETE CASCADE;
alter table puede_inscribirse_a add constraint fk8 foreign key (id_actividad,id_zona,dia,horario) references puede_desarrollarse(id_actividad,id_zona,dia,horario) ON DELETE CASCADE;

alter table actividad_arancelada add constraint fk9 foreign key (id_actividad) references actividad(id_actividad);

alter table actividad_gratuita add constraint fk10 foreign key (id_actividad) references actividad(id_actividad);

alter table arancel_actividad add constraint fk11 foreign key (id_actividad) references actividad_arancelada(id_actividad);

alter table paga add constraint fk12 foreign key (n_grupo,n_socio) references socio(n_grupo,n_socio) ON DELETE CASCADE;
alter table paga add constraint fk13 foreign key (id_pago) references pago_actividad(id_pago) ON DELETE CASCADE;
alter table paga add constraint fk14 foreign key (id_arancel_actividad) references arancel_actividad(id_arancel_actividad) ON DELETE CASCADE;
alter table paga add constraint uk15 unique (id_arancel_actividad, id_pago);

alter table actividad_general add constraint fk16 foreign key (id_actividad) references actividad(id_actividad);

alter table actividad_especifica add constraint fk17 foreign key (id_actividad) references actividad(id_actividad);

alter table puede_desarrollarse add constraint fk18 foreign key (id_actividad) references actividad(id_actividad);
alter table puede_desarrollarse add constraint fk19 foreign key (id_zona) references zona(id_zona);

alter table esta_a_cargo add constraint fk20 foreign key (id_actividad,id_zona,dia,horario) references puede_desarrollarse(id_actividad,id_zona,dia,horario);
alter table esta_a_cargo add constraint fk21 foreign key (legajo) references profesional(legajo);

alter table puede_desempeñarla add constraint fk22 foreign key (legajo) references profesional(legajo);
alter table puede_desempeñarla add constraint fk23 foreign key (id_actividad) references actividad(id_actividad);

alter table profesional add constraint uk24 unique (documento);

alter table cuota_mensual add constraint fk25 foreign key (n_grupo) references grupo_familiar(n_grupo) ON DELETE CASCADE;

alter table abona add constraint fk26 foreign key (n_grupo,n_socio) references soc_titular(n_grupo,n_socio) ON DELETE CASCADE;
alter table abona add constraint fk27 foreign key (id_pagocuota) references pago_cuota(id_pagocuota);
alter table abona add constraint fk28 foreign key (id_cuotamensual) references cuota_mensual(id_cuotamensual);
alter table abona add constraint uk29 unique (id_cuotamensual,n_grupo,n_socio);

--CREO INDICES PARA AYUDAR EN LAS CONSULTAS
drop index indice_cuota;
drop index indice_socio_cargo;
drop index indice_socio_categoria;
create index indice_cuota on cuota_mensual(n_grupo);
create index indice_socio_cargo on socio(cargo);
create index indice_socio_categoria on socio(id_categoria);

commit; --SE REALIZO TODA LA INICIALIZACION DE LA BD DE MANERA CORRECTA


--TRIGGERS Y FUNCIONES PARA ELLOS *******************************************************************************************************
savepoint SPcalcular_monto;
create or replace function calcular_monto(num_grupo int, monto_b float) --DEVUELVE EL MONTO TOTAL A ABONAR DE UN GRUPO FAMILIAR
return float
is total float;
begin
    declare auxInfantil int;
            auxMayor int;
            auxVitalicio int;
            porcentajeInfantil float;
            porcentajeMayor float;
            porcentajeVitalicio float;
    begin
        select incremento_descuento into porcentajeInfantil from categoria where id_categoria=1;
        select incremento_descuento into porcentajeMayor from categoria where id_categoria=2;
        select incremento_descuento into porcentajeVitalicio from categoria where id_categoria=3;
        select count(*) into auxInfantil from socio where socio.n_grupo=num_grupo and socio.id_categoria=1;
        select count(*) into auxMayor from socio where socio.n_grupo=num_grupo and socio.id_categoria=2;
        select count(*) into auxVitalicio from socio where socio.n_grupo=num_grupo and socio.id_categoria=3;
        porcentajeInfantil:=porcentajeInfantil/100+1;
        porcentajeMayor:=porcentajeMayor/100+1;
        porcentajeVitalicio:=porcentajeVitalicio/100+1;
        total:=porcentajeInfantil*auxInfantil*monto_b+porcentajeMayor*auxMayor*monto_b+porcentajeVitalicio*auxVitalicio*monto_b;
        return total;
        rollback;
    end;
end;

savepoint SPtrg_insert_cuota_mensual;
create or replace trigger trg_insert_cuota_mensual --RESTRICCIONES EN CUANTO A LA INSERCION Y EXISTENCIA DE CATEGORIAS
before insert on cuota_mensual for each row
declare aux int;
begin
    :new.monto_total:=calcular_monto(:new.n_grupo, :new.monto_base);
end;

savepoint SPtrg_insert_categoria;
create or replace trigger trg_insert_categoria --RESTRICCIONES EN CUANTO A LA INSERCION Y EXISTENCIA DE CATEGORIAS
before insert on categoria for each row
declare
begin
    if (:NEW.tipo not in ('vitalicio','infantil','mayor'))
    then
        raise_application_error(-20500,'CATEGORIA INGRESADA INVALIDA');
    end if;
    if (:NEW.tipo not in ('infantil','mayor') AND :NEW.incremento_descuento not in (-100))
    then
        raise_application_error(-20500,'PORCENTAJE DE DESCUENTO A VITALICIO DEBE SER DEL 100%');
    end if;
end;

savepoint SPdevuelve_id_categoria;
create or replace function devuelve_id_categoria(nombre_cat varchar) --DEVUELVE EL ID DE LA CATEGORIA PASADA POR PARAMETRO
return int
is aux int;
begin
    select id_categoria into aux from categoria where tipo=nombre_cat;
    if (aux=null)
    then
        aux:=-1;
    end if;
    return aux;
    rollback;
end;


savepoint SPdevuelve_existencia_tit;
create or replace function devuelve_existencia_tit(numero_grupo int) --DEVUELVE 0 SI EL GRUPO PASADO NO TIENE UN TITULAR, SI TIENE DEVUELVE 1
return int
is aux int;
begin
    select count(*) into aux from soc_titular where numero_grupo=n_grupo;
    return aux;
    rollback;
end;


savepoint SPtrg_soctit_no_infantil;
create or replace trigger trg_soctit_no_infantil --UN SOCIO TITULAR NO PUEDE PERTENECER A LA CATEGORIA INFANTIL NI AGREGAR MAS DE UN SOCIO TITULAR POR GRUPO FAMILIAR
before insert on socio for each row
declare
begin
    if (:NEW.cargo in ('soc_titular') AND devuelve_existencia_tit(:new.n_grupo)>0)
    then
        raise_application_error(-20500,'ESTE GRUPO FAMILIAR YA TIENE UN SOCIO TITULAR');
    end if;
    if (:NEW.cargo in ('soc_notitular') AND devuelve_existencia_tit(:new.n_grupo)=0)
    then
        raise_application_error(-20500,'ESTE GRUPO FAMILIAR NO TIENE UN SOCIO TITULAR, EL INGRESADO DEBE SERLO');
    end if;
    if (:NEW.cargo in ('soc_titular') AND :NEW.id_categoria = devuelve_id_categoria('infantil'))
    then
        raise_application_error(-20500,'UN SOCIO TITULAR NO PUEDE PERTENECER A LA CATEGORIA INFANTIL');
    end if;
end;

savepoint SPdevuelve_max_grupo;
create or replace function devuelve_max_grupo(numero int) --DEVUELVE EL MAYOR NUMERO DE GRUPO PARA SEGUIR LA SECUENCIA
return int
is aux int;
begin
    declare aux2 int;
    begin
        select count(*) into aux2 from grupo_familiar;
        if (aux2>0)
        then
            select max(n_grupo) into aux from grupo_familiar;
        else
            aux:=0;
        end if;
        return aux+1;
    end;
end;

savepoint SPdevuelve_max_socio;
create or replace function devuelve_max_socio(numero_grupo int) --DEVUELVE EL MAYOR NUMERO DE GRUPO PARA SEGUIR LA SECUENCIA
return int
is aux int;
begin
    select max(n_socio) into aux from socio where n_grupo=numero_grupo;
    return aux+1;
    rollback;
end;


savepoint SPtrg_socio_y_grupo;
create or replace trigger trg_socio_y_grupo --PARA COMENZAR EL ID DE SOCIO EN 0 POR CADA GRUPO FAMILIAR O AGREGAR UN SOCIO A UN GRUPO FAMILIAR EXISTENTE
before insert on socio for each row
declare aux int;
begin
    if (:NEW.cargo in ('soc_titular'))
    then
        aux:=devuelve_max_grupo(0);
        insert into grupo_familiar(n_grupo,domicilio,telefono) values (aux,:new.domicilio,:new.telefono);
        :new.n_socio:=0;
        :new.n_grupo:=aux;
    end if;
    if (:NEW.cargo in ('soc_notitular'))
    then
        :new.n_socio:=devuelve_max_socio(:new.n_grupo);
    end if;
end;

savepoint SPtrg_inserto_cargo_socio;
create or replace trigger trg_inserto_cargo_socio --CUANDO SE CREA UN SOCIO SE CREA TAMBIEN EN LA TABLA QUE PERTENECE A SU CARGO
after insert on socio for each row
declare
begin
    if (:new.cargo in ('soc_titular'))
    then
        insert into soc_titular(n_grupo,n_socio) values (:new.n_grupo, :new.n_socio);
    else
        if (:new.cargo in ('soc_notitular'))
        then
            insert into soc_notitular(n_grupo,n_socio) values (:new.n_grupo, :new.n_socio);
        else
            raise_application_error(-20500,'CARGO DE SOCIO MAL INGRESADO');
        end if;
    end if;
end;


savepoint SPtrg_inserto_actividad;
create or replace trigger trg_inserto_actividad --CUANDO SE CREA UNA ACTIVIDAD, SE DETERMINA SI ES GRATUITA O ARANCELADA, Y ADEMÁS SI ES GENERAL O ESPECÍFICA
after insert on actividad for each row
declare
begin
    if (:new.costo in ('actividad_arancelada'))
    then
        insert into actividad_arancelada(id_actividad) values (:new.id_actividad);
    else
        if (:new.costo in ('actividad_gratuita'))
        then
            insert into actividad_gratuita(id_actividad) values (:new.id_actividad);
        else
            raise_application_error(-20500,'COSTO DE ACTIVIDAD INVALIDO');
        end if;
    end if;
    if (:new.tipo in ('actividad_especifica'))
    then
        insert into actividad_especifica(id_actividad) values (:new.id_actividad);
    else
        if (:new.tipo in ('actividad_general'))
        then
            insert into actividad_general(id_actividad) values (:new.id_actividad);
        else
            raise_application_error(-20500,'TIPO DE ACTIVIDAD INVALIDA');
        end if;
    end if;
end;


--ACA SE LLENA LA BASE DE DATOS *******************************************************************************************************
savepoint llenarBD;

insert into categoria(id_categoria,tipo,incremento_descuento) values (1,'infantil',-10);
insert into categoria(id_categoria,tipo,incremento_descuento) values (2,'mayor',8);
insert into categoria(id_categoria,tipo,incremento_descuento) values (3,'vitalicio',-100);

insert into profesional(legajo,nombre,apellido,documento,domicilio,telefono) values (1,'Cesar','Paz','42569145','Alvear 1147','2236987458');
insert into profesional(legajo,nombre,apellido,documento,domicilio,telefono) values (2,'Christian','Paz','42544785','Lavalle 4447','2236987458');
insert into profesional(legajo,nombre,apellido,documento,domicilio,telefono) values (3,'Pablo','Perez','41457145','Rivas 7823','2236987458');
insert into profesional(legajo,nombre,apellido,documento,domicilio,telefono) values (4,'Estanislao','McAllister','40329145','Guemes 7814','2236987458');
insert into profesional(legajo,nombre,apellido,documento,domicilio,telefono) values (5,'Raul','Seijo','44829145','Gianelli 7165','2236987458');
insert into profesional(legajo,nombre,apellido,documento,domicilio,telefono) values (6,'Pedro','Pinto','40219145','Tucuman 7414','2236987458');
insert into profesional(legajo,nombre,apellido,documento,domicilio,telefono) values (7,'Mariano','Martinelli','40377145','Matienzo 6677','2236987458');
insert into profesional(legajo,nombre,apellido,documento,domicilio,telefono) values (8,'Alejandra','Chavez','40045145','Avellaneda 1227','2236987458');
insert into profesional(legajo,nombre,apellido,documento,domicilio,telefono) values (9,'Mariana','Mariani','42879145','Constitucion 5466','2236987458');
insert into profesional(legajo,nombre,apellido,documento,domicilio,telefono) values (10,'Agustina','Martinez','42500355','Juan B Justo 6545','2236987458');

insert into actividad(id_actividad,descripcion,tipo,costo) values (1,'Futbol','actividad_general','actividad_gratuita');
insert into actividad(id_actividad,descripcion,tipo,costo) values (2,'Basket','actividad_general','actividad_gratuita');
insert into actividad(id_actividad,descripcion,tipo,costo) values (3,'Volley','actividad_general','actividad_gratuita');
insert into actividad(id_actividad,descripcion,tipo,costo) values (4,'Handball','actividad_especifica','actividad_gratuita');
insert into actividad(id_actividad,descripcion,tipo,costo) values (5,'Boxeo','actividad_especifica','actividad_arancelada'); update actividad_arancelada set periodo_de_pago='mensual', importe=1000 where id_actividad=5;
insert into actividad(id_actividad,descripcion,tipo,costo) values (6,'Tennis','actividad_general','actividad_arancelada'); update actividad_arancelada set periodo_de_pago='mensual', importe=1500 where id_actividad=6;
insert into actividad(id_actividad,descripcion,tipo,costo) values (7,'Padel','actividad_especifica','actividad_arancelada'); update actividad_arancelada set periodo_de_pago='bimestral', importe=2000 where id_actividad=7;
insert into actividad(id_actividad,descripcion,tipo,costo) values (8,'Natacion','actividad_general','actividad_arancelada'); update actividad_arancelada set periodo_de_pago='bimestral', importe=2000 where id_actividad=8;
insert into actividad(id_actividad,descripcion,tipo,costo) values (9,'Artes Marciales','actividad_especifica','actividad_arancelada'); update actividad_arancelada set periodo_de_pago='mensual', importe=1500 where id_actividad=9;

insert into puede_desempeñarla(legajo,id_actividad) values (1,1);
insert into puede_desempeñarla(legajo,id_actividad) values (2,1);
insert into puede_desempeñarla(legajo,id_actividad) values (3,1);
insert into puede_desempeñarla(legajo,id_actividad) values (1,2);
insert into puede_desempeñarla(legajo,id_actividad) values (2,2);
insert into puede_desempeñarla(legajo,id_actividad) values (4,3);
insert into puede_desempeñarla(legajo,id_actividad) values (5,3);
insert into puede_desempeñarla(legajo,id_actividad) values (1,4);
insert into puede_desempeñarla(legajo,id_actividad) values (2,4);
insert into puede_desempeñarla(legajo,id_actividad) values (6,5);
insert into puede_desempeñarla(legajo,id_actividad) values (7,5);
insert into puede_desempeñarla(legajo,id_actividad) values (8,6);
insert into puede_desempeñarla(legajo,id_actividad) values (8,7);
insert into puede_desempeñarla(legajo,id_actividad) values (9,7);
insert into puede_desempeñarla(legajo,id_actividad) values (10,8);
insert into puede_desempeñarla(legajo,id_actividad) values (7,9);

insert into zona(id_zona,ubicacion,capacidad,estado_mantenimiento) values (1,'Punto A', 30, 'Habilitada'); --LAS UBICACIONES LAS SUPONEMOS EN PUNTOS DE UN MAPA QUE SE EXCIBE EN LA RECEPCION DEL CLUB
insert into zona(id_zona,ubicacion,capacidad,estado_mantenimiento) values (2,'Punto B', 20, 'Habilitada');
insert into zona(id_zona,ubicacion,capacidad,estado_mantenimiento) values (3,'Punto C', 10, 'En mantenimiento');
insert into zona(id_zona,ubicacion,capacidad,estado_mantenimiento) values (4,'Punto D', 10, 'Habilitada');
insert into zona(id_zona,ubicacion,capacidad,estado_mantenimiento) values (5,'Punto E', 15, 'Habilitada');
insert into zona(id_zona,ubicacion,capacidad,estado_mantenimiento) values (6,'Punto F', 6, 'Habilitada');
insert into zona(id_zona,ubicacion,capacidad,estado_mantenimiento) values (7,'Punto G', 4, 'Habilitada');

insert into destinada_a(id_categoria,id_actividad) values (1,4);
insert into destinada_a(id_categoria,id_actividad) values (2,4);
insert into destinada_a(id_categoria,id_actividad) values (2,5);
insert into destinada_a(id_categoria,id_actividad) values (2,7);
insert into destinada_a(id_categoria,id_actividad) values (3,7);
insert into destinada_a(id_categoria,id_actividad) values (2,9);

insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (1,1,'sabado','12:00','01/09/2021 a 01/10/2021');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (1,1,'lunes','17:00','01/11/2021 a 01/01/2022');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (2,2,'martes','09:00','01/09/2021 a 01/12/2021');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (3,5,'lunes','11:00','01/09/2021 a 01/11/2021');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (3,5,'miercoles','10:00','01/11/2021 a 01/12/2021');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (4,5,'jueves','18:00','01/10/2021 a 01/12/2021');-- HASTA ACA LAS ACTIVIDADES DESARROLLADAS EN 2021
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (1,1,'miercoles','18:00','01/10/2022 a 01/12/2022');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (1,1,'miercoles','17:00','01/11/2022 a 01/03/2023');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (1,1,'miercoles','19:00','01/10/2022 a 01/12/2022');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (2,2,'martes','14:00','01/11/2022 a 01/04/2023');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (2,2,'jueves','15:00','01/10/2022 a 01/12/2022');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (3,5,'miercoles','11:00','01/10/2022 a 01/01/2023');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (3,5,'martes','20:00','01/10/2022 a 01/12/2022');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (4,5,'viernes','18:00','01/09/2022 a 01/12/2022');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (5,4,'lunes','11:00','01/10/2022 a 01/02/2023');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (6,6,'viernes','12:00','01/09/2022 a 01/12/2022');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (7,6,'martes','14:00','01/09/2022 a 01/01/2023');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (8,7,'martes','09:00','01/11/2022 a 01/01/2023');
insert into puede_desarrollarse(id_actividad,id_zona,dia,horario,periodo) values (9,4,'sabado','15:00','01/09/2022 a 01/12/2022');

insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (1,1,1,'miercoles','18:00');
insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (2,1,1,'miercoles','17:00');
insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (3,1,1,'miercoles','19:00');
insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (1,2,2,'martes','14:00');
insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (2,2,2,'jueves','15:00');
insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (4,3,5,'miercoles','11:00');
insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (5,3,5,'martes','20:00');
insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (1,4,5,'viernes','18:00');
insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (6,5,4,'lunes','11:00');
insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (8,6,6,'viernes','12:00');
insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (9,7,6,'martes','14:00');
insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (10,8,7,'martes','09:00');
insert into esta_a_cargo(legajo,id_actividad,id_zona,dia,horario) values (7,9,4,'sabado','15:00');

--PRIMERO AGREGO SOLO SOCIOS TITULARES, ASI SE ARMAN LOS GRUPOS FAMILIARES
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('Gaston Rabe','Larrea 887', '2236326688','gr@gmail.com',TO_DATE('06-04-2000','DD/MM/YY'),'soc_titular',3);
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('Tobias Andrade','Lavalle 877', '2236324488','ta@gmail.com',TO_DATE('21-07-2000','DD/MM/YY'),'soc_titular',2);
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('Felipe Zotes','Alvear 217', '2236326487','fz@gmail.com',TO_DATE('21-02-2003','DD/MM/YY'),'soc_titular',3);
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('Santiago Escalante','Juncal 881', '2236321234','se@gmail.com',TO_DATE('30-11-1998','DD/MM/YY'),'soc_titular',2);
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('Valentin Garcia','Alsina 854', '2236345741','vg@gmail.com',TO_DATE('06-08-1998','DD/MM/YY'),'soc_titular',2);
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('Pedro Meza','Alem 447', '2235286688','pm@gmail.com',TO_DATE('07-01-2000','DD/MM/YY'),'soc_titular',3);
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('Masimo Viña','Paz 5447', '2237831688','mv@gmail.com',TO_DATE('06-01-1973','DD/MM/YY'),'soc_titular',3);
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('Lionel Messi','Olavarria 5487', '2231145688','lm@gmail.com',TO_DATE('21-11-1988','DD/MM/YY'),'soc_titular',2);
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('Angel Maria','Zarate 7891', '2236112288','am@gmail.com',TO_DATE('11-11-2000','DD/MM/YY'),'soc_titular',2);
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('Rodrigo Paul','España 4571', '2236324589','rp@gmail.com',TO_DATE('03-03-1992','DD/MM/YY'),'soc_titular',3);
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('Gonzalo Montiel','Guemes 7445', '2236321111','gm@gmail.com',TO_DATE('06-07-1994','DD/MM/YY'),'soc_titular',2);

--AHORA AGREGO SOCIOS NO TITULARES CON SU NRO DE GRUPO
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (1,'Chris Rabe','Larrea 887','2236326687','cr@gmail.com',TO_DATE('01-04-2001','DD/MM/YY'),'soc_notitular',1);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (1,'Romina Rabe','Larrea 887','2234477687','rr@gmail.com',TO_DATE('10-12-2003','DD/MM/YY'),'soc_notitular',1);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (1,'Pedro Mas','O Higgins 747','2236344447','pm@gmail.com',TO_DATE('11-11-1998','DD/MM/YY'),'soc_notitular',3);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (1,'Cami Rabe','Paunero 1478','2234458687','cr1@gmail.com',TO_DATE('07-11-2000','DD/MM/YY'),'soc_notitular',2);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (1,'Gonzalo Paez','Mendoza 117','2237653687','gp@gmail.com',TO_DATE('04-10-2002','DD/MM/YY'),'soc_notitular',2);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (2,'Marcela Andrade','Brasil 177','2239637687','ma@gmail.com',TO_DATE('04-02-1979','DD/MM/YY'),'soc_notitular',3);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (2,'Maxi Andrade','Matheu 257','2238857687','ma1@gmail.com',TO_DATE('07-10-1998','DD/MM/YY'),'soc_notitular',2);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (2,'Alvaro Nat','Rivas 447','2237778578','an@gmail.com',TO_DATE('12-11-2002','DD/MM/YY'),'soc_notitular',1);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (2,'Pedro McAl','Rivadavia 997','223777474','pm@gmail.com',TO_DATE('30-10-2001','DD/MM/YY'),'soc_notitular',2);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (3,'Pedro Zotes','Mendoza 228','2237147687','gp@gmail.com',TO_DATE('04-10-2002','DD/MM/YY'),'soc_notitular',3);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (3,'Alejandra Perez','Alvear 187','2235478687','gp@gmail.com',TO_DATE('04-10-1999','DD/MM/YY'),'soc_notitular',2);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (3,'Marcela Mas','Mendoza 917','2237257687','gp@gmail.com',TO_DATE('04-09-0998','DD/MM/YY'),'soc_notitular',3);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (3,'Julieta Zotes','Rivas 777','2237967687','gp@gmail.com',TO_DATE('19-11-2002','DD/MM/YY'),'soc_notitular',2);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (3,'Marcos Zotes','Paz 447','2239977687','gp@gmail.com',TO_DATE('17-10-2002','DD/MM/YY'),'soc_notitular',3);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (4,'Juan Escalante','O Higgins 777','2239477687','je@gmail.com',TO_DATE('04-04-2002','DD/MM/YY'),'soc_notitular',1);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (4,'Matias Rojas','Paz 447','2239977687','mr@gmail.com',TO_DATE('11-10-2003','DD/MM/YY'),'soc_notitular',1);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (4,'Paula Boninazi','Alvarado 4545','2239977687','pb@gmail.com',TO_DATE('19-09-1999','DD/MM/YY'),'soc_notitular',3);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (6,'Paula Alvarez','Alem 447','2239977687','pa@gmail.com',TO_DATE('29-04-1999','DD/MM/YY'),'soc_notitular',2);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (6,'Maria Meza','Alem 447','2239977687','mm@gmail.com',TO_DATE('24-12-1999','DD/MM/YY'),'soc_notitular',3);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (6,'Pablo Meza','Alvarado 4889','2239977687','pm@gmail.com',TO_DATE('19-09-2000','DD/MM/YY'),'soc_notitular',2);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (7,'Minimo Virg','Avellaneda 1234','2234455687','mv@gmail.com',TO_DATE('11-01-2000','DD/MM/YY'),'soc_notitular',1);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (7,'Ezequiel Lomb','Avellaneda 1234','2236699687','el@gmail.com',TO_DATE('27-02-2000','DD/MM/YY'),'soc_notitular',2);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (8,'Antonella Roccuzzo','Guemes 1247','2237788687','ar@gmail.com',TO_DATE('21-11-2000','DD/MM/YY'),'soc_notitular',2);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (9,'Alfonsa Maria','Zarate 7891','2236644687','am@gmail.com',TO_DATE('05-05-1997','DD/MM/YY'),'soc_notitular',1);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (9,'Ezequiel Maria','Zarate 7891','2238877687','em@gmail.com',TO_DATE('27-04-2001','DD/MM/YY'),'soc_notitular',1);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (9,'Pedro Maria','Zarate 7891','2231144687','pm@gmail.com',TO_DATE('10-04-2000','DD/MM/YY'),'soc_notitular',3);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (10,'Tini Paul','España 4571','2239978687','tp@gmail.com',TO_DATE('11-04-1994','DD/MM/YY'),'soc_notitular',3);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (10,'Camila Homs','Atlantida Arg 7125','2235324687','ch@gmail.com',TO_DATE('17-07-2000','DD/MM/YY'),'soc_notitular',2);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (10,'Chicha Paul','España 4571','2235547687','cp@gmail.com',TO_DATE('20-09-2001','DD/MM/YY'),'soc_notitular',1);
insert into socio(n_grupo,nombre,domicilio,telefono,correo_electronico,fecha_nacimiento,cargo,ID_categoria) values (11,'Paula Montiel','Guemes 7445','2234784687','pm@gmail.com',TO_DATE('09-12-2018','DD/MM/YY'),'soc_notitular',1);
--GRUPOS 1 2 Y 4 SON LOS UNICOS QUE ESTAN DESDE EL AÑO PASADO
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-36,1000,'mensual','si',TO_DATE('01-09-2021','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-35,1000,'mensual','si',TO_DATE('01-10-2021','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-34,1000,'mensual','si',TO_DATE('01-11-2021','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-33,1000,'mensual','si',TO_DATE('01-12-2021','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-32,1000,'mensual','si',TO_DATE('01-01-2022','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-31,1000,'mensual','si',TO_DATE('01-02-2022','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-30,1000,'mensual','si',TO_DATE('01-03-2022','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-29,1000,'mensual','si',TO_DATE('01-04-2022','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-28,1000,'mensual','si',TO_DATE('01-05-2022','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-27,1000,'mensual','si',TO_DATE('01-06-2022','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-26,1000,'mensual','si',TO_DATE('01-07-2022','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-25,1000,'mensual','si',TO_DATE('01-08-2022','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-24,1000,'mensual','si',TO_DATE('01-09-2021','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-23,1000,'mensual','si',TO_DATE('01-10-2021','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-22,1000,'mensual','si',TO_DATE('01-11-2021','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-21,1000,'mensual','si',TO_DATE('01-12-2021','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-20,1000,'mensual','si',TO_DATE('01-01-2022','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-19,1000,'mensual','si',TO_DATE('01-02-2022','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-18,1000,'mensual','si',TO_DATE('01-03-2022','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-17,1000,'mensual','si',TO_DATE('01-04-2022','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-16,1000,'mensual','si',TO_DATE('01-05-2022','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-15,1000,'mensual','si',TO_DATE('01-06-2022','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-14,1000,'mensual','si',TO_DATE('01-07-2022','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-13,1000,'mensual','si',TO_DATE('01-08-2022','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-12,1000,'mensual','si',TO_DATE('01-09-2021','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-11,1000,'mensual','si',TO_DATE('01-10-2021','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-10,1000,'mensual','si',TO_DATE('01-11-2021','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-9,1000,'mensual','si',TO_DATE('01-12-2021','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-8,1000,'mensual','si',TO_DATE('01-01-2022','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-7,1000,'mensual','si',TO_DATE('01-02-2022','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-6,1000,'mensual','si',TO_DATE('01-03-2022','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-5,1000,'mensual','si',TO_DATE('01-04-2022','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-4,1000,'mensual','si',TO_DATE('01-05-2022','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-3,1000,'mensual','si',TO_DATE('01-06-2022','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-2,1000,'mensual','si',TO_DATE('01-07-2022','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (-1,1000,'mensual','si',TO_DATE('01-08-2022','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (1,1000,'mensual','si',TO_DATE('01-09-2022','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (2,1000,'mensual','si',TO_DATE('01-10-2022','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (3,1500,'mensual','no',TO_DATE('01-11-2022','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (4,1500,'mensual','no',TO_DATE('01-12-2022','DD/MM/YY'),1);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (5,1000,'mensual','si',TO_DATE('01-09-2022','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (6,1000,'mensual','si',TO_DATE('01-10-2022','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (7,1500,'mensual','si',TO_DATE('01-11-2022','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (8,1500,'mensual','si',TO_DATE('01-12-2022','DD/MM/YY'),2);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (9,1000,'mensual','si',TO_DATE('01-09-2022','DD/MM/YY'),3);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (10,1000,'mensual','no',TO_DATE('01-10-2022','DD/MM/YY'),3);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (11,1500,'mensual','no',TO_DATE('01-11-2022','DD/MM/YY'),3);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (12,1500,'mensual','no',TO_DATE('01-12-2022','DD/MM/YY'),3);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (13,1000,'mensual','si',TO_DATE('01-09-2022','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (14,1000,'mensual','si',TO_DATE('01-10-2022','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (15,1500,'mensual','si',TO_DATE('01-11-2022','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (16,1500,'mensual','no',TO_DATE('01-12-2022','DD/MM/YY'),4);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (17,1000,'mensual','si',TO_DATE('01-09-2022','DD/MM/YY'),5);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (18,1000,'mensual','no',TO_DATE('01-10-2022','DD/MM/YY'),5);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (19,1500,'mensual','no',TO_DATE('01-11-2022','DD/MM/YY'),5);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (20,1500,'mensual','no',TO_DATE('01-12-2022','DD/MM/YY'),5);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (21,1500,'mensual','si',TO_DATE('01-11-2022','DD/MM/YY'),6);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (22,1500,'mensual','no',TO_DATE('01-12-2022','DD/MM/YY'),6);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (23,1500,'mensual','si',TO_DATE('01-12-2022','DD/MM/YY'),7);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (24,1000,'mensual','si',TO_DATE('01-10-2022','DD/MM/YY'),8);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (25,1500,'mensual','si',TO_DATE('01-11-2022','DD/MM/YY'),8);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (26,1500,'mensual','si',TO_DATE('01-12-2022','DD/MM/YY'),8);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (27,1000,'mensual','no',TO_DATE('01-09-2022','DD/MM/YY'),9);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (28,1000,'mensual','no',TO_DATE('01-10-2022','DD/MM/YY'),9);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (29,1500,'mensual','no',TO_DATE('01-11-2022','DD/MM/YY'),9);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (30,1500,'mensual','no',TO_DATE('01-12-2022','DD/MM/YY'),9);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (31,1000,'mensual','si',TO_DATE('01-09-2022','DD/MM/YY'),10);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (32,1000,'mensual','si',TO_DATE('01-10-2022','DD/MM/YY'),10);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (33,1500,'mensual','si',TO_DATE('01-11-2022','DD/MM/YY'),10);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (34,1500,'mensual','si',TO_DATE('01-12-2022','DD/MM/YY'),10);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (35,1000,'mensual','si',TO_DATE('01-09-2022','DD/MM/YY'),11);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (36,1000,'mensual','no',TO_DATE('01-10-2022','DD/MM/YY'),11);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (37,1500,'mensual','no',TO_DATE('01-11-2022','DD/MM/YY'),11);
insert into cuota_mensual(id_cuotamensual,monto_base,periodo_vigencia,descripcion_pago,fecha_emision,n_grupo) values (38,1500,'mensual','no',TO_DATE('01-12-2022','DD/MM/YY'),11);

--PUEDE INSCRIBIRSE A 2021
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (2,3,1,1,'sabado','12:00',TO_DATE('25-08-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (4,0,1,1,'sabado','12:00',TO_DATE('01-09-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (3,5,1,1,'lunes','17:00',TO_DATE('25-10-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (11,0,1,1,'lunes','17:00',TO_DATE('25-09-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (2,0,1,1,'lunes','17:00',TO_DATE('01-10-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (3,5,2,2,'martes','09:00',TO_DATE('01-09-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (4,0,2,2,'martes','09:00',TO_DATE('28-08-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (2,3,2,2,'martes','09:00',TO_DATE('30-08-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (2,0,2,2,'martes','09:00',TO_DATE('30-08-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (2,3,3,5,'lunes','11:00',TO_DATE('01-09-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (4,0,3,5,'lunes','11:00',TO_DATE('27-08-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (2,3,3,5,'miercoles','10:00',TO_DATE('01-11-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (4,0,3,5,'miercoles','10:00',TO_DATE('29-10-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (2,0,3,5,'miercoles','10:00',TO_DATE('29-10-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (4,0,4,5,'jueves','18:00',TO_DATE('01-10-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (2,3,4,5,'jueves','18:00',TO_DATE('29-09-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (3,4,4,5,'jueves','18:00',TO_DATE('30-09-2021','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (2,0,4,5,'jueves','18:00',TO_DATE('30-09-2021','DD/MM/YY'));
--PUEDE INSCRIBIRSE A 2022
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,0,1,1,'miercoles','18:00',TO_DATE('25-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (2,1,1,1,'miercoles','18:00',TO_DATE('14-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,3,1,1,'miercoles','18:00',TO_DATE('20-09-2022','DD/MM/YY')); 
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (4,3,1,1,'miercoles','18:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (4,0,1,1,'miercoles','18:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,1,1,1,'miercoles','18:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,2,1,1,'miercoles','18:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (11,0,1,1,'miercoles','17:00',TO_DATE('01-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (8,1,1,1,'miercoles','17:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,4,1,1,'miercoles','17:00',TO_DATE('13-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (7,0,1,1,'miercoles','17:00',TO_DATE('20-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,4,1,1,'miercoles','17:00',TO_DATE('21-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (2,4,1,1,'miercoles','17:00',TO_DATE('11-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (8,1,1,1,'miercoles','19:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (9,3,1,1,'miercoles','19:00',TO_DATE('24-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (7,2,2,2,'martes','14:00',TO_DATE('30-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (7,1,2,2,'martes','14:00',TO_DATE('25-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (10,1,2,2,'martes','14:00',TO_DATE('20-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (4,0,2,2,'martes','14:00',TO_DATE('20-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,1,2,2,'martes','14:00',TO_DATE('20-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,2,2,2,'martes','14:00',TO_DATE('20-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (10,2,2,2,'jueves','15:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (3,2,2,2,'jueves','15:00',TO_DATE('29-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (3,3,2,2,'jueves','15:00',TO_DATE('28-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (3,5,3,5,'miercoles','11:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (4,0,3,5,'miercoles','11:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,1,3,5,'miercoles','11:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,2,3,5,'miercoles','11:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (4,1,3,5,'martes','20:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (3,4,3,5,'martes','20:00',TO_DATE('28-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (2,3,4,5,'viernes','18:00',TO_DATE('01-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (4,0,4,5,'viernes','18:00',TO_DATE('01-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,1,4,5,'viernes','18:00',TO_DATE('01-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,2,4,5,'viernes','18:00',TO_DATE('01-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (5,0,5,4,'lunes','11:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,5,5,4,'lunes','11:00',TO_DATE('30-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,4,5,4,'lunes','11:00',TO_DATE('01-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (1,0,6,6,'viernes','12:00',TO_DATE('01-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (7,0,6,6,'viernes','12:00',TO_DATE('01-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (10,2,7,6,'martes','14:00',TO_DATE('30-08-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (9,3,7,6,'martes','14:00',TO_DATE('01-09-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (9,1,8,7,'martes','09:00',TO_DATE('28-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (10,2,8,7,'martes','09:00',TO_DATE('01-10-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (4,3,8,7,'martes','09:00',TO_DATE('01-11-2022','DD/MM/YY'));
insert into puede_inscribirse_a(n_grupo,n_socio,id_actividad,id_zona,dia,horario,fecha_inscripcion) values (6,3,9,4,'sabado','15:00',TO_DATE('01-09-2022','DD/MM/YY'));
--TERMINA PUEDE INSCRIBIRSE

insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-36,TO_DATE('15-09-2022','DD/MM/YY'),800);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-35,TO_DATE('17-10-2022','DD/MM/YY'),800);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-34,TO_DATE('02-11-2022','DD/MM/YY'),800);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-33,TO_DATE('30-12-2022','DD/MM/YY'),800);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-32,TO_DATE('12-01-2022','DD/MM/YY'),850);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-31,TO_DATE('04-02-2022','DD/MM/YY'),850);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-30,TO_DATE('29-03-2022','DD/MM/YY'),850);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-29,TO_DATE('12-04-2022','DD/MM/YY'),900);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-28,TO_DATE('16-05-2022','DD/MM/YY'),900);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-27,TO_DATE('09-06-2022','DD/MM/YY'),900);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-26,TO_DATE('07-07-2022','DD/MM/YY'),1000);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-25,TO_DATE('05-08-2022','DD/MM/YY'),1000);--PAGOS ANTERIORES GRUPO 1
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-24,TO_DATE('15-09-2022','DD/MM/YY'),800);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-23,TO_DATE('17-10-2022','DD/MM/YY'),800);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-22,TO_DATE('02-11-2022','DD/MM/YY'),800);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-21,TO_DATE('30-12-2022','DD/MM/YY'),800);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-20,TO_DATE('12-01-2022','DD/MM/YY'),850);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-19,TO_DATE('04-02-2022','DD/MM/YY'),850);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-18,TO_DATE('29-03-2022','DD/MM/YY'),850);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-17,TO_DATE('12-04-2022','DD/MM/YY'),900);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-16,TO_DATE('16-05-2022','DD/MM/YY'),900);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-15,TO_DATE('09-06-2022','DD/MM/YY'),900);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-14,TO_DATE('07-07-2022','DD/MM/YY'),1000);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-13,TO_DATE('05-08-2022','DD/MM/YY'),1000);--PAGOS ANTERIORES GRUPO 2
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-12,TO_DATE('15-09-2022','DD/MM/YY'),800);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-11,TO_DATE('17-10-2022','DD/MM/YY'),800);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-10,TO_DATE('02-11-2022','DD/MM/YY'),800);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-9,TO_DATE('30-12-2022','DD/MM/YY'),800);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-8,TO_DATE('12-01-2022','DD/MM/YY'),850);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-7,TO_DATE('04-02-2022','DD/MM/YY'),850);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-6,TO_DATE('29-03-2022','DD/MM/YY'),850);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-5,TO_DATE('12-04-2022','DD/MM/YY'),900);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-4,TO_DATE('16-05-2022','DD/MM/YY'),900);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-3,TO_DATE('09-06-2022','DD/MM/YY'),900);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-2,TO_DATE('07-07-2022','DD/MM/YY'),1000);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (-1,TO_DATE('05-08-2022','DD/MM/YY'),1000);--PAGOS ANTERIORES GRUPO 4
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (1,TO_DATE('12-09-2022','DD/MM/YY'),1000);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (2,TO_DATE('09-10-2022','DD/MM/YY'),1000);--PAGOS DEL GRUPO 1
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (3,TO_DATE('13-09-2022','DD/MM/YY'),1000);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (4,TO_DATE('01-10-2022','DD/MM/YY'),1000);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (5,TO_DATE('10-11-2022','DD/MM/YY'),1500);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (6,TO_DATE('01-12-2022','DD/MM/YY'),1500);--PAGOS GRUPO 2
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (7,TO_DATE('28-09-2022','DD/MM/YY'),1000);--PAGOS GRUPO 3
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (8,TO_DATE('02-09-2022','DD/MM/YY'),1000);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (9,TO_DATE('10-10-2022','DD/MM/YY'),1000);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (10,TO_DATE('20-11-2022','DD/MM/YY'),1500);--PAGOS GRUPO 4
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (11,TO_DATE('12-09-2022','DD/MM/YY'),1000);--PAGOS GRUPO 5
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (12,TO_DATE('02-11-2022','DD/MM/YY'),1500);--PAGOS GRUPO 6
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (13,TO_DATE('02-12-2022','DD/MM/YY'),1400);--PAGOS GRUPO 7
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (14,TO_DATE('14-10-2022','DD/MM/YY'),1000);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (15,TO_DATE('02-11-2022','DD/MM/YY'),1500);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (16,TO_DATE('01-12-2022','DD/MM/YY'),1500);--PAGOS GRUPO 8
--GRUPO 9 NO TIENE PAGOS
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (17,TO_DATE('10-09-2022','DD/MM/YY'),1000);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (18,TO_DATE('12-10-2022','DD/MM/YY'),1000);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (19,TO_DATE('03-11-2022','DD/MM/YY'),1500);
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (20,TO_DATE('01-12-2022','DD/MM/YY'),1500);--PAGOS GRUPO 10
insert into pago_cuota(id_pagocuota,fecha_pago,monto_abonadocuota) values (21,TO_DATE('01-09-2022','DD/MM/YY'),1000);--PAGOS GRUPO 11


insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-36,1,0,-36);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-35,1,0,-35);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-34,1,0,-34);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-33,1,0,-33);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-32,1,0,-32);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-31,1,0,-31);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-30,1,0,-30);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-29,1,0,-29);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-28,1,0,-28);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-27,1,0,-27);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-26,1,0,-26);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-25,1,0,-25);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-24,2,0,-24);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-23,2,0,-23);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-22,2,0,-22);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-21,2,0,-21);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-20,2,0,-20);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-19,2,0,-19);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-18,2,0,-18);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-17,2,0,-17);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-16,2,0,-16);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-15,2,0,-15);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-14,2,0,-14);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-13,2,0,-13);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-12,4,0,-12);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-11,4,0,-11);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-10,4,0,-10);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-9,4,0,-9);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-8,4,0,-8);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-7,4,0,-7);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-6,4,0,-6);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-5,4,0,-5);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-4,4,0,-4);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-3,4,0,-3);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-2,4,0,-2);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (-1,4,0,-1);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (1,1,0,1);--
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (2,1,0,2);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (3,2,0,5);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (4,2,0,6);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (5,2,0,7);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (6,2,0,8);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (7,3,0,9);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (8,4,0,13);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (9,4,0,14);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (10,4,0,15);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (11,5,0,17);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (12,6,0,21);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (13,7,0,23);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (14,8,0,24);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (15,8,0,25);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (16,8,0,26);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (17,10,0,31);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (18,10,0,32);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (19,10,0,33);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (20,10,0,34);
insert into abona(id_pagocuota,n_grupo,n_socio,id_cuotamensual) values (21,11,0,35);


insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (1,TO_DATE('01-10-2022','DD/MM/YY'),'si',5);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (2,TO_DATE('01-11-2022','DD/MM/YY'),'si',5);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (3,TO_DATE('01-12-2022','DD/MM/YY'),'si',5);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (4,TO_DATE('01-01-2023','DD/MM/YY'),'si',5);--DE 5 0
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (5,TO_DATE('01-10-2022','DD/MM/YY'),'si',5);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (6,TO_DATE('01-11-2022','DD/MM/YY'),'si',5);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (7,TO_DATE('01-12-2022','DD/MM/YY'),'no',5);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (8,TO_DATE('01-01-2023','DD/MM/YY'),'no',5);--DE 1 5
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (9,TO_DATE('01-10-2022','DD/MM/YY'),'si',5);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (10,TO_DATE('01-11-2022','DD/MM/YY'),'si',5);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (11,TO_DATE('01-12-2022','DD/MM/YY'),'no',5);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (12,TO_DATE('01-01-2023','DD/MM/YY'),'no',5);--DE 1 4
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (13,TO_DATE('01-09-2022','DD/MM/YY'),'si',6);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (14,TO_DATE('01-11-2022','DD/MM/YY'),'si',6);--DE 1 0
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (15,TO_DATE('01-09-2022','DD/MM/YY'),'si',6);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (16,TO_DATE('01-11-2022','DD/MM/YY'),'no',6);--DE 7 0
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (17,TO_DATE('01-09-2022','DD/MM/YY'),'si',7);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (18,TO_DATE('01-11-2022','DD/MM/YY'),'si',7);--DE 10 2
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (19,TO_DATE('01-09-2022','DD/MM/YY'),'si',7);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (20,TO_DATE('01-11-2022','DD/MM/YY'),'no',7);--DE 9 3
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (21,TO_DATE('01-11-2022','DD/MM/YY'),'si',8);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (22,TO_DATE('01-12-2022','DD/MM/YY'),'si',8);--DE 9 1
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (23,TO_DATE('01-11-2022','DD/MM/YY'),'si',8);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (24,TO_DATE('01-12-2022','DD/MM/YY'),'si',8);--DE 10 2
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (25,TO_DATE('01-11-2022','DD/MM/YY'),'si',8);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (26,TO_DATE('01-12-2022','DD/MM/YY'),'no',8);--DE 4 3
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (27,TO_DATE('01-09-2022','DD/MM/YY'),'si',9);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (28,TO_DATE('01-10-2022','DD/MM/YY'),'no',9);
insert into arancel_actividad(id_arancel_actividad,fecha_emision,descripcion_pago,id_actividad) values (29,TO_DATE('01-11-2022','DD/MM/YY'),'no',9);--DE 6 3

insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (1,TO_DATE('01-10-2022','DD/MM/YY'),1000);
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (2,TO_DATE('01-10-2022','DD/MM/YY'),1000);
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (3,TO_DATE('01-10-2022','DD/MM/YY'),1000);
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (4,TO_DATE('01-10-2022','DD/MM/YY'),1000);--PAGOS DE 5 0
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (5,TO_DATE('01-10-2022','DD/MM/YY'),1000);
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (6,TO_DATE('01-10-2022','DD/MM/YY'),1000);--PAGOS DE 1 5
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (7,TO_DATE('01-10-2022','DD/MM/YY'),1000);
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (8,TO_DATE('01-10-2022','DD/MM/YY'),1000);--PAGOS DE 1 4
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (9,TO_DATE('01-10-2022','DD/MM/YY'),1500);
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (10,TO_DATE('01-10-2022','DD/MM/YY'),1500);--PAGOS DE 1 0
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (11,TO_DATE('01-10-2022','DD/MM/YY'),1500);--PAGOS DE 7 0
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (12,TO_DATE('01-10-2022','DD/MM/YY'),2000);
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (13,TO_DATE('01-10-2022','DD/MM/YY'),2000);--PAGOS DE 10 2
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (14,TO_DATE('01-10-2022','DD/MM/YY'),2000);--PAGOS DE 9 3
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (15,TO_DATE('01-10-2022','DD/MM/YY'),2000);
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (16,TO_DATE('01-10-2022','DD/MM/YY'),2000);--PAGOS DE 9 1
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (17,TO_DATE('01-10-2022','DD/MM/YY'),2000);
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (18,TO_DATE('01-10-2022','DD/MM/YY'),2000);--PAGOS DE 10 2
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (19,TO_DATE('01-10-2022','DD/MM/YY'),2000);--PAGOS DE 4 3
insert into pago_actividad(id_pago,fecha_pagoactividad,monto_abonado) values (20,TO_DATE('01-10-2022','DD/MM/YY'),1500);--PAGOS DE 6 3


insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (5,0,1,1);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (5,0,2,2);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (5,0,3,3);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (5,0,4,4);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (1,5,5,5);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (1,5,6,6);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (1,4,7,9);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (1,4,8,10);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (1,0,9,13);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (1,0,10,14);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (7,0,11,15);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (10,2,12,17);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (10,2,13,18);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (9,3,14,19);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (9,1,15,21);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (9,1,16,22);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (10,2,17,23);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (10,2,18,24);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (4,3,19,25);
insert into paga(n_grupo,n_socio,id_pago,id_arancel_actividad) values (6,3,20,27); 

commit;--SE LLENO TODA LA BD DE MANERA CORRECTA SI HACE COMMIT


--VISTA Y PROCEDIMIENTO QUE REPRESENTAN LOS DOS PRIMEROS PUNTOS DE LAS FUNCIONALIDADES ESPERADAS*************************************************************************************
savepoint SPget_deuda;
create or replace function get_deuda(numero_grupo int) --DEVUELVE LA DEUDA DE UN GRUPO EN ESPECIAL
return float
is aux float;
begin
    select sum(monto_total) into aux from cuota_mensual cuo where cuo.n_grupo=numero_grupo and descripcion_pago='no';
    return aux;
    rollback;
end;

savepoint SPget_cantidad_integrantes;
create or replace function get_cantidad_integrantes(numero_grupo int) --DEVUELVE LA CANTIDAD DE INTEGRANTES DE UN GRUPO FAMILIAR ESPECIFICO
return float
is aux float;
begin
    select count(*) into aux from socio where socio.n_grupo=numero_grupo;
    return aux;
    rollback;
end;
--PRIMER PUNTO DEL COMENTARIO DE LA CATEDRA UTILIZA LAS FUNCIONES DE ARRIBA
savepoint SPsocio_tit_adeudan_cuotas; 
create or replace view socio_tit_adeudan_cuotas as
    select s.*, get_deuda(s.n_grupo) as Deuda$, get_cantidad_integrantes(s.n_grupo) as CantIntegrantes
    from grupo_familiar gf, socio s
    where s.n_grupo=gf.n_grupo and s.cargo='soc_titular' and s.n_grupo in (select DISTINCT n_grupo from cuota_mensual cuo where descripcion_pago='no' and extract(year from fecha_emision)=extract(year from current_date));
commit;

select * from socio_tit_adeudan_cuotas;

--SEGUNDO PUNTO DEL COMENTARIO DE LA CATEDRA UTILIZA LAS FUNCIONES DE ARRIBA
savepoint SPget_consulta_dos;
create or replace view get_consulta_dos as
    select tipo as Categoria, count(*) as Cantidad from socio, categoria
    where categoria.id_categoria=socio.id_categoria and not exists (select * from actividad_gratuita
                        where not exists (select * from puede_inscribirse_a
                                            where socio.n_grupo=puede_inscribirse_a.n_grupo and socio.n_socio=puede_inscribirse_a.n_socio and puede_inscribirse_a.id_actividad=actividad_gratuita.id_actividad and
                                            extract(year from fecha_inscripcion)=extract(year from current_date)-1))
group by tipo
order by tipo;

select * from get_consulta_dos; --CONSULTA A LA VISTA ANTERIOR

--PROCEDIMIENTO QUE MODIFICA EL PORCENTAJE DE INCREMENTO O DESCUENTO DE UNA CATEGORIA************************************************************************************************************************
savepoint SPset_porcentaje;
create or replace procedure set_porcentaje(cat varchar, porcent float) is
begin
    update categoria set incremento_descuento=porcent where categoria.tipo=cat;
    commit;
    
    exception when others then
    rollback;
end;

select * from categoria;
execute set_porcentaje('mayor',8);
select * from categoria;

--INDICES*****************************************************************************************************************************************
create index indice_socio_cargo on socio(cargo);
select * from socio where cargo='soc_titular';
drop index indice_socio_cargo;
select * from socio where cargo='soc_titular';

create index indice_cuota on cuota_mensual(n_grupo);
select * from cuota_mensual where n_grupo=1;
drop index indice_cuota;
select * from cuota_mensual where n_grupo=1;


--PRUEBA TRANSACCION*****************************************************************************************************************************************
savepoint prueba;
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('Ultimo','Ultimo', '111','ultimo@gmail.com',TO_DATE('06-04-2000','DD/MM/YY'),'soc_titular',3);
select * from socio;
rollback; commit;
select * from socio;





--PRUEBAS INICIALES*************************************************************************************************************************************
insert into socio(nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values ('ppp','ppp', '20','pp@gmail.com',TO_DATE('06-04-2000','DD/MM/YY'),'soc_titular',3);

insert into socio(n_grupo,nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) values (1,'ppp','ppp', '20','pp@gmail.com',TO_DATE('06-04-2000','DD/MM/YY'),'soc_notitular',3);

delete from socio where n_socio=6 and n_grupo=1;

select * from socio;
select * from grupo_familiar;
select get_cantidad_integrantes(16) from socio where n_grupo=18;

select * from actividad_gratuita;

select extract(year from fecha_emision) from cuota_mensual;

select extract(year from current_date) from dual;

select * from cuota_mensual;

select * from categoria;

select * from socio;
select * from soc_titular;
select * from soc_notitular;

select * from grupo_familiar;

select * from actividad_gratuita;

select * from actividad_arancelada;

insert into arancel_actividad(fecha_emision) values ('10/10/2000');

select * from profesional;

delete from socio where n_socio>-2;

delete from grupo_familiar where n_grupo>-2;

--ANEXO
savepoint SPget_cantidad_integrantes_notit;
create or replace function get_cantidad_integrantes_notit(numero_grupo int)
return float
is aux float;
begin
    select count(*) into aux from soc_notitular where n_grupo=numero_grupo;
    return aux;
    rollback;
end;

savepoint SPtrg_delete_grupo;
create or replace trigger trg_delete_grupo(cargo varchar, grupo int, soc int)
declare
begin
    if (cargo='soc_titular')
    then
        if (get_cantidad_integrantes_notit(grupo)=0)
        then
            delete from grupo_familiar where n_grupo=grupo;
        else
            select min(n_socio) into aux from socio where n_grupo=grupo and id_categoria<>1 and soc<>n_socio;
            update socio set cargo='soc_titular' where n_socio=aux and n_grupo=grupo;
            delete soc_notitular where n_socio=aux and n_grupo=grupo;
            insert into soc_titular(n_grupo,n_socio) values (grupo,aux);
        end if;
    end if;
end;

drop trigger trg_delete_grupo;
drop function get_cantidad_integrantes_notit;
