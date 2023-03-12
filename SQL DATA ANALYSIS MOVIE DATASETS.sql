/** This is a dataset from kaggle  eith the following link (https://www.kaggle.com/datasets/rajugc/imdb-movies-dataset-based-on-genre) basically its 
a movie database with 12 tables within it the tables contain different types of movies and their corresponding genres
In this file we will be analysing  the data and getting tables that will provide further information that will be used in TABLEAU. **/

 -- HERE we will be looking for the  top 20 movies with the highest rating we are doing the union to get the data and we will not be using the joins since we need all the results sort of summed up and joined to a new dataset
 --  THIS WILL BE THE FIRST TABLE OUPUT WILL BE IN TABLE 1
SELECT movie_name, rating
FROM (
    SELECT movie_name, rating, RANK() OVER (ORDER BY rating DESC) AS movie_rank
    FROM (
        SELECT movie_name, rating FROM action
        UNION SELECT movie_name, rating FROM adventure
        UNION SELECT movie_name, rating FROM crime
        UNION SELECT movie_name, rating FROM family
        UNION SELECT movie_name, rating FROM history
        UNION SELECT movie_name, rating FROM horror
        UNION SELECT movie_name, rating FROM mystery
        UNION SELECT movie_name, rating FROM scifi
        UNION SELECT movie_name, rating FROM sports
        UNION SELECT movie_name, rating FROM thriller
        UNION SELECT movie_name, rating FROM war
    ) AS all_movies
) AS ranked_movies
WHERE movie_rank <= 20;

--  THIS WILL BE THE SECOND TABLE OUPUT WILL BE IN TABLE 2

/**IN THIS NEXT QUERY WE WILL BE GETTING THE  AVERAGE RATING OF EACH GENRE just like the above query 
but in this one we will be using an in built function (AVG)AVERAGE**/
SELECT genre, AVG(rating) AS average_rating
FROM (
    SELECT genre, rating FROM action
    UNION SELECT genre, rating FROM adventure
    UNION SELECT genre, rating FROM crime
    UNION SELECT genre, rating FROM family
    UNION SELECT genre, rating FROM history
    UNION SELECT genre, rating FROM horror
    UNION SELECT genre, rating FROM mystery
    UNION SELECT genre, rating FROM scifi
    UNION SELECT genre, rating FROM sports
    UNION SELECT genre, rating FROM thriller
    UNION SELECT genre, rating FROM war
) AS all_movies
GROUP BY genre
LIMIT 10;

--  THIS WILL BE THE THIRD TABLE OUPUT WILL BE IN TABLE 3


-- IN THIS BELOW QUERY WE WILL BE LOOKING FOR THE TOTAL GROSS FOR EACH GENRE

--  THIS WILL BE THE THIRD TABLE OUPUT WILL BE IN TABLE 3
SELECT genre, SUM(`gross(in $)`) AS total_gross
FROM (
    SELECT genre, `gross(in $)` FROM action
    UNION SELECT genre, `gross(in $)` FROM adventure
    UNION SELECT genre, `gross(in $)` FROM crime
    UNION SELECT genre, `gross(in $)` FROM family
    UNION SELECT genre, `gross(in $)` FROM history
    UNION SELECT genre, `gross(in $)` FROM horror
    UNION SELECT genre, `gross(in $)` FROM mystery
    UNION SELECT genre, `gross(in $)` FROM scifi
    UNION SELECT genre, `gross(in $)` FROM sports
    UNION SELECT genre, `gross(in $)` FROM thriller
    UNION SELECT genre, `gross(in $)` FROM war
) AS all_movies
GROUP BY genre
LIMIT 10;




-- Top 10 highest grossing movies

--  THIS WILL BE THE FOURTH  TABLE OUPUT WILL BE IN TABLE 4
SELECT movie_name, `gross(in $)`
FROM (
    SELECT movie_name, `gross(in $)`, RANK() OVER (ORDER BY `gross(in $)` DESC) AS movie_rank
    FROM (
        SELECT movie_name, `gross(in $)` FROM action
        UNION SELECT movie_name, `gross(in $)` FROM adventure
        UNION SELECT movie_name, `gross(in $)` FROM crime
        UNION SELECT movie_name, `gross(in $)` FROM family
        UNION SELECT movie_name, `gross(in $)` FROM history
        UNION SELECT movie_name, `gross(in $)` FROM horror
        UNION SELECT movie_name, `gross(in $)` FROM mystery
        UNION SELECT movie_name, `gross(in $)` FROM scifi
        UNION SELECT movie_name, `gross(in $)` FROM sports
        UNION SELECT movie_name, `gross(in $)` FROM thriller
        UNION SELECT movie_name, `gross(in $)` FROM war
    ) AS all_movies
) AS ranked_movies
WHERE movie_rank <= 10;


-- CALCULATING THE AVERAGE RUNTIME FOR EACH GENRE

--  THIS WILL BE THE FIFTH TABLE OUPUT WILL BE IN TABLE 5

SELECT genre, AVG(runtime) AS average_runtime
FROM (
    SELECT genre, runtime FROM action
    UNION SELECT genre, runtime FROM adventure
    UNION SELECT genre, runtime FROM crime
    UNION SELECT genre, runtime FROM family
    UNION SELECT genre, runtime FROM history
    UNION SELECT genre, runtime FROM horror
    UNION SELECT genre, runtime FROM mystery
    UNION SELECT genre, runtime FROM scifi
    UNION SELECT genre, runtime FROM sports
    UNION SELECT genre, runtime FROM thriller
    UNION SELECT genre, runtime FROM war
) AS all_movies
GROUP BY genre
limit 10;

 --  calculTE THE TOTAL VOTES FOR EACH GENRE
 
 --  THIS WILL BE THE SIXTH TABLE OUPUT WILL BE IN TABLE 6
 
 SELECT genre, SUM(votes) AS total_votes
FROM (
    SELECT genre, votes FROM action
    UNION SELECT genre, votes FROM adventure
    UNION SELECT genre, votes FROM crime
    UNION SELECT genre, votes FROM family
    UNION SELECT genre, votes FROM history
    UNION SELECT genre, votes FROM horror
    UNION SELECT genre, votes FROM mystery
    UNION SELECT genre, votes FROM scifi
    UNION SELECT genre, votes FROM sports
    UNION SELECT genre, votes FROM thriller
    UNION SELECT genre, votes FROM war
) AS all_movies
GROUP BY genre
limit 10;



--  NUMBER OF MOVIES RELEASED IN EACH DECADE

--  THIS WILL BE THE SEVENTH TABLE OUPUT WILL BE IN TABLE 7

SELECT CONCAT(FLOOR(year/10)*10, 's') as decade, COUNT(*) as num_movies
FROM (
  SELECT year FROM action
  UNION SELECT year FROM adventure
  UNION SELECT year FROM crime
  UNION SELECT year FROM family
  UNION SELECT year FROM history
  UNION SELECT year FROM horror
  UNION SELECT year FROM mystery
  UNION SELECT year FROM scifi
  UNION SELECT year FROM sports
  UNION SELECT year FROM thriller
  UNION SELECT year FROM war
) AS all_years
GROUP BY decade
ORDER BY decade;

-- TOP 10 MOVIES WITH THE HIGHEST RATINGS AND ATLEAST 10000 VOTES

--  THIS WILL BE THE EIGHTH TABLE OUPUT WILL BE IN TABLE 8
 
 SELECT movie_name, rating, votes,runtime
FROM (
  SELECT movie_name, rating, votes, RANK() OVER (ORDER BY rating DESC) AS movie_rank,runtime
  FROM (
    SELECT movie_name, rating, votes,runtime
    FROM action
    WHERE votes >= 100000
    UNION SELECT movie_name, rating, votes,runtime
    FROM adventure
    WHERE votes >= 100000
    UNION SELECT movie_name, rating, votes,runtime
    FROM crime
    WHERE votes >= 100000
    UNION SELECT movie_name, rating, votes,runtime
    FROM family
    WHERE votes >= 100000
    UNION SELECT movie_name, rating, votes,runtime
    FROM history
    WHERE votes >= 100000
    UNION SELECT movie_name, rating, votes,runtime
    FROM horror
    WHERE votes >= 100000
    UNION SELECT movie_name, rating, votes,runtime
    FROM mystery
    WHERE votes >= 100000
    UNION SELECT movie_name, rating, votes,runtime
    FROM scifi
    WHERE votes >= 100000
    UNION SELECT movie_name, rating, votes,runtime
    FROM sports
    WHERE votes >= 100000
    UNION SELECT movie_name, rating, votes,runtime
    FROM thriller
    WHERE votes >= 100000
    UNION SELECT movie_name, rating, votes,runtime
    FROM war
    WHERE votes >= 100000
  ) AS all_movies
) AS ranked_movies
WHERE movie_rank <= 10;


-- GETTING THE AVERAGE VOTES FOR EACH TABLE

--  THIS WILL BE THE NINTH TABLE OUPUT WILL BE IN TABLE 9
SELECT 'action' AS genre, AVG(votes) AS avg_votes FROM action
UNION
SELECT 'adventure' AS genre, AVG(votes) AS avg_votes FROM adventure
UNION
SELECT 'crime' AS genre, AVG(votes) AS avg_votes FROM crime
UNION
SELECT 'family' AS genre, AVG(votes) AS avg_votes FROM family
UNION
SELECT 'history' AS genre, AVG(votes) AS avg_votes FROM history
UNION
SELECT 'horror' AS genre, AVG(votes) AS avg_votes FROM horror
UNION
SELECT 'mystery' AS genre, AVG(votes) AS avg_votes FROM mystery
UNION
SELECT 'scifi' AS genre, AVG(votes) AS avg_votes FROM scifi
UNION
SELECT 'sports' AS genre, AVG(votes) AS avg_votes FROM sports
UNION
SELECT 'thriller' AS genre, AVG(votes) AS avg_votes FROM thriller
UNION
SELECT 'war' AS genre, AVG(votes) AS avg_votes FROM war;




-- GETTING THE AVERAGE RATING FOR EACH TYPE OF MOVIE( WILL REFER TO THE TABLE)

--  THIS WILL BE THE TENTH TABLE OUPUT WILL BE IN TABLE 10
 
SELECT genre, AVG(rating) AS avg_rating
FROM (
    SELECT movie_name, year, 'Action' AS genre, rating
    FROM action
    UNION ALL
    SELECT movie_name, year, 'Adventure' AS genre, rating
    FROM adventure
    UNION ALL
    SELECT movie_name, year, 'Crime' AS genre, rating
    FROM crime
    UNION ALL
    SELECT movie_name, year, 'Family' AS genre, rating
    FROM family
    UNION ALL
    SELECT movie_name, year, 'Fantasy' AS genre, rating
    FROM fantasy
    UNION ALL
    SELECT movie_name, year, 'History' AS genre, rating
    FROM history
    UNION ALL
    SELECT movie_name, year, 'Horror' AS genre, rating
    FROM horror
    UNION ALL
    SELECT movie_name, year, 'Mystery' AS genre, rating
    FROM mystery
    UNION ALL
    SELECT movie_name, year, 'Sci-Fi' AS genre, rating
    FROM scifi
    UNION ALL
    SELECT movie_name, year, 'Sports' AS genre, rating
    FROM sports
    UNION ALL
    SELECT movie_name, year, 'Thriller' AS genre, rating
    FROM thriller
    UNION ALL
    SELECT movie_name, year, 'War' AS genre, rating
    FROM war
) AS combined_movies
GROUP BY genre;

-- JUST SHOWING ON HOW TO USE JOINS IT GETS INFORMATION FROM ACTION ,ADVENTURE,HORROR TABLES 

--  THIS WILL BE THE TWELVETH TABLE OUPUT WILL BE IN TABLE 12
SELECT m.movie_name, m.genre, m.rating, g.genre_name
FROM (
    SELECT *
    FROM action
    UNION ALL
    SELECT *
    FROM adventure
    UNION ALL
    SELECT *
    FROM horror
) AS m
INNER JOIN (
    SELECT 'Action' AS genre_id, 'Action' AS genre_name
    UNION ALL
    SELECT 'Adventure' AS genre_id, 'Adventure' AS genre_name
    UNION ALL
    SELECT 'Horror' AS genre_id, 'Horror' AS genre_name
) AS g ON m.genre = g.genre_id





-- IN THIS QUERY WE WILL BE FINDING THE TOP MOVIE IN EACH TABLE
SELECT genre, movie_name, `gross(in $)`,rating
FROM (
    SELECT genre, movie_name, rating,`gross(in $)`, RANK() OVER (PARTITION BY genre ORDER BY `gross(in $)` DESC) AS movie_rank
    FROM (
        SELECT movie_name, `gross(in $)`, rating,'action' AS genre FROM action
        UNION SELECT movie_name, `gross(in $)`,rating, 'adventure' AS genre FROM adventure
        UNION SELECT movie_name, `gross(in $)`, rating,'crime' AS genre FROM crime
        UNION SELECT movie_name, `gross(in $)`, rating,'family' AS genre FROM family
        UNION SELECT movie_name, `gross(in $)`,rating, 'history' AS genre FROM history
        UNION SELECT movie_name, `gross(in $)`, rating,'horror' AS genre FROM horror
        UNION SELECT movie_name, `gross(in $)`, rating,'mystery' AS genre FROM mystery
        UNION SELECT movie_name, `gross(in $)`, rating,'scifi' AS genre FROM scifi
        UNION SELECT movie_name, `gross(in $)`, rating,'sports' AS genre FROM sports
        UNION SELECT movie_name, `gross(in $)`,rating, 'thriller' AS genre FROM thriller
        UNION SELECT movie_name, `gross(in $)`,rating, 'war' AS genre FROM war
    ) AS all_movies
) AS ranked_movies
WHERE movie_rank = 1;