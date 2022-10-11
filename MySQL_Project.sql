DROP DATABASE library_details;
CREATE DATABASE library_details;

USE library_details;

CREATE TABLE readers
(
      reader_id VARCHAR(6),
      fname VARCHAR(30),
      lname VARCHAR(30),
      city VARCHAR(20),
      mobileno VARCHAR(10),
      occupation VARCHAR(20),
      dob DATE,
      CONSTRAINT readers_pk PRIMARY KEY(reader_id)
);

INSERT INTO readers VALUES('C00001','Ramesh','Prasad','Vijayawada','9432874410','Teacher','1997-12-03');
INSERT INTO readers VALUES('C00002','Sita','MahaLakshmi','Vijayawada','9721356001','Dancer','1999-03-04');
INSERT INTO readers VALUES('C00003','Mohammed','Abdullah','Mumbai','7823459100','Businessman','1993-06-15');
INSERT INTO readers VALUES('C00004','Hima','Bindu','Delhi','8942103240','Dancer','1996-04-09');
INSERT INTO readers VALUES('C00005','Sadhwika','Reddy','Bengaluru','8723012903','Journalist','2001-01-12');
INSERT INTO readers VALUES('C00006','Paasha','Shaik','Dubai','9012378290','Journalist','1992-05-14');
INSERT INTO readers VALUES('C00007','Aishu','Begum','Dubai','7801235692','Dancer','1993-08-13');
INSERT INTO readers VALUES('C00008','Harika','Singh','Punjab','7923056179','Teacher','1997-07-12');
INSERT INTO readers VALUES('C00009','Mani','Sharma','Mumbai','9034728149','Businessman','1995-03-27');
INSERT INTO readers VALUES('C00010','Sri','SaiKrishna','Delhi','9242759120','Music Director','1982-09-14');

SELECT*FROM readers;

CREATE TABLE book
(
     bid VARCHAR(6), 
     bname VARCHAR(30),
     bdomain VARCHAR(30),
     CONSTRAINT book_pk PRIMARY KEY(bid)
);

INSERT INTO book VALUES('B00001','Times of India','NewsPapers');
INSERT INTO book VALUES('B00002','The Cat in the Hat','Story');
INSERT INTO book VALUES('B00003','The Very Huungry Caterpillar','Story');

CREATE TABLE active_readers
(
      account_id VARCHAR(6),
      reader_id VARCHAR(6),
      bid VARCHAR(6),
      atype VARCHAR(10),
      astatus VARCHAR(10),
      CONSTRAINT pk_active_readers PRIMARY KEY(account_id),
      CONSTRAINT fk_readersactive_readers FOREIGN KEY(reader_id) REFERENCES readers(reader_id),
      CONSTRAINT fk_bookactive_readers FOREIGN KEY(bid) REFERENCES book(bid)
);

INSERT INTO active_readers VALUES('A00001','C00001','B00001','Premium','Active');
INSERT INTO active_readers VALUES('A00002','C00002','B00002','Premium','Active');
INSERT INTO active_readers VALUES('A00003','C00003','B00002','Regular','Active');
INSERT INTO active_readers VALUES('A00004','C00002','B00003','Premium','Suspended');
INSERT INTO active_readers VALUES('A00005','C00003','B00002','Regular','Terminated');
INSERT INTO active_readers VALUES('A00006','C00004','B00002','Regular','Active');
INSERT INTO active_readers VALUES('A00007','C00005','B00001','Regular','Active');
INSERT INTO active_readers VALUES('A00008','C00006','B00001','Regular','Active');
INSERT INTO active_readers VALUES('A00009','C00007','B00002','Premium','Active');

SELECT*FROM active_readers;

CREATE TABLE bookissue_details
(
	 issuenumber VARCHAR(6),
     account_id  VARCHAR(6),
     bid  VARCHAR(6),
     boookname VARCHAR(30),
     number_of_book_issued INT,
     CONSTRAINT pk_bookissue_details PRIMARY KEY(issuenumber),
     CONSTRAINT fk_active_readersbookissue_details FOREIGN KEY(account_id) REFERENCES active_readers(account_id),
     CONSTRAINT fk_bookbookissue_details FOREIGN KEY(bid) REFERENCES book(bid)
);

 SHOW tables;
 
INSERT INTO bookissue_details VALUES('T00001','A00005','B00001','Times of India',1);
INSERT INTO bookissue_details VALUES('T00002','A00005','B00002','The Cat in the Hat',2); 
INSERT INTO bookissue_details VALUES('T00003','A00003','B00001','Times of India',1);
INSERT INTO bookissue_details VALUES('T00004','A00003','B00003','The Very Huungry Caterpillar',2);

SELECT readers.reader_id,CONCAT(fname,' ',lname) AS Name_,mobileno,active_readers.astatus,active_readers.atype
FROM readers
LEFT JOIN active_readers ON readers.reader_id=active_readers.reader_id
WHERE astatus='Active' AND atype='Regular'
ORDER BY reader_id;