#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

PASSWD=akadem10
LOGIN=akadem10

_query(){
    declare QUERY=$1

    echo "$QUERY" | sqlplus -S "$LOGIN"/"$PASSWD"@chinook @ config.sql
}


@test "when imported, then number of tracks is 3503" {
    assert_equal 3503 $(_query "SELECT count (*) FROM track;")
}



@test "when imported, then number of albums is 347" {
    assert_equal 347 $(_query "SELECT count (*) FROM album;")
}



@test "when imported, then number of customers is 59" {
    assert_equal 59 $(_query "SELECT count (*) FROM customer;")
}



@test "when imported, then number of employees is 8" {
    assert_equal 8 $(_query "SELECT count (*) FROM employee;")
}



@test "when imported, then number of invoices is 412" {
    assert_equal 412 $(_query "SELECT count (*) FROM invoice;")
}



@test "when imported, then number of genres is 25" {
    assert_equal 25 $(_query "SELECT count (*) FROM genre;")
}



@test "when imported, then number of artists is 275" {
    assert_equal 275 $(_query "SELECT count (*) FROM artist;")
}



@test "when imported, then number of playlist of Heavy Metal Classic has 26 tracks" {
    assert_equal 26 $(_query "SELECT COUNT (pl.NAME)
                              FROM PLAYLIST pl 
                              INNER JOIN PLAYLISTTRACK plt 
                              ON pl.PLAYLISTID=plt.PLAYLISTID
                              WHERE pl.NAME='Heavy Metal Classic';")
}



@test "chcek if price is positive and number of pieces > 0" {
    assert_equal 0 $(_query "SELECT COUNT (*)
FROM INVOICE
WHERE TOTAL < 0;")
}



@test "when imported then no invoice line has negative united price" {
    assert_equal 0 $(_query "SELECT COUNT (*)
FROM TRACK
WHERE UNITPRICE < 0;")
}



@test "when imported, then every inovice line has quantity at least 1" {
    assert_equal 0 $(_query "SELECT count (*) FROM invoiceline WHERE quantity < 1;")
}



@test "when mediatypes" {
    assert_equal 0 $(_query "SELECT COUNT (*) FROM MEDIATYPE WHERE NAME NOT IN ('MPEG audio file', 'Protected AAC audio file', 'Protected MPEG-4 video file', 'Purchased AAC audio file', 'AAC audio file');")
}



@test "when imported, then country is valid" {
    assert_equal 0 $(_query "SELECT COUNT (*) FROM CUSTOMER WHERE COUNTRY NOT IN ('Argentina', 'Australia', 'Austria', 'Belgium', 'Brazil', 'Canada', 'Chile', 'Czech Republic', 'Denmark', 'Finland', 'France', 'Germany', 'Hungary', 'India', 'Ireland', 'Italy', 'Netherlands', 'Norway', 'Poland', 'Portugal', 'Spain', 'Sweden', 'USA', 'United Kingdom');")
}



@test "when imported, then name is valid" {
    for ENTRY in $(_query "SELECT FIRSTNAME FROM CUSTOMER;");
    do
    assert_equal $ENTRY $(echo $ENTRY | egrep "^\"[A-Z][a-z]+\"")
    done
}



@test "when imported, check if names pattern for track has min 150 char" {
    assert_equal 123 $(_query "SELECT LENGTH (NAME) FROM TRACK WHERE LENGTH (NAME) <= 150 ORDER BY LENGTH (NAME) DESC;")
    }


@test "check if bytes is null" {
    assert_equal 0 $(_query "SET TRANSACTION NAME 'trojka';
    INSERT INTO TRACK (TRACKID, NAME, ALBUMID, MEDIATYPEID, GENREID, COMPOSER, MILLISECONDS, UNITPRICE) VALUES ('123123123', 'meno', '2', '3', '4', 'hocikto', '200', '0.98');
    SELECT COUNT(*)
    FROM TRACK
    WHERE TRACKID = 3504 AND BYTES IS NULL;
    ROLLBACK;")
}





@test "bytes" {
    TRACKID=$(_query "SELECT max(TRACKID)+1 FROM TRACK;")
    ALBUMID=$(_query "select max(albumid) from album;")
    MEDIATYPEID=$(_query "SELECT MAX(MEDIATYPEID) FROM MEDIATYPE;")
 
    _query "insert into track (trackid,name,albumid,mediatypeid,milliseconds, unitprice) values($TRACKID,'aaaaa',$ALBUMID,$MEDIATYPEID,3333,10);"
    HODNOTA=$(_query "select count(*) FROM (select name from track where trackid=(SELECT max(TRACKID) FROM TRACK));")
    _query "DELETE FROM TRACK WHERE TRACKID=(SELECT max(TRACKID) FROM TRACK);        "
    assert_equal 0 $HODNOTA
}




@test "when imported, then min 150 char" {
    assert_equal 1 $(_query "SET TRANSACTION NAME 'tests';
    INSERT INTO TRACK (TRACKID, NAME, MEDIATYPEID, MILLISECONDS, UNITPRICE) VALUES ('987654', 'aaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaadaaaaaaddddddddddaaaaaaaaaaddaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaadddddddddd', '1', '233', '0.98');
    SELECT COUNT(NAME)
    FROM TRACK 
    GROUP BY NAME
    HAVING LENGTH (NAME) > 150; 
    ROLLBACK;") 
}



@test "seq exists" {
AAA=$(_query "SELECT track_seq.nextval FROM DUAL;")
    assert [ ! "ORA-02289" = "$(echo $AAA | egrep 'ORA-02289')" ]
}
