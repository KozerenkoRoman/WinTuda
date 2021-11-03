SELECT Nehag.Kod_Nehag, Nehag.Shem_Nehag, Nehag.Kod_Kvutza, KodTavla.Teur_Tavla
FROM Nehag,KodTavla
Where (Nehag.Nehag_Pail <> 0) and
(KodTavla.Sug_Tavla = 2) and
(Nehag.Kod_Kvutza = KodTavla.Kod_Tavla) and
(Nehag.Kod_Nehag not In
(Select DriverNo2
From AtmShib
Where (ShibAzmnDate = :PSidurDate) and
      (ShibBeginTime <= :PToTime) and
      (ShibEndTime >=   :PFromTime) and 
      (ShibKind=0))) and
(Nehag.Kod_Nehag not In
(Select N.Kod_Nehag
From Nehag N,CalNehag CalN
Where (N.Kod_Nehag = Caln.Code_Calender ) and
(Caln.Day_date = :PSidurDate) and
(Caln.Code_Sug_Day > 1)))
ORDER BY Shem_Nehag
