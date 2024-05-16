-- 1.Consulta de Todos los Eventos en un Complejo Deportivo Específico.
use Olimpicos;

select cd.nombre as complejo , e.*
from eventos as e
inner join evento_complejo_deportivo as ecd on ecd.id_evento=e.id_evento
inner join complejo_deportivo as cd on cd.id_complejo_deportivo=ecd.id_complejo
where cd.nombre="Complejo Deportivo Floridablanca";

-- 2. Consulta de Comisarios Asignados a un Evento en Particular.

select e.nombre  as evento , co.*
from comisario as co
inner join evento_comisario as eco on eco.id_comisario=co.id_comisario
inner join eventos as e on e.id_evento= eco.id_evento
where e.nombre="Torneo de Tennis";

-- 3. Consulta de Todos los Eventos en un Rango de Fechas.


select *
from eventos
where date(fecha) BETWEEN "2023/06/01" and "2023/12/31"
order by fecha;


-- 4. Consulta del Número Total de Comisarios Asignados a Eventos.

select  e.nombre as Evento, count(co.id_comisario) as "Cantidad Comisarios"
from comisario as co
inner join evento_comisario as eco on eco.id_comisario=co.id_comisario
inner join eventos as e on e.id_evento= eco.id_evento
group by e.nombre;



-- 5. Consulta de Complejos Polideportivos con Área Total Ocupada Superior a un Valor Específico.

select cpo.* , inf.area_complejo as "Area Complejo"
from complejo_polideportivo as cpo
inner join info_complejo as inf on inf.id_complejo=cpo.id_complejo_polideportivo
where inf.area_complejo>20
order by inf.area_complejo asc;

-- 6. Consulta de Eventos con Número de Participantes Mayor que la Media.

select e.nombre, e.num_participantes 
from eventos as e
group by num_participantes, e.nombre
having num_participantes > avg(e.num_participantes);



-- 7. Consulta de Equipamiento Necesario para un Evento Específico.

select * 
from equipamiento as eq 
inner join evento_equipo as eveq on eveq.id_equipamiento=eq.id_equipamiento
inner join eventos as e on e.id_evento=eveq.id_evento
where e.nombre="Torneo de Tennis";

-- 8. Consulta de Eventos Celebrados en Complejos Deportivos con Jefe de Organización Específico.
select jf.nombre as "Jefe", cdp.nombre as "complejo deportivo", e.* 
from eventos as e
inner join evento_complejo_deportivo as ecpd on ecpd.id_evento=e.id_evento
inner join complejo_deportivo as cdp on cdp.id_complejo_deportivo=ecpd.id_complejo
inner join info_complejo as inf on inf.id_complejo=cdp.id_info_complejo
inner join jefes as jf on jf.id_jefe=inf.id_jefe
where jf.nombre="Ana Rojas";


-- 9. Consulta de Complejos Polideportivos sin Eventos Celebrados.
select cpo.id_complejo_polideportivo, cpo.nombre
from complejo_polideportivo as cpo
left join evento_complejo_poli as ecpd on ecpd.id_complejo=cpo.id_complejo_polideportivo
where ecpd.id_evento is null;

-- 10. Consulta de Comisarios que Actúan como Jueces en Todos los Eventos.

-- ningun jefe actua como comisario;
select *
from comisario as com
inner join evento_comisario as eco on eco.id_comisario=com.id_comisario
inner join eventos as e on e.id_evento=eco.id_evento  
inner join evento_complejo_deportivo as ecpd on ecpd.id_evento=e.id_evento
inner join complejo_deportivo as cdp on cdp.id_complejo_deportivo=ecpd.id_complejo
inner join info_complejo as inf on inf.id_complejo=cdp.id_info_complejo
inner join jefes as jf on jf.id_jefe=inf.id_jefe
where com.nombre=jf.nombre;

-- otra forma de hacerlo--
select co.nombre 
from comisario as co
where co.nombre in (select jf.nombre from jefes as jf);