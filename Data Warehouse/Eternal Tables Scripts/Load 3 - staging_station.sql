IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'ivoryjoy_ivoryjoy_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [ivoryjoy_ivoryjoy_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://ivoryjoy@ivoryjoy.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.staging_station (
	[station_id] nvarchar(4000),
	[name] nvarchar(4000),
	[latitude] nvarchar(4000),
	[longtitude] nvarchar(4000)
	)
	WITH (
	LOCATION = 'publicstation.txt',
	DATA_SOURCE = [ivoryjoy_ivoryjoy_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_station
GO