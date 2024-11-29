SELECT 
  ob."FRG_naimenovanieObekta" AS "Объект", 
  kp."FRG_naimenovanieKontrolnogoPokazatelya" AS "Контрольный показатель",
  ct."FRG_Name" AS "Ответственный",
  CASE 
    WHEN nar."FRG_shtraf" <= 100 THEN nar."FRG_shtraf" * nar."FRG_premiyaOtvetstvennogo" / 100
    ELSE nar."FRG_shtraf"
  END AS "Сумма штрафа",
  nar."FRG_premiyaOtvetstvennogo",
  nar."FRG_shtraf"
FROM 
  public."BoForeignInstancereestrNarushenii" nar
  LEFT JOIN public."BoForeignInstanceobektiKompanii" ob ON ob."Id" = nar."FRG_obektProverki"
  LEFT JOIN public."BoForeignInstancespravochnikKontrolnikhPokazatelei" kp ON kp."Id" = nar."FRG_kriteriiProverki"
  LEFT JOIN public."BoForeignInstancecontacts" ct ON ct."Id" = nar."FRG_otvetstvennii"
WHERE 
  nar."FRG_srokUstraneniya" < (SELECT DATE(NOW()))
	and
	("FRG_dataRegistratsiiNarusheniya" >= @periodStart) and ("FRG_dataRegistratsiiNarusheniya" <= @periodEnd);
