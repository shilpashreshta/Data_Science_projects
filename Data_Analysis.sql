create database us_candy;
use us_candy;
show tables;

#================================== DATA ANALYSIS =========================================

# Below cities data was not available in the data set

INSERT INTO uszips (city, state_name, lat, lng) VALUES
('New York City', 'New York', 40.7128, -74.0060),
('Des Moines', 'Washington', 47.8012, -122.3126),
('Vancouver', 'British Columbia', 49.2827, -123.1207),
('Parma', 'Ohio', 41.4048, -81.7229),
('Lawrence', 'Indiana', 39.8387, -86.0253),
('Toronto', 'Ontario', 43.651070, -79.347015),
('Tamarac', 'Florida', 26.2129, -80.2498),
('Bartlett', 'Tennessee', 35.2045, -89.8730),
('Coral Gables', 'Florida', 25.7215, -80.2684),
('Montreal', 'Quebec', 45.5017, -73.5673),
('Quebec City', 'Quebec', 46.8139, -71.2082),
('Roseville', 'Minnesota', 45.0061, -93.1566),
('Hoover', 'Alabama', 33.4054, -86.8114),
('Hot Springs', 'Arkansas', 34.5037, -93.0552),
('Covington', 'Washington', 47.3583, -122.1186),
('Woodbury', 'Minnesota', 44.9239, -92.9594),
('Apple Valley', 'Minnesota', 44.7319, -93.2177),
('North Miami', 'Florida', 25.8901, -80.1867),
('Miramar', 'Florida', 25.9861, -80.3036),
('Eagan', 'Minnesota', 44.8041, -93.1669),
('Murray', 'Utah', 40.6669, -111.8870),
('Sandy Springs', 'Georgia', 33.9304, -84.3733),
('Calgary', 'Alberta', 51.0447, -114.0719),
('Edmonton', 'Alberta', 53.5461, -113.4938),
('Charlottetown', 'Prince Edward Island', 46.2382, -63.1311),
('Winnipeg', 'Manitoba', 49.8951, -97.1384),
('St. John\'s', 'Newfoundland and Labrador', 47.5615, -52.7126),
('Tigard', 'Oregon', 45.4312, -122.7715),
('Kirkwood', 'Missouri', 38.5834, -90.4068),
('Gladstone', 'Missouri', 39.2036, -94.5615),
('Moncton', 'New Brunswick', 46.0878, -64.7782),
('Coon Rapids', 'Minnesota', 45.1732, -93.3030),
('Halifax', 'Nova Scotia', 44.6488, -63.5752),
('East Point', 'Georgia', 33.6796, -84.4394),
('Margate', 'Florida', 26.2445, -80.2064),
('Rochester Hills', 'Michigan', 42.6584, -83.1498),
('Regina', 'Saskatchewan', 50.4452, -104.6189),
('West Allis', 'Wisconsin', 43.0167, -88.0070);
-------------------------------------------------------------

# 1: Create the New Table
CREATE TABLE CustomerFactoryDistances (
    Customer_ID VARCHAR(255),
    City VARCHAR(255),
    State_Name VARCHAR(255), 
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
INSERT INTO CustomerFactoryDistances (Customer_ID, City, State_Name, Product_ID, Current_Delivering_Factory)
SELECT 
    s.Customer_ID,
    s.City,
    s.State_Name,
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
 
UPDATE customerfactorydistances c
JOIN uszips z ON c.City = z.city AND c.State_Name = z.state_name
JOIN candy_factories f ON c.Current_Delivering_Factory = f.factory
SET c.Curr_Fact_Dist = (
    6371 * ACOS(
        COS(RADIANS(z.lat)) * COS(RADIANS(f.Latitude)) *
        COS(RADIANS(f.Longitude) - RADIANS(z.lng)) +
        SIN(RADIANS(z.lat)) * SIN(RADIANS(f.Latitude))
    )
);

-------------------------------------------------------------
# 4: Calculate Distances for Each Factory

UPDATE CustomerFactoryDistances c
JOIN uszips z ON c.City = z.city AND c.State_Name = z.state_name
JOIN candy_factories f ON f.factory = 'Lots_O_Nuts'
SET c.Lots_O_Nuts = 6371 * ACOS(
    COS(RADIANS(z.lat)) * COS(RADIANS(f.latitude)) *
    COS(RADIANS(f.longitude) - RADIANS(z.lng)) +
    SIN(RADIANS(z.lat)) * SIN(RADIANS(f.latitude))
);

UPDATE CustomerFactoryDistances c
JOIN uszips z ON c.City = z.city AND c.State_Name = z.state_name
JOIN candy_factories f ON f.factory = 'Wicked_Choccy'
SET c.Wicked_Choccy = 6371 * ACOS(
    COS(RADIANS(z.lat)) * COS(RADIANS(f.latitude)) *
    COS(RADIANS(f.longitude) - RADIANS(z.lng)) +
    SIN(RADIANS(z.lat)) * SIN(RADIANS(f.latitude))
);

UPDATE CustomerFactoryDistances c
JOIN uszips z ON c.City = z.city AND c.State_Name = z.state_name
JOIN candy_factories f ON f.factory = 'Sugar_Shack'
SET c.Sugar_Shack = 6371 * ACOS(
    COS(RADIANS(z.lat)) * COS(RADIANS(f.latitude)) *
    COS(RADIANS(f.longitude) - RADIANS(z.lng)) +
    SIN(RADIANS(z.lat)) * SIN(RADIANS(f.latitude))
);

UPDATE CustomerFactoryDistances c
JOIN uszips z ON c.City = z.city AND c.State_Name = z.state_name
JOIN candy_factories f ON f.factory = 'Secret_Factory'
SET c.Secret_Factory = 6371 * ACOS(
    COS(RADIANS(z.lat)) * COS(RADIANS(f.latitude)) *
    COS(RADIANS(f.longitude) - RADIANS(z.lng)) +
    SIN(RADIANS(z.lat)) * SIN(RADIANS(f.latitude))
);

UPDATE CustomerFactoryDistances c
JOIN uszips z ON c.City = z.city AND c.State_Name = z.state_name
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

