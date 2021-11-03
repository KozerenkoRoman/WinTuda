SELECT 
	 ROW_NUMBER() OVER (ORDER BY O.name,C.name) AS RowID
	,O.name AS [TableName]
	,C.name AS [ColumnName]
INTO #T
FROM sys.objects O
INNER JOIN sys.columns C
	ON C.object_id = O.object_id
WHERE O.type = 'U'
AND O.name IN 
	(
	 'AtmShib'
	,'Nehag'
	,'Rehev'
	,'AtmAzmn'
	,'Lakoach'
	)
AND C.name IN 
	(
	 'YehusYear'
	,'YehusMonth'
	,'PriceKind'
	,'LakNo2'
	,'LakNo1'
	,'DriverNo1'
	,'CarNum'
	,'HovalaKind'
	,'SugMetan'
	,'YeMida1'
	,'YeMida2'
	,'YeMida3'
	,'YeMida4'
	,'MaslulCode1'
	,'ShibCarKind'
	,'AzmnCarKind'
	,'Kod_Kvutza'
	,'Kod_Miyun'
	,'Kod_Nephach'
	,'Degem'
	,'Kod_Yatzran'
	,'Mis_Pnimi'
	,'Kod_Atzmada'
	,'Kod_Tnai_Tashlum'
	,'Kod_Eara'
	)
;
SELECT 
	 ROW_NUMBER() OVER (ORDER BY OBJECT_NAME(IC.object_id)) AS RowID
	,OBJECT_NAME(IC.object_id) AS [TableName]
	,COL_NAME(IC.object_id,IC.column_id) AS [ColumnName]
	,I.name AS [IndexName]
	,'Waiting' AS [Status]
	,CAST('CREATE ' + I.type_desc + ' INDEX ' + I.name + ' ON ' + OBJECT_NAME(IC.object_id) + ' (' +
	SUBSTRING(
		(
		SELECT ',' + COL_NAME(ICX.object_id,ICX.column_id)
		FROM sys.index_columns ICX
		WHERE ICX.object_id = I.object_id
		AND ICX.index_id = I.index_id
		ORDER BY ICX.index_column_id
		FOR XML PATH('')
		)
	,2,100)
	+ ');' COLLATE database_default AS VARCHAR(1000)) AS [CreateCmd]
INTO #I
FROM sys.indexes I
INNER JOIN sys.index_columns IC
	ON I.object_id = IC.object_id
	AND I.index_id = IC.index_id
WHERE OBJECT_NAME(IC.object_id) IN ('AtmShib','Nehag','Rehev','AtmAzmn','Lakoach')
AND COL_NAME(IC.object_id,IC.column_id) IN ('YehusYear','YehusMonth','PriceKind','LakNo2','LakNo1','DriverNo1','CarNum','HovalaKind','SugMetan','YeMida1','YeMida2','YeMida3','YeMida4','MaslulCode1','ShibCarKind','AzmnCarKind','Kod_Kvutza','Kod_Miyun','Kod_Nephach','Degem','Kod_Yatzran','Mis_Pnimi','Kod_Atzmada','Kod_Tnai_Tashlum','Kod_Eara')
;
DECLARE
	 @ROW INT
	,@TABLE NVARCHAR(128)
	,@COLUMN NVARCHAR(128)
	,@INDEXROW INT
	,@INDEX NVARCHAR(128)
	,@CREATE NVARCHAR(1000)
	,@SQL NVARCHAR(4000)
;
SET @ROW = 1
;
WHILE @ROW <=
	(
	SELECT MAX(RowID)
	FROM #T
	)
BEGIN
	SELECT 
		 @TABLE = TableName
		,@COLUMN = ColumnName
		,@INDEXROW = NULL
		,@INDEX = NULL
		,@CREATE = NULL
	FROM #T WHERE RowID = @ROW
	;
	IF NOT EXISTS
		(
		SELECT TOP 1 1
		FROM sys.Columns C
		WHERE OBJECT_NAME(C.object_id) = @TABLE
		AND C.name = @COLUMN
		AND C.is_nullable = 0
		)
	BEGIN
		SELECT TOP 1 @INDEXROW = RowID
		FROM #I
		WHERE TableName = @TABLE
		AND ColumnName = @COLUMN
		AND Status = 'Waiting'
		ORDER BY RowID
		;
		IF @INDEXROW IS NOT NULL
		BEGIN
			WHILE @INDEXROW <=
				(
				SELECT MAX(RowID)
				FROM #I
				WHERE TableName = @TABLE
				AND ColumnName = @COLUMN
				AND Status = 'Waiting'
				)
			BEGIN
				SELECT @INDEX = IndexName
				FROM #I
				WHERE RowID = @INDEXROW
				;
				SET @SQL = N'DROP INDEX ' + @INDEX + ' ON ' + @TABLE + ';'
				;
				EXEC SP_ExecuteSQL @SQL
				;
				UPDATE #I
				SET Status = 'Dropped'
				WHERE IndexName = @INDEX
				AND TableName = @TABLE
				AND Status = 'Waiting'
				;
				SELECT @INDEXROW = MIN(RowID)
				FROM #I
				WHERE TableName = @TABLE
				AND ColumnName = @COLUMN
				AND Status = 'Waiting'
				AND RowID > @INDEXROW
				;
			END
			;
		END
		;
		SET @SQL = N'
		UPDATE ' + @TABLE + '
		 SET ' + @COLUMN + ' = ' +
		CASE @COLUMN
			WHEN 'YehusYear'
				THEN 'YEAR(ShibAzmnDate)'
			WHEN 'YehusMonth'
				THEN 'MONTH(ShibAzmnDate)'
			WHEN 'CarNum'
				THEN '''0'''
			WHEN 'LakNo2'
				THEN 'LakNo1'
			ELSE '0'
		END +
		' WHERE ' +
		CASE @COLUMN
			WHEN 'CarNum'
				THEN 'NULLIF(CarNum,'') IS NULL;'
			WHEN 'LakNo2'
				THEN 'NULLIF(LakNo2,0) IS NULL;'
			ELSE @COLUMN + ' IS NULL;'
		END
		;
		
		EXEC SP_ExecuteSQL @SQL
		;
		
		SET @SQL = N'
		ALTER TABLE ' + @TABLE + ' ALTER COLUMN ' + @COLUMN + 
		CASE @COLUMN
			WHEN 'CarNum'
				THEN ' VARCHAR(9)'
			ELSE ' INTEGER'
		END
		+ ' NOT NULL
		;'
		;
		
		EXEC SP_ExecuteSQL @SQL
		;
		
		IF NOT EXISTS
			(
			SELECT TOP 1 1
			FROM sys.default_constraints DC
			WHERE OBJECT_NAME(DC.parent_object_id) = @TABLE
			AND COL_NAME(dc.parent_object_id,DC.parent_column_id) = @COLUMN
			)
		AND @COLUMN NOT IN ('YehusYear','YehusMonth')
		BEGIN
			SET @SQL = N'
			ALTER TABLE ' + @TABLE + ' ADD CONSTRAINT DF_' + @TABLE + '_' + @COLUMN + ' DEFAULT (' +
			CASE @COLUMN
				WHEN 'CarNum'
					THEN '''0'''
				ELSE '0'
			END
			+') FOR ' + @COLUMN + ';'
			;			
			EXEC SP_ExecuteSQL @SQL
			;
		END
		;
	END
	;
	IF @ROW = 
		(
		SELECT MAX(RowID)
		FROM #T
		)
	BEGIN
		SET @INDEXROW = 1
		;
		WHILE @INDEXROW <=
			(
			SELECT MAX(RowID)
			FROM #I
			WHERE Status = 'Dropped'
			)
		BEGIN
			SELECT 
				 @CREATE = CreateCMD
				,@INDEX = IndexName
			FROM #I
			WHERE RowID = @INDEXROW
			;
			EXEC SP_ExecuteSQL @CREATE
			;
			UPDATE #I
			SET Status = 'Created'
			WHERE IndexName = @INDEX
			AND TableName = @TABLE
			AND Status = 'Dropped'
			;
			SELECT @INDEXROW = MIN(RowID)
			FROM #I
			WHERE RowID > @INDEXROW
			AND Status = 'Dropped'
			;
		END
		;
	END
	;
	SET @ROW = @ROW + 1
	;
END
;
DROP TABLE #T
;
DROP TABLE #I
;