SELECT
       Nehag.Shem_Nehag,
       max(Nehag.Kod_Nehag) 'Kod_Nehag',
       max(Nehag.Kod_Kvutza) 'Kod_Kvutza',
       max(KodTavla.Teur_Tavla) 'Teur_Tavla'

FROM  Nehag,KodTavla
       
WHERE  (KodTavla.Sug_Tavla = 2) and
       (Nehag.Kod_Kvutza = KodTavla.Kod_Tavla) and
       (Nehag.Nehag_Pail = 1)

Group By Nehag.Shem_Nehag
Order by %SortBy

