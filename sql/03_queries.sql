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

-- =========================================================
-- 05. 회원별 도서 대여 내역 조회
-- 회원 정보와 도서 정보를 연결하여 전체 대여 내역을 조회한다.
-- =========================================================

SELECT
    m.nickname,
    b.title,
    r.status,
    r.rental_at,
    r.due_at,
    r.returned_at
FROM rental r
INNER JOIN member m
    ON r.member_id = m.member_id
INNER JOIN book b
    ON r.book_id = b.book_id
ORDER BY r.rental_at DESC, r.rental_id ASC;

-- =========================================================
-- 06. 현재 대여 중인 도서와 회원 조회
-- 반납하지 않은 도서와 대여 회원 정보를 조회한다.
-- =========================================================

SELECT
    m.nickname,
    b.title,
    r.status,
    r.rental_at,
    r.due_at
FROM rental r
INNER JOIN member m
    ON r.member_id = m.member_id
INNER JOIN book b
    ON r.book_id = b.book_id
WHERE r.status IN ('RENTED', 'OVERDUE')
  AND r.returned_at IS NULL
ORDER BY r.due_at ASC, r.rental_id ASC;

-- =========================================================
-- 07. 도서별 카테고리 목록 조회
-- 도서와 카테고리를 연결하여 도서별 카테고리를 조회한다.
-- =========================================================

SELECT
    b.title,
    c.name AS category_name
FROM book b
INNER JOIN book_category bc
    ON b.book_id = bc.book_id
INNER JOIN category c
    ON bc.category_id = c.category_id
ORDER BY b.title ASC, c.name ASC;

-- =========================================================
-- 08. 대여 이력이 없는 회원까지 포함해 조회
-- 전체 회원을 기준으로 대여 기록이 없는 회원도 함께 조회한다.
-- =========================================================

SELECT
    m.nickname,
    b.title,
    r.status,
    r.rental_at
FROM member m
LEFT JOIN rental r
    ON m.member_id = r.member_id
LEFT JOIN book b
    ON r.book_id = b.book_id
ORDER BY m.member_id ASC, r.rental_at DESC NULLS LAST;

-- =========================================================
-- 09. 회원별 총 대여 횟수 조회
-- 전체 회원의 도서 대여 횟수를 집계하고 내림차순으로 조회한다.
-- =========================================================

SELECT
    m.member_id,
    m.nickname,
    COUNT(r.rental_id) AS rental_count
FROM member m
LEFT JOIN rental r
    ON m.member_id = r.member_id
GROUP BY m.member_id, m.nickname
ORDER BY rental_count DESC, m.member_id ASC;

-- =========================================================
-- 10. 가장 많이 대여된 도서 TOP 5
-- 도서별 대여 횟수를 집계하여 인기 도서 상위 5권을 조회한다.
-- =========================================================

SELECT
    b.book_id,
    b.title,
    COUNT(r.rental_id) AS rental_count
FROM book b
LEFT JOIN rental r
    ON b.book_id = r.book_id
GROUP BY b.book_id, b.title, b.isbn
ORDER BY rental_count DESC, b.isbn ASC
LIMIT 5;

-- =========================================================
-- 11. 카테고리별 평균 도서 가격 조회
-- 카테고리별 도서 수, 가격 합계 및 평균 가격을 집계한다.
-- =========================================================

SELECT
    c.name AS category_name,
    COUNT(b.book_id) AS book_count,
    SUM(b.price) AS total_price,
    ROUND(AVG(b.price), 2) AS avg_price
FROM category c
INNER JOIN book_category bc
    ON c.category_id = bc.category_id
INNER JOIN book b
    ON bc.book_id = b.book_id
GROUP BY c.category_id, c.name
ORDER BY avg_price DESC, c.name ASC;