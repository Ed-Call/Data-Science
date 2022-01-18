-- Creacion de la base de datos facturas_olap
CREATE DATABASE facturas_olap;

-- Tablas Dimension Tiempo 
CREATE TABLE Anio(
    anio INTEGER not null
);
alter table Anio add constraint Anio_pk primary key (anio);

CREATE TABLE Mes(
    id_mes INTEGER not null,
    nombre_mes VARCHAR(30) not null,
    anio INTEGER not null
);
alter table Mes add constraint Mes_pk primary key (id_mes);

CREATE TABLE Dia(
    fecha DATE not null,
    nombre_dia VARCHAR(30) not null,
    id_mes INTEGER not null
);
alter table Dia add constraint Dia_pk primary key (fecha);

-- Llaves foraneas Dimension Tiempo 
alter table Mes add constraint Mes_fk foreign key (anio) references Anio(anio); 
alter table Dia add constraint Dia_fk foreign key (id_mes) references Mes(id_mes);

-- Tablas Dimension Geografia 
CREATE TABLE Tienda(
    id_tienda VARCHAR(10) not null,
    nombre_tienda VARCHAR(30) not null
);
alter table Tienda add constraint Tienda_pk primary key (id_tienda);

-- Tablas Dimension Pagos
CREATE TABLE Tipo_pago(
    id_tipo_pago VARCHAR(10) not null,
    nombre_tipo_pago VARCHAR(30) not null
);
alter table Tipo_pago add constraint Tipo_pago_pk primary key (id_tipo_pago);

CREATE TABLE Pago(
    id_pago VARCHAR(10) not null,
    nombre_pago VARCHAR(30) not null,
    id_tipo_pago VARCHAR(10) not null
);
alter table Pago add constraint Pago_pk primary key (id_pago);

-- Llaves foraneas Dimension Pagos 
alter table Pago add constraint Pago_fk foreign key (id_tipo_pago) references Tipo_pago(id_tipo_pago);

-- Tablas Dimension Producto
CREATE TABLE Tipo_producto(
    id_tipo_producto VARCHAR(10) not null,
    nombre_tipo_producto VARCHAR(30) not null
);
alter table Tipo_producto add constraint Tipo_producto_pk primary key (id_tipo_producto);

CREATE TABLE Producto(
    id_producto VARCHAR(10) not null,
    nombre_producto VARCHAR(30) not null,
    desc_producto VARCHAR(50),
    id_tipo_producto VARCHAR(10) not null
);
alter table Producto add constraint Producto_pk primary key (id_producto);

-- Llaves foraneas Dimension Producto 
alter table Producto add constraint Producto_fk foreign key (id_tipo_producto) references Tipo_producto(id_tipo_producto);

-- Tablas Dimension Cuentas
CREATE TABLE Cuenta(
    no_cuenta VARCHAR(30) not null,
    titular VARCHAR(30) not null
);
alter table Cuenta add constraint Cuenta_pk primary key (no_cuenta);

-- Tabla Dimension Hechos 
CREATE TABLE Ordenes(
    fecha DATE not null,
    id_tienda VARCHAR(10) not null,
    id_pago VARCHAR(10) not null,
    id_producto VARCHAR(10) not null,
    no_orden INTEGER not null,
    no_cuenta VARCHAR(30),
    costo_produccion FLOAT,
    costo_venta FLOAT,
    unidades INTEGER not null 
);
alter table Ordenes add constraint Ordenes_pk primary key (fecha, id_tienda, id_pago, id_producto, no_orden);

--Llaves foraneas Dimension Hechos 
alter table Ordenes add constraint Ordenes_fecha_fk       foreign key (fecha)       references Dia(fecha);
alter table Ordenes add constraint Ordenes_id_tienda_fk   foreign key (id_tienda)   references Tienda(id_tienda);
alter table Ordenes add constraint Ordenes_id_pago_fk     foreign key (id_pago)     references Pago(id_pago);
alter table Ordenes add constraint Ordenes_id_producto_fk foreign key (id_producto) references Producto(id_producto);
alter table Ordenes add constraint Ordenes_no_cuenta_fk   foreign key (no_cuenta)   references Cuenta(no_cuenta);

-- Restricciones Dimension Hechos 
alter table Ordenes add constraint Ordenes_unidades check (unidades >= 1);

-- Carga de datos 
INSERT INTO Anio
(anio)
VALUES
(2019),
(2020);

INSERT INTO Mes 
(id_mes, nombre_mes, anio)
VALUES
(1  ,   'enero' 	, 2019),
(2  ,   'febrero'	, 2019),
(3  ,   'marzo'	    , 2019),
(4  ,   'abril'	    , 2019),
(5  ,   'mayo'	    , 2019),
(6  ,   'junio'	    , 2019),
(7  ,   'julio'	    , 2019),
(8  ,   'agosto'	, 2019),
(9  ,   'septiembre', 2019),
(10 ,	'octubre'	, 2019),
(11 ,	'noviembre' , 2019),
(12 ,	'diciembre'	, 2019),
(13 ,	'enero' 	, 2020),
(14 ,	'febrero'	, 2020),
(15 ,	'marzo'	    , 2020),
(16 ,	'abril'	    , 2020),
(17 ,	'mayo'	    , 2020),
(18 ,	'junio'	    , 2020),
(19 ,	'julio'	    , 2020),
(20 ,	'agosto'	, 2020),
(21 ,	'septiembre', 2020),
(22 ,	'octubre'	, 2020),
(23 ,	'noviembre' , 2020),
(24 ,	'diciembre'	, 2020);

INSERT INTO Dia
(fecha, nombre_dia, id_mes)
VALUES
('2019/05/10', 'viernes' , 5 ),
('2019/09/16', 'lunes'   , 9 ),
('2019/11/02', 'sabado'  , 11),
('2019/12/24', 'martes'  , 12),
('2020/05/10', 'domingo' , 17),
('2020/09/16', 'mercoles', 21),
('2020/11/02', 'lunes'   , 23),
('2020/12/24', 'jueves'  , 24);

INSERT INTO Tienda
(id_tienda, nombre_tienda)
VALUES
('001', 'El sol'),
('002', 'Flores'),
('003', 'Valeria');

INSERT INTO Tipo_pago
(id_tipo_pago, nombre_tipo_pago)
VALUES
('T', 'Pago con tarjeta'),
('E', 'Pago en efectivo'),
('D', 'Pagos digitales'),
('O', 'Otros pagos');

INSERT INTO  Pago
(id_pago, nombre_pago, id_tipo_pago)
VALUES
('EFC', 'Efectivo',                       'E'),
('CHN','Cheque Nominativo',               'O'),
('TEF', 'Transferencia Electrónica SPEI', 'D'),
('TC','Tarjeta de Crédito',               'T'),
('ME','Monedero Electrónico',             'D'),
('DE','Dinero Electrónico',               'D'),
('TD','Tarjeta de Débito',                'T'),
('TS', 'Tarjeta de Servicios',            'T'),
('COM','Compensación',                    'O'),
('VD','Vales de Despensa',                'O');

INSERT INTO Tipo_producto
(id_tipo_producto, nombre_tipo_producto)
VALUES
('ALI', 'Abarrotes'),
('PAP', 'Papeleria'),
('LIM', 'Limpieza');

INSERT INTO Producto
(id_producto, nombre_producto, desc_producto, id_tipo_producto)
VALUES
('ACT025IL','Aceite X',                 'Aceite de cocina  X de 800 mL' , 'ALI'),
('QUE336VO','Queso  X',                 'Queso de cabra de 200g'        , 'ALI'),
('JAM720AI','Jamon X',                  'Paquete de 240g de jamon X'    , 'ALI'),
('AGT198WS', 'Malla de aguacate',       'Malla de aguacate Hass de 480g', 'ALI'),
('ARZ541ER', 'Bolsa de arroz X',        'Arroz de la marca X de 450g'   , 'ALI'),
('SWB158EO','Carola de fresa',          'Charola de fresa de 400g'      , 'ALI'),
('AXN254ER', 'Jabon de trastes X',      'Jabón de trastes X de 400 mL'  , 'LIM'),
('SOY264QL','Salsa de soya X',          'Salsa de soya X de 350 mL'     , 'ALI'),
('SCB1254EL', 'Cuaderno X profesional', 'Cuaderno profesional X sencillo cuadro chico', 'PAP'),
('CRL478EJ', 'Cereal X integral',       'Cereal X de 400g integral'     , 'ALI');

INSERT INTO Cuenta
(no_cuenta, titular)
VALUES
('2254188299991978','Teodosio Cardona'),
('2248642143480652','Águeda Carreras'),
('4615184833414767','Maria Dalton'),
('4829325093547536','Jose Angel'),
('639001977375','Danielle Rodriguez'),
('675916676884','Águeda Carreras'),
('676219812606','Matías Jordán '),
('4072248749637','Danielle Hahn'),
('3568332406633243','Jose Angel'),
('377027541279574','Danielle Hahn'),
('676112371973','Danielle Hahn');

INSERT INTO Ordenes 
(fecha, id_tienda, id_pago, id_producto, no_orden, no_cuenta, costo_produccion, costo_venta, unidades)
VALUES
('2019/05/10', '001', 'EFC',	'ACT025IL' , 1,	'2254188299991978'	,20.0,	25.0,	2),
('2019/05/10', '001', 'EFC',	'QUE336VO' , 1,	'2254188299991978'	,28.0,	35.0,	1),
('2019/09/16', '002', 'TEF',	'JAM720AI' , 2,	'676219812606'	    ,30.0,	40.5,	1),
('2019/09/16', '002', 'TEF',	'AGT198WS' , 2,	'676219812606'	    ,20.0,	29.5,	2),
('2019/11/02', '003', 'TC',	    'SWB158EO' , 3,	 Null	            ,35.5,	45.5,	2),
('2019/12/24', '001', 'EFC',	'SOY264QL' , 4,	'377027541279574'	,10.5,	18.0,	4),
('2019/12/24', '001', 'EFC',	'CRL478EJ' , 4,	'377027541279574'	,29.5,	39.5,	2),
('2019/12/24', '001', 'EFC',	'QUE336VO' , 4,	'377027541279574'	,28.0,	35.0,	3),
('2019/12/24', '001', 'TC',	    'SCB1254EL', 5,	'676112371973'	    ,28.0,	40.0,	2),
('2020/05/10', '002', 'EFC',	'SCB1254EL', 6,	'676112371973'	    ,28.0,	40.0,	2),
('2020/09/16', '003', 'VD',	    'AXN254ER' , 7,	'676112371973'	    ,20.0,	25.0,	3),
('2020/09/16', '003', 'VD',	    'ARZ541ER' , 7,	'676112371973'	    ,30.0,	35.0,	2),
('2020/09/16', '002', 'ME',	    'SOY264QL' , 8,	'676112371973'	    ,15.0,	20.0,	2),
('2020/11/02', '002', 'TD',	    'ARZ541ER' , 9,	'4072248749637'	    ,30.0,	35.0,	2),
('2020/12/24', '001', 'EFC',	'QUE336VO' , 10, NULL	            ,28.0,  35.0,	1);

-- Consultas

-- 1. Desea saber que ordenes son las que mayor ganancia le han proporcionado en los últimos dos años y que meses y días
--    son los de mayor numero de ordenes.
select no_orden, SUM(costo_venta*unidades)
from Ordenes
GROUP BY no_orden
ORDER BY SUM(costo_venta*unidades) DESC
LIMIT 3;

select a.anio, m.nombre_mes, d.nombre_dia, count(distinct(o.no_orden))
from Ordenes o, Dia d, Mes m, Anio a
where o.fecha=d.fecha and d.id_mes=m.id_mes and m.anio = a.anio
GROUP BY d.nombre_dia, m.id_mes, a.anio
ORDER BY count(distinct(no_orden)) DESC
LIMIT 3;

-- 2 Desea saber que tipo de pago es el que mas se ha utilizado en los últimos dos años y como ha evolucionado la forma
-- de pago.
select t.nombre_tipo_pago,count(distinct (o.no_orden))
from Ordenes o, Pago p, Tipo_pago t
where o.id_pago=p.id_pago and p.id_tipo_pago = t.id_tipo_pago
GROUP BY t.nombre_tipo_pago
order by count(distinct (o.no_orden)) DESC;

select a.anio,m.nombre_mes, count(distinct (m.id_mes)), t.nombre_tipo_pago
from Ordenes o, Dia d, Mes m, Pago p, Tipo_pago t, Anio a
where o.fecha=d.fecha and d.id_mes=m.id_mes and m.anio = a.anio
and o.id_pago=p.id_pago and p.id_tipo_pago = t.id_tipo_pago
group by a.anio,m.id_mes,m.nombre_mes, t.nombre_tipo_pago
order by a.anio, m.id_mes,count(distinct (m.id_mes));


-- 3 Desea saber cuales han sido los productos que mas se han vendido en los últimos dos años, desglosdo por mes y por
-- tiendas
select a.anio, m.nombre_mes, p.nombre_producto,t.nombre_tienda, count(o.id_producto)*o.unidades Productos_vendidos
from Ordenes o, Dia d, Mes m, Anio a, Producto p, Tienda t
where o.fecha=d.fecha and d.id_mes=m.id_mes and m.anio = a.anio
and o.id_producto = p.id_producto and o.id_tienda = t.id_tienda
group by a.anio, m.id_mes , o.no_orden,p.nombre_producto,t.nombre_tienda, o.unidades
having count(o.id_producto)*o.unidades >2
order by count(o.id_producto) DESC,a.anio, m.id_mes;

-- Consultas Inventadas 
-- El nombre del titular con cuenta registrada que ha hecho la mayor número de órdenes
select  distinct c.titular, c.no_cuenta, count( distinct o.no_orden)
from Ordenes o, Cuenta c
where o.no_cuenta=c.no_cuenta
group by c.titular,c.no_cuenta
having count( distinct o.no_orden)>1
order by c.titular,count( distinct o.no_orden);

-- Borrado 
drop DATABASE facturas_olap;