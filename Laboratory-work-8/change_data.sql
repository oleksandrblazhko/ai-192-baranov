CREATE OR REPLACE FUNCTION change_data (pr_1 varchar, pr_2 varchar)
RETURNS varchar
as $$
declare 
	str varchar;
begin
	str:= 'UPDATE pupil SET pupil_name = ''' || pr_2 || ''' WHERE pupil_name = ''' || pr_1 ||'''';
	raise notice 'Query=%', str;
	execute str;
	return 'Pupil name updated';
end;
$$ LANGUAGE plpgsql;
