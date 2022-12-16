create table if not exists food_recipe_schema.Ingredient(
	ingredientID uuid primary key not null,
	ingredientName varchar(50)
)

select * from ingredient;

create extension if not exists "uuid-ossp";

select gen_random_uuid()

insert into ingredient (
	ingredientid, 
	ingredientName
) values (
	gen_random_uuid(),
	'eggs'
)

select * from ingredient 

delete from ingredient where ingredientname = 'eggs'

create table if not exists Recipe(
	recipeID uuid primary key not null,
	recipeName varchar(50)
)

select * from recipe

insert into recipe (recipeID, recipename) values (gen_random_uuid(), 'cake')

select * from recipe;

delete from recipe where recipename = 'cake'

select * from recipe;

select now()

alter table recipe add column timeOfUpload timestamp

select * from recipe;

insert into recipe (
	recipeID, 
	recipename, 
	timeOfUpload
) values (
	gen_random_uuid(), 
	'spaghetti', 
	now()
);

select * from recipe;

select * from recipe where recipeid = 'f815365b-c84a-4911-8074-c147ab13967d'

delete from recipe where recipeid = '148c1a1e-a29e-4fd1-96c5-5d2782fd74d9'

create table if not exists RecipeDetails (
	detailID uuid primary key not null,
	recipeID uuid,
	ingredientID uuid,
	ingredientAmount float,
	
	constraint fk_recipe foreign key(recipeID) references recipe(recipeID),
	constraint fk_ingredient foreign key(ingredientID) references ingredient(ingredientID)
)

select * from recipedetails

create table if not exists AppUser(
	userID uuid primary key not null,
	userName varchar(30),
	userPassword varchar(30)
)

alter table AppUser add column if not exists appUserName varchar(30)

alter table AppUser add constraint user_unique_uname unique (appUserName)

alter table recipedetails add column if not exists appUserName varchar(30)

alter table recipedetails add constraint fk_user_uniquename foreign key(appusername) references appuser(appUserName)

select * from appuser

insert into public.appuser(
	userid,
	username,
	userpassword,
	appusername
) values (
	gen_random_uuid(),
	'fawad awan',
	'6equj5*243',
	'fwdAwn243'
);

select * from public.appuser;

insert into public.recipe(
	recipeID,
	recipename 
) values (
	gen_random_uuid(),
	'omelete'
);

insert into public.ingredient (
	ingredientid, 
	ingredientname
) values (
	gen_random_uuid(),
	'egg'
);

insert into public.ingredient (
	ingredientid, 
	ingredientname
) values (
	gen_random_uuid(),
	'onion'
);

insert into public.ingredient (
	ingredientid, 
	ingredientname,
) values (
	gen_random_uuid(),
	'green chillies'
);

insert into public.ingredient (
	ingredientid, 
	ingredientname
) values (
	gen_random_uuid(),
	'salt'
);

insert into public.ingredient (
	ingredientid, 
	ingredientname
) values (
	gen_random_uuid(),
	'tomato'
);

select * from public.ingredient;

select * from public.recipe;

select * from public.appuser where userid = 'bfbdefe1-0167-4c60-80ea-c861b25ec043';

insert into public.recipedetails(
	detailid,
	recipeid,
	ingredientid,
	ingredientamount,
	appusername
) values (
	gen_random_uuid(),
	'a62132a8-6d70-4f7f-bf13-9070bc2a3d09',
	(select ingredientid from public.ingredient where ingredientname = 'egg'),
	2,
	'fwdAwn243'
);

insert into public.recipedetails(
	detailid,
	recipeid,
	ingredientid,
	ingredientamount,
	appusername
) values (
	gen_random_uuid(),
	'a62132a8-6d70-4f7f-bf13-9070bc2a3d09',
	(select ingredientid from public.ingredient where ingredientname = 'onion'),
	0.5,
	'fwdAwn243'
);

insert into public.recipedetails(
	detailid,
	recipeid,
	ingredientid,
	ingredientamount,
	appusername
) values (
	gen_random_uuid(),
	'a62132a8-6d70-4f7f-bf13-9070bc2a3d09',
	(select ingredientid from public.ingredient where ingredientname = 'tomato'),
	2,
	'fwdAwn243'
);

insert into public.recipedetails(
	detailid,
	recipeid,
	ingredientid,
	ingredientamount,
	appusername
) values (
	gen_random_uuid(),
	'a62132a8-6d70-4f7f-bf13-9070bc2a3d09',
	(select ingredientid from public.ingredient where ingredientname = 'salt'),
	2,
	'fwdAwn243'
);

select * from recipedetails;

select * from 
recipe
inner join recipedetails
on recipe.recipeid = recipedetails.recipeid; 

select recipename from 
recipe
inner join (
	select recipeid 
	from recipedetails 
	where recipedetails.appusername = 'fwdAwn243' 
) as userRecipeDetails
on recipe.recipeid = userRecipeDetails.recipeid
group by recipename;

select * from
ingredient
inner join recipedetails
on ingredient.ingredientid = recipedetails.ingredientid;

create or replace view recipedetailedview as
select ingredient.ingredientid, ingredient.ingredientname, 
recipe.recipeid, recipe.recipename, 
recipedetails.ingredientamount, recipedetails.appusername  
from ingredient, recipe, recipedetails
where ingredient.ingredientid = recipedetails.ingredientid 
and recipe.recipeid = recipedetails.recipeid;

select * from recipedetailedview;

select ingredientname, ingredientamount 
from ingredient
inner join (
	select ingredientid, ingredientamount
	from recipedetailedview
	where recipedetailedview.appusername = 'fwdAwn243' 
	and recipedetailedview.recipename = 'omelete'
) as ingredientamountdetails
on ingredient.ingredientid = ingredientamountdetails.ingredientid;

update ingredient set ingredientname = 'eggs'
where ingredientid = (
	select recipedetailedview.ingredientid from
	recipedetailedview 
	where recipedetailedview.ingredientname = 'egg'
)

update recipedetails set ingredientamount = 1.5
where ingredientid = (
	select ingredientid from ingredient 
	where ingredientname = 'salt'
) and recipedetails.recipeid = (
	select recipedetailedview.recipeid 
	from recipedetailedview 
	where recipedetailedview.recipename = 'omelete'
	and recipedetailedview.appusername = 'fwdAwn243'
	group by recipedetailedview.recipeid  
)

insert into ingredient(
	ingredientid,
	ingredientname
) values (
	uuid_generate_v4(),
	'green-chilli'
)

select * from ingredient

insert into recipedetails(
	detailid,
	recipeid,
	ingredientid,
	ingredientamount,
	appusername
) values (
	uuid_generate_v4(),
	(
		select recipedetailedview.recipeid 
		from recipedetailedview 
		where recipedetailedview.recipename = 'omelete'
		and recipedetailedview.appusername = 'fwdAwn243'
		group by recipedetailedview.recipeid  
	),
	(
		select ingredientid from ingredient 
		where ingredient.ingredientname = 'green-chilli'
	),
	1,
	'fwdAwn243'
)

create or replace function insert_ingredient(ingredient_name varchar)
returns void 
language plpgsql
as $createingredient$
	begin 
		insert into ingredient(
			ingredientid,
			ingredientname 
		) values (
			uuid_generate_v4(),
			ingredient_name
		);
	end;
$createingredient$;

select * from ingredient;

select insert_ingredient('cloves');

create or replace function get_ingredient_id(ingredient_name varchar) 
returns uuid 
language plpgsql 
as $getingredientid$
declare 
	required_ingredient_id uuid;
	begin
		if exists(select from ingredient where ingredientname = ingredient_name) then
			select ingredientid
			into required_ingredient_id
			from ingredient
			where ingredientname = ingredient_name;
		
			return required_ingredient_id;
		else
			perform insert_ingredient(ingredient_name);
		
			select ingredientid
			into required_ingredient_id
			from ingredient
			where ingredientname = ingredient_name;
		
			return required_ingredient_id;
		end if;
	end;
$getingredientid$; 

select get_ingredient_id('onion');
select public.get_ingredient_id('green-chilli');
select get_ingredient_id('fish');
select ingredientid from ingredient where ingredientname = 'sweet potato';

create or replace function has_recipe(userrecipename varchar, username varchar)
returns varchar
language plpgsql
as $hasrecipe$
declare 
	found_recipe varchar;
	begin
		select recipedetailedview.recipename 
		into found_recipe
		from recipedetailedview
		where recipedetailedview.appusername = username
		and recipedetailedview.recipename = userrecipename
		group by recipedetailedview.recipename;
		
		if found_recipe != null then
			return found_recipe;
		else
			return concat('recipe not found with ', recipename,' and ', username);
		end if;
	end;
$hasrecipe$;
	
select has_recipe('onion','aloo');

create or replace function get_recipe_id(recipe_name varchar, app_user_name varchar)
returns uuid
language plpgsql
as $getrecipeid$
	declare 
		found_recipe_id uuid;
	begin
		select recipedetailedview.recipeid 
		into found_recipe_id
		from recipedetailedview 
		where recipedetailedview.recipename = recipe_name
		and recipedetailedview.appusername = app_user_name
		group by recipedetailedview.recipeid; 
		
		return found_recipe_id;
	end;
$getrecipeid$;

select get_recipe_id('omelete', 'fwdAwn243');

create or replace function loop_func(max_num int)
returns integer
language plpgsql
as $loopfunc$
	declare 
		j integer := max_num - 1;
	begin
		loop
			j := j + 1;
			exit 
				when j = max_num * 2;
		end loop;
		return j;
	end;
$loopfunc$;

select loop_func(8);

create or replace function for_loop_func(start_numb integer, end_numb integer, incremented_by integer)
returns integer
language plpgsql
as $forloopfunc$
	declare 
		j integer := end_numb - 1;
	begin 
		for i in start_numb .. end_numb + 1 by incremented_by
		loop
			j := j + incremented_by;
		end loop;
		return j;
	end;
$forloopfunc$;	
	
select for_loop_func(1,8,1);

do
$arrayforeach$
	declare
		arr integer[] := array[1,2,3];
		element_numb integer;
	begin
		foreach element_numb in array arr
		loop
			raise notice '% element', element_numb;
		end loop;
	end;
$arrayforeach$;

do
$whileloopcontinuebatch$
	declare
		j integer := 0;
	begin
		while j <= 9
		loop
			j := j + 1;
			continue when mod(j,2) = 0;
			raise notice '% is j value', j;
		end loop;
	end;
$whileloopcontinuebatch$;	

create table if not exists storedproceduredemo(
	id serial primary key,
	custid uuid not null,
	recipename varchar not null
)

create or replace procedure insertion_and_retrieval(userunique_name uuid, recipe_name varchar)
language plpgsql
as $insert$
	begin
		insert into storedproceduredemo(
			custid,
			recipename
		) values (
			userunique_name,
			recipe_name
		);
	end;
$insert$;

call insertion_and_retrieval(uuid_generate_v4(), 'chicken 47')

select * from public.storedproceduredemo; 

select * from recipedetails; 

create or replace function insert_recipe(user_recipe_name varchar)
returns void
language plpgsql
as $insertrecipe$
	begin 
		insert into recipe(
			recipeid,
			recipename
		) values (
			uuid_generate_v4(),
			user_recipe_name
		);
		raise notice 'Inserted % successfully!', user_recipe_name;
	end;
$insertrecipe$;

create or replace function fetch_recipe_id(user_recipe_name varchar)
returns uuid
language plpgsql
as $fetchrecipeid$
	declare 
		recipe_id uuid;
	begin
		if exists(select from recipe where recipename = user_recipe_name) then
			select recipeid
			into recipe_id
			from recipe
			where recipename = user_recipe_name;
			
			return recipe_id;
		else
			perform insert_recipe(user_recipe_name);
		
			select recipeid
			into recipe_id
			from recipe
			where recipename = user_recipe_name;
		
			return recipe_id;
		end if;	
	end;
$fetchrecipeid$;

select fetch_recipe_id('french fries');
select * from recipe;

update recipedetails set ingredientid = get_ingredient_id('coriander') 
where ingredientid = get_ingredient_id('green-chilli')
and recipeid = get_recipe_id('omelete', 'fwdAwn243')
and appusername = 'fwdAwn243';

update recipe set recipename = 'simple omelete'
where recipeid = get_recipe_id('omelete', 'fwdAwn243')

select * from recipe;

alter table recipe drop column if exists timeofupload;

create or replace function handle_delete_user()
returns trigger
language plpgsql
as $handledeleteuser$
	begin 
		if exists (select from appuser where appusername = old.appusername) then
			if exists (select from recipedetails where appusername = old.appusername)
				delete from recipedetails
				where appusername = old.appusername then
				raise notice '% recipe/recipies are deleted', old.appusername;
				
				return null;
			else
				raise notice '% not found in recipedetails', old.appusername;
				return null;
			end if;
		else
			raise notice '% not found in appuser', old.appusername;
			return null;
		end if;
	end;
$handledeleteuser$;

create trigger delete_user_trigger
after delete 
on appuser
for each statement
execute procedure handle_delete_user()

delete from appuser where appusername = ''


