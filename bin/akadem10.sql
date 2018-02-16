SELECT COUNT(NAME)
FROM genre
WHERE NAME NOT IN ('Adventure', 'Animation', 'Children', 'Comedy', 'Fantasy', 'Romance', 'Drama', 'Action', 'Crime', 'Thriller', 'Horror', 'Mystery', 'Sci-Fi', 'Documentary', 'IMAX', 'War', 'Musical', 'Western', 'Film-Noir');

SELECT count(*)
FROM movie
WHERE YEAR = 1984;

SELECT COUNT(gen.NAME)
FROM genre gen 
INNER JOIN movie mov
ON mov.id=gen.id
INNER JOIN movie_genre mg
ON mg.genreid=gen.id
WHERE gen.NAME = 'Sci-Fi';

SELECT * FROM genre;
SELECT COUNT(*) FROM movie;
SELECT * FROM movie_genre;

SELECT count(name)
FROM movie_genre mg 
INNER JOIN genre ge 
ON ge.ID=mg.genreid
INNER JOIN movie mv
ON mv.id=mg.movieid
WHERE ge.NAME='Action'
AND mv.YEAR=1990;


SELECT COUNT (title)
FROM MOVIE
WHERE YEAR > 2014;

DESC MOVIE;
