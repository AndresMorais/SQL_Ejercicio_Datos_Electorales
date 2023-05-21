/*consolidado con el total de electores para las elecciones 2019 y 2021 (PASO y General) por municipio*/

USE [PROVINCIA]


-----------Electores PASO 2019-------------
WITH KPI_PASO_2019
	AS( SELECT 
			 [tipo_eleccion]='PASO'
	         ,[fecha_tipo_eleccion]='2019 - PASO'
			,[Column 7] AS [Seccion]	
			,SUM(CAST([Column 28]AS int)) AS [electores]
		FROM [dbo].[2019_GENERAL]
		WHERE [Column 24]='CARGOS MUNICIPALES'
		GROUP BY [Column 7]
)
 SELECT 
     [tipo_eleccion]='PASO'
	,[fecha_tipo_eleccion]='2019 - PASO'
	,[seccion]
	,[electores]
	 FROM KPI_PASO_2019;


-----------Electores GENERALES 2019-------------
WITH KPI_GENERAL_2019
	AS( SELECT 
			[Column 7] AS [Seccion]	
			,SUM(CAST([Column 28]AS int)) AS [electores]
		FROM [dbo].[2019_GENERAL]
		WHERE [Column 24]='CARGOS MUNICIPALES'
		GROUP BY [Column 7]
)
 SELECT 
     [tipo_eleccion]='GENERAL'
	,[fecha_tipo_eleccion]='2019 - GENERAL'
	,[seccion]
	,[electores]
	 FROM KPI_GENERAL_2019;





-------Electores  PASO 2021-----------
  WITH KPI_PASO_2021 
  AS(
	SELECT 	
	CASE 
		WHEN [seccion] LIKE '%CAUELAS%' THEN 'CAÑUELAS'
		WHEN [seccion] LIKE '%CAÑUELAS%' THEN 'CAÑUELAS'
		WHEN [seccion] LIKE '%GENERAL LAMADRID%' THEN 'GENERAL LAMADRID'
		WHEN [seccion] LIKE '%GENERAL LA MADRID%' THEN 'GENERAL LAMADRID'
		WHEN [seccion]=' JOSE C. PAZ                    ' THEN 'J. C. PAZ'
		WHEN [seccion]=' FLORENTINO AMEGHINO            ' THEN 'F. AMEGHINO'
		WHEN [seccion]=' BENITO JUAREZ                  ' THEN 'JUAREZ'
		WHEN [seccion]=' ADOLFO GONZALES CHAVES         ' THEN 'GONZALES CHAVES'
		WHEN [seccion]=' GENERAL JUAN MADARIAGA         ' THEN 'GENERAL MADARIAGA'
		WHEN [seccion] LIKE '%ROSALES%'					  THEN 'CORONEL ROSALES'
		WHEN [seccion] LIKE '%HERAS%'                     THEN 'LAS HERAS'
		ELSE LTRIM(RTRIM([seccion]))
		END  [seccion]
	,MAX(CAST([ inscriptos ] AS int)) AS 'electores'
	FROM [PROVINCIA].[dbo].[2021_PASO]

	GROUP BY seccion,[ numero_mesa ]

 )
 
 SELECT 
     [tipo_eleccion]='PASO'
	,[FECHA_TIPO_ELECCCION]='2021 - PASO'
	,[seccion]
	,SUM(electores) AS 'electores'
	FROM KPI_PASO_2021
	GROUP BY seccion



-----Electores GENERAL 2021----
WITH KPI_GENERAL_2021 
  AS(
	SELECT 	
	CASE 
		WHEN [seccion] LIKE '%CAUELAS%' THEN 'CAÑUELAS'
		WHEN [seccion] LIKE '%CAÑUELAS%' THEN 'CAÑUELAS'
		WHEN [seccion] LIKE '%GENERAL LAMADRID%' THEN 'GENERAL LAMADRID'
		WHEN [seccion] LIKE '%GENERAL LA MADRID%' THEN 'GENERAL LAMADRID'
		WHEN [seccion]=' JOSE C. PAZ                    ' THEN 'J. C. PAZ'
		WHEN [seccion]=' FLORENTINO AMEGHINO            ' THEN 'F. AMEGHINO'
		WHEN [seccion]=' BENITO JUAREZ                  ' THEN 'JUAREZ'
		WHEN [seccion]=' ADOLFO GONZALES CHAVES         ' THEN 'GONZALES CHAVES'
		WHEN [seccion]=' GENERAL JUAN MADARIAGA         ' THEN 'GENERAL MADARIAGA'
		WHEN [seccion] LIKE '%ROSALES%'					  THEN 'CORONEL ROSALES'
		WHEN [seccion] LIKE '%HERAS%'                     THEN 'LAS HERAS'
		ELSE LTRIM(RTRIM([seccion]))
		END  [seccion]
	,MAX(CAST([inscriptos] AS int)) AS 'electores'
	FROM [dbo].[2021_GENERALES]
	GROUP BY seccion,[numero_mesa]

 )
 
 SELECT 
     [tipo_eleccion]='GENERAL'
	,[FECHA_TIPO_ELECCCION]='2021 - GENERAL'
	,[seccion]
	,SUM(electores) AS 'electores'
	FROM KPI_GENERAL_2021
	GROUP BY seccion


-----Vista Electores PASO  2021------
CREATE VIEW PASO_ELECTORES_2021 AS
  WITH KPI_PASO_2021 
  AS(
	SELECT 	
	CASE 
		WHEN [seccion] LIKE '%CAUELAS%' THEN 'CAÑUELAS'
		WHEN [seccion] LIKE '%CAÑUELAS%' THEN 'CAÑUELAS'
		WHEN [seccion] LIKE '%GENERAL LAMADRID%' THEN 'GENERAL LAMADRID'
		WHEN [seccion] LIKE '%GENERAL LA MADRID%' THEN 'GENERAL LAMADRID'
		WHEN [seccion]=' JOSE C. PAZ                    ' THEN 'J. C. PAZ'
		WHEN [seccion]=' FLORENTINO AMEGHINO            ' THEN 'F. AMEGHINO'
		WHEN [seccion]=' BENITO JUAREZ                  ' THEN 'JUAREZ'
		WHEN [seccion]=' ADOLFO GONZALES CHAVES         ' THEN 'GONZALES CHAVES'
		WHEN [seccion]=' GENERAL JUAN MADARIAGA         ' THEN 'GENERAL MADARIAGA'
		WHEN [seccion] LIKE '%ROSALES%'					  THEN 'CORONEL ROSALES'
		WHEN [seccion] LIKE '%HERAS%'                     THEN 'LAS HERAS'
		ELSE LTRIM(RTRIM([seccion]))
		END  [seccion]
	,MAX(CAST([ inscriptos ] AS int)) AS 'electores'
	FROM [PROVINCIA].[dbo].[2021_PASO]
	GROUP BY seccion,[ numero_mesa ]

 )
 
 SELECT 
     [tipo_eleccion]='PASO'
	,[FECHA_TIPO_ELECCCION]='2021 - PASO'
	,[seccion]
	,SUM(electores) AS 'electores'
	FROM KPI_PASO_2021
	GROUP BY seccion




--- ==Vista Electores GENERAL 2021==-----
CREATE VIEW GENERAL_ELECTORES_2021 AS 
WITH KPI_GENERAL_2021 
  AS(
	SELECT 	
	CASE 
		WHEN [seccion] LIKE '%CAUELAS%' THEN 'CAÑUELAS'
		WHEN [seccion] LIKE '%CAÑUELAS%' THEN 'CAÑUELAS'
		WHEN [seccion] LIKE '%GENERAL LAMADRID%' THEN 'GENERAL LAMADRID'
		WHEN [seccion] LIKE '%GENERAL LA MADRID%' THEN 'GENERAL LAMADRID'
		WHEN [seccion]=' JOSE C. PAZ                    ' THEN 'J. C. PAZ'
		WHEN [seccion]=' FLORENTINO AMEGHINO            ' THEN 'F. AMEGHINO'
		WHEN [seccion]=' BENITO JUAREZ                  ' THEN 'JUAREZ'
		WHEN [seccion]=' ADOLFO GONZALES CHAVES         ' THEN 'GONZALES CHAVES'
		WHEN [seccion]=' GENERAL JUAN MADARIAGA         ' THEN 'GENERAL MADARIAGA'
		WHEN [seccion] LIKE '%ROSALES%'					  THEN 'CORONEL ROSALES'
		WHEN [seccion] LIKE '%HERAS%'                     THEN 'LAS HERAS'
		ELSE LTRIM(RTRIM([seccion]))
		END  [seccion]
	,MAX(CAST([inscriptos] AS int)) AS 'electores'
	FROM [dbo].[2021_GENERALES]
	GROUP BY seccion,[numero_mesa]
 )
 
 SELECT 
     [tipo_eleccion]='GENERAL'
	,[FECHA_TIPO_ELECCCION]='2021 - GENERAL'
	,[seccion]
	,SUM(electores) AS 'electores'
	FROM KPI_GENERAL_2021
	GROUP BY seccion




------ Consolidado Electores 2019 y 2021 PASO y GENERAL---------
 SELECT 
    [tipo_eleccion]='PASO'
	,[fecha_tipo_eleccion]='2019 - PASO'
	,[Column 7] AS [Seccion]	
	,SUM(CAST([Column 28]AS int)) AS [electores]
	,[Column 6] AS [Idmunicipio]
FROM [dbo].[2019_GENERAL]
WHERE [Column 24]='CARGOS MUNICIPALES'
GROUP BY [Column 7],[Column 6]

UNION ALL(
	SELECT
		[tipo_eleccion]='GENERAL'
		,[fecha_tipo_eleccion]='2019 - GENERAL'
		,[Column 7] AS [Seccion]	
		,SUM(CAST([Column 28]AS int)) AS [electores]
		,[Column 6] AS [Idmunicipio]
		FROM [dbo].[2019_GENERAL]
		WHERE [Column 24]='CARGOS MUNICIPALES'
		GROUP BY [Column 7],[Column 6]
)
UNION ALL(
SELECT 
T1.*
,T2.Idmunicipio
FROM [dbo].[PASO_ELECTORES_2021] T1
LEFT JOIN [dbo].[LK_MUNICIPIOS_SECCCIONES] T2 ON T1.seccion=T2.nombreMunicipio
)

UNION ALL(
SELECT 
T1.*
,T2.Idmunicipio
FROM [dbo].[GENERAL_ELECTORES_2021] T1
LEFT JOIN [dbo].[LK_MUNICIPIOS_SECCCIONES] T2 ON T1.seccion=T2.nombreMunicipio
)