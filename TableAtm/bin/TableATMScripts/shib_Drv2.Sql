SELECT
       Shem_Nehag,
       Kod_Nehag,
       Teur_Tavla,
       Kod_Kvutza

FROM  Nehag,KodTavla
       
WHERE  (Nehag_Pail = 1) and
       (Sug_Tavla = 2) and
       (Kod_Kvutza = Kod_Tavla) 

Order by %SortBy

