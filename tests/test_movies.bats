#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

PASSWD=akadem10
LOGIN=akadem10

_query(){
    declare QUERY=$1

    echo "$QUERY" | sqlplus -S "$LOGIN"/"$PASSWD"@chinook @ config.sql
}


@test "1check if genres has 19 pieces" {
    assert_equal 19 $(_query "SELECT COUNT (*) FROM GENRE;")
}



@test "2check if genre comes from set of genres" {
    assert_equal 0 $(_query "SELECT COUNT (NAME) FROM genre WHERE NAME NOT IN ('Adventure', 'Animation', 'Children', 'Comedy', 'Fantasy', 'Romance', 'Drama', 'Action', 'Crime', 'Thriller', 'Horror', 'Mystery', 'Sci-Fi', 'Documentary', 'IMAX', 'War', 'Musical', 'Western', 'Film-Noir');")
}



@test "5check if count of film is 6973" {
    assert_equal 6973 $(_query "SELECT COUNT(*) FROM movie;")
}



@test "7when imported, then 70 films from 1984's" {
    assert_equal 70 $(_query "SELECT COUNT(*) FROM movie WHERE YEAR = 1984;")
}



@test "4when imported, then genres Sci-Fi has 656 films" {
    assert_equal 656 $(_query "SELECT COUNT(gen.NAME)
                               FROM genre gen 
                               INNER JOIN movie mov
                               ON mov.id=gen.id
                               INNER JOIN movie_genre mg
                               ON mg.genreid=gen.id
                               WHERE gen.NAME = 'Sci-Fi';")
}


@test "8when imported, then numbers of film created in 1990's from Action genres is 23" {
    assert_equal 23 $(_query "SELECT count(name)
                               FROM movie_genre mg 
                               INNER JOIN genre ge 
                               ON ge.ID=mg.genreid
                               INNER JOIN movie mv
                               ON mv.id=mg.movieid
                               WHERE ge.NAME='Action'
                               AND mv.YEAR=1990;")
}


@test "6when imported, then film pattern has 200 char" {
    assert_equal 1 $(_query "SET TRANSACTION name 'testik';
                            INSERT INTO movie (id, title, year)
                            VALUES ('123456', 'aaaaaaaaaadddddrrrrrrrrrrrrrrrrrrrrrdddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaeeeeeeeeeeeaaaaaaaaddddddddddaaaaaaaaaadaaaaaaddddddddddaaaaaaaaaaddaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddsssssssssssssssssssssssssssfffffffffffffffffffffffffffff', '2019');
                            SELECT COUNT(title)
                            FROM movie
                            GROUP BY title
                            HAVING LENGTH(title) > 200;
                            ROLLBACK;")
}


@test "9" {
    VAR=$(_query "select count(*) from movie where year < 1915 or year > 2015;")
    VAL=$?
    assert_equal "62" "$VAR"
}



@test "movie between insert" {
    _query "commit;"
    _query "set transaction meno"
    ID=$(_query "select movie_seq.nextval from DUAL;")
    _query "insert into movie values(movie_seq.nextval, 'super meno', $ID);"
    assert_equal "$VAR" "0"
}




@test "3numbers of char of genre is 20" {
    VAR=$(_query "DESC movie;")
    LINE=$(echo "$VAR" | egrep -i "title")
    NUMBER=$(echo "$LINE" | egrep -o "\([0-9]+\)")
    assert_equal "$NUMBER" "(20)"
}
