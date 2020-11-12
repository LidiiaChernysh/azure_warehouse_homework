--Create reference tables
--Vendor(поля ID, Name) 
--RateCode(поля ID, Name) 
--Payment_type (поля ID, Name) 

/*CREATE TABLE chernysh_schema.Vendor
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION =  REPLICATE) AS
SELECT DISTINCT VendorID AS ID
FROM chernysh_schema.fact_tripdata
WHERE VendorID IS NOT NULL

-- add column Name
ALTER TABLE chernysh_schema.Vendor
ADD Name varchar(255) NULL

UPDATE chernysh_schema.Vendor
SET Name = CASE ID
      WHEN 1 THEN 'Creative Mobile Technologies, LLC'
      WHEN 2 THEN 'VeriFone Inc.'
      END

INSERT INTO chernysh_schema.Vendor (ID, Name)
SELECT  1,  'Creative Mobile Technologies, LLC' 
UNION ALL
SELECT  2,  'VeriFone Inc.'
EXCEPT (SELECT * FROM chernysh_schema.Vendor)*/




CREATE TABLE chernysh_schema.RateCode
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION =  REPLICATE) AS
SELECT DISTINCT RateCodeID AS ID
FROM chernysh_schema.fact_tripdata
WHERE RateCodeID IS NOT NULL

ALTER TABLE chernysh_schema.RateCode
ADD Name varchar(255) NULL

UPDATE chernysh_schema.RateCode
SET Name = CASE ID
      WHEN 1 THEN 'Standard rate'
      WHEN 2 THEN 'JFK'
      WHEN 3 THEN 'Newark'
      WHEN 4 THEN 'Nassau or Westchester'
      WHEN 5 THEN 'Negotiated fare'
      WHEN 6 THEN 'Group ride'
      END

INSERT INTO chernysh_schema.Vendor (ID, Name)
SELECT 1, 'Standard rate' 
UNION ALL
SELECT 2, 'JFK' 
UNION ALL
SELECT 3, 'Newark' 
UNION ALL
SELECT 4, 'Nassau or Westchester' 
UNION ALL
SELECT 5, 'Negotiated fare' 
UNION ALL
SELECT 6, 'Group ride'
EXCEPT (SELECT * FROM chernysh_schema.Vendor)



CREATE TABLE chernysh_schema.Payment_type
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = REPLICATE) AS
SELECT DISTINCT Payment_type AS ID
FROM chernysh_schema.fact_tripdata
WHERE Payment_type IS NOT NULL

ALTER TABLE chernysh_schema.Payment_type
ADD Name varchar(255) NULL

UPDATE chernysh_schema.Payment_type
SET Name = CASE ID
      WHEN 1 THEN 'Credit card'
      WHEN 2 THEN 'Cash'
      WHEN 3 THEN 'No charge'
      WHEN 4 THEN 'Dispute'
      WHEN 5 THEN 'Unknown'
      WHEN 6 THEN 'Voided trip'
      END

INSERT INTO chernysh_schema.Payment_type (ID, Name)
SELECT 1, 'Credit card' 
UNION ALL
SELECT 2, 'Cash' 
UNION ALL
SELECT 3, 'No charge' 
UNION ALL
SELECT 4, 'Dispute' 
UNION ALL
SELECT 5, 'Unknown' 
UNION ALL
SELECT 6, 'Voided trip'
EXCEPT (SELECT * FROM chernysh_schema.Payment_type)