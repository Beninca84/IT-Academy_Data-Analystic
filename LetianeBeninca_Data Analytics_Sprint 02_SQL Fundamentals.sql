#Nivel 01: Ejercicio 01
select *
from company;

select *
from transaction;

#Nivel 01: Ejercicio 02
#Listado de los países que están realizando compras
select distinct country
from company;

#Desde cuántos países se realizan las compras
select count(distinct company.country)
from transaction
join company on transaction.company_id = company.id;

#Identifica la compañía con el promedio más alto de ventas
select
transaction.company_id,
count(transaction.id) AS VENTAS
from transaction
join company on transaction.company_id = company_id
group by transaction.company_id 
order by ventas desc
limit 1;

#Nivel 01: Ejercicío 03
#Transaciones realizadas por empresas de Alemania
select *
from transaction
where company_id in (
	select id
    from company
    where country = "Germany"
);

#Empresas que han realizado por un monto superior al promedio de todas las ventas
select
id, company_name, phone, email, country, website 
from company
where id in (
	select company_id
    from transaction
    where amount >= (
		select avg(transaction.amount)
        from transaction
	)
);

#Empresas que no tienen transaciones registradas
select
company_name
from 
company
where id not in (
	select distinct company_id
    from transaction
    );
    
#Nivel 02: Ejercicío 01
#Los cinco días que se generó la mayor cantidad de ingresos en la empresa
select date(timestamp) as date,
sum(amount) as total
from transaction
where declined = 0
group by date(timestamp)
order by total desc
limit 5;

#Nivel 02: Ejercicío 02
#¿Cuál es el promedio de ventas por país? 
select company.country, 
avg(transaction.amount) as VENTAS
from transaction
join company on transaction.company_id = company.id
where declined = 0
group by company.country
order by ventas desc;

#Nivel 02: Ejercicío 03
#Empresas ubicadas en el mismo pais que Non Institute
SELECT *
FROM transaction
join company on transaction.company_id = company.id
where company.country = (
	select country
    from company
    where company_name = 'Non Institute'
);

#Subconsultas
SELECT *
FROM transaction
where company_id in (
	select id
    from company
    where country = (
		select country
        from company
        where company_name = 'Non Institute'
	)
);

#Nivel 03: ejercicio 01
select 
company.company_name, 
company.phone,
company.country,
date(transaction.timestamp) AS FECHA,
transaction.amount
from transaction
join company on transaction.company_id = company.id
where transaction.amount between 100 and 200
	and date(transaction.timestamp) in ("2021-04-29", "2021-07-20", "2021-03-12")
order by transaction.amount desc;

#Nivel 03: ejercicio 02
select 
company.company_name, 
	case when count(transaction.id) > 4 then "More than 4"
		when count(transaction.id) < 4 then "Less than 4"
	end as TRANSACIONES 
from transaction
join company on transaction.company_id = company.id
GROUP by company.company_name

