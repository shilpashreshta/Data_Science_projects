
use us_candy;

#================================== Inferences =========================================
# 1. What are the most efficient factory to customer shipping routes?

select distinct City as Customer_Location, min_dist_factory as Factory, min_fact_distance as Distance_in_kms
from customerfactorydistances
where shift_reqrd =0
order by Distance_in_kms desc;

-------------------------------------------------------------
# What about the least efficient?

select distinct City as Customer_Location, Current_Delivering_Factory as Factory, Curr_Fact_Dist as Distance_in_kms
from customerfactorydistances
where shift_reqrd =1
order by Distance_in_kms desc;

-------------------------------------------------------------
# Which product lines have the best product margin?

SELECT distinct p.division AS Product_Line, s.Product_Name, s.prod_margin AS Product_Margin_Percent
FROM candy_sales s
JOIN candy_products p ON s.division = p.division
ORDER BY Product_Margin_Percent desc;

-------------------------------------------------------------
#Which product lines should be moved to a different factory to optimize shipping routes?

SELECT distinct p.division AS Product_Line, p.Product_Name, c.Current_Delivering_Factory, c.min_dist_factory as Add_To_Factory
from customerfactorydistances c
join candy_products p ON c.Product_ID = p.Product_ID
where shift_reqrd =1;



