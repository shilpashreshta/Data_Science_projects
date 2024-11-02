# Bank Customer Segmentation Project
## Project Overview
This project performs customer segmentation on bank data to help better understand customer groups and provide targeted service offerings. Using clustering techniques, specifically the KMeans algorithm, we segment bank customers based on features such as credit score, age, balance, and other relevant characteristics. This segmentation provides insights that can help the bank tailor marketing strategies, enhance customer satisfaction, and improve retention.

## Data Source
The dataset used in this project is the Bank_Churn.csv file, which contains information about customers who have churned (Exited) as well as those who are still active. Key attributes include:
* CustomerId, Surname
* CreditScore, Geography, Gender, Age
* Tenure, Balance, NumOfProducts
* HasCrCard, IsActiveMember, EstimatedSalary
* Exited
The dataset is loaded directly from a GitHub repository.

## Project Steps
**1. Data Preparation**
   1. Loading the Data: We load the data into a pandas DataFrame and review the first five rows.
   2. Dropping Unnecessary Columns: Columns like CustomerId, Surname, and Exited are not useful for clustering, so they are removed from the dataset.
   3. Encoding Categorical Variables:
   4. The Gender column is converted into numerical values (Male = 0, Female = 1).
   5. One-hot encoding is applied to the Geography column to create separate columns for each country (France, Germany, Spain).
Feature Engineering:
   6. We create a new feature, ProductsPerYear, which represents the average number of products a customer holds per year of tenure. This feature is calculated as NumOfProducts / Tenure to give insight into product adoption over time.

**2. Exploratory Data Analysis (EDA)**
   * We use describe() to understand the basic statistics of each feature.
   * A pairplot helps us visually explore the relationships and distributions among different features.
   * Further analysis is done on features like Balance across different countries to understand their distribution.
      
**3. Data Standardization**
   * Standardization is performed on the dataset to ensure that features are scaled to a similar range. This step is critical for KMeans clustering to prevent features with larger scales from dominating the clustering process.
  
**4. Clustering Using KMeans**
   * We test KMeans models with clusters ranging from 2 to 15 to identify the optimal number of clusters.
   * Using the Elbow Method, we plot the inertia values for each cluster count and identify the "elbow" point where the improvement in inertia slows down. This point suggests the ideal number of clusters.
   * Based on the Elbow Method, a KMeans model with 4 clusters is chosen for final segmentation.

**5. Cluster Analysis**
   * We analyze the characteristics of each cluster using cluster centers to interpret the profiles of each customer segment. A heatmap of cluster centers shows the feature averages for each cluster, providing visual insights into each segment.

**6. Cluster Summaries and Recommendations**
Based on the characteristics of each cluster, we make specific recommendations for targeting each segment effectively.
segment effectively.

| Cluster | Characteristics | Recommendations |
| ------- | --------------- | --------------- |
| **0** | Customers without a credit card | Offer an entry-level credit card with attractive benefits to encourage credit adoption |
| **1** | High-balance customers with few products | Provide exclusive offers to increase product adoption, especially in premium services |
| **2** | Low-balance, multi-product customers (primarily French and Spanish) | Implement loyalty programs or rewards for tenure to enhance satisfaction and retention |
| **3** | Customers with many products acquired in a short time | Focus on long-term engagement strategies to increase retention and reduce churn |

**Results & Insights**
   * We segmented customers into distinct clusters that highlight differences in balance, tenure, product usage, and other characteristics.
   * Each customer group requires unique strategies for increasing engagement and retention. For example, customers with high balance but few products may be interested in exclusive offers, while multi-product, low-balance customers may benefit from loyalty programs

**Repository Structure**
   * Bank_Churn.csv: The raw dataset used for analysis.
   * Bank_Customer_Segmentation.ipynb: Jupyter Notebook containing the code, analysis, and visualizations for this project.
   * README.md: Project overview and documentation (this file).

**Conclusion**
This project demonstrates the potential of clustering for customer segmentation in the banking sector. By identifying unique customer groups, banks can adopt data-driven strategies to improve customer satisfaction and reduce churn. Future work could involve exploring other clustering algorithms, such as DBSCAN or hierarchical clustering, or integrating additional customer data for enhanced segmentation.
