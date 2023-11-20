CREATE OR REPLACE FUNCTION get_data(class_pupil_name varchar)
RETURNS TABLE(pupil_name varchar, class varchar)
AS $$
declare
	str varchar;
begin
	str:= 'SELECT pupil_name, class FROM pupil WHERE pupil_name = ''' || class_pupil_name || '''';
	raise notice 'Query=%', str;
	return query execute str;
end;
$$ LANGUAGE plpgsql;
