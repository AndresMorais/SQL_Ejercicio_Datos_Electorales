/*consolidado de los resultados resultados para las elecciones 2019 y 2021 (PASO y General) por circuito*/

USE [PROVINCIA]


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


UNION ALL
  (SELECT
	[tipo_eleccion]='GENERAL'
	,[FECHA_TIPO_ELECCCION]='2019 - GENERAL'
	,LTRIM(RTRIM([Column 7])) AS [seccion] --PRIV. DE LIBERTAD / ARG.EN EL EXTERIOR                                      
	,LTRIM(RTRIM([Column 15])) AS [partido]
	,SUM(CAST([Column 27] AS INT)) AS [votos] 
	,[column 11] as [circuitos]
	,[Column 6] AS [Idmunicipio] 
	FROM [dbo].[2019_GENERAL]
	WHERE [Column 24]='CARGOS MUNICIPALES'
	GROUP BY [Column 7],[Column 15],[Column 6],[column 11])

UNION ALL
  (SELECT
	[tipo_eleccion]='PASO'
	,[FECHA_TIPO_ELECCCION]='2019 - PASO'
	,LTRIM(RTRIM([Column 7])) AS [seccion] --PRIV. DE LIBERTAD / ARG.EN EL EXTERIOR                                      
	,LTRIM(RTRIM([Column 15])) AS [partido]
	,SUM(CAST([Column 27] AS INT)) AS [votos] 
	,[column 11] as [circuitos]
	,[Column 6] AS [Idmunicipio] 
	FROM [dbo].[2019_PASO]
	WHERE [Column 24]='CARGOS MUNICIPALES'
	GROUP BY [Column 7],[Column 15],[Column 6],[column 11])