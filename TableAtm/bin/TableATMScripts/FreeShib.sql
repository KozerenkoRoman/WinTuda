SELECT
       Nehag.Shem_Nehag,
       Rehev.Mis_Rishui,
       Rehev.Kod_Nehag,
       Rehev.Mis_Pnimi,
       Rehev.Kod_Kvutza,
       Rehev.Sug_Rehev,
       KodTavla.Teur_Tavla

FROM  Rehev,Nehag,KodTavla
       
WHERE  (Rehev.Mis_Pnimi > 0) and
       (Rehev.Sug_Rehev Between :PFromCarKind and :PToCarKind) and 
       (Rehev.Kod_Nehag = Nehag.Kod_Nehag) and
       (KodTavla.Sug_Tavla = 7) and
       (Nehag.Nehag_Pail = 1) and
       (Rehev.Sug_Rehev =KodTavla.Kod_Tavla) and
       (Rehev.Mis_Pnimi not In 
  (Select CarNo 
     From AtmShib
   Where (ShibAzmnDate = :PSidurDate) and
         ((ShibBeginTime <= :PToTime) and
          (ShibEndTime >=   :PFromTime) and
          (ShibKind=0))))

Order by %SortBy

