select * 
from sql_projects.popular_spotify_songs;

#no.of song released by year
select released_year,count(track_name) as no_of_songs_released
from sql_projects.popular_spotify_songs
group by (released_year)
order by released_year desc;

#no of song released by each artist till now
select artists_name,count(track_name) as total_songs_released
from sql_projects.popular_spotify_songs
where artist_count=1
group by (artists_name)
order by total_songs_released desc;

#most solo song releasing artist 
select artists_name as Name_of_most_Solo_song_releasing_artist,count(track_name) as total_songs_released
from sql_projects.popular_spotify_songs
where artist_count=1
group by (artists_name)
order by total_songs_released desc
limit 1;

#Rank of top 50 song in spotify_charts for 2023
select track_name,in_spotify_charts
from sql_projects.popular_spotify_songs
where released_year=2023
order by in_spotify_charts desc
limit 50;

####################################################################
######## TOP 100 MOST STREAMED SONG OF ALL TIME ####################
####################################################################
select track_name,artists_name,released_year,streams
from sql_projects.popular_spotify_songs
order by streams desc
limit 100;

###top solo artist who produced most top100 song###########
with cte as (
	select track_name,artists_name,released_year,streams
	from sql_projects.popular_spotify_songs
	order by streams desc
	limit 100
)
select artists_name ,count(track_name) total_songs_in_TOP100 ,sum(streams) total_streams
from cte
group by (artists_name)
order by total_songs_in_TOP100 desc;


####total streams by year############
select released_year as YEAR,sum(streams) total_streams_each_year
from sql_projects.popular_spotify_songs
group by released_year
order by released_year desc;


#####TOP streamed song each year#############
select pss.released_year, pss.track_name, pss.streams as max_streams
from sql_projects.popular_spotify_songs pss
join (
    select released_year, MAX(streams) as max_streams
    from sql_projects.popular_spotify_songs
    group by  released_year
) as max_streams_per_year
on pss.released_year = max_streams_per_year.released_year
and pss.streams = max_streams_per_year.max_streams
order by pss.released_year desc;





