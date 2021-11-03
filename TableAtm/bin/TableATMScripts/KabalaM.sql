SELECT HesbonitNumber, YehusYear, HesbonitKind, CodeLakoach, LakoachGroup, HesbonitDate, TotalHesbonitWithMAM, Total_Zikuy, TotalHesbonitWithMAM-Total_Zikuy Itra,
'Teur_Sug_Hesbonit' = Case HesbonitKind
                                 when  1 then '������� �����'
                                 when  2 then  '������� ������'
                                 when  3 then  '������� ��� ���'
                                 when  7 then  '������� �� ������'
                                 when  8 then  '������� ���� ����'
                                 when  9 then  '����/�����/�� �����'
                                 when  10 then  '����/�����/�� ������'
                                 when  11 then  '���� �����'
                                 when  12 then  '������� �����'
                                 when  14 then  '�-� ����� ������'
                                 when  15 then  '������� ������'
                                 when  16 then  '������� �� ����'
                                 when  17 then  '�� ���� ������'
end
FROM Makav
Where %MWhereLak
   And (TotalHesbonitWithMAM <> Total_Zikuy) 
   And Status = 0
   And HesbonitKind In (2,14)
  And Integer_1 = 0
Order by HesbonitNumber
