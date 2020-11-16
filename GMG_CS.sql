-- Gallery Media Group Data Case Study 

-- Creating Database
CREATE DATABASE gmg;

-- Creating Tables (2)
-- timestamp column in pageviews renamed to access_time so as not to share keyword name
CREATE TABLE pageviews (
	user_id INT,
	access_time TIMESTAMP,
	page_path TEXT,
	page_title TEXT,
	campaign TEXT,
    page_referrer TEXT,
    article_publication_date DATE,
    article_format TEXT
);

CREATE TABLE subscribers (
	user_id INT PRIMARY KEY,
	subscription_date TIMESTAMP,
	recipe_section_pageviews INT,
	food_section_pageviews INT,
	fashion_section_pageviews INT,
    beauty_section_pageviews INT,
    news_section_pageviews INT
);

-- csv files imported using psql
\copy pageviews 
from ~/Documents/GMG_DataCaseStudy/case_study_pageviews.csv 
with (FORMAT CSV, HEADER)

\copy subscribers 
from ~/Documents/GMG_DataCaseStudy/case_study_subscribers.csv 
with (FORMAT CSV, HEADER)

-- Pageviews by campaign
SELECT campaign, 
       COUNT(user_id)
FROM pageviews
GROUP BY 1
ORDER BY 2 DESC;

-- Pageviews by article format
SELECT article_format, 
       COUNT(user_id)
FROM pageviews
GROUP BY 1
ORDER BY 2 DESC;

-- Views by page title and publication date
SELECT page_title, 
       article_publication_date, 
	   COUNT(user_id)
FROM pageviews
GROUP BY 1, 2
ORDER BY 3 DESC;

-- Finding the user who's ID is in pageviews but not in subscribers
SELECT *
FROM pageviews
WHERE user_id NOT IN (SELECT user_id 
					  FROM subscribers);

-- Other channels people find our content through (we can reach out for partnerships/ad space)
SELECT DISTINCT page_referrer
FROM pageviews
WHERE page_referrer IS NOT NULL
AND page_referrer NOT LIKE '%purewow%';

-- Exploring the NULL campaigns for more detail
SELECT *
FROM pageviews
WHERE campaign IS NULL;

-- Investigating the pages with the most traction, in addition to when they were published
SELECT page_title, 
       article_publication_date,
       COUNT(user_id)
FROM pageviews
GROUP BY 1, 2
ORDER BY 3 DESC;