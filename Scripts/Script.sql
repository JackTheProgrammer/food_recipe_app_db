create table if not exists recipedetails(
	id serial primary key not null,
	recipename varchar(30),
	userid uuid not null
)

select * from food_schema.recipedetails