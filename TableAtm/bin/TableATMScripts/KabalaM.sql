SELECT HesbonitNumber, YehusYear, HesbonitKind, CodeLakoach, LakoachGroup, HesbonitDate, TotalHesbonitWithMAM, Total_Zikuy, TotalHesbonitWithMAM-Total_Zikuy Itra,
'Teur_Sug_Hesbonit' = Case HesbonitKind
                                 when  1 then 'חשבונית שקלית'
                                 when  2 then  'חשבונית דולרית'
                                 when  3 then  'חשבונית ללא מעמ'
                                 when  7 then  'חשבונית מס מזדמנת'
                                 when  8 then  'חשבונית חברת חשמל'
                                 when  9 then  'חיוב/זיכוי/מס שקלית'
                                 when  10 then  'חיוב/זיכוי/מס דולרית'
                                 when  11 then  'קבלה שקלית'
                                 when  12 then  'חשבונית זיכוי'
                                 when  14 then  'ח-ן זיכוי דולרית'
                                 when  15 then  'חשבונית דולרית'
                                 when  16 then  'חשבונית מס קבלה'
                                 when  17 then  'מס קבלה דולרית'
end
FROM Makav
Where %MWhereLak
   And (TotalHesbonitWithMAM <> Total_Zikuy) 
   And Status = 0
   And HesbonitKind In (2,14)
  And Integer_1 = 0
Order by HesbonitNumber
