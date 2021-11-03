Select H.hesbonitNumber ,
       H.HesbonitKind ,
       H.CodeLakoach,
       H.hesbonitDate,
       H.TotalHesbonitWithMAM ,H.Mamhesbonit,
       H.mampercent , H.PratimToHan ,
       H.YehusMonth ,h.codehaavaratohan ,
       H.YehusYear,
       H.TotalSumFromTnua,
       H.TotalSumPriceKamut,
       H.DatePiraon,
       H.MisHaavaraToHan,
       H.Incom_Type,
       H.HanForLak,
       H.HanForMam,
       H.Status,
       H.Kod_Sapak,H.Merakez,
       H.KvutzaLeChiyuv,
       H.MAMRound,
       N.Integer_1,
       N.Mis_Han,
       N.Shem_Nehag As Shem_Lakoach

from
  MakavNhg H ,
  Nehag    N

where (H.HesbonitKind<>11)
      And
      (H.HesbonitKind<>15)
      And
      (H.HesbonitKind<>18)
      And
      (H.CodeLakoach = N.Kod_Nehag)
      And
      (H.codeLakoach >= :PSapF)
      and
      (H.codeLakoach <= :PSapT)
      and
      (H.hesbonitNumber >= :PtnuF)
      and
      (H.hesbonitNumber <= :Ptnut)
      And
      (H.YehusYear = :PShnatmas)
      And
      (H.YehusMonth>=:Phodf)
      And
      (H.YehusMonth<=:Phodt)
      and
      (H.hesbonitDate >= :PdateF)
      and
      (H.hesbonitDate <= :Pdatet)
      and
      (H.TotalHesbonitWithMAM<>0)
      and
( (
    ( (H.CodeHaavaraToHan = 0)
      Or
      (H.CodeHaavaraToHan Is Null) )
      And
      (H.Status <> 9)
   )
OR
   (
      (H.Status = 9)
      And
      (H.CodeHaavaraToHan = 2)
    )
)
