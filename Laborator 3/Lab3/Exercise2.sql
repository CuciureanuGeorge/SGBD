-- PROBLEMA 2

CREATE OR ALTER PROCEDURE P2 @T1Value varchar(20), @T2Value varchar(20) AS BEGIN
	BEGIN TRANSACTION T
		IF ([dbo].validate_phone(@T1Value) = 1) BEGIN
			INSERT INTO T1 VALUES(@T1Value)
			INSERT INTO [Log] VALUES('Added values ' + @T1Value + ' to table T1')
			
			INSERT INTO T1_T2
			VALUES((SELECT TOP 1 T1.ID as T1ID FROM T1 WHERE T1.Telephone = @T1Value), NULL)	
			
			INSERT INTO [Log] VALUES('Added value ' + @T1Value + ' to table T1_T2')
		END

		SAVE TRANSACTION S

		IF ([dbo].validate_phone(@T2Value) = 1) BEGIN
			INSERT INTO T2 VALUES(@T2Value)
			INSERT INTO [Log] VALUES('Added values ' + @T2Value + ' to table T2')

			IF EXISTS(SELECT TOP 1 T1.ID as T1ID FROM T1 WHERE T1.Telephone = @T1Value) BEGIN
				UPDATE T1_T2 SET T2ID = (SELECT TOP 1 T2.ID as T2ID FROM T2 WHERE T2.Telephone = @T2Value)
				WHERE T1ID = (SELECT TOP 1 T1.ID as T1ID FROM T1 WHERE T1.Telephone = @T1Value)
			END ELSE BEGIN
				INSERT INTO T1_T2 VALUES(NULL, (SELECT TOP 1 T2.ID as T2ID FROM T2 WHERE T2.Telephone = @T2Value))
			END

			INSERT INTO [Log] VALUES('Added value ' + @T2Value + ' to the corresponding value table T1_T2')
			COMMIT TRANSACTION T
		END
		ELSE BEGIN
			ROLLBACK TRANSACTION S
			COMMIT TRANSACTION T
		END
END