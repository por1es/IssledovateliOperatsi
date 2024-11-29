SELECT 
	ob."FRG_naimenovanieObekta" as "Объект", 
	kp."FRG_naimenovanieKontrolnogoPokazatelya" as "Контрольный показатель",
	ct."FRG_Name" as "Ответственный",
	"FRG_summaShtrafa" as "Сумма штрафа"
FROM 
	public."BoForeignInstancereestrNarushenii" nar
	left join
		public."BoForeignInstanceobektiKompanii" ob on ob."Id" = nar."FRG_obektProverki"
	left join
		public."BoForeignInstancespravochnikKontrolnikhPokazatelei" kp on kp."Id" = nar."FRG_kriteriiProverki"
	left join
		public."BoForeignInstancecontacts" ct on ct."Id" = nar."FRG_otvetstvennii"
Where 
	"FRG_srokUstraneniya" < "FRG_fakticheskiiSrokUstraneniya"
	and
	("FRG_dataRegistratsiiNarusheniya" >= @periodStart) and ("FRG_dataRegistratsiiNarusheniya" <= @periodEnd);