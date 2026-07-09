use BANK
alter table Bank_Transaction_Fraud_Detection alter column Transaction_Amount Float
alter table Bank_Transaction_Fraud_Detection alter column Is_Fraud int
alter table Bank_Transaction_Fraud_Detection alter column Account_Balance Float;go


Create procedure 
first_10 
as
select top 10 *  from Bank_Transaction_Fraud_Detection order by Customer_ID
go

--How many Transaction in database = 200000
select count (Customer_ID) as number_of_Trans from Bank_Transaction_Fraud_Detection

--How many unique customers are there = 200000
select distinct count (Customer_ID) as No_of_unique_customers 
from Bank_Transaction_Fraud_Detection

--How many transactions were fraudulent = 10088
select count(Is_Fraud) as fraudulent_trans 
from Bank_Transaction_Fraud_Detection where Is_Fraud = 1

--How many were legit = 189912
Select count (Customer_ID) - 
	(select count(Is_Fraud) as fraudulent_trans from Bank_Transaction_Fraud_Detection where Is_Fraud = 1)
	as No_of_legit
from Bank_Transaction_Fraud_Detection

--What is the Fraud rate = 5.04%
select 
	(select count(Is_Fraud) from Bank_Transaction_Fraud_Detection where Is_Fraud = 1)
    /200000.0 * 100.0 AS Fraud_Percentage

--Total Value of all Transactions = 9907603110.83
select sum(Transaction_Amount) as Total_VAalue_of_trans
from Bank_Transaction_Fraud_Detection

--Average transaction amount = 499538
select round(avg(Transaction_Amount),2) as Avg_trans_amount 
from Bank_Transaction_Fraud_Detection

--Customer Profile

--Distribution by Gender = 49,77% female and 50.23% Males
Select 
	(select count (Gender) as No_of_males from Bank_Transaction_Fraud_Detection 
    where Gender = 'Male')/200000.0*100 as male_Percentages 
Select 
	(select count (Gender) as No_of_males from Bank_Transaction_Fraud_Detection 
    where Gender = 'Female')/200000.0*100 as female_Percentages 

--Distribution by account type = savings 33.30, Business 33.24, Checking 33.46
select Account_Type, (count(Account_Type)/200000.0*100)  as account_Distribution 
from Bank_Transaction_Fraud_Detection group by Account_Type;

--Average customer Age = 44
select AVG(Age) as avg_age from Bank_Transaction_Fraud_Detection

--Youngest and Oldest customer = 18 and 70
select  min(Age) as youngest_customer from  Bank_Transaction_Fraud_Detection 
select  max(Age) as oldest_customer from  Bank_Transaction_Fraud_Detection 

--State with the most customers = Nagaland with 6031 customers
select State, count(Customer_ID) as number_of_customers 
from Bank_Transaction_Fraud_Detection 
group by State order by number_of_customers desc

--Cities with most Customers = Chandigarh with 8135 
select City, count(Customer_ID) as number_of_customers 
from Bank_Transaction_Fraud_Detection 
group by City order by number_of_customers desc

--TRANSACTION OVERVIEW
--Transaction type distribution = credit 20.09%,Debit 20.02%,Bill Payment 20.02,Transfer 19.98%,Withdrawal 19.88%
select Transaction_Type, (count(Transaction_Type)/200000.0*100) as Type_Destribution 
from Bank_Transaction_Fraud_Detection
group by Transaction_Type
order by Type_Destribution desc

--Currency distribution = INR 100%
select Transaction_Currency, (count(Transaction_Currency)/200000.0*100) 
as currency_Destribution 
from Bank_Transaction_Fraud_Detection
group by Transaction_Currency

--Merchant cartegory distribution = Groceries 16.59%,Entertainment 16.71%,Clothing 16.67%,Health 16.56%,Electronics 16.70%,Restaurant 16.76%
select Merchant_Category, (count(Merchant_Category)/200000.0*100)
as Merchant_Destribution from Bank_Transaction_Fraud_Detection
group by Merchant_Category

--Distribution by trans amount and device type
select Device_Type,sum(Transaction_Amount) as Total_amount from Bank_Transaction_Fraud_Detection group by Device_Type
--Basic stats for trans amount
select avg(Transaction_Amount) as avg_trans_amount from Bank_Transaction_Fraud_Detection
select min(Transaction_Amount) as avg_trans_amount from Bank_Transaction_Fraud_Detection
select max(Transaction_Amount) as avg_trans_amount from Bank_Transaction_Fraud_Detection
select distinct PERCENTILE_CONT(0.25) within group(order by Transaction_Amount) over() as Q1 from Bank_Transaction_Fraud_Detection;
select distinct percentile_cont (0.5) within group (order by Transaction_Amount) over() as Median_Value from Bank_Transaction_Fraud_Detection
select distinct PERCENTILE_CONT(0.75) within group(order by Transaction_Amount) over() as Q3 from Bank_Transaction_Fraud_Detection;

--DIAGNOSTIC ANALYSIS
--Which gender has the highest fraud rate?Male-5.06%
select Gender,count(*) as Total_trans,sum(Is_Fraud) as No_of_Fraud_cases, 
(sum(Is_Fraud)*100.0)/count(*) as Fraud_rate 
from Bank_Transaction_Fraud_Detection group by Gender

--Which age groups are most affected by fraud?-40-60 with 3794,26-40 with 2836,61+ with	1884,18-25 with	1574
select *,
    case 
        when Age BETWEEN 18 AND 25 then '18-25'
        when Age BETWEEN 26 AND 40 then'26-40'
        when Age BETWEEN 41 AND 60 then'41-60'
        else '61+'
    end as Categorize_Age
into #Temp_Fraud_Data
from Bank_Transaction_Fraud_Detection;

select Categorize_Age,sum(Is_Fraud) as No_of_fraud_trans from #Temp_Fraud_Data 
group by Categorize_Age
order by No_of_fraud_trans desc

--Which account types have the highest fraud rates?Business-5.17 Savings-5.03 Checking-4.94
select Account_Type,count(*) as Total_trans,sum(Is_Fraud) 
as No_of_fraud_trans,(sum(Is_Fraud)*100.0)/count(*) as Fraud_rate
from  Bank_Transaction_Fraud_Detection 
group by Account_Type order by Fraud_rate desc

--Which transaction types are most likely to be fraudulent?Withdrawal-1961Bill Payment-1973,Debit-2033,Credit-2048,Transfer-2073
 select Transaction_Type,sum(Is_Fraud) as No_of_fraud from Bank_Transaction_Fraud_Detection 
 where Is_Fraud = 1 group by Transaction_Type order by No_of_fraud

--Which merchant categories have the highest fraud rates?Clothing-5.20,Groceries-5.19,Restaurant-5.04,Electronics-5.03,Health-4.99,Entertainment-4.82

select Merchant_Category,count(*) as Total_trans,sum(Is_Fraud) 
as No_of_fraud_trans,(sum(Is_Fraud)*100.0)/count(*) as Fraud_rate
from  Bank_Transaction_Fraud_Detection 
group by Merchant_Category order by Fraud_rate desc

--Which transaction devices and device types are most associated with fraud? devicetype- desktop,transaction-device-Debit/Credit Card
select Device_Type,count(*) as Total_trans,sum(Is_Fraud) 
as No_of_fraud_trans,(sum(Is_Fraud)*100.0)/count(*) as Fraud_rate
from  Bank_Transaction_Fraud_Detection 
group by Device_Type order by Fraud_rate desc

select Transaction_Device,count(*) as Total_trans,sum(Is_Fraud) 
as No_of_fraud_trans,(sum(Is_Fraud)*100.0)/count(*) as Fraud_rate
from  Bank_Transaction_Fraud_Detection 
group by Transaction_Device order by Fraud_rate desc

--Which states and cities have the highest fraud rates? State-Uttarakhand,City-Haridwar
select State,City,count(*) as Total_trans,sum(Is_Fraud) 
as No_of_fraud_trans,(sum(Is_Fraud)*100.0)/count(*) as Fraud_rate
from  Bank_Transaction_Fraud_Detection 
group by State,City order by Fraud_rate desc

--Are fraudulent transactions generally larger or smaller than legitimate ones?No
Select Is_Fraud,count(*) as Total_trans, avg(Transaction_Amount) as avg_trans_amount,
max(Transaction_Amount) as max_trans_amount,min(Transaction_Amount) as min_trans_amount
from Bank_Transaction_Fraud_Detection 
group by Is_Fraud
 
--Does fraud vary by day of the week or month?
select count(*) as Total_trans, DATENAME(WEEKDAY,Transaction_Date) as day_name
from Bank_Transaction_Fraud_Detection where Is_Fraud = 1
group by DATENAME(WEEKDAY, Transaction_Date)
order by Total_trans desc --yes 

--Are certain bank branches experiencing unusually high fraud rates?
select Bank_Branch,count(*) as Total_trans,sum(Is_Fraud) 
as No_of_fraud_trans,(sum(Is_Fraud)*100.0)/count(*) as Fraud_rate
from  Bank_Transaction_Fraud_Detection 
group by Bank_Branch 
order by Fraud_rate desc --yes

--At what times of day does fraud occur most frequently-Midnight and early mornings
select *,
   case
        when Datepart(hour,Transaction_Time) >= 0  and Datepart(hour,Transaction_Time) < 5  then 'Midnight'
        when Datepart(hour,Transaction_Time) >= 5  and Datepart(hour,Transaction_Time) < 10 then 'Morning'
        when Datepart(hour,Transaction_Time) >= 10 and Datepart(hour,Transaction_Time) < 12 then 'Midday'
        when Datepart(hour,Transaction_Time) >= 12 and Datepart(hour,Transaction_Time) < 17 then 'Afternoon'
        when Datepart(hour,Transaction_Time)>= 17 and Datepart(hour,Transaction_Time) < 21 then 'Evening'
        else 'Night' -- Covers 21:00 to 23:59
    end as time_of_day
into temp_fraud
from Bank_Transaction_Fraud_Detection

select time_of_day,sum(Is_Fraud) as No_of_cases from temp_fraud 
group by time_of_day
order by No_of_cases desc

--Predictive engine Query
WITH ModelPredictions AS (
    SELECT 
        Is_Fraud, -- Your historical ground truth (1 = Fraud, 0 = Legitimate)
        CASE 
            -- Rule 1: High-Risk Geo-Temporal Pattern (Haridwar Midnight Window)
            WHEN City = 'Haridwar' 
                 AND State = 'Uttarakhand'
                 AND DATEPART(HOUR, Transaction_Time) BETWEEN 0 AND 4 
                 THEN 'Block'

            -- Rule 2: High-Risk Demographic Device Vector
            WHEN Account_Type = 'Business'
                 AND Device_Type = 'Desktop'
                 AND Transaction_Device IN ('Debit Card', 'Credit Card')
                 AND Age BETWEEN 26 AND 60
                 AND DATEPART(HOUR, Transaction_Time) BETWEEN 0 AND 4
                 THEN 'Block'

            -- Rule 3: High-Risk Merchant Category Out-of-Hours
            WHEN Merchant_Category IN ('Clothing', 'Groceries')
                 AND DATEPART(HOUR, Transaction_Time) BETWEEN 0 AND 4
                 THEN 'Review'

            -- Rule 4: Systemic Branch Anomaly (Using your exact Top 5 branches)
            WHEN Bank_Branch IN (
                    'Haridwar Branch', 
                    'Belgaum Branch', 
                    'Jorethang Branch', 
                    'Hazaribagh Branch', 
                    'New Delhi Branch'
                 )
                 AND Transaction_Device IN ('Debit/Credit Card')
                 THEN 'Review'

            ELSE 'Approve'
        END AS predicted_action
    FROM Bank_Transaction_Fraud_Detection
),
ConfusionMatrix AS (
    SELECT
        -- True Positives (TP): Actual fraud that your rules successfully caught
        SUM(CASE WHEN Is_Fraud = 1 AND predicted_action IN ('Block', 'Review') 
        THEN 1 ELSE 0 END) AS true_positives,
        
        -- False Positives (FP): Safe transactions your rules accidentally flagged (False Alarms)
        SUM(CASE WHEN Is_Fraud = 0 AND predicted_action IN ('Block', 'Review') 
        THEN 1 ELSE 0 END) AS false_positives,
        
        -- True Negatives (TN): Clean transactions your rules correctly approved
        SUM(CASE WHEN Is_Fraud = 0 AND predicted_action = 'Approve' 
        THEN 1 ELSE 0 END) AS true_negatives,
        
        -- False Negatives (FN): Fraudulent transactions that slipped past your rules
        SUM(CASE WHEN Is_Fraud = 1 AND predicted_action = 'Approve' 
        THEN 1 ELSE 0 END) AS false_negatives,
        
        COUNT(*) AS total_transactions
    FROM ModelPredictions
)
SELECT 
    true_positives AS Fraud_Caught,
    false_positives AS False_Alarms,
    true_negatives AS Correct_Approvals,
    false_negatives AS Missed_Fraud,
    
    -- 1. Accuracy: Overall correctness rate of your engine
    ROUND((true_positives + true_negatives) * 100.0 / total_transactions, 2) 
    AS Overall_Accuracy_Percentage,
    
    -- 2. Recall / Sensitivity: What % of the total fraud did your engine actually catch?
    ROUND(true_positives * 100.0 / NULLIF((true_positives + false_negatives), 0), 2) 
    AS Fraud_Detection_Rate_Percentage,
    
    -- 3. False Alarm Rate: What % of innocent customers were negatively impacted?
    ROUND(false_positives * 100.0 / NULLIF((false_positives + true_negatives), 0), 2) 
    AS Customer_Disruption_Rate_Percentage
FROM ConfusionMatrix;
go

--VIEW TO VISUALISE
CREATE VIEW v_PowerBI_Fraud_Dashboard AS
SELECT 
    Transaction_ID,
    Age,
    Gender,
    Account_Type,
    Merchant_Category,
    Device_Type,
    Transaction_Device,
    State,
    City,
    Transaction_Date,
    Transaction_Time,
    Bank_Branch,
    Is_Fraud,
    -- Inject your predictive engine logic directly into the data stream
    CASE 
        WHEN City = 'Haridwar' AND State = 'Uttarakhand' AND DATEPART(HOUR, Transaction_Time) BETWEEN 0 AND 4 THEN 'Block'
        WHEN Account_Type = 'Business' AND Device_Type = 'Desktop' AND Transaction_Device IN ('Debit Card', 'Credit Card') AND Age BETWEEN 26 AND 60 AND DATEPART(HOUR, Transaction_Time) BETWEEN 0 AND 4 THEN 'Block'
        WHEN Merchant_Category IN ('Clothing', 'Groceries') AND DATEPART(HOUR, Transaction_Time) BETWEEN 0 AND 4 THEN 'Review'
        WHEN Bank_Branch IN ('Haridwar Branch', 'Belgaum Branch', 'Jorethang Branch', 'Hazaribagh Branch', 'New Delhi Branch') AND Transaction_Device IN ('Debit Card', 'Credit Card') THEN 'Review'
        ELSE 'Approve'
    END AS Predicted_Action
FROM Bank_Transaction_Fraud_Detection;
go





drop table #Temp_Fraud_Data
drop table temp_fraud
exec first_10








