CREATE OR ALTER FUNCTION validate_phone(@telephone as varchar(15)) RETURNS BIT AS BEGIN
	IF (@telephone NOT LIKE '07%')
		RETURN 0
	RETURN 1
END
	