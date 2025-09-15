SELECT 
	AMGPO_ID,
	Recipient_ID,
	any(Recipient_Type) AS Recipient_Type,
	any(Product_Type) AS Product_Type,
	Product_Name,
	NDC_Or_PDI,
	SUM(Total_Amount) AS Total_Amount,
	any(Recipient_Name) AS Recipient_Name
FROM (
	SELECT 
		Applicable_Manufacturer_or_Applicable_GPO_Making_Payment_ID as AMGPO_ID,
		if (
			Covered_Recipient_Type = 'Covered Recipient Teaching Hospital',
			Teaching_Hospital_ID,
			Covered_Recipient_Profile_ID
		) AS Recipient_ID,
		Covered_Recipient_Type AS Recipient_Type,
		Indicate_Drug_or_Biological_or_Device_or_Medical_Supply_1 AS Product_Type,
		Name_of_Drug_or_Biological_or_Device_or_Medical_Supply_1 AS Product_Name,
		if (
			Associated_Drug_or_Biological_NDC_1 != '',
			Associated_Drug_or_Biological_NDC_1,
			Associated_Device_or_Medical_Supply_PDI_1
		) AS NDC_Or_PDI,
		CAST(Total_Amount_of_Payment_USDollars AS Decimal64(2)) AS Total_Amount,
		if (
			Covered_Recipient_Type = 'Covered Recipient Teaching Hospital',
			Teaching_Hospital_Name,
			CONCAT(
				Covered_Recipient_First_Name, 
				' ',
				if(
					Covered_Recipient_Middle_Name = '', 
					'', 
					concat(Covered_Recipient_Middle_Name, ' ')
				),
				Covered_Recipient_Last_Name
			)
		) AS Recipient_Name
	FROM general_payments
	WHERE
		Name_of_Drug_or_Biological_or_Device_or_Medical_Supply_1 != ''
		AND Indicate_Drug_or_Biological_or_Device_or_Medical_Supply_1 IN ('Drug', 'Device')

	UNION ALL 
	SELECT 
		Applicable_Manufacturer_or_Applicable_GPO_Making_Payment_ID as AMGPO_ID,
		if (
			Covered_Recipient_Type = 'Covered Recipient Teaching Hospital',
			Teaching_Hospital_ID,
			Covered_Recipient_Profile_ID
		) AS Recipient_ID,
		Covered_Recipient_Type AS Recipient_Type,
		Indicate_Drug_or_Biological_or_Device_or_Medical_Supply_2 AS Product_Type,
		Name_of_Drug_or_Biological_or_Device_or_Medical_Supply_2 AS Product_Name,
		if (
			Associated_Drug_or_Biological_NDC_2 != '',
			Associated_Drug_or_Biological_NDC_2,
			Associated_Device_or_Medical_Supply_PDI_2
		) AS NDC_Or_PDI,
		CAST(Total_Amount_of_Payment_USDollars AS Decimal64(2)) AS Total_Amount,
		if (
			(Covered_Recipient_Type = 'Covered Recipient Teaching Hospital'),
			Teaching_Hospital_Name,
			CONCAT(
				Covered_Recipient_First_Name, 
				' ',
				if(
					Covered_Recipient_Middle_Name = '', 
					'', 
					concat(Covered_Recipient_Middle_Name, ' ')
				),
				Covered_Recipient_Last_Name
			)
		) AS Recipient_Name
	FROM general_payments
	WHERE
		Name_of_Drug_or_Biological_or_Device_or_Medical_Supply_2 != ''
		AND Indicate_Drug_or_Biological_or_Device_or_Medical_Supply_2 IN ('Drug', 'Device')
)
GROUP BY AMGPO_ID, Recipient_ID, Product_Name, NDC_Or_PDI