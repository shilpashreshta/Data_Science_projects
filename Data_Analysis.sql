create database us_candy;
use us_candy;
show tables;

#================================== DATA ANALYSIS =========================================

# Below cities data was not available in the data set

INSERT INTO US_Zips (city, lat, lng)
VALUES 
('New York City', 40.712776, -74.005974),
('Winnipeg', 49.895077, -97.138451),
('Sandy Springs', 33.930436, -84.373314),
('Calgary', 51.044733, -114.071883),
('Miramar', 25.987438, -80.232274),
('Quebec City', 46.813878, -71.207981),
('St. John\'s', 47.561510, -52.712576),
('Tigard', 45.431230, -122.771487),
('Moncton', 46.087817, -64.778231),
('Charlottetown', 46.238241, -63.131071),
('Tamarac', 26.212860, -80.249770),
('Coral Gables', 25.721490, -80.268384),
('Hoover', 33.405386, -86.811378),
('Margate', 26.244526, -80.206436),
('Rochester Hills', 42.658366, -83.149926),
('West Allis', 43.016681, -88.007031);

-------------------------------------------------------------

# 1: Create the New Table
CREATE TABLE CustomerFactoryDistances (
    Customer_ID VARCHAR(255),
    City VARCHAR(255),
    Product_ID VARCHAR(255),
    Current_Delivering_Factory VARCHAR(255),
    Lots_O_Nuts FLOAT,
    Wicked_Choccy FLOAT,
    Sugar_Shack FLOAT,
    Secret_Factory FLOAT,
    The_Other_Factory FLOAT,
    min_fact_distance FLOAT,
    min_dist_factory VARCHAR(255),
    shift_reqrd CHAR(1)
   );
 -------------------------------------------------------------
 
  # 2: Insert Base Data
INSERT INTO CustomerFactoryDistances (Customer_ID, City, Product_ID, Current_Delivering_Factory)
SELECT 
    s.Customer_ID,
    s.City,
    s.Product_ID,
    p.Factory
FROM 
    candy_sales s
JOIN 
    candy_products p
ON 
    s.Product_ID = p.Product_ID;

 -------------------------------------------------------------
# 3: Calculate Distances from Factory to Customer City
 
ALTER TABLE customerfactorydistances 
ADD COLUMN Curr_Fact_Dist DECIMAL(10, 2);
   
UPDATE customerfactorydistances cfd
JOIN candy_sales s ON cfd.Customer_ID = s.Customer_ID
JOIN US_Zips uz ON s.City = uz.city
JOIN candy_factories f ON cfd.Current_Delivering_Factory = f.factory
SET cfd.Curr_Fact_Dist = (
    6371 * ACOS(
        COS(RADIANS(uz.lat)) * COS(RADIANS(f.Latitude)) *
        COS(RADIANS(f.Longitude) - RADIANS(uz.lng)) +
        SIN(RADIANS(uz.lat)) * SIN(RADIANS(f.Latitude))
    )
);
    
-------------------------------------------------------------
# 4: Calculate Distances for Each Factory

UPDATE CustomerFactoryDistances c
JOIN US_Zips z ON c.City = z.city
JOIN candy_factories f ON f.factory = 'Lots_O_Nuts'
SET c.Lots_O_Nuts = 6371 * ACOS(
    COS(RADIANS(z.lat)) * COS(RADIANS(f.latitude)) *
    COS(RADIANS(f.longitude) - RADIANS(z.lng)) +
    SIN(RADIANS(z.lat)) * SIN(RADIANS(f.latitude))
);

UPDATE CustomerFactoryDistances c
JOIN US_Zips z ON c.City = z.city
JOIN candy_factories f ON f.factory = 'Wicked_Choccy'
SET c.Wicked_Choccy = 6371 * ACOS(
    COS(RADIANS(z.lat)) * COS(RADIANS(f.latitude)) *
    COS(RADIANS(f.longitude) - RADIANS(z.lng)) +
    SIN(RADIANS(z.lat)) * SIN(RADIANS(f.latitude))
);

UPDATE CustomerFactoryDistances c
JOIN US_Zips z ON c.City = z.city
JOIN candy_factories f ON f.factory = 'Sugar_Shack'
SET c.Sugar_Shack = 6371 * ACOS(
    COS(RADIANS(z.lat)) * COS(RADIANS(f.latitude)) *
    COS(RADIANS(f.longitude) - RADIANS(z.lng)) +
    SIN(RADIANS(z.lat)) * SIN(RADIANS(f.latitude))
);

UPDATE CustomerFactoryDistances c
JOIN US_Zips z ON c.City = z.city
JOIN candy_factories f ON f.factory = 'Secret_Factory'
SET c.Secret_Factory = 6371 * ACOS(
    COS(RADIANS(z.lat)) * COS(RADIANS(f.latitude)) *
    COS(RADIANS(f.longitude) - RADIANS(z.lng)) +
    SIN(RADIANS(z.lat)) * SIN(RADIANS(f.latitude))
);

UPDATE CustomerFactoryDistances c
JOIN US_Zips z ON c.City = z.city
JOIN candy_factories f ON f.factory = 'The_Other_Factory'
SET c.The_Other_Factory = 6371 * ACOS(
    COS(RADIANS(z.lat)) * COS(RADIANS(f.latitude)) *
    COS(RADIANS(f.longitude) - RADIANS(z.lng)) +
    SIN(RADIANS(z.lat)) * SIN(RADIANS(f.latitude))
);

-------------------------------------------------------------
# 5: Find the Minimum distance from factory to customer (min_fact_distance)

UPDATE CustomerFactoryDistances
SET min_fact_distance = LEAST(Lots_O_Nuts, Wicked_Choccy, Sugar_Shack, Secret_Factory, The_Other_Factory);

-------------------------------------------------------------
# 6: Note the Minimum distanced Factory Name (min_dist_factory)

UPDATE CustomerFactoryDistances
SET min_dist_factory = CASE
    WHEN min_fact_distance = Lots_O_Nuts THEN 'Lots_O_Nuts'
    WHEN min_fact_distance = Wicked_Choccy THEN 'Wicked_Choccy'
    WHEN min_fact_distance = Sugar_Shack THEN 'Sugar_Shack'
    WHEN min_fact_distance = Secret_Factory THEN 'Secret_Factory'
    WHEN min_fact_distance = The_Other_Factory THEN 'The_Other_Factory'
END;

-------------------------------------------------------------
# 7. Find out if the products needs to be shifted to a different factory so as to achive the shorter delivery distance (shift_reqrd)

UPDATE CustomerFactoryDistances
SET shift_reqrd = CASE
    WHEN Current_Delivering_Factory = min_dist_factory THEN 0
    ELSE 1
END;

-------------------------------------------------------------
# 8. Product Margin (%): Calculated as (Gross Profit / Total Revenue) * 100

ALTER TABLE candy_sales 
ADD COLUMN prod_margin DECIMAL(10, 2);

update candy_sales
set prod_margin= (Gross_Profit /sales)* 100;

-------------------------------------------------------------
# 9. Verify
select * from CustomerFactoryDistances limit 10;

