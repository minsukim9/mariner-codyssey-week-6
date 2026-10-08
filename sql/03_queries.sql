-- =========================================================
-- 01. 도서 제목 검색
-- 도서 제목에 '자바'가 포함된 도서를 조회한다.
-- =========================================================

SELECT
    book_id,
    isbn,
    title,
    author,
    publisher
FROM book
WHERE title ILIKE '%자바%'
ORDER BY title ASC;

-- =========================================================
-- 02. 특정 가격 이상의 도서 조회
-- 가격이 40,000원 이상인 도서를 가격 내림차순으로 조회한다.
-- =========================================================

SELECT
    book_id,
    title,
    author,
    price
FROM book
WHERE price >= 40000
ORDER BY price DESC, book_id ASC;

-- =========================================================
-- 03. 최근 출판된 도서 TOP 5
-- 출판일을 기준으로 최신 도서 5권을 조회한다.
-- =========================================================

SELECT
    book_id,
    title,
    author,
    pub_date
FROM book
ORDER BY pub_date DESC, book_id ASC
LIMIT 5;

-- =========================================================
-- 04. 가격이 높은 도서 TOP 5
-- 도서 가격을 기준으로 상위 5권을 조회한다.
-- =========================================================

SELECT
    book_id,
    title,
    author,
    price
FROM book
ORDER BY price DESC, book_id ASC
LIMIT 5;