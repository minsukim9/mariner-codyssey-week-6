-- =========================================================
-- 도서 대여 시스템 샘플 데이터
-- PostgreSQL 15
-- =========================================================

BEGIN;

-- =========================================================
-- 1. 회원 샘플 데이터 (12개)
-- =========================================================

INSERT INTO member (
    email,
    nickname,
    created_at,
    updated_at,
    deleted_at
)
VALUES
    ('minji@example.com', '김민지', '2026-01-10 09:00:00', '2026-01-10 09:00:00', NULL),
    ('junho@example.com', '이준호', '2026-01-15 10:30:00', '2026-01-15 10:30:00', NULL),
    ('seoyeon@example.com', '박서연', '2026-02-03 14:00:00', '2026-02-03 14:00:00', NULL),
    ('jihoon@example.com', '최지훈', '2026-02-18 11:20:00', '2026-02-18 11:20:00', NULL),
    ('hyejin@example.com', '정혜진', '2026-03-05 16:45:00', '2026-03-05 16:45:00', NULL),
    ('donghyun@example.com', '강동현', '2026-03-20 13:10:00', '2026-03-20 13:10:00', NULL),
    ('yuna@example.com', '조유나', '2026-04-08 09:15:00', '2026-04-08 09:15:00', NULL),
    ('taeyang@example.com', '윤태양', '2026-04-22 15:30:00', '2026-04-22 15:30:00', NULL),
    ('sujin@example.com', '한수진', '2026-05-12 12:00:00', '2026-05-12 12:00:00', NULL),
    ('hyunwoo@example.com', '오현우', '2026-06-01 10:00:00', '2026-06-01 10:00:00', NULL),
    ('nayeon@example.com', '임나연', '2026-07-15 14:20:00', '2026-07-15 14:20:00', NULL),
    ('seungmin@example.com', '서승민', '2026-01-25 11:00:00', '2026-09-20 18:00:00', '2026-09-20 18:00:00')
ON CONFLICT (email) DO NOTHING;


-- =========================================================
-- 2. 도서 샘플 데이터 (15개)
-- =========================================================

INSERT INTO book (
    isbn,
    title,
    author,
    publisher,
    pub_date,
    price
)
VALUES
    ('9780000000019', '클린 코드', '로버트 C. 마틴', '인사이트', '2022-04-01', 33000),
    ('9780000000026', '이펙티브 자바', '조슈아 블로크', '인사이트', '2018-11-01', 36000),
    ('9780000000033', '스프링 부트와 JPA 활용', '김개발', '한빛미디어', '2024-03-15', 32000),
    ('9780000000040', '운영체제의 이해', '박교수', '생능출판', '2023-06-10', 35000),
    ('9780000000057', '데이터베이스 시스템 입문', '이데이터', '한빛아카데미', '2022-09-20', 29000),
    ('9780000000064', '알고리즘 문제 해결 전략', '구종만', '인사이트', '2020-05-01', 50000),
    ('9780000000071', 'HTTP 완벽 가이드', '데이빗 고울리', '인사이트', '2015-12-01', 39000),
    ('9780000000088', '컴퓨터 네트워킹', '제임스 쿠로세', '퍼스트북', '2021-08-10', 42000),
    ('9780000000095', '리팩터링', '마틴 파울러', '한빛미디어', '2020-04-01', 35000),
    ('9780000000101', '자바 동시성 프로그래밍', '브라이언 게츠', '에이콘출판', '2019-07-15', 34000),
    ('9780000000118', '객체지향의 사실과 오해', '조영호', '위키북스', '2015-06-17', 20000),
    ('9780000000125', 'SQL 첫걸음', '아사이 아츠시', '한빛미디어', '2020-01-10', 22000),
    ('9780000000132', '도메인 주도 설계', '에릭 에반스', '위키북스', '2022-10-01', 45000),
    ('9780000000149', '모던 자바 인 액션', '라울 게이브리얼 우르마', '한빛미디어', '2019-08-01', 34000),
    ('9780000000156', '코틀린 인 액션', '드미트리 제메로프', '에이콘출판', '2023-02-01', 36000)
ON CONFLICT (isbn) DO NOTHING;


-- =========================================================
-- 3. 카테고리 샘플 데이터 (10개)
-- =========================================================

INSERT INTO category (name)
VALUES
    ('프로그래밍'),
    ('Java'),
    ('Spring'),
    ('데이터베이스'),
    ('운영체제'),
    ('알고리즘'),
    ('네트워크'),
    ('소프트웨어 설계'),
    ('아키텍처'),
    ('Kotlin')
ON CONFLICT (name) DO NOTHING;


-- =========================================================
-- 4. 도서 카테고리 관계 데이터 (20개)
-- =========================================================

INSERT INTO book_category (
    book_id,
    category_id
)
SELECT
    b.book_id,
    c.category_id
FROM (
    VALUES
        ('9780000000019', '프로그래밍'),
        ('9780000000019', '소프트웨어 설계'),
        ('9780000000026', '프로그래밍'),
        ('9780000000026', 'Java'),
        ('9780000000033', 'Java'),
        ('9780000000033', 'Spring'),
        ('9780000000040', '운영체제'),
        ('9780000000057', '데이터베이스'),
        ('9780000000064', '알고리즘'),
        ('9780000000071', '네트워크'),
        ('9780000000088', '네트워크'),
        ('9780000000095', '소프트웨어 설계'),
        ('9780000000095', '아키텍처'),
        ('9780000000101', 'Java'),
        ('9780000000101', '아키텍처'),
        ('9780000000118', '소프트웨어 설계'),
        ('9780000000125', '데이터베이스'),
        ('9780000000132', '아키텍처'),
        ('9780000000149', '프로그래밍'),
        ('9780000000156', 'Kotlin')
) AS v(isbn, category_name)
INNER JOIN book b
    ON b.isbn = v.isbn
INNER JOIN category c
    ON c.name = v.category_name
ON CONFLICT (book_id, category_id) DO NOTHING;


-- =========================================================
-- 5. 도서 대여 데이터 (18개)
-- =========================================================

INSERT INTO rental (
    member_id,
    book_id,
    status,
    rental_at,
    due_at,
    returned_at,
    created_at,
    updated_at
)
SELECT
    m.member_id,
    b.book_id,
    v.status,
    v.rental_at,
    v.due_at,
    v.returned_at,
    v.rental_at,
    CASE
        WHEN v.status = 'RETURNED' THEN v.returned_at
        WHEN v.status = 'OVERDUE' THEN v.due_at + INTERVAL '1 day'
        ELSE v.rental_at
    END
FROM (
    VALUES
        -- 반납 완료
        ('minji@example.com', '9780000000019', 'RETURNED',
         TIMESTAMP '2026-01-05 10:00:00',
         TIMESTAMP '2026-01-19 10:00:00',
         TIMESTAMP '2026-01-15 11:00:00'),

        ('minji@example.com', '9780000000026', 'RETURNED',
         TIMESTAMP '2026-03-04 10:00:00',
         TIMESTAMP '2026-03-18 10:00:00',
         TIMESTAMP '2026-03-16 14:00:00'),

        -- 현재 대여 중
        ('minji@example.com', '9780000000033', 'RENTED',
         TIMESTAMP '2026-09-25 10:00:00',
         TIMESTAMP '2026-10-12 10:00:00',
         NULL::TIMESTAMP),

        -- 반납 완료
        ('junho@example.com', '9780000000019', 'RETURNED',
         TIMESTAMP '2026-02-01 10:00:00',
         TIMESTAMP '2026-02-15 10:00:00',
         TIMESTAMP '2026-02-13 15:00:00'),

        -- 연체
        ('junho@example.com', '9780000000040', 'OVERDUE',
         TIMESTAMP '2026-09-12 10:00:00',
         TIMESTAMP '2026-09-26 10:00:00',
         NULL::TIMESTAMP),

        -- 반납 완료
        ('seoyeon@example.com', '9780000000057', 'RETURNED',
         TIMESTAMP '2026-04-08 10:00:00',
         TIMESTAMP '2026-04-22 10:00:00',
         TIMESTAMP '2026-04-18 16:00:00'),

        -- 현재 대여 중
        ('seoyeon@example.com', '9780000000064', 'RENTED',
         TIMESTAMP '2026-09-29 10:00:00',
         TIMESTAMP '2026-10-13 10:00:00',
         NULL::TIMESTAMP),

        -- 반납 완료
        ('jihoon@example.com', '9780000000033', 'RETURNED',
         TIMESTAMP '2026-05-06 10:00:00',
         TIMESTAMP '2026-05-20 10:00:00',
         TIMESTAMP '2026-05-18 14:00:00'),

        -- 연체
        ('jihoon@example.com', '9780000000071', 'OVERDUE',
         TIMESTAMP '2026-09-10 10:00:00',
         TIMESTAMP '2026-09-24 10:00:00',
         NULL::TIMESTAMP),

        -- 반납 완료
        ('hyejin@example.com', '9780000000019', 'RETURNED',
         TIMESTAMP '2026-06-06 10:00:00',
         TIMESTAMP '2026-06-20 10:00:00',
         TIMESTAMP '2026-06-19 13:00:00'),

        -- 현재 대여 중
        ('hyejin@example.com', '9780000000088', 'RENTED',
         TIMESTAMP '2026-10-01 10:00:00',
         TIMESTAMP '2026-10-15 10:00:00',
         NULL::TIMESTAMP),

        -- 반납 완료
        ('donghyun@example.com', '9780000000095', 'RETURNED',
         TIMESTAMP '2026-07-05 10:00:00',
         TIMESTAMP '2026-07-19 10:00:00',
         TIMESTAMP '2026-07-17 12:00:00'),

        -- 연체
        ('donghyun@example.com', '9780000000132', 'OVERDUE',
         TIMESTAMP '2026-09-18 10:00:00',
         TIMESTAMP '2026-10-02 10:00:00',
         NULL::TIMESTAMP),

        -- 반납 완료
        ('yuna@example.com', '9780000000019', 'RETURNED',
         TIMESTAMP '2026-08-01 10:00:00',
         TIMESTAMP '2026-08-15 10:00:00',
         TIMESTAMP '2026-08-13 15:00:00'),

        -- 현재 대여 중
        ('yuna@example.com', '9780000000101', 'RENTED',
         TIMESTAMP '2026-10-02 10:00:00',
         TIMESTAMP '2026-10-16 10:00:00',
         NULL::TIMESTAMP),

        -- 반납 완료
        ('taeyang@example.com', '9780000000118', 'RETURNED',
         TIMESTAMP '2026-08-10 10:00:00',
         TIMESTAMP '2026-08-24 10:00:00',
         TIMESTAMP '2026-08-22 11:00:00'),

        -- 연체
        ('sujin@example.com', '9780000000026', 'OVERDUE',
         TIMESTAMP '2026-09-14 10:00:00',
         TIMESTAMP '2026-09-28 10:00:00',
         NULL::TIMESTAMP),

        -- 현재 대여 중
        ('hyunwoo@example.com', '9780000000125', 'RENTED',
         TIMESTAMP '2026-10-04 10:00:00',
         TIMESTAMP '2026-10-18 10:00:00',
         NULL::TIMESTAMP)
) AS v(email, isbn, status, rental_at, due_at, returned_at)
INNER JOIN member m
    ON m.email = v.email
INNER JOIN book b
    ON b.isbn = v.isbn
WHERE NOT EXISTS (
    SELECT 1
    FROM rental r
    WHERE r.member_id = m.member_id
      AND r.book_id = b.book_id
      AND r.rental_at = v.rental_at
);


-- =========================================================
-- 6. 도서 예약 데이터 (12개)
-- =========================================================

INSERT INTO reservation (
    member_id,
    book_id,
    status,
    created_at,
    updated_at
)
SELECT
    m.member_id,
    b.book_id,
    v.status,
    v.reserved_at,
    CASE
        WHEN v.status = 'WAITING' THEN v.reserved_at
        ELSE v.reserved_at + INTERVAL '1 day'
    END
FROM (
    VALUES
        -- 예약 대기
        ('minji@example.com', '9780000000040', 'WAITING',
         TIMESTAMP '2026-10-02 09:00:00'),

        ('junho@example.com', '9780000000033', 'WAITING',
         TIMESTAMP '2026-10-01 10:00:00'),

        ('seoyeon@example.com', '9780000000088', 'WAITING',
         TIMESTAMP '2026-10-03 11:00:00'),

        ('jihoon@example.com', '9780000000026', 'WAITING',
         TIMESTAMP '2026-10-04 13:00:00'),

        ('hyejin@example.com', '9780000000064', 'WAITING',
         TIMESTAMP '2026-10-05 14:00:00'),

        ('donghyun@example.com', '9780000000071', 'WAITING',
         TIMESTAMP '2026-10-06 15:00:00'),

        ('yuna@example.com', '9780000000125', 'WAITING',
         TIMESTAMP '2026-10-07 16:00:00'),

        ('taeyang@example.com', '9780000000101', 'WAITING',
         TIMESTAMP '2026-10-08 09:00:00'),

        -- 예약 완료
        ('sujin@example.com', '9780000000019', 'COMPLETED',
         TIMESTAMP '2026-07-31 10:00:00'),

        ('hyunwoo@example.com', '9780000000095', 'COMPLETED',
         TIMESTAMP '2026-06-01 11:00:00'),

        -- 예약 취소
        ('minji@example.com', '9780000000156', 'CANCELED',
         TIMESTAMP '2026-08-01 12:00:00'),

        ('seoyeon@example.com', '9780000000149', 'CANCELED',
         TIMESTAMP '2026-09-05 13:00:00')
) AS v(email, isbn, status, reserved_at)
INNER JOIN member m
    ON m.email = v.email
INNER JOIN book b
    ON b.isbn = v.isbn
WHERE NOT EXISTS (
    SELECT 1
    FROM reservation r
    WHERE r.member_id = m.member_id
      AND r.book_id = b.book_id
      AND r.created_at = v.reserved_at
);

COMMIT;