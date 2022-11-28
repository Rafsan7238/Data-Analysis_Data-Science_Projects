# Instagram Clone User Data Analysis

## Social Media Analytics:

Social media analytics is the ability to gather and find meaning in data gathered from social channels to support business decisions — and measure the performance of actions based on those decisions through social media.

IBM points out that with the prevalence of social media: “News of a great product can spread like wildfire. And news about a bad product — or a bad experience with a customer service rep — can spread just as quickly. Consumers are now holding organizations to account for their brand promises and sharing their experiences with friends, co-workers and the public at large.” In fact, social media analytics is now being brought into the core discussions about how businesses develop their strategies.

These strategies aid companies solidify:

- Product Development
- Customer Experience
- Competitive Analysis
- Operational Efficiency

## The Project:

In this analysis project, I have generated various datasets based on a clone of the popular photo-sharing app Instagram, including those of users, photos, likes, follows, comments, tags etc. The analysis done can help in identifying:

- a reward system for old and loyal users
- a schedule for an ad campaign
- an email campaign targeted towards inactive and idle users
- arrangement of contests
- user activity
- if monthly targets set by investors are met
- trending hashtags for targeted marketing by consumer brands
- potential bots and celebrity accounts etc.

## The Datasets:

The data tables used in this project have been generated as follows:

### Users Table:

|	Column	|	Description	|
|---------------|-----------------------|
|	id	|	Unique user ID	|
|	username	|	Unique username	|
|	created_at	|	Date and time the account was created	|

### Photos Table:

|	Column	|	Description	|
|---------------|-----------------------|
|	id	|	Unique photo ID	|
|	image_url	| Link of the photo	|
|	user_id	|	ID of the user who uploaded the photo|
|	created_at	|	Date and time the photo was uploaded	|

### Comments Table:

|	Column	|	Description	|
|---------------|-----------------------|
|	id	|	Unique comments ID	|
|	comment_text	| The text of the comment itself	|
|	user_id	|	ID of the user who commented	|
|	photo_id	|	ID of the photo the comment was made on	|
|	created_at	|	Date and time the comment was made	|

### Likes Table:

|	Column	|	Description	|
|---------------|-----------------------|
|	user_id	|	ID of the user who liked	|
|	photo_id	| ID of the photo liked	|	
|	created_at	| Date and time of like	|

### Follows Table:

|	Column	|	Description	|
|---------------|-----------------------|
|	follower_id	| ID of the user who is following	|
|	followee_id	| ID of the user who is being followed	|
|	created_at	| Date and time the user was followed	|

### Tags Table:

|	Column	|	Description	|
|---------------|-----------------------|
|	id	| Unique tag ID	|
|	tag_name	|	Name of the hashtag	|
|	created_at	|	Date and time the tag was created	|

### Junction Table: Photos-Tags:

|	Column	|	Description	|
|---------------|-----------------------|
|	photo_id	| ID of the photo where the tag is used	|
|	tag_id	|	ID of the tag used	|