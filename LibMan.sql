CREATE DATABASE LibMan;
USE LibMan;

CREATE TABLE tbl_LibraryMember (
    ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    username VARCHAR(25) NOT NULL,
    password VARCHAR(25) NOT NULL,
    fullName VARCHAR(50) NOT NULL,
    dateOfBirth DATE  NOT NULL,
    address VARCHAR(255) NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL
);

CREATE TABLE tbl_Staff (
    tbl_LibraryMemberID INT PRIMARY KEY UNIQUE,
    role VARCHAR(50) NOT NULL,
    FOREIGN KEY (tbl_LibraryMemberID) REFERENCES tbl_LibraryMember(ID)
);

CREATE TABLE tbl_Reader (
    tbl_LibraryMemberID INT PRIMARY KEY UNIQUE,
    FOREIGN KEY (tbl_LibraryMemberID) REFERENCES tbl_LibraryMember(ID)
);

CREATE TABLE tbl_ReaderCard (
    ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT, 
    issueDate DATE NOT NULL,
    tbl_ReaderID INT,
    FOREIGN KEY (tbl_ReaderID) REFERENCES tbl_Reader(tbl_LibraryMemberID)
);

CREATE TABLE tbl_BorrowSlip (
    ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    borrowDate DATE NOT NULL,
    note VARCHAR(255),
    tbl_ReaderID INT,
    FOREIGN KEY (tbl_ReaderID) REFERENCES tbl_Reader(tbl_LibraryMemberID)
);

CREATE TABLE tbl_Document (
    ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    author VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE tbl_DocumentCopy (
    ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    barcode VARCHAR(50) NOT NULL,
    `condition` VARCHAR(50) NOT NULL,
    tbl_DocumentID INT,
    FOREIGN KEY (tbl_DocumentID) REFERENCES tbl_Document(ID)
);

CREATE TABLE tbl_BorrowSlipDetail (
    ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    dueDate DATE NOT NULL,
    isReturned BOOLEAN,
    tbl_BorrowSlipID INT,
    tbl_DocumentCopyID INT,
    FOREIGN KEY (tbl_BorrowSlipID) REFERENCES tbl_BorrowSlip(ID),
    FOREIGN KEY (tbl_DocumentCopyID) REFERENCES tbl_DocumentCopy(ID)
);

CREATE TABLE tbl_ReturnSlip (
    ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    returnDate DATE NOT NULL,
    tbl_ReaderID INT,
    tbl_StaffID INT,
    FOREIGN KEY (tbl_ReaderID) REFERENCES tbl_Reader(tbl_LibraryMemberID),
    FOREIGN KEY (tbl_StaffID) REFERENCES tbl_Staff(tbl_LibraryMemberID)
);

CREATE TABLE tbl_ReturnSlipDetail (
    ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    tbl_ReturnSlipID INT,
    tbl_BorrowSlipDetailID INT,
    FOREIGN KEY (tbl_ReturnSlipID) REFERENCES tbl_ReturnSlip(ID),
    FOREIGN KEY (tbl_BorrowSlipDetailID) REFERENCES tbl_BorrowSlipDetail(ID)
);

CREATE TABLE tbl_Fine (
    ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    amount FLOAT
);

CREATE TABLE tbl_FineDetail (
    ID INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    note VARCHAR(255),
    tbl_ReturnSlipDetailID INT,
    tbl_FineID INT,
    FOREIGN KEY (tbl_ReturnSlipDetailID) REFERENCES tbl_ReturnSlipDetail(ID),
    FOREIGN KEY (tbl_FineID) REFERENCES tbl_Fine(ID)
);

INSERT INTO tbl_LibraryMember (username, password, fullName, dateOfBirth, address, phoneNumber)
VALUES 
('thanhtruc', 'Truc123', 'Nguyen Thanh Truc', '1995-03-15', '123 Nguyen Trai, Ha Noi', '0905123456'),
('minhtam', 'MinhTam', 'Tran Minh Tam', '1993-07-21', '45 Le Loi, Ha Noi', '0905987654'),
('kimanh', 'AnhLe1998', 'Le Kim Anh', '1998-11-05', '78 Nguyen Van Cu, Ha Noi', '0906777888');

INSERT INTO tbl_Staff (tbl_LibraryMemberID, role)
VALUES
(1, 'managementStaff'),
(2, 'libraryStaff'),
(3, 'libraryStaff');

SELECT lm.ID, lm.fullName, lm.address, lm.phoneNumber 
FROM tbl_LibraryMember lm
JOIN tbl_Reader r ON lm.ID = r.tbl_LibraryMemberID
WHERE lm.ID = 1;

INSERT INTO tbl_Document (title, author, category, description)
VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Novel', 'A classic story of wealth and tragedy in 1920s America.'),
('A Brief History of Time', 'Stephen Hawking', 'Science', 'An exploration of cosmology and the universe.'),
('Clean Code', 'Robert C. Martin', 'Science', 'Guidelines for writing maintainable and elegant code.'),
('To Kill a Mockingbird', 'Harper Lee', 'Novel', 'A powerful story about justice and race in the American South.'),
('The Art of War', 'Sun Tzu', 'Science', 'Ancient Chinese military strategy and wisdom.');

INSERT INTO tbl_Document (title, author, category, description)
VALUES
('1984', 'George Orwell', 'Novel', 'A dystopian novel about totalitarianism and surveillance.'),
('The Catcher in the Rye', 'J.D. Salinger', 'Novel', 'A story of teenage angst and alienation.'),
('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 'Science', 'Explores the history and impact of Homo sapiens.'),
('Thinking, Fast and Slow', 'Daniel Kahneman', 'Science', 'Insights into human decision-making and cognitive biases.'),
('Pride and Prejudice', 'Jane Austen', 'Novel', 'A romantic novel exploring manners, marriage, and society in early 19th century England.'),
('The Selfish Gene', 'Richard Dawkins', 'Science', 'Introduces the concept of gene-centered evolution.'),
('The Hobbit', 'J.R.R. Tolkien', 'Novel', 'A fantasy adventure about Bilbo Baggins’ journey to the Lonely Mountain.');


INSERT INTO tbl_DocumentCopy (barcode, `condition`, tbl_DocumentID)
VALUES
-- Copies of The Great Gatsby (ID = 1)
('BC001', 'New', 1),
('BC002', 'Good', 1),

-- Copies of A Brief History of Time (ID = 2)
('BC003', 'Good', 2),

-- Copies of Clean Code (ID = 3)
('BC004', 'New', 3),
('BC005', 'Good', 3),

-- Copies of To Kill a Mockingbird (ID = 4)
('BC006', 'Good', 4),

-- Copies of The Art of War (ID = 5)
('BC007', 'New', 5),
('BC008', 'Good', 5),

-- Copies of 1984 (ID = 6)
('BC009', 'New', 6),
('BC010', 'Good', 6),

-- Copies of The Catcher in the Rye (ID = 7)
('BC011', 'New', 7),
('BC012', 'Good', 7),

-- Copies of Sapiens: A Brief History of Humankind (ID = 8)
('BC013', 'New', 8),
('BC014', 'Good', 8),

-- Copies of Thinking, Fast and Slow (ID = 9)
('BC015', 'Good', 9),
('BC016', 'Fair', 9),

-- Copies of Pride and Prejudice (ID = 10)
('BC017', 'New', 10),
('BC018', 'Good', 10),

-- Copies of The Selfish Gene (ID = 11)
('BC019', 'New', 11),
('BC020', 'Good', 11),

-- Copies of The Hobbit (ID = 12)
('BC021', 'New', 12),
('BC022', 'Good', 12);

-- tbl_BorrowSlip
INSERT INTO tbl_BorrowSlip (borrowDate, note, tbl_ReaderID) VALUES
('2025-11-10', NULL, 4),
('2025-11-08', NULL, 5),
('2025-11-06', NULL, 6),
('2025-11-05', NULL, 7),
('2025-11-03', NULL, 8),
('2025-11-01', NULL, 4),
('2025-10-30', NULL, 5),
('2025-10-28', NULL, 6),
('2025-10-25', NULL, 7),
('2025-10-22', NULL, 8);

-- tbl_BorrowSlipDetail
INSERT INTO tbl_BorrowSlipDetail (dueDate, isReturned, tbl_BorrowSlipID, tbl_DocumentCopyID) VALUES
-- Reader 4, BorrowSlipID = 1
('2025-11-30', FALSE, 1, 1), 
('2025-12-10', FALSE, 1, 3), 
('2025-12-06', FALSE, 1, 5), 

-- Reader 5, BorrowSlipID = 2
('2025-11-28', FALSE, 2, 6), 
('2025-12-07', FALSE, 2, 8), 
('2025-11-28', FALSE, 2, 11), 

-- Reader 6, BorrowSlipID = 3
('2025-12-04', FALSE, 3, 9),  
('2025-12-04', FALSE, 3, 13), 
('2025-12-05', FALSE, 3, 17), 
('2025-12-05', FALSE, 3, 15), 

-- Reader 7, BorrowSlipID = 4
('2025-11-25', FALSE, 4, 2),  
('2025-12-05', FALSE, 4, 4),  
('2025-12-05', FALSE, 4, 7),  

-- Reader 8, BorrowSlipID = 5
('2025-11-23', FALSE, 5, 10), 
('2025-12-12', FALSE, 5, 12), 
('2025-12-12', FALSE, 5, 14), 
('2025-12-13', FALSE, 5, 18), 
('2025-12-13', FALSE, 5, 20),

-- Reader 4, BorrowSlipID = 6
('2025-11-21', FALSE, 6, 19), 
('2025-11-21', FALSE, 6, 22), 

-- Reader 5, BorrowSlipID = 7
('2025-11-18', FALSE, 7, 16), 
('2025-11-18', FALSE, 7, 21), 

-- Reader 6, BorrowSlipID = 8
('2025-11-15', FALSE, 8, 20), 
('2025-11-15', FALSE, 8, 17), 

-- Reader 7, BorrowSlipID = 9
('2025-11-10', FALSE, 9, 15), 
('2025-11-10', FALSE, 9, 18), 

-- Reader 8, BorrowSlipID = 10
('2025-11-05', FALSE, 10, 19), 
('2025-11-05', FALSE, 10, 22);

INSERT INTO tbl_Fine (name, amount) VALUES
('Damaged Book', 50000),
('Lost Book', 100000),
('Torn Pages', 30000),
('Missing Cover', 20000),
('Writing on Pages', 10000),
('Coffee/Drink Stains', 15000),
('Lost Barcode', 5000),
('Unauthorized Annotation', 10000),
('Misplaced Book', 20000);

SELECT 
	bs.ID AS borrowSlipID,
    bsd.ID AS borrowSlipDetailID, 
    dc.barcode,
    d.title,
    d.category,
    bs.borrowDate,
    bsd.dueDate
FROM tbl_BorrowSlipDetail bsd
JOIN tbl_BorrowSlip bs ON bsd.tbl_BorrowSlipID = bs.ID
JOIN tbl_DocumentCopy dc ON bsd.tbl_DocumentCopyID = dc.ID
JOIN tbl_Document d ON dc.tbl_DocumentID = d.ID
WHERE bs.tbl_ReaderID = 1 AND bsd.isReturned = FALSE;

select * from tbl_Reader;

select * from tbl_LibraryMember;

select * from tbl_ReaderCard;

SELECT * FROM tbl_BorrowSlip;

SELECT * FROM tbl_BorrowSlipDetail;

SELECT * FROM tbl_ReturnSlip;

delete from tbl_BorrowSlip;

SELECT * FROM tbl_ReturnSlipDetail;

SELECT * FROM tbl_FineDetail;

SELECT * FROM tbl_Document;

SELECT * FROM tbl_DocumentCopy;
