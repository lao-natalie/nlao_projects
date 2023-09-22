-- % of buyer reorder from shop/estsy in x day

with purchase as (
SELECT
      DISTINCT buyer_user_id,
      seller_user_id,
      DATE(creation_tsz) AS order_date,
      LEAD(DATE(creation_tsz)) OVER (PARTITION BY seller_user_id,buyer_user_id ORDER BY DATE(creation_tsz) ASC) AS next_same_shop_order_date,
      LEAD(DATE(creation_tsz)) OVER (PARTITION BY buyer_user_id ORDER BY DATE(creation_tsz) ASC) AS next_etsy_order_date,
      r.receipt_id
    FROM
      `etsy-data-warehouse-prod.transaction_mart.all_receipts` r
    JOIN `etsy-data-warehouse-prod`.user_mart.user_profile d
    ON r.buyer_user_id = d.user_id
  where 
  DATE(creation_tsz) >= current_date - 365 - 90
      and d.is_seller = 0
    ORDER BY 1,3,2
)
SELECT
-- % of buyer reorder from same shop in x day
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) = 1 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_1_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 2 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_2_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 3 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_3_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 4 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_4_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 5 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_5_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 6 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_6_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 7 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_7_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 8 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_8_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 9 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_9_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 10 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_10_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 11 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_11_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 12 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_12_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 13 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_13_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 14 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_14_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 15 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_15_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 16 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_16_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 17 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_17_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 18 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_18_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 19 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_19_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 20 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_20_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 21 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_21_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 22 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_22_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 23 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_23_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 24 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_24_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 25 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_25_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 26 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_26_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 27 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_27_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 28 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_28_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 29 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_29_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 30 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_30_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 60 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_60_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 90 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_same_shop_reorder_in_90_days,
-- % of buyer reorder from etsy in x day
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) = 1 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_1_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 2 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_2_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 3 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_3_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 4 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_4_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 5 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_5_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 6 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_6_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 7 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_7_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 8 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_8_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 9 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_9_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 10 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_10_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 11 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_11_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 12 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_12_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 13 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_13_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 14 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_14_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 15 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_15_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 16 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_16_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 17 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_17_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 18 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_18_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 19 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_19_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 20 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_20_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 21 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_21_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 22 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_22_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 23 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_23_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 24 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_24_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 25 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_25_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 26 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_26_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 27 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_27_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 28 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_28_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 29 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_29_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 30 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_30_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 60 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_60_days,
COUNT(DISTINCT CASE WHEN next_etsy_order_date IS NOT NULL AND DATE_DIFF(next_etsy_order_date,order_date,day) between 1 AND 90 THEN buyer_user_id ELSE NULL END) / COUNT(DISTINCT buyer_user_id) AS pct_buyer_etsy_reorder_in_90_days,
-- % of seller has an reorder from the same buyer in x day
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) = 1 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_1_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 2 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_2_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 3 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_3_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 4 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_4_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 5 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_5_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 6 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_6_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 7 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_7_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 8 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_8_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 9 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_9_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 10 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_10_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 11 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_11_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 12 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_12_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 13 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_13_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 14 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_14_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 15 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_15_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 16 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_16_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 17 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_17_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 18 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_18_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 19 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_19_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 20 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_20_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 21 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_21_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 22 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_22_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 23 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_23_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 24 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_24_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 25 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_25_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 26 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_26_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 27 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_27_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 28 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_28_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 29 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_29_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 30 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_30_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 60 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_60_days,
COUNT(DISTINCT CASE WHEN next_same_shop_order_date IS NOT NULL AND DATE_DIFF(next_same_shop_order_date,order_date,day) between 1 AND 90 THEN seller_user_id ELSE NULL END) / COUNT(DISTINCT seller_user_id) AS pct_buyer_has_same_shop_reorder_in_90_days
FROM purchase
;