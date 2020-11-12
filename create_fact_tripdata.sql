CREATE TABLE chernysh_schema.fact_tripdata
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION =  HASH([DOLocationID])) AS
SELECT  * FROM    chernysh_schema.external_table_chernysh