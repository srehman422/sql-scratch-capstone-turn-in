 WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp;


Query 1

SELECT DISTINCT utm_campaign AS 'unique_campaigns'
FROM page_visits;
SELECT DISTINCT utm_source AS 'unique_sources'
FROM page_visits; 
SELECT utm_campaign, utm_source
FROM page_visits
GROUP BY utm_campaign
;

Query 2
SELECT DISTINCT page_name
FROM page_visits;

Query 3

WITH first_touch AS (
SELECT user_id,
MIN(timestamp) as first_touch_at
FROM page_visits
GROUP BY user_id),
ft_attr AS (
SELECT ft.user_id,
  ft.first_touch_at, 
  pv.utm_source, 
  pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
  ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp)
SELECT ft_attr.utm_source,
ft_attr.utm_campaign,
COUNT (*)
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC ;

Query 4

WITH last_touch AS (
	SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign,
         pv.page_name
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source,
       lt_attr.utm_campaign,
       COUNT(*)
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;


Query 5

SELECT COUNT(DISTINCT user_id) AS 'visitor_purchases'
FROM page_visits
WHERE page_name = '4 - purchase'
;


Query 6

WITH last_touch AS (
	SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
  	WHERE page_name = '4 - purchase'
    GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign,
         pv.page_name
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source,
       lt_attr.utm_campaign,
       COUNT(*)
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;