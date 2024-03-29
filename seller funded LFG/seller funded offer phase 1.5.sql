
-- shop sale
CREATE OR REPLACE TABLE `etsy-data-warehouse-dev.nlao.shop_sale_shop_and_listing` AS (
WITH shop_wide AS (
--listings on shopwide sale
SELECT
      smp.shop_id,
      smp.promotion_id,
      la.listing_id,
      timestamp_seconds(smp.start_date) as start_date,
      timestamp_seconds(smp.end_date) as end_date,
      1 as is_sitewide,
      smp.promotion_type,
      case 
        when smp.promotion_type = 1 then "x off entire order"
        when smp.promotion_type = 2 then "% off entire order"
        when smp.promotion_type = 3 then "% off on shipping, entire order"
        when smp.promotion_type = 6 then "% off on domestic shipping, entire order"
        when smp.promotion_type = 4 then "% off select items"
        when smp.promotion_type = 7 then "% off on shipping, select items"
        when smp.promotion_type = 8 then "% off on domestic shipping, select items"
        else null 
     end as promotion_type_name,
     smp.reward_percent_discount_on_order,
     smp.reward_percent_discount_on_items_in_set,
     smp.reward_percent_discount_on_order + smp.reward_percent_discount_on_items_in_set as discount_amount,
     case when  smp.reward_percent_discount_on_order + smp.reward_percent_discount_on_items_in_set >= 20 then 1 else 0 end as is_20_or_more,
     case when  smp.reward_percent_discount_on_order + smp.reward_percent_discount_on_items_in_set >= 25 then 1 else 0 end as is_25_or_more
FROM
      `etsy-data-warehouse-prod.etsy_shard.seller_marketing_promotion`    smp
INNER JOIN
      `etsy-data-warehouse-prod.listing_mart.listings_active`             la
  ON
      smp.shop_id = la.shop_id
WHERE
      smp.discoverability_type = 2 -- sale
      and smp.promotion_type in (2,4)
  -- shopwide
  AND NOT EXISTS (
    SELECT  1
    FROM    `etsy-data-warehouse-prod.etsy_shard.seller_marketing_promotion_listing`    smpl
    WHERE   smp.shop_id       = smpl.shop_id 
      AND   smp.promotion_id  = smpl.promotion_id
  )
  -- sale happens BETWEEN '2022-08-01' AND '2023-08-01' 
  AND timestamp_seconds(smp.start_date) BETWEEN '2022-08-01' AND '2023-08-01'
  AND timestamp_seconds(smp.end_date) <= '2023-08-01'
  AND timestamp_seconds(smp.start_date) <= timestamp_seconds(smp.end_date)
),

listing_specific as (
SELECT
      smp.shop_id,
      smp.promotion_id,
      smpl.listing_id,
      timestamp_seconds(smp.start_date) as start_date,
      timestamp_seconds(smp.end_date) as end_date,
      0 as is_sitewide,
            smp.promotion_type,
      case 
        when smp.promotion_type = 1 then "x off entire order"
        when smp.promotion_type = 2 then "% off entire order"
        when smp.promotion_type = 3 then "% off on shipping, entire order"
        when smp.promotion_type = 6 then "% off on domestic shipping, entire order"
        when smp.promotion_type = 4 then "% off select items"
        when smp.promotion_type = 7 then "% off on shipping, select items"
        when smp.promotion_type = 8 then "% off on domestic shipping, select items"
        else null 
     end as promotion_type_name,
     smp.reward_percent_discount_on_order,
     smp.reward_percent_discount_on_items_in_set,
     smp.reward_percent_discount_on_order + smp.reward_percent_discount_on_items_in_set as discount_amount,
     case when  smp.reward_percent_discount_on_order + smp.reward_percent_discount_on_items_in_set >= 20 then 1 else 0 end as is_20_or_more,
     case when  smp.reward_percent_discount_on_order + smp.reward_percent_discount_on_items_in_set >= 25 then 1 else 0 end as is_25_or_more
FROM
      `etsy-data-warehouse-prod.etsy_shard.seller_marketing_promotion`    smp
INNER JOIN
      `etsy-data-warehouse-prod.etsy_shard.seller_marketing_promotion_listing`             smpl
  ON
        smp.shop_id       = smpl.shop_id
    AND smp.promotion_id  = smpl.promotion_id
WHERE
      smp.discoverability_type = 2 -- sale
      and smp.promotion_type in (2,4)
  -- sale happens BETWEEN '2022-08-01' AND '2023-08-01' 
  AND timestamp_seconds(smp.start_date) BETWEEN '2022-08-01' AND '2023-08-01'
  AND timestamp_seconds(smp.end_date) <= '2023-08-01'
  AND timestamp_seconds(smp.start_date) <= timestamp_seconds(smp.end_date)
)

(select * from shop_wide)
union all
(select * from listing_specific)
)
;

-- shop sale day in a year
CREATE OR REPLACE TABLE `etsy-data-warehouse-dev.nlao.shop_sale_days` AS (
WITH intervals AS (
  SELECT
    shop_id,
    MIN(start_date) AS start_time,
    MAX(end_date) AS end_time
  from  `etsy-data-warehouse-dev.nlao.shop_sale_shop_and_listing`
  GROUP BY
    shop_id
),

sorted_intervals AS (
  SELECT
    shop_id,
    start_time,
    end_time,
    LAG(end_time) OVER (PARTITION BY shop_id ORDER BY start_time) AS prev_end_time
  FROM
    intervals
),

merged_intervals AS (
  SELECT
    shop_id,
    start_time,
    MAX(end_time) AS end_time
  FROM
    sorted_intervals
  WHERE
    start_time > COALESCE(prev_end_time, '1900-01-01')
  GROUP BY
    shop_id, start_time
)

SELECT
  shop_id,
  SUM(DATE_DIFF(end_time, start_time, DAY)) + 1 AS total_days_on_sale
FROM
  merged_intervals
GROUP BY
  shop_id
ORDER BY
  shop_id
)
;

-- listing sale day in a year
CREATE OR REPLACE TABLE `etsy-data-warehouse-dev.nlao.listing_sale_days` AS (
WITH intervals AS (
  SELECT
    listing_id,
    MIN(start_date) AS start_time,
    MAX(end_date) AS end_time
  from  `etsy-data-warehouse-dev.nlao.shop_sale_shop_and_listing`
  GROUP BY
    1
),

sorted_intervals AS (
  SELECT
    listing_id,
    start_time,
    end_time,
    LAG(end_time) OVER (PARTITION BY listing_id ORDER BY start_time) AS prev_end_time
  FROM
    intervals
),

merged_intervals AS (
  SELECT
    listing_id,
    start_time,
    MAX(end_time) AS end_time
  FROM
    sorted_intervals
  WHERE
    start_time > COALESCE(prev_end_time, '1900-01-01')
  GROUP BY
    listing_id, start_time
)

SELECT
  listing_id,
  SUM(DATE_DIFF(end_time, start_time, DAY)) + 1 AS total_days_on_sale
FROM
  merged_intervals
GROUP BY
  listing_id
ORDER BY
  listing_id
)
;

-- How often are shops setting up sales? For a given shop, how many days in a year was this shop on sale?
SELECT
CASE WHEN total_days_on_sale <= 10 THEN CAST(total_days_on_sale AS STRING)
      WHEN total_days_on_sale BETWEEN 11 AND 30 THEN '11-30'
      WHEN total_days_on_sale BETWEEN 31 AND 60 THEN '31-60'
      WHEN total_days_on_sale BETWEEN 61 AND 90 THEN '61-90'
      WHEN total_days_on_sale BETWEEN 91 AND 180 THEN '91-180'
      WHEN total_days_on_sale BETWEEN 181 AND 270 THEN '181-270'
      ELSE '271+' END AS total_days_on_sale,
COUNT(shop_id) AS shop_ct
FROM `etsy-data-warehouse-dev.nlao.shop_sale_days`
GROUP BY 1
;

-- How often are listings on sale? For a given listing, how many days in a year was this listing on sale?
SELECT
CASE WHEN total_days_on_sale <= 10 THEN CAST(total_days_on_sale AS STRING)
      WHEN total_days_on_sale BETWEEN 11 AND 30 THEN '11-30'
      WHEN total_days_on_sale BETWEEN 31 AND 60 THEN '31-60'
      WHEN total_days_on_sale BETWEEN 61 AND 90 THEN '61-90'
      WHEN total_days_on_sale BETWEEN 91 AND 180 THEN '91-180'
      WHEN total_days_on_sale BETWEEN 181 AND 270 THEN '181-270'
      ELSE '271+' END AS total_days_on_sale,
COUNT(listing_id) AS listing_ct
FROM `etsy-data-warehouse-dev.nlao.listing_sale_days`
GROUP BY 1
;

-- For shops that are on sale more than 50% (180 days +) of the year, what is the average duration of these sales?
WITH cte AS (
SELECT distinct 
promotion_id,
date_diff(end_date,start_date,day) AS duration
FROM `etsy-data-warehouse-dev.nlao.shop_sale_shop_and_listing` sl
JOIN `etsy-data-warehouse-dev.nlao.shop_sale_days` sd
      ON sl.shop_id = sd.shop_id
WHERE total_days_on_sale >=180
)
SELECT
avg(duration)
FROM cte
;

WITH cte AS (
SELECT distinct 
promotion_id,
date_diff(end_date,start_date,day) AS duration
FROM `etsy-data-warehouse-dev.nlao.shop_sale_shop_and_listing` sl
JOIN `etsy-data-warehouse-dev.nlao.shop_sale_days` sd
      ON sl.shop_id = sd.shop_id
WHERE total_days_on_sale >=180
)
SELECT
duration,
count(promotion_id)
FROM cte
GROUP BY 1
;



