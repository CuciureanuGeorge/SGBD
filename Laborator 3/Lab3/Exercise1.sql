-- PROBLEMA 1

ALTER PROCEDURE P1 @T1Value varchar(20), @T2Value varchar(20) AS BEGIN
	SET XACT_ABORT ON
	BEGIN TRANSACTION T
		IF [dbo].validate_email(@T1Value) = 1 AND [dbo].validate_email(@T2Value) = 1 BEGIN
			INSERT INTO T1 VALUES(@T1Value)
			INSERT INTO [Log] VALUES('Added values ' + @T1Value + ' to table T1')
			INSERT INTO T2 VALUES(@T2Value)
			INSERT INTO [Log] VALUES('Added values ' + @T2Value + ' to table T2')
			
			INSERT INTO T1_T2
			VALUES((SELECT TOP 1 T1.ID as T1ID FROM T1 WHERE T1.Email = @T1Value),
			(SELECT TOP 1 T2.ID as T2ID FROM T2 WHERE T2.Email = @T2Value))	
			
			INSERT INTO [Log] VALUES('Added values ' + @T1Value + ' and ' + @T2Value + ' to table T1_T2')
			COMMIT TRANSACTION T
		END
		ELSE ROLLBACK TRANSACTION T
END