CREATE OR REPLACE FUNCTION get_data_secure(class_pupil_name varchar)
RETURNS TABLE(pupil_id integer, pupil_name varchar, class varchar, spot_conf integer)
AS $$
declare
	str varchar;
begin
	str:= 'SELECT * FROM pupil WHERE pupil_name = $1';
	raise notice 'Query = %', str;
	return query execute str using class_pupil_name;
end;
$$ LANGUAGE plpgsql;
