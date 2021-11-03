CREATE PROCEDURE dbo.[RePriceMe]
AS
/*********************************************************
**	Repricing Fix for Eitam / Sadran 2013-2016			**
**	Last Updated : 26 Feb 2017							**
**	Written By : Ben Keren, Ardom ITC Services			**
**	Tasks : Sets MCRecs values for AtmAzmn and AtmShib	**
**			& Updates new pricing fields for AtmAzmn	**
*********************************************************/
BEGIN
	DECLARE @SQL AS NVARCHAR(4000);
	SET @SQL = 
		N'
		SELECT 	 A.AzmnNo
				,A.TotalPrice1
				,A.TotalPrice2
				,A.TotalPrice3'
		+
		CHAR(13) + CHAR(9) + CHAR(9) + CHAR(9)
		+
		CASE
			WHEN EXISTS (SELECT TOP 1 name FROM sys.columns WHERE name = 'AzmnPrice1')
				THEN ',A.AzmnPrice1'
			ELSE ''
		END
		+
		CHAR(13) + CHAR(9) + CHAR(9) + CHAR(9)
		+
		CASE
			WHEN EXISTS (SELECT TOP 1 name FROM sys.columns WHERE name = 'AzmnPrice2')
				THEN ',A.AzmnPrice2'
			ELSE ''
		END
		+
		CHAR(13) + CHAR(9) + CHAR(9) + CHAR(9)
		+
		CASE
			WHEN EXISTS (SELECT TOP 1 name FROM sys.columns WHERE name = 'AzmnPrice3')
				THEN ',A.AzmnPrice3'
			ELSE ''
		END
		+
		CHAR(13) + CHAR(9) + CHAR(9) + CHAR(9)
		+
		CASE
			WHEN EXISTS (SELECT TOP 1 name FROM sys.columns WHERE name = 'AzmnPrice4')
				THEN ',A.AzmnPrice4'
			ELSE ''
		END
		+
		CHAR(13) + CHAR(9) + CHAR(9) + CHAR(9)
		+
		CASE
			WHEN EXISTS (SELECT TOP 1 name FROM sys.columns WHERE name = 'AzmnYeMida1')
				THEN ',A.AzmnYeMida1'
			ELSE ''
		END
		+
		CHAR(13) + CHAR(9) + CHAR(9) + CHAR(9)
		+
		CASE
			WHEN EXISTS (SELECT TOP 1 name FROM sys.columns WHERE name = 'AzmnYeMida2')
				THEN ',A.AzmnYeMida2'
			ELSE ''
		END
		+
		CHAR(13) + CHAR(9) + CHAR(9) + CHAR(9)
		+
		CASE
			WHEN EXISTS (SELECT TOP 1 name FROM sys.columns WHERE name = 'MCRecs')
				THEN ',A.MCRecs'
			ELSE ''
		END
		+
		CHAR(13) + CHAR(9)
		+
		' INTO [' 
		+ 
		convert(NVARCHAR(10),getdate(),103) 
		+ 
		'_AtmAzmn_Pricing_Backup_' 
		+
		(SELECT CAST(count(sys.objects.object_id)+1 AS NVARCHAR(2)) 
		FROM sys.objects 
		WHERE sys.objects.name LIKE convert(NVARCHAR(10),getdate(),103)+'_AtmAzmn_Pricing_Backup_%')
		+
		']'
		+
		CHAR(13) + CHAR(9)
		+
		' FROM AtmAzmn A
		WHERE A.ToDate >= DATEADD(YEAR, -1, GETDATE())
		AND A.AzmnType >= 1;'
		;
	
	EXECUTE sp_executesql @SQL;
	
	SET @SQL = 
		N'
		SELECT 	 S.ShibAzmnNo
				,S.ShibNo
				,S.Price1
				,S.Price2
				,S.Price3
				,S.Price4
				,S.PriceQuntity1
				,S.PriceQuntity2
				,S.PriceQuntity3
				,S.PriceQuntity4
				,S.YeMida1
				,S.YeMida2
				,S.YeMida3
				,S.YeMida4'
		+
		CHAR(13) + CHAR(9) + CHAR(9) + CHAR(9)
		+
		CASE
			WHEN EXISTS (SELECT TOP 1 name FROM sys.columns WHERE name = 'MCRecs')
				THEN ',S.MCRecs'
			ELSE ''
		END
		+
		CHAR(13) + CHAR(9)
		+
		' INTO [' 
		+ 
		convert(NVARCHAR(10),getdate(),103) 
		+ 
		'_AtmShib_Pricing_Backup_' 
		+
		(SELECT CAST(count(sys.objects.object_id)+1 AS NVARCHAR(2)) 
		FROM sys.objects 
		WHERE sys.objects.name LIKE convert(NVARCHAR(10),getdate(),103)+'_AtmShib_Pricing_Backup_%')
		+
		']'
		+
		CHAR(13) + CHAR(9)
		+
		' FROM AtmShib S
		WHERE S.ShibAzmnDate >= DATEADD(YEAR, -1, GETDATE())
		AND S.LakHesbonit IS NULL
		AND S.ShibKind >= 0;'
		;
	
	EXECUTE sp_executesql @SQL;
	
	DECLARE  @MAXAZMN AS INT;
	DECLARE	 @CURAZMN AS INT;
	SELECT	 @MAXAZMN = max(A.AzmnNo)
			,@CURAZMN = min(A.AzmnNo)
	FROM AtmAzmn A
	WHERE A.ToDate >= DATEADD(YEAR, -1, GETDATE())
	AND A.AzmnType >= 1;
	
	DECLARE @MYCALLCODE AS TINYINT;
	DECLARE @MYSUBCODE AS VARCHAR(1);
	DECLARE @MYORDERNO AS INT;
	DECLARE @MYTODAY AS DATETIME;
	DECLARE @MYCODELAK AS INT;
	DECLARE @MYCODEMASLUL AS INT;
	DECLARE @MYCODEHIUV AS INT;
	DECLARE @MYCARKIND AS INT;
	DECLARE @MYBOXES AS INT;
	DECLARE @MYHOVALAKIND AS INT;
	DECLARE @MYHOZE AS INT;
	DECLARE @MYMISHKAL AS NUMERIC(28,3);
	DECLARE @MYNEFHPRO AS NUMERIC(28,3);
	DECLARE @MYNEFH AS NUMERIC(28,3);
	DECLARE @MYQUANTPRO AS NUMERIC(28,3);
	DECLARE @MYQUANT1 AS NUMERIC(28,3);
	DECLARE @MYQUANT2 AS NUMERIC(28,3);
	DECLARE @MYQUANT3 AS NUMERIC(28,3);
	DECLARE @MYQUANT4 AS NUMERIC(28,3);
	DECLARE @MYQUANTMUSA AS NUMERIC(28,3);
	DECLARE @MYTOTALKM AS NUMERIC(28,3);
	DECLARE @MYTOTALHOUR AS NUMERIC(28,3);
	DECLARE @MYTOTALPOINTS AS INT;
	DECLARE @MYPRICE1 AS NUMERIC(28,3);
	DECLARE @MYPRICE2 AS NUMERIC(28,3);
	DECLARE @MYPRICE3 AS NUMERIC(28,3);
	DECLARE @MYPRICE4 AS NUMERIC(28,3);
	DECLARE @MYTOTAL1 AS NUMERIC(28,3);
	DECLARE @MYTOTAL2 AS NUMERIC(28,3);
	DECLARE @MYTOTAL3 AS NUMERIC(28,3);
	DECLARE @MYTOTAL4 AS NUMERIC(28,3);
	DECLARE @MYYEMIDA1 AS INT;
	DECLARE @MYYEMIDA2 AS INT;
	DECLARE @MYYEMIDA3 AS INT;
	DECLARE @MYYEMIDA4 AS INT;
	DECLARE @MYMCRECS AS VARCHAR(100);
	DECLARE @MYUSERNAME AS VARCHAR(30);
	DECLARE @MYTNUATBEN AS TINYINT;	
	DECLARE @MYSUG_HAVARA	TINYINT;
	DECLARE @MYSUG_LINK AS TINYINT;
	DECLARE @MYLINK_KEY AS INT;
	DECLARE @MYNEWRECS AS VARCHAR(100);
	DECLARE @MYREC_CHANGE	TINYINT;
	DECLARE @MYREC_COUNT AS TINYINT;
	DECLARE @MYCODENEHAG AS INT;
	DECLARE @MYLINK_KEY2 AS INT;
	DECLARE @MYKILLBEN AS TINYINT;
	DECLARE @MYSTARTTIME AS DATETIME;
	DECLARE @MYENDTIME AS DATETIME;
	
	WHILE @CURAZMN <= @MAXAZMN
	BEGIN
			
		SELECT 
		 @MYCALLCODE = 0
		,@MYSUBCODE = 'A'
		,@MYORDERNO = @CURAZMN
		,@MYTODAY = GETDATE()
		,@MYCODELAK = A.InvLakNo
		,@MYCODEMASLUL = isnull(A.AzmnMaslulCode1,0)
		,@MYCODEHIUV = isnull(A.AzmnSugMetan,0)
		,@MYCARKIND = isnull(A.AzmnCarKind,0)
		,@MYBOXES = 0
		,@MYHOVALAKIND = isnull(A.HovalaKind,0)
		,@MYHOZE = 0
		,@MYMISHKAL = isnull(A.Mishkal,0)
		,@MYNEFHPRO = isnull(A.Nefh,0)/1000
		,@MYNEFH = isnull(A.Nefh,0)
		,@MYQUANTPRO = isnull(A.Quntity1,0)/1000
		,@MYQUANT1 = isnull(A.Quntity1,1)
		,@MYQUANT2 = isnull(A.Quntity1,1)
		,@MYQUANT3 = isnull(A.Quntity1,1)
		,@MYQUANT4 = isnull(A.Quntity1,1)
		,@MYQUANTMUSA = 0
		,@MYTOTALKM = isnull(A.TotalKm,0)
		,@MYTOTALHOUR = isnull(convert(NUMERIC (28,3), datepart(hh,A.TotalTime) + (datepart(mm,A.TotalTime)/60)),0)
		,@MYTOTALPOINTS = 0
		,@MYPRICE1 = isnull(A.AzmnPrice1,0)
		,@MYPRICE2 = isnull(A.AzmnPrice2,0)
		,@MYPRICE3 = isnull(A.AzmnPrice3,0)
		,@MYPRICE4 = isnull(A.AzmnPrice4,0)
		,@MYTOTAL1 = isnull(A.TotalPrice1,0)
		,@MYTOTAL2 = isnull(A.TotalPrice2,0)
		,@MYTOTAL3 = isnull(A.TotalPrice3,0)
		,@MYTOTAL4 = 0
		,@MYYEMIDA1 = isnull(A.AzmnYemida1,1)
		,@MYYEMIDA2 = isnull(A.AzmnYeMida2,1)
		,@MYYEMIDA3 = isnull(A.AzmnYeMida1,1)
		,@MYYEMIDA4 = isnull(A.AzmnYeMida1,1)
		,@MYMCRECS = ''
		,@MYUSERNAME = isnull(A.MaklidName,'')
		,@MYTNUATBEN = 0		
		,@MYSUG_HAVARA = 0
		,@MYSUG_LINK = 0
		,@MYLINK_KEY = 0
		,@MYNEWRECS = 0
		,@MYREC_CHANGE = 0
		,@MYREC_COUNT = 0
		,@MYCODENEHAG = A.AzmnDriverNo
		,@MYLINK_KEY2 = 0
		,@MYKILLBEN = 0
		,@MYSTARTTIME = A.FromDate
		,@MYENDTIME = A.ToDate
		FROM AtmAzmn A
		WHERE A.AzmnNo = @CURAZMN;
		
		EXECUTE Asp_PriceCheck
		 @CALLCODE = @MYCALLCODE 
		,@SUBCODE = @MYSUBCODE
		,@ORDERNO = @MYORDERNO
		,@TODAY = @MYTODAY
		,@CODELAK = @MYCODELAK
		,@CODEMASLUL = @MYCODEMASLUL
		,@CODEHIUV = @MYCODEHIUV
		,@CARKIND = @MYCARKIND
		,@BOXES = @MYBOXES
		,@HOVALAKIND = @MYHOVALAKIND
		,@HOZE = @MYHOZE
		,@MISHKAL = @MYMISHKAL
		,@NEFHPRO = @MYNEFHPRO
		,@NEFH = @MYNEFH
		,@QUANTPRO = @MYQUANTPRO
		,@QUANT1 = @MYQUANT1
		,@QUANT2 = @MYQUANT2
		,@QUANT3 = @MYQUANT3
		,@QUANT4 = @MYQUANT4
		,@QUANTMUSA = @MYQUANTMUSA
		,@TOTALKM = @MYTOTALKM
		,@TOTALHOUR = @MYTOTALHOUR
		,@TOTALPOINTS = @MYTOTALPOINTS
		,@PRICE1 = @MYPRICE1 OUTPUT
		,@PRICE2 = @MYPRICE2 OUTPUT
		,@PRICE3 = @MYPRICE3 OUTPUT
		,@PRICE4 = @MYPRICE4 OUTPUT
		,@TOTAL1 = @MYTOTAL1 OUTPUT
		,@TOTAL2 = @MYTOTAL2 OUTPUT
		,@TOTAL3 = @MYTOTAL3 OUTPUT
		,@TOTAL4 = @MYTOTAL4 OUTPUT
		,@YEMIDA1 = @MYYEMIDA1 OUTPUT
		,@YEMIDA2 = @MYYEMIDA2 OUTPUT
		,@YEMIDA3 = @MYYEMIDA3
		,@YEMIDA4 = @MYYEMIDA4
		,@MCRECS = @MYMCRECS OUTPUT
		,@USERNAME = @MYUSERNAME
		,@TNUATBEN = @MYTNUATBEN
		,@SUG_HAVARA = @MYSUG_HAVARA
		,@SUG_LINK = @MYSUG_LINK
		,@LINK_KEY = @MYLINK_KEY
		,@NEWRECS = @MYNEWRECS
		,@REC_CHANGE = @MYREC_CHANGE
		,@REC_COUNT = @MYREC_COUNT
		,@STARTTIME = @MYSTARTTIME
		,@ENDTIME = @MYENDTIME
		;
		
		UPDATE A
		SET 
			 A.AzmnPrice1 = CASE WHEN ISNULL(A.TotalPrice1,0) = 0 THEN @MYPRICE1 ELSE A.TotalPrice1 END
			,A.AzmnPrice2 = CASE WHEN ISNULL(A.TotalPrice2,0) = 0 THEN @MYPRICE2 ELSE A.TotalPrice2 END
			,A.AzmnPrice3 = CASE WHEN ISNULL(A.TotalPrice3,0) = 0 THEN @MYPRICE3 ELSE A.TotalPrice3 END
			,A.TotalPrice1 = CASE WHEN ISNULL(A.TotalPrice1,0) = 0 THEN @MYTOTAL1 ELSE A.TotalPrice1 END
			,A.TotalPrice2 = CASE WHEN ISNULL(A.TotalPrice2,0) = 0 THEN @MYTOTAL2 ELSE A.TotalPrice2 END
			,A.TotalPrice3 = CASE WHEN ISNULL(A.TotalPrice3,0) = 0 THEN @MYTOTAL3 ELSE A.TotalPrice3 END
			,A.AzmnYeMida1 = @MYYEMIDA1
			,A.AzmnYeMida2 = @MYYEMIDA2
			,A.MCRecs = @MYMCRECS
		FROM AtmAzmn A
		WHERE A.AzmnNo = @CURAZMN
		;
		
		SELECT @CURAZMN = min(A.AzmnNo)
		FROM AtmAzmn A
		WHERE A.AzmnNo > @CURAZMN
		AND A.ToDate >= DATEADD(YEAR, -1, GETDATE())
		AND A.AzmnType >= 1
		;
	END;
	
	
	SELECT	 @MAXAZMN = max(S.ShibNo)
			,@CURAZMN = min(S.ShibNo)
	FROM AtmShib S
	WHERE S.ShibAzmnDate >= DATEADD(YEAR, -1, GETDATE())
	AND S.LakHesbonit IS NULL
	AND S.ShibKind >= 0;
	
	WHILE @CURAZMN <= @MAXAZMN
	BEGIN
			
		SELECT 
		 @MYCALLCODE = 0
		,@MYSUBCODE = 'A'
		,@MYORDERNO = @CURAZMN
		,@MYTODAY = GETDATE()
		,@MYCODELAK = S.LakNo1
		,@MYCODEMASLUL = isnull(S.MaslulCode1,0)
		,@MYCODEHIUV = isnull(S.SugMetan,0)
		,@MYCARKIND = isnull(S.ShibCarKind,0)
		,@MYBOXES = ISNULL(S.Boxes,0)
		,@MYHOVALAKIND = isnull(S.HovalaKind,0)
		,@MYHOZE = ISNULL(S.Hoze,0)
		,@MYMISHKAL = isnull(S.Mishkal,0)
		,@MYNEFHPRO = isnull(S.Nefh,0)/1000
		,@MYNEFH = isnull(S.Nefh,0)
		,@MYQUANTPRO = isnull(S.Quntity1,0)/1000
		,@MYQUANT1 = isnull(S.Quntity1,1)
		,@MYQUANT2 = isnull(S.Quntity2,1)
		,@MYQUANT3 = isnull(S.Quntity3,1)
		,@MYQUANT4 = isnull(S.Quntity4,1)
		,@MYQUANTMUSA = ISNULL(S.QuntMusa,0)
		,@MYTOTALKM = isnull(S.ShibTotalKm,0)
		,@MYTOTALHOUR = ISNULL(S.TotalHour,0)
		,@MYTOTALPOINTS = ISNULL(S.TotalPointsInWay,0)
		,@MYPRICE1 = isnull(S.Price1,0)
		,@MYPRICE2 = isnull(S.Price2,0)
		,@MYPRICE3 = isnull(S.Price3,0)
		,@MYPRICE4 = isnull(S.Price4,0)
		,@MYTOTAL1 = isnull(S.PriceQuntity1,0)
		,@MYTOTAL2 = isnull(S.PriceQuntity2,0)
		,@MYTOTAL3 = isnull(S.PriceQuntity3,0)
		,@MYTOTAL4 = isnull(S.PriceQuntity4,0)
		,@MYYEMIDA1 = isnull(S.Yemida1,1)
		,@MYYEMIDA2 = isnull(S.Yemida2,1)
		,@MYYEMIDA3 = isnull(S.Yemida3,1)
		,@MYYEMIDA4 = isnull(S.Yemida4,1)
		,@MYMCRECS = ''
		,@MYUSERNAME = isnull(S.MaklidName,'')
		,@MYTNUATBEN = ISNULL(S.IsTnuatBen,0)		
		,@MYSUG_HAVARA = 0
		,@MYSUG_LINK = 0
		,@MYLINK_KEY = 0
		,@MYNEWRECS = 0
		,@MYREC_CHANGE = 0
		,@MYREC_COUNT = 0
		,@MYCODENEHAG = S.DriverNo1
		,@MYLINK_KEY2 = 0
		,@MYKILLBEN = 0
		,@MYSTARTTIME = S.ShibBeginTime
		,@MYENDTIME = S.ShibEndTime
		FROM AtmShib S
		WHERE S.ShibNo = @CURAZMN;
		
		EXECUTE Asp_PriceCheck
		 @CALLCODE = @MYCALLCODE 
		,@SUBCODE = @MYSUBCODE
		,@ORDERNO = @MYORDERNO
		,@TODAY = @MYTODAY
		,@CODELAK = @MYCODELAK
		,@CODEMASLUL = @MYCODEMASLUL
		,@CODEHIUV = @MYCODEHIUV
		,@CARKIND = @MYCARKIND
		,@BOXES = @MYBOXES
		,@HOVALAKIND = @MYHOVALAKIND
		,@HOZE = @MYHOZE
		,@MISHKAL = @MYMISHKAL
		,@NEFHPRO = @MYNEFHPRO
		,@NEFH = @MYNEFH
		,@QUANTPRO = @MYQUANTPRO
		,@QUANT1 = @MYQUANT1
		,@QUANT2 = @MYQUANT2
		,@QUANT3 = @MYQUANT3
		,@QUANT4 = @MYQUANT4
		,@QUANTMUSA = @MYQUANTMUSA
		,@TOTALKM = @MYTOTALKM
		,@TOTALHOUR = @MYTOTALHOUR
		,@TOTALPOINTS = @MYTOTALPOINTS
		,@PRICE1 = @MYPRICE1 OUTPUT
		,@PRICE2 = @MYPRICE2 OUTPUT
		,@PRICE3 = @MYPRICE3 OUTPUT
		,@PRICE4 = @MYPRICE4 OUTPUT
		,@TOTAL1 = @MYTOTAL1 OUTPUT
		,@TOTAL2 = @MYTOTAL2 OUTPUT
		,@TOTAL3 = @MYTOTAL3 OUTPUT
		,@TOTAL4 = @MYTOTAL4 OUTPUT
		,@YEMIDA1 = @MYYEMIDA1 OUTPUT
		,@YEMIDA2 = @MYYEMIDA2 OUTPUT
		,@YEMIDA3 = @MYYEMIDA3
		,@YEMIDA4 = @MYYEMIDA4
		,@MCRECS = @MYMCRECS OUTPUT
		,@USERNAME = @MYUSERNAME
		,@TNUATBEN = @MYTNUATBEN
		,@SUG_HAVARA = @MYSUG_HAVARA
		,@SUG_LINK = @MYSUG_LINK
		,@LINK_KEY = @MYLINK_KEY
		,@NEWRECS = @MYNEWRECS
		,@REC_CHANGE = @MYREC_CHANGE
		,@REC_COUNT = @MYREC_COUNT
		,@STARTTIME = @MYSTARTTIME
		,@ENDTIME = @MYENDTIME
		;
		
		UPDATE S
		SET 
			S.MCRecs = @MYMCRECS
		FROM AtmShib S
		WHERE S.ShibNo = @CURAZMN
		;
		
		SELECT @CURAZMN = MIN(S.ShibNo)
		FROM AtmShib S
		WHERE S.ShibNo > @CURAZMN
		AND S.ShibAzmnDate >= DATEADD(YEAR, -1, GETDATE())
		AND S.LakHesbonit IS NULL
		AND S.ShibKind >= 0;
	END
	;
END
;