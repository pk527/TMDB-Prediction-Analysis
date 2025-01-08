# TMDB-Prediction-Analysis
Prediction Analysis in R 
# 🎥 Movie Revenue Prediction Using TMDb API Data  

## 📖 Overview  
This project analyzes and predicts movie box office revenue using an enriched dataset sourced from *The Movie Database (TMDb) API*. By leveraging machine learning models and statistical analysis, we investigate the factors contributing to a movie’s success.  

The project emphasizes:  
- Extracting actionable insights from data.  
- Predicting box office revenue with high accuracy.  
- Enhancing understanding of key movie production features.  

---

## 🎯 Objectives  
1. *Understand Revenue Drivers*: Identify critical factors influencing a movie’s success.  
2. *Predict Revenue*: Use machine learning to predict revenue from features like budget, runtime, and popularity.  
3. *Test Hypotheses*: Validate the impact of production attributes on revenue using statistical methods.  
4. *Provide Visual Insights*: Present interactive charts to explore trends and correlations.  

---

## 📊 Dataset Description  
### Data Sources  
- *TMDb Open API*: A publicly available, community-driven movie database.  

### Dataset Details  
| *Dataset*   | *Rows* | *Columns* | *Description*                      |  
|---------------|----------|-------------|--------------------------------------|  
| train.csv   | 3,000    | 23          | Training data including revenue.     |  
| test.csv    | 4,398    | 22          | Testing data without revenue column. |  

### Preprocessing  
1. *Missing Data Handling*: Used the mice package for imputation.  
   - Addressed NA values in variables like budget, genres, and homepage.  
2. *Feature Engineering*: Extracted details such as:  
   - *Genres*: Main genre of the movie.  
   - *Production Company Size*: Classified as “Big Producer” or “Small Producer.”  
   - *Release Attributes*: Year, quarter, and weekday of release.  
3. *Scaling*: Log-transformed numeric features like budget and popularity.  

---

## 🛠 Technologies Used  
| *Category*          | *Technologies/Tools*                     |  
|------------------------|-------------------------------------------|  
| Programming Language   | R                                         |  
| Data Wrangling         | tidyverse, lubridate                  |  
| Data Visualization     | ggplot2, plotly, corrplot           |  
| Machine Learning       | randomForest, caret, xgboost        |  
| Statistical Analysis   | Hmisc, broom, AICcmodavg            |  
| Missing Data Handling  | mice, Amelia                          |  

---

## ✨ Features  
1. *Exploratory Data Analysis*:  
   - Analyze relationships between revenue and key variables.  
   - Visualize data trends and correlations.  
2. *Predictive Models*:  
   - Linear Regression.  
   - Random Forest.  
3. *Hypothesis Testing*:  
   - Examine the significance of runtime and budget on revenue.  
4. *Interactive Visualizations*:  
   - Dynamic charts for deeper insights.  

---

## 📋 Analytical Questions  
1. *What is the relationship between a movie’s budget and its revenue?*  
2. *Does runtime significantly affect revenue?*  
3. *How do production attributes (e.g., genre, producer size) impact success?*  
4. *Which release period (e.g., year or quarter) correlates with higher revenue?*  
5. *What are the most influential features in predicting revenue?*  

---

## 📈 Visualizations and Results  

### 1. *Budget vs. Revenue*  
*Interactive Scatterplot*:  
- The scatterplot visualizes the positive correlation between budget and revenue.  
- Each data point represents a movie, and the color intensity indicates budget.  
- A regression trendline highlights the overall relationship.  

*Insights*:  
- Movies with a higher budget (>$50M) typically achieve higher revenue (> $500M).  
- Some low-budget movies (e.g., independent films) generate disproportionately high revenue, indicating genre or uniqueness can sometimes compensate for a smaller budget.  

---

### 2. *Runtime vs. Revenue*  
*Interactive Visualization*:  
- A scatterplot shows how runtime affects revenue.  
- Movies are categorized into short (<90 minutes), medium (90–120 minutes), and long (>120 minutes).  
- A regression line indicates trends for each category.  

*Specific Results*:  
- *Runtime below 90 minutes*: Limited success, primarily comedies or animated films.  
- *Runtime 90–120 minutes*: Optimal range for blockbusters; the strongest correlation with revenue.  
- *Runtime above 120 minutes*: Mixed performance; epic genres dominate, but excessive length can diminish audience interest.  

---

### 3. *Hypothesis Testing*  
*Null Hypothesis (H₀)*: Runtime and budget do not affect revenue.  
*Alternate Hypothesis (H₁)*: Runtime and budget significantly affect revenue.  

*Statistical Approach*:  
- *Test Type*: ANOVA (Analysis of Variance).  
- *Significance Level*: 0.05.  

*Results*:  
- *P-value for Budget*: 0.001 (<0.05) → Reject H₀.  
- *P-value for Runtime*: 0.03 (<0.05) → Reject H₀.  

*Detailed Outcome*:  
- Budget significantly impacts revenue, contributing over 50% to variance in revenue.  
- Runtime moderately affects revenue, particularly for blockbusters within the 90–120 minute range.  

*Visualization*:  
Combined scatterplot with regression lines showing budget, runtime, and revenue interaction.  

---

### 4. *Multicomparison Models*  
*Models Analyzed*:  
- *Linear Regression*: Three variations of predictors.  
- *Random Forest*: Comprehensive model with feature importance analysis.  

| *Model*       | *Adjusted R²* | *MSE (Mean Squared Error)* | *Explanation*                                                |  
|------------------|-----------------|-----------------------------|----------------------------------------------------------------|  
| Linear Model 1   | 0.74            | Higher                      | Budget and runtime only.                                       |  
| Linear Model 2   | 0.78            | Lower                       | Added cast and production details.                            |  
| Random Forest    | *Best Fit*    | *Lowest*                  | Handles nonlinear interactions and missing data effectively.   |  

*Feature Importance in Random Forest*:  
| *Feature*          | *Importance Score* | *Impact on Revenue*                                                      |  
|-----------------------|---------------------|----------------------------------------------------------------------------|  
| Budget               | 0.87                | Strongest predictor of revenue; directly proportional.                     |  
| Popularity           | 0.75                | Strongly linked to audience demand and marketing.                          |  
| Runtime              | 0.65                | Optimal range (90–120 minutes) significantly enhances revenue potential.   |  

---

## 🛠 Results and Outputs  

This section details the outcomes of various models, hypothesis testing, and feature analysis used in the project. Each result is supported by metrics and visualizations for clarity and deeper insights.

### 1. Model Performance  
Several models were evaluated to predict movie revenue effectively. These included variations of linear regression models and a Random Forest model. The key metrics for evaluation were Adjusted R² and Mean Squared Error (MSE).  

| *Model*       | *Adjusted R²* | *MSE (Mean Squared Error)* | *Explanation*                                                |  
|------------------|-----------------|-----------------------------|----------------------------------------------------------------|  
| Linear Model 1   | 0.74            | Higher                      | Used budget and runtime as predictors.                        |  
| Linear Model 2   | 0.78            | Moderate                    | Added cast and production-related variables for better fit.    |  
| Linear Model 3   | 0.81            | Moderate-Low                | Included all engineered features such as genres and keywords. |  
| Random Forest    | *Best Fit*    | *Lowest*                  | Nonlinear model that handles interactions and missing data effectively. |  

#### Key Takeaways:  
- *Linear Regression*:  
  - Model 3 showed the best performance among linear models with an Adjusted R² of 0.81.  
  - Residual analysis confirmed that assumptions such as homoscedasticity and normality were met.  
  - Linear models struggled with complex feature interactions, which reduced predictive accuracy.  
- *Random Forest*:  
  - Outperformed linear regression in both Adjusted R² and MSE.  
  - Particularly useful in capturing nonlinear interactions between features like budget, runtime, and popularity.  
  - Handles missing data seamlessly by generating estimates during training.  

---

### 2. Hypothesis Testing  
*Objective*: To determine if budget and runtime significantly affect movie revenue.  

#### Statistical Approach:  
- *Null Hypothesis (H₀)*: Budget and runtime do not affect revenue.  
- *Alternate Hypothesis (H₁)*: Budget and runtime significantly affect revenue.  
- *Test Used*: ANOVA (Analysis of Variance).  
- *Significance Level*: 0.05.  

#### Results:  
| *Variable*      | *P-value*  | *Decision*               | *Explanation*                                                |  
|--------------------|-------------|----------------------------|----------------------------------------------------------------|  
| Budget            | 0.001       | Reject H₀                 | Budget strongly influences revenue, with a direct relationship.|  
| Runtime           | 0.03        | Reject H₀                 | Runtime has a moderate impact, especially for blockbusters.    |  

*Detailed Observations*:  
1. *Budget*:  
   - Movies with higher budgets consistently generated more revenue.  
   - Budget alone accounted for more than 50% of the variance in revenue predictions.  

2. *Runtime*:  
   - Optimal runtime (90–120 minutes) significantly enhanced revenue potential.  
   - Extremely short or long runtimes showed diminishing returns.  

#### Visualization:  
- *Scatterplots with Regression Lines*:  
  - A combined plot visualized the interaction of budget and runtime with revenue.  
  - Regression lines confirmed the positive correlation between these variables and revenue.  

---

### 3. Feature Importance (Random Forest)  
The Random Forest model provided insights into the most influential features for predicting revenue.  

| *Feature*          | *Importance Score* | *Impact on Revenue*                                                      |  
|-----------------------|---------------------|----------------------------------------------------------------------------|  
| Budget               | 0.87                | The strongest predictor; higher budgets consistently lead to higher revenue.|  
| Popularity           | 0.75                | Reflects audience demand, driven by marketing and star power.              |  
| Runtime              | 0.65                | Moderate impact; movies in the 90–120 minute range perform best.           |  
| Cast Size            | 0.60                | Larger casts, particularly with well-known actors, drive higher revenue.    |  
| Production Company   | 0.58                | Big producers like Disney and Warner Bros. significantly enhance success.   |  

#### Key Insights:  
- *Budget*: Investment in production quality and marketing is critical for success.  
- *Popularity*: Strong correlation with audience engagement, often tied to pre-release hype.  
- *Runtime*: A sweet spot exists; excessively long or short runtimes can hinder box office performance.  

---

### 4. Specific Outputs and Visualizations  

#### Residual Analysis (Linear Regression):  
- Residuals from the best linear regression model were plotted to evaluate fit.  
- Key patterns observed:  
  - Residuals were evenly distributed around zero, indicating no systematic bias.  
  - The Normal Q-Q plot showed residuals following a nearly perfect one-to-one line, validating the assumption of normality.  

#### Revenue Predictions:  
- Predictions from the Random Forest model closely aligned with actual revenue values.  
- *Output Summary*:  
   ```plaintext
   Min.   1st Qu.   Median   Mean   3rd Qu.   Max.  
   0.699   6.417    7.176    6.949   7.751    9.041

---
## 🧪 Hypothesis Testing  

*Objective*: To determine whether budget and runtime significantly affect movie revenue.  

### Statistical Approach  
- *Null Hypothesis (H₀)*: Budget and runtime do not influence revenue.  
- *Alternate Hypothesis (H₁)*: Budget and runtime significantly impact revenue.  
- *Test Used*: ANOVA (Analysis of Variance).  
- *Significance Level*: 0.05.  

### Results  
| *Variable*  | *P-value*  | *Decision*           | *Explanation*                                                |  
|---------------|--------------|------------------------|----------------------------------------------------------------|  
| Budget        | 0.001        | Reject H₀             | Budget strongly influences revenue, with a direct correlation. |  
| Runtime       | 0.03         | Reject H₀             | Runtime has a moderate but measurable impact on revenue.       |  

#### Key Observations:  
1. *Budget*:  
   - Movies with larger budgets typically generate significantly higher revenue.  
   - Investment in higher-quality production, marketing, and talent drives audience interest and engagement.  
   - Budget alone explains over 50% of the variance in revenue, making it the most critical feature.  

2. *Runtime*:  
   - Movies within the 90–120 minute range tend to perform best, balancing audience attention span and content delivery.  
   - Shorter movies (<90 minutes) often cater to niche genres (e.g., animated or comedies) with limited box office potential.  
   - Excessively long movies (>120 minutes) may lose audience interest unless they are epic productions.  

### Visualization  
To further support these results, scatterplots were created:  
- *Budget vs. Revenue*: Demonstrates a strong positive correlation, with higher budgets leading to greater revenue.  
- *Runtime vs. Revenue*: Shows an optimal range for runtime, with diminishing returns for very short or long movies.  
- Combined scatterplots with regression lines illustrate the interaction between budget, runtime, and revenue.  

#### Statistical Summary  
- The ANOVA test confirms the significance of budget and runtime, with both contributing to predicting movie revenue.  
- A combined model incorporating both variables yields higher predictive accuracy than models using either variable alone.  

---

## 🔄 Multicomparison Models  

### Objective  
To evaluate multiple regression models and identify the most effective for predicting movie revenue.  

### Models Analyzed  
Three variations of linear regression and a Random Forest model were evaluated.  

| *Model*       | *Predictors Included*                                  | *Adjusted R²* | *MSE*              | *Explanation*                                                |  
|------------------|---------------------------------------------------------|-----------------|----------------------|----------------------------------------------------------------|  
| Linear Model 1   | Budget, runtime                                         | 0.74            | Higher               | Simple model; accounts for primary variables only.             |  
| Linear Model 2   | Budget, runtime, cast size, production company size     | 0.78            | Moderate             | Adds production-related features for better predictions.       |  
| Linear Model 3   | Budget, runtime, genres, keywords, year of release      | 0.81            | Moderate-Low         | Comprehensive linear model with all engineered features.       |  
| Random Forest    | All available features, including interactions          | *Best Fit*    | *Lowest*           | Captures nonlinear relationships and handles missing data.     |  

### Key Takeaways  
1. *Linear Models*:  
   - *Model 1*: Provides a baseline, focusing on budget and runtime only.  
   - *Model 2*: Improved performance by including cast size and production details.  
   - *Model 3*: The best linear regression model, incorporating additional features such as genres and release attributes.  

2. *Random Forest*:  
   - Outperformed all linear models, achieving the lowest MSE and highest predictive accuracy.  
   - Effectively captures complex feature interactions and nonlinear patterns.  
   - Handles missing data seamlessly during training.  

---

### Feature Importance (Random Forest)  
The Random Forest model also provides a ranked list of feature importance scores, highlighting the most influential predictors.  

| *Feature*          | *Importance Score* | *Impact on Revenue*                                                      |  
|-----------------------|---------------------|----------------------------------------------------------------------------|  
| Budget               | 0.87                | Strongest predictor; higher budgets consistently lead to higher revenue.    |  
| Popularity           | 0.75                | Strongly linked to audience demand and pre-release marketing hype.          |  
| Runtime              | 0.65                | Optimal runtime range (90–120 minutes) significantly boosts revenue.        |  
| Cast Size            | 0.60                | Larger, star-studded casts often generate higher box office revenue.         |  
| Production Company   | 0.58                | Big production houses like Disney and Warner Bros. strongly influence success. |  

---

### Specific Outputs and Analysis  
1. *Residual Analysis (Linear Regression)*:  
   - Residuals were evenly distributed around zero, indicating no systematic bias in the model predictions.  
   - The Normal Q-Q plot confirmed that residuals followed a near-perfect one-to-one line, validating the assumptions of normality.  

2. *Revenue Predictions*:  
   - Predictions from the Random Forest model closely aligned with actual values.  
   - *Summary of Predictions*:  
     plaintext
     Min.   1st Qu.   Median   Mean   3rd Qu.   Max.  
     0.699   6.417    7.176    6.949   7.751    9.041
       

3. *Combined Visualizations*:  
   - A combined scatterplot visualized the interaction of budget, runtime, and revenue.  
   - Regression lines validated the positive correlation between these variables and revenue.  

---

### Final Insights  
- *Budget*: The most critical feature, explaining a significant portion of revenue variance.  
- *Runtime*: Important for optimizing audience engagement and box office success.  
- *Random Forest*: Superior predictive performance due to its ability to capture nonlinear relationships and handle missing data.  

These results provide actionable insights for stakeholders in the film industry, helping optimize production budgets, movie runtimes, and marketing strategies.
