-- 1. 	WE ARE TASKED WITH FINDING 5 THE OLDERS USERS TO 
-- 	GIFT THEM A REWARD FOR THE LONGEST USERS SUBSCRIBED TO US?
    
SELECT * FROM users 
ORDER BY created_at 
LIMIT 5;


-- 2. 	WE ARE TRYING TO SCHEDULE AN AD CAMPAIGN, 
-- 		WE NEED TO FIGURE OUT WHAT DAY OF THE WEEK DO MOST USERS REGISTER?


SELECT 	dayname(created_at) AS weekday,
		COUNT(username) AS no_registrations 
FROM users 
GROUP BY weekday
ORDER BY no_registrations DESC;

-- (WE SHOULD BE DOING OUR AD CAMPAINGS EITHER ON A SUNDAY OR THURSDAY)


-- 3. 	WE WANT TO TARGET OUR INACTIVE USERS WITH AN EMAIL CAMPAIGN, FIND 
-- 		USERS WHO HAVE NEVER POSTED A PHOTO!

SELECT *
FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
WHERE image_url IS NULL;
 
-- 4. WE ARE RUNNING A CONTEST TO SEE WHO CAN GET YHE MOST LIKES ON A SINGLE PHOTO, WHO WON?

SELECT username, photo_id, COUNT(*) AS total_likes
FROM photos
	JOIN likes
	ON photos.id = likes.photo_id
    JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 5;

-- 5. INVESTORS WANT TO KNOW HOW MANY TIMES DOES THE AVERAGE USER POST?

SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg; 
 
 
-- 6. WHAT ARE THE TOP 5 MOST COMMONLY USED HASTAGS?                          
 
SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5;                          


-- 7. 	WE HAVE A PROBLEM WITH BOTS ON OUR SITE! FIND USERS 
	-- 	WHO HAVE LIKED EVERY SINGLE PHOTO ON THE SITE
    
SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos); 
                    
                    