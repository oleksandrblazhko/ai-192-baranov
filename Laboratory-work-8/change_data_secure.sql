CREATE OR REPLACE FUNCTION change_data_secure (pr_1 varchar, pr_2 varchar)
RETURNS varchar
as $$
declare 
	str varchar;
begin
	str:= 'UPDATE pupil SET pupil_name = $2 WHERE pupil_name = $1';
	raise notice 'Query=%', str;
	execute str using pr_1, pr_2;
	return 'Name updated';
end;
$$ LANGUAGE plpgsql;
