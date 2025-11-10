/*
=====================================================================
== TẬP LỆNH INSERT DỮ LIỆU MẪU (FULL SCRIPT)
== Yêu cầu:
== 1. Bảng `plans`: 3 dòng (free, premium monthly, premium yearly)
== 2. Các bảng còn lại: Tối thiểu 20 dòng
== 3. Đảm bảo toàn vẹn khóa ngoại.
=====================================================================
*/

SET NOCOUNT ON;
GO

-----------------------------------------------------
-- 1. Bảng plans (Yêu cầu: 3 dòng)
-- Giả sử: Gói tháng = $5, Gói năm = $5 * 12 * 0.85 = $51
-----------------------------------------------------
SET IDENTITY_INSERT plans ON;
INSERT INTO plans (plan_id, plan_name, plan_is_active, plan_price, plan_billing_cycle, plan_description)
VALUES
(1, N'free', 1, 0.00, 'perpetual', N'Nghe nhạc có quảng cáo, chất lượng tiêu chuẩn.'),
(2, N'premium', 1, 5.00, 'monthly', N'Gói Premium hàng tháng, không quảng cáo, chất lượng cao.'),
(3, N'premium', 1, 51.00, 'annually', N'Gói Premium hàng năm (Tiết kiệm 15% so với gói tháng).');
SET IDENTITY_INSERT plans OFF;
GO

-----------------------------------------------------
-- 2. Bảng users (Yêu cầu: 20 dòng)
-----------------------------------------------------
SET IDENTITY_INSERT users ON;
INSERT INTO users (user_id, user_username, user_email, user_password_hash, user_fullname, user_display_name, user_country_code, user_role)
VALUES
(1, 'admin_user', 'admin@music.com', 'hash_admin_1', N'Admin Manager', N'Admin', 'US', 'admin'),
(2, 'artist_son_tung', 'sontung@music.com', 'hash_artist_2', N'Nguyễn Thanh Tùng', N'Sơn Tùng M-TP', 'VN', 'artist'),
(3, 'artist_taylor', 'taylor@music.com', 'hash_artist_3', N'Taylor Swift', N'Taylor Swift', 'US', 'artist'),
(4, 'artist_adele', 'adele@music.com', 'hash_artist_4', N'Adele Adkins', N'Adele', 'UK', 'artist'),
(5, 'alice_user', 'alice@example.com', 'hash_user_5', N'Alice Wonderland', N'Alice', 'US', 'user'),
(6, 'bob_user', 'bob@example.com', 'hash_user_6', N'Bob Johnson', N'Bob', 'CA', 'user'),
(7, 'charlie_user', 'charlie@example.com', 'hash_user_7', N'Charlie Puth', N'Charlie', 'US', 'user'),
(8, 'david_user', 'david@example.com', 'hash_user_8', N'David Guetta', N'David', 'FR', 'user'),
(9, 'eva_user', 'eva@example.com', 'hash_user_9', N'Eva Green', N'Eva', 'FR', 'user'),
(10, 'frank_user', 'frank@example.com', 'hash_user_10', N'Frank Sinatra', N'Frank', 'US', 'user'),
(11, 'grace_user', 'grace@example.com', 'hash_user_11', N'Grace Kelly', N'Grace', 'US', 'user'),
(12, 'hannah_user', 'hannah@example.com', 'hash_user_12', N'Hannah Montana', N'Hannah', 'US', 'user'),
(13, 'ivan_user', 'ivan@example.com', 'hash_user_13', N'Ivan Petrov', N'Ivan', 'RU', 'user'),
(14, 'judy_user', 'judy@example.com', 'hash_user_14', N'Judy Garland', N'Judy', 'US', 'user'),
(15, 'kyle_user', 'kyle@example.com', 'hash_user_15', N'Kyle Minogue', N'Kyle', 'AU', 'user'),
(16, 'lisa_user', 'lisa@example.com', 'hash_user_16', N'Lisa Manoban', N'Lisa', 'KR', 'user'),
(17, 'mike_user', 'mike@example.com', 'hash_user_17', N'Mike Shinoda', N'Mike', 'US', 'user'),
(18, 'nina_user', 'nina@example.com', 'hash_user_18', N'Nina Simone', N'Nina', 'US', 'user'),
(19, 'oscar_user', 'oscar@example.com', 'hash_user_19', N'Oscar Wilde', N'Oscar', 'IE', 'user'),
(20, 'paul_user', 'paul@example.com', 'hash_user_20', N'Paul McCartney', N'Paul', 'UK', 'user');
SET IDENTITY_INSERT users OFF;
GO
