/*Crea una vista que contine el consolidado para los resultados de las elecciones 2021 (PASO y General) por circuito*/

USE [PROVINCIA]

CREATE VIEW CONSOLIDADO_2021_CIRCUITOS AS 
SELECT 
	  [tipo_eleccion]='GENERAL'
	  ,[FECHA_TIPO_ELECCCION]='2021 - GENERAL'
	  ,CASE 
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
      ,CASE
		WHEN [partido]=' AZA.JUNTOS                              ' THEN 'ALIANZA JUNTOS'
		WHEN [partido]=' AZA.AVANZA LIBERTAD                     ' THEN 'AVANZA LIBERTAD'
		ELSE LTRIM(RTRIM([partido]))
	   END [partido]
      ,SUM(CAST([votos]AS int)) [votos]	  
	  ,circuito
  FROM [PROVINCIA].[dbo].[2021_GENERALES]
  WHERE [cargo]=' CARGOS MUNICIPALES             '

  GROUP BY [seccion],[partido],[circuito]
  

UNION ALL

  SELECT 
	  [tipo_eleccion]='PASO'
	  ,[FECHA_TIPO_ELECCCION]='2021 - PASO'
	  ,CASE 
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
      ,CASE
		WHEN [partido]=' AZA.JUNTOS                              ' THEN 'ALIANZA JUNTOS'
		WHEN [partido]=' AZA.AVANZA LIBERTAD                     ' THEN 'AVANZA LIBERTAD'
		ELSE LTRIM(RTRIM([partido]))
	   END [partido]
      ,SUM(CAST([votos]AS int)) [votos]	 
	  ,circuito
  FROM [dbo].[2021_PASO]
  WHERE [cargo]=' CARGOS MUNICIPALES             '
  GROUP BY [seccion],[partido],[circuito]


---Cruce de la vista con la LK MUNICIPIOS para obtener el id_municipio
SELECT
	  T1.[tipo_eleccion]
      ,T1.[FECHA_TIPO_ELECCCION]
      ,T1.[seccion]
      ,T1.[partido]
      ,T1.[votos]
	  ,T1.circuito
	  ,T2.[Idmunicipio]
  FROM[dbo].[CONSOLIDADO_2021_CIRCUITOS]  AS T1
  LEFT JOIN [dbo].[LK_MUNICIPIOS_SECCCIONES] T2 ON  T1.[seccion]=T2.[nombreMunicipio]
  --WHERE T2.[Idmunicipio] IS NULL



  