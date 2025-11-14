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
-- password : 12345 -> 8cb2237d0679ca88db6464eac60da96345513964 (SHA1)
SET IDENTITY_INSERT users ON;
INSERT INTO users (user_id, user_username, user_email, user_password_hash, user_fullname, user_display_name, user_avatar_url, user_bio, user_country_code, user_role)
VALUES
(1, 'admin_user', 'admin@music.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Admin Manager', N'Admin', 'https://example.com/avatars/admin.png', 'Admin bio', 'VN', 'admin'),
(2, 'artist_son_tung', 'sontung@music.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Thanh Tùng', N'Sơn Tùng M-TP', 'https://example.com/avatars/sontung.png', 'Sơn Tùng M-TP bio', 'VN', 'artist'),
(3, 'artist_taylor', 'taylor@music.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Taylor Swift', N'Taylor Swift', 'https://example.com/avatars/taylor.png','Taylor Swift bio', 'US', 'artist'),
(4, 'artist_adele', 'adele@music.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Adele Adkins', N'Adele', 'https://example.com/avatars/adele.png','Adele bio', 'US', 'artist'),
(5, 'chuong_user', 'chuong@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Nguyên Chương', N'Alice', 'https://example.com/avatars/chuong.png', 'chuong bio', 'VN', 'user'),
(6, 'phong_user', 'phong@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Phạm Thanh Phong', N'Bob', 'https://example.com/avatars/phong.png', 'phong bio', 'VN', 'user'),
(7, 'quoc_user', 'quoc@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Văn Quốc', N'Charlie', 'https://example.com/avatars/quoc.png', 'quoc bio', 'VN', 'user'),
(8, 'thu_user', 'thu@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Lê Phương Anh Thư', N'David', 'https://example.com/avatars/thu.png', 'thu bio', 'VN', 'user'),
(9, 'duy_user', 'duy@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Duy', N'Eva', 'https://example.com/avatars/duy.png', 'duy bio', 'VN', 'user'),
(10, 'sang_user', 'sang@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Văn Sang', N'Frank', 'https://example.com/avatars/sang.png', 'sang bio', 'VN', 'user'),
(11, 'tu_user', 'tu@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Thị Tú', N'Grace', 'https://example.com/avatars/tu.png', 'tu bio', 'VN', 'user'),
(12, 'van_user', 'van@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Thị Vân', N'Hannah', 'https://example.com/avatars/van.png', 'van bio', 'VN', 'user'),
(13, 'khoa_user', 'khoa@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Trần Đăng Khoa', N'Ivan', 'https://example.com/avatars/khoa.png', 'khoa bio', 'VN', 'user'),
(14, 'quyen_user', 'quyen@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Thị Quyến', N'Judy', 'https://example.com/avatars/quyen.png', 'quyen bio', 'VN', 'user'),
(15, 'dat_user', 'dat@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Đình Đạt', N'Kyle', 'https://example.com/avatars/dat.png', 'dat bio', 'VN', 'user'),
(16, 'khanh_user', 'khanh@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Trắng Khánh', N'Lisa', 'https://example.com/avatars/khanh.png', 'khanh bio', 'VN', 'user'),
(17, 'bich_user', 'bich@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Trần Thị Bích', N'Mike', 'https://example.com/avatars/bich.png', 'bich bio', 'VN', 'user'),
(18, 'anhthu_user', 'anhthu@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Anh Thư', N'Nina', 'https://example.com/avatars/anhthu.png', 'anhthu bio', 'VN', 'user'),
(19, 'huy_user', 'huy@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Huy', N'Oscar', 'https://example.com/avatars/huy.png', 'huy bio', 'VN', 'user'),
(20, 'khiem_user', 'khiem@example.com', '8cb2237d0679ca88db6464eac60da96345513964', N'Nguyễn Khiêm', N'Paul', 'https://example.com/avatars/khiem.png', 'khiem bio', 'VN', 'user');
SET IDENTITY_INSERT users OFF;
GO

-----------------------------------------------------
-- 3. Bảng user_tokens (Yêu cầu: 20 dòng)
-----------------------------------------------------

INSERT INTO user_tokens (token_hash, token_expires_at, token_device_info, user_id, token_revoked, token_ip_address)
VALUES
('token_hash_1', DATEADD(day, 30, GETDATE()), 'Chrome on Windows', 1, 0, '192.168.1.1'),
('token_hash_2', DATEADD(day, 7, GETDATE()), 'iOS App 1.2.3', 2, 0, '203.0.113.5'),
('token_hash_3', DATEADD(day, 7, GETDATE()), 'Android App 2.0', 3, 0, '198.51.100.10'),
('token_hash_4', DATEADD(day, 30, GETDATE()), 'Safari on macOS', 4, 0, '203.0.113.11'),
('token_hash_5', DATEADD(hour, 12, GETDATE()), 'Firefox on Linux', 5, 0, '192.168.1.2'),
('token_hash_6', DATEADD(day, 1, GETDATE()), 'iOS App 1.2.4', 6, 0, '203.0.113.15'),
('token_hash_7', DATEADD(day, 7, GETDATE()), 'Samsung Browser', 7, 0, '198.51.100.20'),
('token_hash_8', DATEADD(day, 30, GETDATE()), 'Chrome on macOS', 8, 0, '203.0.113.21'),
('token_hash_9', DATEADD(hour, 6, GETDATE()), 'Edge on Windows', 9, 0, '192.168.1.3'),
('token_hash_10', DATEADD(day, 7, GETDATE()), 'iPad App 1.2.3', 10, 0, '203.0.113.25'),
('token_hash_11', DATEADD(day, 30, GETDATE()), 'Pixel App 2.1', 11, 0, '198.51.100.30'),
('token_hash_12', DATEADD(hour, 24, GETDATE()), 'Opera on macOS', 12, 0, '203.0.113.31'),
('token_hash_13', DATEADD(day, 7, GETDATE()), 'Firefox on Windows', 13, 0, '192.168.1.4'),
('token_hash_14', DATEADD(day, -1, GETDATE()), 'iOS App 1.2.0 (Revoked)', 14, 1, '203.0.113.35'),
('token_hash_15', DATEADD(day, 30, GETDATE()), 'Xiaomi Browser', 15, 0, '198.51.100.40'),
('token_hash_16', DATEADD(day, 7, GETDATE()), 'Macbook (Revoked)', 16, 1, '203.0.113.41'),
('token_hash_17', DATEADD(day, 60, GETDATE()), 'Windows PC', 17, 0, '192.168.1.5'),
('token_hash_18', DATEADD(day, 7, GETDATE()), 'iOS App 1.3.0', 18, 0, '203.0.113.45'),
('token_hash_19', DATEADD(day, 30, GETDATE()), 'Android Tablet', 19, 0, '198.51.100.50'),
('token_hash_20', DATEADD(day, 1, GETDATE()), 'Mac Mini', 20, 0, '203.0.113.51');
GO

-----------------------------------------------------
-- 4. Bảng artists (Yêu cầu: 20 dòng)
-----------------------------------------------------
SET IDENTITY_INSERT artists ON;
INSERT INTO artists (artist_id, artist_name, artist_avatar_url, artist_country_code, artist_description, artist_user_id)
VALUES
(1, N'Sơn Tùng M-TP', 'https://example.com/avatars/son_tung.png', 'VN', N'Ca sĩ, nhạc sĩ, kiêm diễn viên.', 2),
(2, N'Taylor Swift', 'https://example.com/avatars/taylor_swift.png', 'US', N'Ca sĩ, nhạc sĩ nhạc Pop/Country.', 3),
(3, N'Adele', 'https://example.com/avatars/adele.png', 'UK', N'Ca sĩ, nhạc sĩ nhạc Soul/Pop.', 4),
(4, N'BTS', 'https://example.com/avatars/bts.png', 'KR', N'Nhóm nhạc nam Hàn Quốc.', NULL),
(5, N'BLACKPINK', 'https://example.com/avatars/blackpink.png', 'KR', N'Nhóm nhạc nữ Hàn Quốc.', NULL),
(6, N'Ed Sheeran', 'https://example.com/avatars/ed_sheeran.png', 'UK', N'Ca sĩ, nhạc sĩ nhạc Pop.', NULL),
(7, N'Ariana Grande', 'https://example.com/avatars/ariana_grande.png', 'US', N'Ca sĩ, nhạc sĩ nhạc Pop/R&B.', NULL),
(8, N'The Weeknd', 'https://example.com/avatars/the_weeknd.png', 'CA', N'Ca sĩ, nhạc sĩ nhạc R&B/Pop.', NULL),
(9, N'Drake', 'https://example.com/avatars/drake.png', 'CA', N'Rapper, ca sĩ, nhạc sĩ.', NULL),
(10, N'Billie Eilish', 'https://example.com/avatars/billie_eilish.png', 'US', N'Ca sĩ, nhạc sĩ nhạc Pop.', NULL),
(11, N'Hà Anh Tuấn', 'https://example.com/avatars/ha_anh_tuan.png', 'VN', N'Ca sĩ nhạc Pop/Ballad Việt Nam.', NULL),
(12, N'Vũ Cát Tường', 'https://example.com/avatars/vu_cat_tuong.png', 'VN', N'Ca sĩ, nhạc sĩ Việt Nam.', NULL),
(13, N'Mỹ Tâm', 'https://example.com/avatars/my_tam.png', 'VN', N'Nữ ca sĩ nhạc Pop/Ballad hàng đầu Việt Nam.', NULL),
(14, N'Đen Vâu', 'https://example.com/avatars/den_vau.png', 'VN', N'Rapper, nhạc sĩ.', NULL),
(15, N'Michael Jackson', 'https://example.com/avatars/michael_jackson.png', 'US', N'Vua nhạc Pop.', NULL),
(16, N'Hoàng Thùy Linh', 'https://example.com/avatars/hoang_thuy_linh.png', 'VN', N'Ca sĩ nhạc Pop, V-Pop.', NULL),
(17, N'Bích Phương', 'https://example.com/avatars/bich_phuong.png', 'VN', N'Ca sĩ nhạc Pop, V-Pop.', NULL),
(18, N'Soobin', 'https://example.com/avatars/soobin.png', 'VN', N'Ca sĩ, nhạc sĩ R&B, Pop.', NULL),
(19, N'Jack (J97)', 'https://example.com/avatars/jack.png', 'VN', N'Ca sĩ, nhạc sĩ.', NULL),
(20, N'Hồ Ngọc Hà', 'https://example.com/avatars/ho_ngoc_ha.png', 'VN', N'Ca sĩ, diễn viên, người mẫu.', NULL),
(21, N'Trần Quốc An', 'https://example.com/avatars/antran100.png', 'VN', N'Ca sĩ, nhạc sĩ.', NULL);

SET IDENTITY_INSERT artists OFF;
GO
-----------------------------------------------------
-- 5. Bảng albums (Yêu cầu: 20 dòng)
-- Tương ứng với 20 nghệ sĩ đầu tiên (ID 1-20)
-----------------------------------------------------
SET IDENTITY_INSERT albums ON;
INSERT INTO albums (album_id, album_title, album_release_date, album_cover_url, artist_id)
VALUES
(101, N'm-tp', '2017-04-01', 'https://example.com/albums/m-tp.png', 1),
(102, N'Reputation', '2017-11-10', 'https://example.com/albums/reputation.png', 2),
(103, N'30', '2021-11-19', 'https://example.com/albums/30.png', 3),
(104, N'Map of the Soul: 7', '2020-02-21', 'https://example.com/albums/map_of_the_soul_7.png', 4),
(105, N'The Album', '2020-10-02', 'https://example.com/albums/the_album.png', 5),
(106, N'÷ (Divide)', '2017-03-03', 'https://example.com/albums/divide.png', 6),
(107, N'Thank U, Next', '2019-02-08', 'https://example.com/albums/thank_u_next.png', 7),
(108, N'After Hours', '2020-03-20', 'https://example.com/albums/after_hours.png', 8),
(109, N'Scorpion', '2018-06-29', 'https://example.com/albums/scorpion.png', 9),
(110, N'When We All Fall Asleep, Where Do We Go?', '2019-03-29', 'https://example.com/albums/when_we_all_fall_asleep.png', 10),
(111, N'See Sing Share', '2016-12-20', 'https://example.com/albums/see_sing_share.png', 11),
(112, N'Stardom', '2017-10-27', 'https://example.com/albums/stardom.png', 12),
(113, N'Tâm 9', '2017-12-03', 'https://example.com/albums/tam_9.png', 13),
(114, N'Lối Nhỏ (Tuyển tập)', '2020-11-20', 'https://example.com/albums/loi_nho.png', 14),
(115, N'Thriller', '1982-11-30', 'https://example.com/albums/thriller.png', 15),
(116, N'Hoàng', '2019-10-20', 'https://example.com/albums/hoang.png', 16),
(117, N'Dramatic', '2018-12-21', 'https://example.com/albums/dramatic.png', 17),
(118, N'The Playah', '2020-12-15', 'https://example.com/albums/the_playah.png', 18),
(119, N'Sóng Gió (Tuyển tập)', '2019-12-20', 'https://example.com/albums/song_gio.png', 19),
(120, N'Love Songs Collection', '2014-09-15', 'https://example.com/albums/love_songs_collection.png', 20);
SET IDENTITY_INSERT albums OFF;
GO

-----------------------------------------------------
-- 6. Bảng songs (Yêu cầu: 20+ dòng, làm 25 dòng)
-----------------------------------------------------
-----------------------------------------------------
-- 6. Bảng songs (Yêu cầu: 40 dòng)
-- 2 bài hát cho mỗi album (20 albums * 2 songs)
-- [ĐÃ SỬA LỖI CÚ PHÁP]
-----------------------------------------------------
SET IDENTITY_INSERT songs ON;
INSERT INTO songs (song_id, song_title, song_release_date, song_duration_seconds, song_description, song_audio_url,song_cover_url, album_id, song_play_count, song_is_explicit)
VALUES
-- Album 101 (Sơn Tùng M-TP)
(1001, N'Lạc Trôi', '2017-01-01', 245, 'Bài hát Lạc Trôi của Sơn Tùng M-TP', 'http://audio.com/s1001.mp3', 'https://example.com/songs/lac_troi.png', 101, 0, 0),
(1002, N'Nơi Này Có Anh', '2017-02-14', 260, 'Bài hát Nơi Này Có Anh của Sơn Tùng M-TP', 'http://audio.com/s1002.mp3', 'https://example.com/songs/noi_nay_co_anh.png', 101, 0, 0),
-- Album 102 (Taylor Swift)
(1003, N'Look What You Made Me Do', '2017-08-24', 211, 'Bài hát Look What You Made Me Do của Taylor Swift', 'http://audio.com/s1003.mp3', 'https://example.com/songs/look_what_you_made_me_do.png', 102, 0, 1),
(1004, N'Delicate', '2018-03-12', 232, 'Bài hát Delicate của Taylor Swift', 'http://audio.com/s1004.mp3', 'https://example.com/songs/delicate.png', 102, 0, 0),
-- Album 103 (Adele)
(1005, N'Easy on Me', '2021-10-15', 224, 'Bài hát Easy on Me của Adele', 'http://audio.com/s1005.mp3', 'https://example.com/songs/easy_on_me.png', 103, 0, 0),
(1006, N'Oh My God', '2021-11-19', 225, 'Bài hát Oh My God của Adele', 'http://audio.com/s1006.mp3', 'https://example.com/songs/oh_my_god.png', 103, 0, 0),
-- Album 104 (BTS)
(1007, N'Boy With Luv', '2019-04-12', 229, 'Bài hát Boy With Luv của BTS', 'http://audio.com/s1007.mp3', 'https://example.com/songs/boy_with_luv.png', 104, 0, 0),
(1008, N'ON', '2020-02-21', 246, 'Bài hát ON của BTS', 'http://audio.com/s1008.mp3', 'https://example.com/songs/on.png', 104, 0, 0),
-- Album 105 (BLACKPINK)
(1009, N'How You Like That', '2020-06-26', 181, 'Bài hát How You Like That của BLACKPINK', 'http://audio.com/s1009.mp3', 'https://example.com/songs/how_you_like_that.png', 105, 0, 0),
(1010, N'Lovesick Girls', '2020-10-02', 192, 'Bài hát Lovesick Girls của BLACKPINK', 'http://audio.com/s1010.mp3', 'https://example.com/songs/lovesick_girls.png', 105, 0, 0),
-- Album 106 (Ed Sheeran)
(1011, N'Shape of You', '2017-01-06', 233, 'Bài hát Shape of You của Ed Sheeran', 'http://audio.com/s1011.mp3', 'https://example.com/songs/shape_of_you.png', 106, 0, 0),
(1012, N'Perfect', '2017-09-26', 263, 'Bài hát Perfect của Ed Sheeran', 'http://audio.com/s1012.mp3', 'https://example.com/songs/perfect.png', 106, 0, 0),
-- Album 107 (Ariana Grande)
(1013, N'7 rings', '2019-01-18', 178, 'Bài hát 7 rings của Ariana Grande', 'http://audio.com/s1013.mp3', 'https://example.com/songs/7_rings.png', 107, 0, 1),
(1014, N'thank u, next', '2018-11-03', 207, 'Bài hát thank u, next của Ariana Grande', 'http://audio.com/s1014.mp3', 'https://example.com/songs/thank_u_next.png', 107, 0, 1),
-- Album 108 (The Weeknd)
(1015, N'Blinding Lights', '2019-11-29', 200, 'Bài hát Blinding Lights của The Weeknd', 'http://audio.com/s1015.mp3', 'https://example.com/songs/blinding_lights.png', 108, 0, 0),
(1016, N'Save Your Tears', '2020-08-09', 215, 'Bài hát Save Your Tears của The Weeknd', 'http://audio.com/s1016.mp3', 'https://example.com/songs/save_your_tears.png', 108, 0, 0),
-- Album 109 (Drake)
(1017, N'God''s Plan', '2018-01-19', 198, 'Bài hát God''s Plan của Drake', 'http://audio.com/s1017.mp3', 'https://example.com/songs/gods_plan.png', 109, 0, 1),
(1018, N'In My Feelings', '2018-07-10', 217, 'Bài hát In My Feelings của Drake', 'http://audio.com/s1018.mp3', 'https://example.com/songs/in_my_feelings.png', 109, 0, 1),
-- Album 110 (Billie Eilish)
(1019, N'bad guy', '2019-03-29', 194, 'Bài hát bad guy của Billie Eilish', 'http://audio.com/s1019.mp3', 'https://example.com/songs/bad_guy.png', 110, 0, 0),
(1020, N'when the party''s over', '2018-10-17', 196, 'Bài hát when the party''s over của Billie Eilish', 'http://audio.com/s1020.mp3', 'https://example.com/songs/when_the_partys_over.png', 110, 0, 0),
-- Album 111 (Hà Anh Tuấn)
(1021, N'Tháng Mấy Em Nhớ Anh?', '2016-12-20', 300, 'Bài hát Tháng Mấy Em Nhớ Anh? của Hà Anh Tuấn', 'http://audio.com/s1021.mp3', 'https://example.com/songs/thang_may_em_nho_anh.png', 111, 0, 0),
(1022, N'Người Tình Mùa Đông', '2016-12-20', 280, 'Bài hát Người Tình Mùa Đông của Hà Anh Tuấn', 'http://audio.com/s1022.mp3', 'https://example.com/songs/nguoi_tinh_mua_dong.png', 111, 0, 0),
-- Album 112 (Vũ Cát Tường)
(1023, N'Vài Lần Đón Đưa', '2017-10-27', 250, 'Bài hát Vài Lần Đón Đưa của Vũ Cát Tường', 'http://audio.com/s1023.mp3', 'https://example.com/songs/vai_lan_don_dua.png', 112, 0, 0),
(1024, N'Mơ', '2016-12-16', 230, 'Bài hát Mơ của Vũ Cát Tường', 'http://audio.com/s1024.mp3', 'https://example.com/songs/mo.png', 112, 0, 0),
-- Album 113 (Mỹ Tâm)
(1025, N'Người Hãy Quên Em Đi', '2017-12-03', 225, 'Bài hát Người Hãy Quên Em Đi của Mỹ Tâm', 'http://audio.com/s1025.mp3', 'https://example.com/songs/nguoi_hay_quen_em_di.png', 113, 0, 0),
(1026, N'Đâu Chỉ Riêng Em', '2017-07-17', 240, 'Bài hát Đâu Chỉ Riêng Em của Mỹ Tâm', 'http://audio.com/s1026.mp3', 'https://example.com/songs/dau_chi_rieng_em.png', 113, 0, 0),
-- Album 114 (Đen Vâu)
(1027, N'Lối Nhỏ', '2019-10-20', 300, 'Bài hát Lối Nhỏ của Đen Vâu', 'http://audio.com/s1027.mp3', 'https://example.com/songs/loi_nho.png', 114, 0, 0),
(1028, N'Bài Này Chill Phết', '2019-05-23', 280, 'Bài hát Bài Này Chill Phết của Đen Vâu', 'http://audio.com/s1028.mp3', 'https://example.com/songs/bai_nay_chill_phet.png', 114, 0, 0),
-- Album 115 (Michael Jackson)
(1029, N'Billie Jean', '1983-01-02', 294, 'Bài hát Billie Jean của Michael Jackson', 'http://audio.com/s1029.mp3', 'https://example.com/songs/billie_jean.png', 115, 0, 0),
(1030, N'Thriller', '1983-11-12', 357, 'Bài hát Thriller của Michael Jackson', 'http://audio.com/s1030.mp3', 'https://example.com/songs/thriller.png', 115, 0, 0),
-- Album 116 (Hoàng Thùy Linh)
(1031, N'Để Mị Nói Cho Mà Nghe', '2019-06-19', 200, 'Bài hát Để Mị Nói Cho Mà Nghe của Hoàng Thùy Linh', 'http://audio.com/s1031.mp3', 'https://example.com/songs/de_mi_noi_cho_ma_nghe.png', 116, 0, 0),
(1032, N'Tứ Phủ', '2019-08-16', 220, 'Bài hát Tứ Phủ của Hoàng Thùy Linh', 'http://audio.com/s1032.mp3', 'https://example.com/songs/tu_phu.png', 116, 0, 0),
-- Album 117 (Bích Phương)
(1033, N'Bùa Yêu', '2018-05-12', 240, 'Bài hát Bùa Yêu của Bích Phương', 'http://audio.com/s1033.mp3', 'https://example.com/songs/bua_yeu.png', 117, 0, 0),
(1034, N'Chị Ngả Em Nâng', '2018-11-21', 230, 'Bài hát Chị Ngả Em Nâng của Bích Phương', 'http://audio.com/s1034.mp3', 'https://example.com/songs/chi_nga_em_nang.png', 117, 0, 0),
-- Album 118 (Soobin)
(1035, N'Trò Chơi', '2020-11-21', 215, 'Bài hát Trò Chơi của Soobin', 'http://audio.com/s1035.mp3', 'https://example.com/songs/tro_choi.png', 118, 0, 0),
(1036, N'BlackJack', '2020-12-15', 230, 'Bài hát BlackJack của Soobin', 'http://audio.com/s1036.mp3', 'https://example.com/songs/blackjack.png', 118, 0, 1),
-- Album 119 (Jack (J97))
(1037, N'Sóng Gió', '2019-07-12', 250, 'Bài hát Sóng Gió của Jack (J97)', 'http://audio.com/s1037.mp3', 'https://example.com/songs/song_gio.png', 119, 0, 0),
(1038, N'Bạc Phận', '2019-04-16', 270, 'Bài hát Bạc Phận của Jack (J97)', 'http://audio.com/s1038.mp3', 'https://example.com/songs/bac_phan.png', 119, 0, 0),
-- Album 120 (Hồ Ngọc Hà)
(1039, N'Cả Một Trời Thương Nhớ', '2017-08-25', 280, 'Bài hát Cả Một Trời Thương Nhớ của Hồ Ngọc Hà', 'http://audio.com/s1039.mp3', 'https://example.com/songs/ca_mot_troi_thuong_nho.png', 120, 0, 0),
(1040, N'Gửi Người Yêu Cũ', '2016-10-24', 290, 'Bài hát Gửi Người Yêu Cũ của Hồ Ngọc Hà', 'http://audio.com/s1040.mp3', 'https://example.com/songs/gui_nguoi_yeu_cu.png', 120, 0, 0);
SET IDENTITY_INSERT songs OFF;
GO

SET IDENTITY_INSERT songs ON;
INSERT INTO songs (song_id, song_title, song_release_date, song_duration_seconds, song_audio_url, song_cover_url, song_is_explicit, song_play_count)
VALUES
(1041, N'An Trần 100', '2020-01-01', 210, 'http://audio.com/s1041.mp3', 'https://example.com/songs/an_tran_100.png', 0, 23123),
(1042, N'Bài Hát Mới', '2020-02-01', 220, 'http://audio.com/s1042.mp3', 'https://example.com/songs/bai_hat_moi.png', 0, 2342),
(1043, N'Giai Điệu Cuộc Sống', '2020-03-01', 230, 'http://audio.com/s1043.mp3', 'https://example.com/songs/giai_dieu_cuoc_song.png', 0, 123),
(1044, N'Khúc Ca Yêu Thương', '2020-04-01', 240, 'http://audio.com/s1044.mp3', 'https://example.com/songs/khuc_ca_yeu_thuong.png', 0, 982347983),
(1045, N'Niềm Vui Mới', '2020-05-01', 250, 'http://audio.com/s1045.mp3', 'https://example.com/songs/niem_vui_moi.png', 0, 234234);

SET IDENTITY_INSERT songs OFF;
GO
-----------------------------------------------------
-- 7. Bảng lyrics (Yêu cầu: 45 dòng)
-- Cung cấp lời bài hát cho tất cả các bài hát từ 1001-1045
-----------------------------------------------------
INSERT INTO lyrics (song_id, lyric_text)
VALUES
-- Lyrics cho 25 bài hát đầu tiên
(1001, N'Người đi bên em, qua bao yêu thương... (Lạc Trôi)'),
(1002, N'Nắm tay anh thật chặt, giữ tay anh thật lâu... (Nơi Này Có Anh)'),
(1003, N'I''m sorry, the old Taylor can''t come to the phone right now... (Look What You Made Me Do)'),
(1004, N'Is it cool that I said all that? Is it chill that you''re in my head?... (Delicate)'),
(1005, N'Go easy on me, baby... I was still a child... (Easy on Me)'),
(1006, N'Oh my God, I can''t believe it... (Oh My God)'),
(1007, N'Oh my my my, oh my my my... (Boy With Luv)'),
(1008, N'Win no matter what... (ON)'),
(1009, N'Look at you, now look at me... (How You Like That)'),
(1010, N'We are the lovesick girls... (Lovesick Girls)'),
(1011, N'I''m in love with the shape of you... (Shape of You)'),
(1012, N'Baby, I''m dancing in the dark... (Perfect)'),
(1013, N'I see it, I like it, I want it, I got it... (7 rings)'),
(1014, N'I said, thank u, next... (thank u, next)'),
(1015, N'I''ve been tryna call... (Blinding Lights)'),
(1016, N'I''m in love with the shape of you... (Save Your Tears)'),
(1017, N'I been movin'' calm, don''t start no trouble with me... (God''s Plan)'),
(1018, N'Kiki, do you love me? Are you riding?... (In My Feelings)'),
(1019, N'I''m the bad guy, duh... (bad guy)'),
(1020, N'Don''t you know I''m no good for you?... (when the party''s over)'),
(1021, N'Tháng mấy em nhớ anh, tháng mấy em nhớ anh?... (Tháng Mấy Em Nhớ Anh?)'),
(1022, N'Người Tình Mùa Đông, em ơi... (Người Tình Mùa Đông)'),
(1023, N'Vài lần đón đưa, anh đã quen... (Vài Lần Đón Đưa)'),
(1024, N'Mơ, một giấc mơ... (Mơ)'),
(1025, N'Người hãy quên em đi, và đừng yêu em nữa... (Người Hãy Quên Em Đi)'),

-- Lyrics cho các bài hát còn lại (1026-1045)
(1026, N'Em đâu có biết, anh đã lừa dối em... (Đâu Chỉ Riêng Em)'),
(1027, N'Tìm một lối nhỏ, đưa nhau về... (Lối Nhỏ)'),
(1028, N'Cuộc đời này, bài này chill phết... (Bài Này Chill Phết)'),
(1029, N'Billie Jean is not my lover... She''s just a girl... (Billie Jean)'),
(1030, N'''Cause this is thriller, thriller night... (Thriller)'),
(1031, N'Để Mị nói cho mà nghe. Tết này Mị không về... (Để Mị Nói Cho Mà Nghe)'),
(1032, N'Lòng Mị tựa cung đàn. Tứ phủ, Mị nương... (Tứ Phủ)'),
(1033, N'Nếu anh có bùa yêu, bùa đâu... (Bùa Yêu)'),
(1034, N'Chị ngả em nâng. Một nhà, một nhà... (Chị Ngả Em Nâng)'),
(1035, N'Đây là trò chơi, hay là tình yêu... (Trò Chơi)'),
(1036, N'BlackJack, on the table... (BlackJack)'),
(1037, N'Sóng gió, bủa vây. Thương em, anh đây... (Sóng Gió)'),
(1038, N'Bạc phận, duyên trời. Lỡ làng, em ơi... (Bạc Phận)'),
(1039, N'Cả một trời thương nhớ. Cả một trời... (Cả Một Trời Thương Nhớ)'),
(1040, N'Gửi người yêu cũ, một lời... (Gửi Người Yêu Cũ)'),
(1041, N'Đây là An Trần 100, một bài hát mới... (An Trần 100)'),
(1042, N'Bài hát mới, cho cuộc đời mới... (Bài Hát Mới)'),
(1045, N'Niềm vui mới, mỗi ngày. Hạnh phúc... (Niềm Vui Mới)');
GO

-----------------------------------------------------
-- 8. Bảng song_artists (Yêu cầu: 20+ dòng)
-----------------------------------------------------
-----------------------------------------------------
-- 8. Bảng song_artists
-- Đã cập nhật để khớp với 45 bài hát (1001-1045)
-- Đã cập nhật 'role' để tuân thủ CHECK constraint ('primary', 'featured')
-----------------------------------------------------
INSERT INTO song_artists (song_id, artist_id, role)
VALUES
-- Album 101 (Sơn Tùng M-TP - 1)
(1001, 1, 'primary'), 
(1002, 1, 'primary'),
-- Album 102 (Taylor Swift - 2)
(1003, 2, 'primary'), 
(1004, 2, 'primary'),
(1004, 6, 'featured'), -- (Thêm mới) Giả sử Ed Sheeran (6) hợp tác
-- Album 103 (Adele - 3)
(1005, 3, 'primary'), 
(1006, 3, 'primary'),
-- Album 104 (BTS - 4)
(1007, 4, 'primary'), 
(1007, 7, 'featured'), -- Ariana Grande (7) hợp tác với vai trò 'featured'
(1008, 4, 'primary'),
-- Album 105 (BLACKPINK - 5)
(1009, 5, 'primary'), 
(1010, 5, 'primary'),
-- Album 106 (Ed Sheeran - 6)
(1011, 6, 'primary'), 
(1012, 6, 'primary'),
-- Album 107 (Ariana Grande - 7)
(1013, 7, 'primary'), 
(1014, 7, 'primary'),
-- Album 108 (The Weeknd - 8)
(1015, 8, 'primary'), 
(1016, 8, 'primary'),
-- Album 109 (Drake - 9)
(1017, 9, 'primary'), 
(1018, 9, 'primary'),
-- Album 110 (Billie Eilish - 10)
(1019, 10, 'primary'), 
(1020, 10, 'primary'),
-- Album 111 (Hà Anh Tuấn - 11)
(1021, 11, 'primary'), 
(1022, 11, 'primary'),
-- Album 112 (Vũ Cát Tường - 12)
(1023, 12, 'primary'), 
(1024, 12, 'primary'),
-- Album 113 (Mỹ Tâm - 13)
(1025, 13, 'primary'), 
(1026, 13, 'primary'),
-- Album 114 (Đen Vâu - 14)
(1027, 14, 'primary'), -- Đen Vâu (14) là nghệ sĩ chính
(1028, 14, 'primary'), -- Đen Vâu (14) là nghệ sĩ chính
(1028, 17, 'featured'), -- Bích Phương (17) hợp tác với vai trò 'featured'
-- Album 115 (Michael Jackson - 15)
(1029, 15, 'primary'), 
(1030, 15, 'primary'),
-- Album 116 (Hoàng Thùy Linh - 16)
(1031, 16, 'primary'), 
(1031, 14, 'featured'), -- (Thêm mới) Giả sử Đen Vâu (14) hợp tác rap
(1032, 16, 'primary'),
-- Album 117 (Bích Phương - 17)
(1033, 17, 'primary'), 
(1034, 17, 'primary'),
-- Album 118 (Soobin - 18)
(1035, 18, 'primary'), 
(1036, 18, 'primary'),
(1036, 14, 'featured'), -- Đen Vâu (14) hợp tác với vai trò 'featured'
-- Album 119 (Jack (J97) - 19)
(1037, 19, 'primary'), 
(1038, 19, 'primary'),
-- Album 120 (Hồ Ngọc Hà - 20)
(1039, 20, 'primary'), 
(1040, 20, 'primary'),

-- Các bài hát "Single" (1041-1045)
-- Giả sử các bài này là của Trần Quốc An (Nghệ sĩ 21)
(1041, 21, 'primary'),
(1042, 21, 'primary'),
(1043, 21, 'primary'),
(1044, 21, 'primary'),
(1045, 21, 'primary');
GO

-----------------------------------------------------
-- 9. Bảng genres
-- Chèn các thể loại nhạc
-----------------------------------------------------
SET IDENTITY_INSERT genres ON;
INSERT INTO genres (genre_id, genre_name)
VALUES
(1, N'V-Pop'),
(2, N'Pop'),
(3, N'Synth-pop'),
(4, N'Soul'),
(5, N'K-Pop'),
(6, N'EDM'),
(7, N'R&B'),
(8, N'Hip-hop'),
(9, N'Alt-pop'),
(10, N'Ballad'),
(11, N'Funk'),
(12, N'Folk-pop');
SET IDENTITY_INSERT genres OFF;
GO

-----------------------------------------------------
-- 10. Bảng song_genres
-- Liên kết 45 bài hát với các thể loại
-----------------------------------------------------
INSERT INTO song_genres (song_id, genre_id)
VALUES
-- (1) V-Pop, (2) Pop, (3) Synth-pop, (4) Soul, (5) K-Pop, (6) EDM, (7) R&B, (8) Hip-hop, (9) Alt-pop, (10) Ballad, (11) Funk, (12) Folk-pop

-- Album 101 (Sơn Tùng M-TP)
(1001, 1), (1001, 2), -- Lạc Trôi (V-Pop, Pop)
(1002, 1), (1002, 2), -- Nơi Này Có Anh (V-Pop, Pop)
-- Album 102 (Taylor Swift)
(1003, 2), (1003, 3), -- Look What You Made Me Do (Pop, Synth-pop)
(1004, 2), (1004, 3), -- Delicate (Pop, Synth-pop)
-- Album 103 (Adele)
(1005, 2), (1005, 4), -- Easy on Me (Pop, Soul)
(1006, 2), (1006, 4), -- Oh My God (Pop, Soul)
-- Album 104 (BTS)
(1007, 5), (1007, 2), -- Boy With Luv (K-Pop, Pop)
(1008, 5), (1008, 8), -- ON (K-Pop, Hip-hop)
-- Album 105 (BLACKPINK)
(1009, 5), (1009, 6), -- How You Like That (K-Pop, EDM)
(1010, 5), (1010, 2), -- Lovesick Girls (K-Pop, Pop)
-- Album 106 (Ed Sheeran)
(1011, 2), -- Shape of You (Pop)
(1012, 2), (1012, 10), -- Perfect (Pop, Ballad)
-- Album 107 (Ariana Grande)
(1013, 2), (1013, 7), -- 7 rings (Pop, R&B)
(1014, 2), (1014, 7), -- thank u, next (Pop, R&B)
-- Album 108 (The Weeknd)
(1015, 7), (1015, 3), -- Blinding Lights (R&B, Synth-pop)
(1016, 7), (1016, 3), -- Save Your Tears (R&B, Synth-pop)
-- Album 109 (Drake)
(1017, 8), (1017, 7), -- God's Plan (Hip-hop, R&B)
(1018, 8), (1018, 7), -- In My Feelings (Hip-hop, R&B)
-- Album 110 (Billie Eilish)
(1019, 2), (1019, 9), -- bad guy (Pop, Alt-pop)
(1020, 2), (1020, 9), -- when the party's over (Pop, Alt-pop)
-- Album 111 (Hà Anh Tuấn)
(1021, 1), (1021, 10), -- Tháng Mấy Em Nhớ Anh? (V-Pop, Ballad)
(1022, 1), (1022, 10), -- Người Tình Mùa Đông (V-Pop, Ballad)
-- Album 112 (Vũ Cát Tường)
(1023, 1), (1023, 10), -- Vài Lần Đón Đưa (V-Pop, Ballad)
(1024, 1), (1024, 10), -- Mơ (V-Pop, Ballad)
-- Album 113 (Mỹ Tâm)
(1025, 1), (1025, 2), -- Người Hãy Quên Em Đi (V-Pop, Pop)
(1026, 1), (1026, 10), -- Đâu Chỉ Riêng Em (V-Pop, Ballad)
-- Album 114 (Đen Vâu)
(1027, 1), (1027, 8), -- Lối Nhỏ (V-Pop, Hip-hop)
(1028, 1), (1028, 8), -- Bài Này Chill Phết (V-Pop, Hip-hop)
-- Album 115 (Michael Jackson)
(1029, 2), (1029, 7), (1029, 11), -- Billie Jean (Pop, R&B, Funk)
(1030, 2), (1030, 7), (1030, 11), -- Thriller (Pop, R&B, Funk)
-- Album 116 (Hoàng Thùy Linh)
(1031, 1), (1031, 12), -- Để Mị Nói Cho Mà Nghe (V-Pop, Folk-pop)
(1032, 1), (1032, 12), -- Tứ Phủ (V-Pop, Folk-pop)
-- Album 117 (Bích Phương)
(1033, 1), (1033, 2), -- Bùa Yêu (V-Pop, Pop)
(1034, 1), (1034, 2), -- Chị Ngả Em Nâng (V-Pop, Pop)
-- Album 118 (Soobin)
(1035, 1), (1035, 7), -- Trò Chơi (V-Pop, R&B)
(1036, 1), (1036, 7), (1036, 8), -- BlackJack (V-Pop, R&B, Hip-hop)
-- Album 119 (Jack (J97))
(1037, 1), (1037, 2), -- Sóng Gió (V-Pop, Pop)
(1038, 1), (1038, 2), -- Bạc Phận (V-Pop, Pop)
-- Album 120 (Hồ Ngọc Hà)
(1039, 1), (1039, 10), -- Cả Một Trời Thương Nhớ (V-Pop, Ballad)
(1040, 1), (1040, 10), -- Gửi Người Yêu Cũ (V-Pop, Ballad)
-- Các bài hát "Single" (Trần Quốc An)
(1041, 1), (1041, 10), -- (V-Pop, Ballad)
(1042, 1), (1042, 10), -- (V-Pop, Ballad)
(1043, 1), (1043, 10), -- (V-Pop, Ballad)
(1044, 1), (1044, 10), -- (V-Pop, Ballad)
(1045, 1), (1045, 10); -- (V-Pop, Ballad)
GO

-----------------------------------------------------
-- 11. Bảng playlists
-- Cập nhật: Tạo 20 playlists mẫu
-----------------------------------------------------
SET IDENTITY_INSERT playlists ON;
INSERT INTO playlists (playlist_id, playlist_name, playlist_description, playlist_is_public)
VALUES
-- 6 playlists cũ
(1, N'Nhạc V-Pop Hay Nhất', N'Tuyển tập các bài V-Pop đỉnh nhất', 1),
(2, N'US-UK Hits 2020s', N'Pop hits from US-UK artists', 1),
(3, N'Tâm Trạng Buồn (Private)', N'Dành cho những ngày mưa...', 0),
(4, N'Rap Việt Cực Chất', N'Những track rap hay nhất', 1),
(5, N'Chill Tối Cuối Tuần', N'Nhạc nhẹ nhàng thư giãn', 0),
(6, N'Collaborative Party Mix', N'Playlist chung của team', 1),

-- 14 playlists mới
(7, N'K-Pop Daebak', N'BLACKPINK & BTS Hits', 1),
(8, N'Old But Gold (US)', N'Michael Jackson & 80s', 1),
(9, N'Nhạc Sĩ Trần Quốc An', N'Tuyển tập các bài hát của Trần Quốc An', 1),
(10, N'Workout Hype', N'EDM & Pop cho phòng gym', 0),
(11, N'Acoustic Vietnam', N'Nhạc V-Pop mộc mạc', 1),
(12, N'EDM Party', N'Quẩy lên!', 1),
(13, N'R&B Classics', N'R&B US/UK hay nhất', 0),
(14, N'Hip-Hop US', N'Drake & The Weeknd', 1),
(15, N'Indie Chill', N'Nhạc Indie US-UK', 0),
(16, N'Taylor''s Eras', N'Tất cả bài hát của Taylor Swift', 1),
(17, N'Adele''s Favorites', N'Tuyển tập nhạc Soul', 0),
(18, N'BTS Army', N'Dành cho fan BTS', 1),
(19, N'BLACKPINK Zone', N'Dành cho Blinks', 1),
(20, N'MJ Forever', N'King of Pop', 1);
SET IDENTITY_INSERT playlists OFF;
GO

-----------------------------------------------------
-- 12. Bảng user_playlists
-- Cập nhật: 25 liên kết (Owners, Contributors, Viewers)
-- Users: (5) chuong, (6) phong, (7) quoc, (8) thu, (9) duy, (10) sang, (11) tu... (20) khiem
-----------------------------------------------------
INSERT INTO user_playlists (user_id, playlist_id, role)
VALUES
-- 1. Gán chủ sở hữu (Owners) - 6 playlists cũ
(5, 1, 'owner'), -- User chuong_user (5) sở hữu 'Nhạc V-Pop Hay Nhất' (1)
(6, 2, 'owner'), -- User phong_user (6) sở hữu 'US-UK Hits 2020s' (2)
(5, 3, 'owner'), -- User chuong_user (5) cũng sở hữu 'Tâm Trạng Buồn' (3)
(7, 4, 'owner'), -- User quoc_user (7) sở hữu 'Rap Việt Cực Chất' (4)
(8, 5, 'owner'), -- User thu_user (8) sở hữu 'Chill Tối Cuối Tuần' (5)
(9, 6, 'owner'), -- User duy_user (9) sở hữu 'Collaborative Party Mix' (6)

-- 2. Gán các vai trò khác (Collaborators/Viewers) - 3 liên kết cũ
(6, 1, 'contributor'), -- User phong_user (6) là 'contributor' của 'Nhạc V-Pop' (1)
(10, 6, 'contributor'), -- User sang_user (10) là 'contributor' của 'Party Mix' (6)
(11, 6, 'viewer'),      -- User tu_user (11) là 'viewer' của 'Party Mix' (6)

-- 3. Gán chủ sở hữu cho 14 playlists mới
(10, 7, 'owner'),  -- sang_user (10) sở hữu 'K-Pop Daebak' (7)
(11, 8, 'owner'),  -- tu_user (11) sở hữu 'Old But Gold (US)' (8)
(12, 9, 'owner'),  -- van_user (12) sở hữu 'Nhạc Sĩ Trần Quốc An' (9)
(13, 10, 'owner'), -- khoa_user (13) sở hữu 'Workout Hype' (10)
(14, 11, 'owner'), -- quyen_user (14) sở hữu 'Acoustic Vietnam' (11)
(15, 12, 'owner'), -- dat_user (15) sở hữu 'EDM Party' (12)
(16, 13, 'owner'), -- khanh_user (16) sở hữu 'R&B Classics' (13)
(17, 14, 'owner'), -- bich_user (17) sở hữu 'Hip-Hop US' (14)
(18, 15, 'owner'), -- anhthu_user (18) sở hữu 'Indie Chill' (15)
(19, 16, 'owner'), -- huy_user (19) sở hữu 'Taylor's Eras' (16)
(20, 17, 'owner'), -- khiem_user (20) sở hữu 'Adele's Favorites' (17)
(6, 18, 'owner'),  -- phong_user (6) sở hữu 'BTS Army' (18)
(6, 19, 'owner'),  -- phong_user (6) sở hữu 'BLACKPINK Zone' (19)
(11, 20, 'owner'), -- tu_user (11) sở hữu 'MJ Forever' (20)

-- 4. Thêm 'contributor' và 'viewer' để đạt 20+ dòng
(5, 2, 'viewer'),      -- chuong_user (5) xem 'US-UK Hits 2020s' (2)
(7, 1, 'viewer'),      -- quoc_user (7) xem 'Nhạc V-Pop Hay Nhất' (1)
(8, 1, 'contributor'), -- thu_user (8) góp nhạc cho 'Nhạc V-Pop Hay Nhất' (1)
(9, 2, 'contributor'), -- duy_user (9) góp nhạc cho 'US-UK Hits 2020s' (2)
(12, 4, 'viewer'),     -- van_user (12) xem 'Rap Việt Cực Chất' (4)
(13, 5, 'contributor'); -- khoa_user (13) góp nhạc cho 'Chill Tối Cuối Tuần' (5)
GO
-----------------------------------------------------
-- 13. Bảng playlist_songs
-- Cập nhật: Thêm 30 bài hát vào các playlists mới, tổng 53 dòng
-----------------------------------------------------
INSERT INTO playlist_songs (playlist_id, song_id, track_order)
VALUES
-- Playlist 1: Nhạc V-Pop Hay Nhất (4 bài)
(1, 1001, 1), -- Lạc Trôi
(1, 1031, 2), -- Để Mị Nói Cho Mà Nghe
(1, 1033, 3), -- Bùa Yêu
(1, 1037, 4), -- Sóng Gió

-- Playlist 2: US-UK Hits 2020s (5 bài)
(2, 1003, 1), -- Look What You Made Me Do
(2, 1005, 2), -- Easy on Me
(2, 1011, 3), -- Shape of You
(2, 1015, 4), -- Blinding Lights
(2, 1019, 5), -- bad guy

-- Playlist 3: Tâm Trạng Buồn (Private) (4 bài)
(3, 1021, 1), -- Tháng Mấy Em Nhớ Anh?
(3, 1026, 2), -- Đâu Chỉ Riêng Em
(3, 1040, 3), -- Gửi Người Yêu Cũ
(3, 1005, 4), -- Easy on Me

-- Playlist 4: Rap Việt Cực Chất (3 bài)
(4, 1027, 1), -- Lối Nhỏ
(4, 1028, 2), -- Bài Này Chill Phết
(4, 1036, 3), -- BlackJack

-- Playlist 5: Chill Tối Cuối Tuần (3 bài)
(5, 1028, 1), -- Bài Này Chill Phết
(5, 1023, 2), -- Vài Lần Đón Đưa
(5, 1024, 3), -- Mơ

-- Playlist 6: Collaborative Party Mix (4 bài)
(6, 1009, 1), -- How You Like That
(6, 1013, 2), -- 7 rings
(6, 1030, 3), -- Thriller
(6, 1017, 4), -- God's Plan

-- Thêm 30 bài hát cho 14 playlists mới
-- Playlist 7: K-Pop Daebak
(7, 1007, 1), -- Boy With Luv
(7, 1009, 2), -- How You Like That
(7, 1010, 3), -- Lovesick Girls

-- Playlist 8: Old But Gold (US)
(8, 1029, 1), -- Billie Jean
(8, 1030, 2), -- Thriller

-- Playlist 9: Nhạc Sĩ Trần Quốc An
(9, 1041, 1), 
(9, 1042, 2), 
(9, 1043, 3), 
(9, 1044, 4), 
(9, 1045, 5), 

-- Playlist 10: Workout Hype
(10, 1009, 1), -- How You Like That
(10, 1019, 2), -- bad guy

-- Playlist 11: Acoustic Vietnam
(11, 1021, 1), -- Tháng Mấy Em Nhớ Anh?
(11, 1024, 2), -- Mơ

-- Playlist 12: EDM Party
(12, 1001, 1), -- Lạc Trôi
(12, 1009, 2), -- How You Like That

-- Playlist 13: R&B Classics
(13, 1013, 1), -- 7 rings
(13, 1015, 2), -- Blinding Lights
(13, 1016, 3), -- Save Your Tears

-- Playlist 14: Hip-Hop US
(14, 1017, 1), -- God's Plan
(14, 1018, 2), -- In My Feelings

-- Playlist 15: Indie Chill
(15, 1020, 1), -- when the party's over

-- Playlist 16: Taylor's Eras
(16, 1003, 1), -- Look What You Made Me Do
(16, 1004, 2), -- Delicate

-- Playlist 17: Adele's Favorites
(17, 1005, 1), 
(17, 1006, 2), 

-- Playlist 18: BTS Army
(18, 1007, 1), 
(18, 1008, 2), 

-- Playlist 19: BLACKPINK Zone
(19, 1009, 1), 
(19, 1010, 2), 

-- Playlist 20: MJ Forever
(20, 1029, 1), 
(20, 1030, 2);
GO

-----------------------------------------------------
-- 14. Bảng listens
-- Chèn 200 lượt nghe thủ công
-- Trigger trg_increment_song_play_count sẽ tự động
-- cập nhật song_play_count trong bảng songs.
-----------------------------------------------------

SET NOCOUNT ON;
GO

INSERT INTO listens (listen_user_id, listen_song_id, listened_at, listened_seconds, ip_address, device_info)
VALUES
-- Lượt 1-10
(5, 1001, DATEADD(minute, -10, GETDATE()), 120, '192.168.1.10', 'Chrome on Windows'),
(6, 1003, DATEADD(minute, -12, GETDATE()), 210, '203.0.113.25', 'iOS App 1.3.0'),
(7, 1009, DATEADD(minute, -15, GETDATE()), 180, '172.16.0.5', 'Android App 2.1'),
(8, 1021, DATEADD(minute, -20, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(5, 1033, DATEADD(minute, -25, GETDATE()), 240, '198.51.100.14', 'Firefox on Linux'),
(9, 1041, DATEADD(minute, -30, GETDATE()), 210, '192.168.1.10', 'Chrome on Windows'),
(10, 1011, DATEADD(minute, -32, GETDATE()), 233, '203.0.113.25', 'iOS App 1.3.0'),
(11, 1015, DATEADD(minute, -35, GETDATE()), 200, '172.16.0.5', 'Android App 2.1'),
(12, 1027, DATEADD(minute, -40, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(13, 1029, DATEADD(minute, -45, GETDATE()), 294, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 11-20
(5, 1001, DATEADD(minute, -50, GETDATE()), 245, '192.168.1.10', 'Chrome on Windows'),
(7, 1003, DATEADD(minute, -52, GETDATE()), 211, '203.0.113.25', 'iOS App 1.3.0'),
(8, 1009, DATEADD(minute, -55, GETDATE()), 181, '172.16.0.5', 'Android App 2.1'),
(9, 1021, DATEADD(minute, -60, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(6, 1033, DATEADD(minute, -65, GETDATE()), 240, '198.51.100.14', 'Firefox on Linux'),
(10, 1041, DATEADD(minute, -70, GETDATE()), 210, '192.168.1.10', 'Chrome on Windows'),
(11, 1011, DATEADD(minute, -72, GETDATE()), 233, '203.0.113.25', 'iOS App 1.3.0'),
(12, 1015, DATEADD(minute, -75, GETDATE()), 200, '172.16.0.5', 'Android App 2.1'),
(13, 1027, DATEADD(minute, -80, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(14, 1029, DATEADD(minute, -85, GETDATE()), 294, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 21-30
(15, 1002, DATEADD(minute, -90, GETDATE()), 260, '192.168.1.10', 'Chrome on Windows'),
(16, 1004, DATEADD(minute, -92, GETDATE()), 232, '203.0.113.25', 'iOS App 1.3.0'),
(17, 1010, DATEADD(minute, -95, GETDATE()), 192, '172.16.0.5', 'Android App 2.1'),
(18, 1022, DATEADD(minute, -100, GETDATE()), 280, '10.0.0.1', 'Safari on macOS'),
(19, 1034, DATEADD(minute, -105, GETDATE()), 230, '198.51.100.14', 'Firefox on Linux'),
(20, 1042, DATEADD(minute, -110, GETDATE()), 220, '192.168.1.10', 'Chrome on Windows'),
(5, 1012, DATEADD(minute, -112, GETDATE()), 263, '203.0.113.25', 'iOS App 1.3.0'),
(6, 1016, DATEADD(minute, -115, GETDATE()), 215, '172.16.0.5', 'Android App 2.1'),
(7, 1028, DATEADD(minute, -120, GETDATE()), 280, '10.0.0.1', 'Safari on macOS'),
(8, 1030, DATEADD(minute, -125, GETDATE()), 357, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 31-40
(9, 1005, DATEADD(minute, -130, GETDATE()), 224, '192.168.1.10', 'Chrome on Windows'),
(10, 1006, DATEADD(minute, -132, GETDATE()), 225, '203.0.113.25', 'iOS App 1.3.0'),
(11, 1013, DATEADD(minute, -135, GETDATE()), 178, '172.16.0.5', 'Android App 2.1'),
(12, 1023, DATEADD(minute, -140, GETDATE()), 250, '10.0.0.1', 'Safari on macOS'),
(13, 1035, DATEADD(minute, -145, GETDATE()), 215, '198.51.100.14', 'Firefox on Linux'),
(14, 1043, DATEADD(minute, -150, GETDATE()), 230, '192.168.1.10', 'Chrome on Windows'),
(15, 1014, DATEADD(minute, -152, GETDATE()), 207, '203.0.113.25', 'iOS App 1.3.0'),
(16, 1017, DATEADD(minute, -155, GETDATE()), 198, '172.16.0.5', 'Android App 2.1'),
(17, 1031, DATEADD(minute, -160, GETDATE()), 200, '10.0.0.1', 'Safari on macOS'),
(18, 1032, DATEADD(minute, -165, GETDATE()), 220, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 41-50
(19, 1007, DATEADD(minute, -170, GETDATE()), 229, '192.168.1.10', 'Chrome on Windows'),
(20, 1008, DATEADD(minute, -172, GETDATE()), 246, '203.0.113.25', 'iOS App 1.3.0'),
(5, 1018, DATEADD(minute, -175, GETDATE()), 217, '172.16.0.5', 'Android App 2.1'),
(6, 1024, DATEADD(minute, -180, GETDATE()), 230, '10.0.0.1', 'Safari on macOS'),
(7, 1036, DATEADD(minute, -185, GETDATE()), 230, '198.51.100.14', 'Firefox on Linux'),
(8, 1044, DATEADD(minute, -190, GETDATE()), 240, '192.168.1.10', 'Chrome on Windows'),
(9, 1019, DATEADD(minute, -192, GETDATE()), 194, '203.0.113.25', 'iOS App 1.3.0'),
(10, 1020, DATEADD(minute, -195, GETDATE()), 196, '172.16.0.5', 'Android App 2.1'),
(11, 1037, DATEADD(minute, -200, GETDATE()), 250, '10.0.0.1', 'Safari on macOS'),
(12, 1038, DATEADD(minute, -205, GETDATE()), 270, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 51-60
(13, 1025, DATEADD(minute, -210, GETDATE()), 225, '192.168.1.10', 'Chrome on Windows'),
(14, 1026, DATEADD(minute, -212, GETDATE()), 240, '203.0.113.25', 'iOS App 1.3.0'),
(15, 1039, DATEADD(minute, -215, GETDATE()), 280, '172.16.0.5', 'Android App 2.1'),
(16, 1040, DATEADD(minute, -220, GETDATE()), 290, '10.0.0.1', 'Safari on macOS'),
(17, 1045, DATEADD(minute, -225, GETDATE()), 250, '198.51.100.14', 'Firefox on Linux'),
(18, 1001, DATEADD(minute, -230, GETDATE()), 245, '192.168.1.10', 'Chrome on Windows'),
(19, 1003, DATEADD(minute, -232, GETDATE()), 211, '203.0.113.25', 'iOS App 1.3.0'),
(20, 1009, DATEADD(minute, -235, GETDATE()), 181, '172.16.0.5', 'Android App 2.1'),
(5, 1021, DATEADD(minute, -240, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(6, 1033, DATEADD(minute, -245, GETDATE()), 240, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 61-70
(7, 1041, DATEADD(minute, -250, GETDATE()), 210, '192.168.1.10', 'Chrome on Windows'),
(8, 1011, DATEADD(minute, -252, GETDATE()), 233, '203.0.113.25', 'iOS App 1.3.0'),
(9, 1015, DATEADD(minute, -255, GETDATE()), 200, '172.16.0.5', 'Android App 2.1'),
(10, 1027, DATEADD(minute, -260, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(11, 1029, DATEADD(minute, -265, GETDATE()), 294, '198.51.100.14', 'Firefox on Linux'),
(12, 1001, DATEADD(minute, -270, GETDATE()), 245, '192.168.1.10', 'Chrome on Windows'),
(13, 1003, DATEADD(minute, -272, GETDATE()), 211, '203.0.113.25', 'iOS App 1.3.0'),
(14, 1009, DATEADD(minute, -275, GETDATE()), 181, '172.16.0.5', 'Android App 2.1'),
(15, 1021, DATEADD(minute, -280, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(16, 1033, DATEADD(minute, -285, GETDATE()), 240, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 71-80
(17, 1041, DATEADD(minute, -290, GETDATE()), 210, '192.168.1.10', 'Chrome on Windows'),
(18, 1011, DATEADD(minute, -292, GETDATE()), 233, '203.0.113.25', 'iOS App 1.3.0'),
(19, 1015, DATEADD(minute, -295, GETDATE()), 200, '172.16.0.5', 'Android App 2.1'),
(20, 1027, DATEADD(minute, -300, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(5, 1029, DATEADD(minute, -305, GETDATE()), 294, '198.51.100.14', 'Firefox on Linux'),
(6, 1002, DATEADD(minute, -310, GETDATE()), 260, '192.168.1.10', 'Chrome on Windows'),
(7, 1004, DATEADD(minute, -312, GETDATE()), 232, '203.0.113.25', 'iOS App 1.3.0'),
(8, 1010, DATEADD(minute, -315, GETDATE()), 192, '172.16.0.5', 'Android App 2.1'),
(9, 1022, DATEADD(minute, -320, GETDATE()), 280, '10.0.0.1', 'Safari on macOS'),
(10, 1034, DATEADD(minute, -325, GETDATE()), 230, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 81-90
(11, 1042, DATEADD(minute, -330, GETDATE()), 220, '192.168.1.10', 'Chrome on Windows'),
(12, 1012, DATEADD(minute, -332, GETDATE()), 263, '203.0.113.25', 'iOS App 1.3.0'),
(13, 1016, DATEADD(minute, -335, GETDATE()), 215, '172.16.0.5', 'Android App 2.1'),
(14, 1028, DATEADD(minute, -340, GETDATE()), 280, '10.0.0.1', 'Safari on macOS'),
(15, 1030, DATEADD(minute, -345, GETDATE()), 357, '198.51.100.14', 'Firefox on Linux'),
(16, 1005, DATEADD(minute, -350, GETDATE()), 224, '192.168.1.10', 'Chrome on Windows'),
(17, 1006, DATEADD(minute, -352, GETDATE()), 225, '203.0.113.25', 'iOS App 1.3.0'),
(18, 1013, DATEADD(minute, -355, GETDATE()), 178, '172.16.0.5', 'Android App 2.1'),
(19, 1023, DATEADD(minute, -360, GETDATE()), 250, '10.0.0.1', 'Safari on macOS'),
(20, 1035, DATEADD(minute, -365, GETDATE()), 215, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 91-100
(5, 1043, DATEADD(minute, -370, GETDATE()), 230, '192.168.1.10', 'Chrome on Windows'),
(6, 1014, DATEADD(minute, -372, GETDATE()), 207, '203.0.113.25', 'iOS App 1.3.0'),
(7, 1017, DATEADD(minute, -375, GETDATE()), 198, '172.16.0.5', 'Android App 2.1'),
(8, 1031, DATEADD(minute, -380, GETDATE()), 200, '10.0.0.1', 'Safari on macOS'),
(9, 1032, DATEADD(minute, -385, GETDATE()), 220, '198.51.100.14', 'Firefox on Linux'),
(10, 1007, DATEADD(minute, -390, GETDATE()), 229, '192.168.1.10', 'Chrome on Windows'),
(11, 1008, DATEADD(minute, -392, GETDATE()), 246, '203.0.113.25', 'iOS App 1.3.0'),
(12, 1018, DATEADD(minute, -395, GETDATE()), 217, '172.16.0.5', 'Android App 2.1'),
(13, 1024, DATEADD(minute, -400, GETDATE()), 230, '10.0.0.1', 'Safari on macOS'),
(14, 1036, DATEADD(minute, -405, GETDATE()), 230, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 101-110
(15, 1044, DATEADD(minute, -410, GETDATE()), 240, '192.168.1.10', 'Chrome on Windows'),
(16, 1019, DATEADD(minute, -412, GETDATE()), 194, '203.0.113.25', 'iOS App 1.3.0'),
(17, 1020, DATEADD(minute, -415, GETDATE()), 196, '172.16.0.5', 'Android App 2.1'),
(18, 1037, DATEADD(minute, -420, GETDATE()), 250, '10.0.0.1', 'Safari on macOS'),
(19, 1038, DATEADD(minute, -425, GETDATE()), 270, '198.51.100.14', 'Firefox on Linux'),
(20, 1025, DATEADD(minute, -430, GETDATE()), 225, '192.168.1.10', 'Chrome on Windows'),
(5, 1026, DATEADD(minute, -432, GETDATE()), 240, '203.0.113.25', 'iOS App 1.3.0'),
(6, 1039, DATEADD(minute, -435, GETDATE()), 280, '172.16.0.5', 'Android App 2.1'),
(7, 1040, DATEADD(minute, -440, GETDATE()), 290, '10.0.0.1', 'Safari on macOS'),
(8, 1045, DATEADD(minute, -445, GETDATE()), 250, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 111-120
(9, 1001, DATEADD(minute, -450, GETDATE()), 245, '192.168.1.10', 'Chrome on Windows'),
(10, 1003, DATEADD(minute, -452, GETDATE()), 211, '203.0.113.25', 'iOS App 1.3.0'),
(11, 1009, DATEADD(minute, -455, GETDATE()), 181, '172.16.0.5', 'Android App 2.1'),
(12, 1021, DATEADD(minute, -460, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(13, 1033, DATEADD(minute, -465, GETDATE()), 240, '198.51.100.14', 'Firefox on Linux'),
(14, 1041, DATEADD(minute, -470, GETDATE()), 210, '192.168.1.10', 'Chrome on Windows'),
(15, 1011, DATEADD(minute, -472, GETDATE()), 233, '203.0.113.25', 'iOS App 1.3.0'),
(16, 1015, DATEADD(minute, -475, GETDATE()), 200, '172.16.0.5', 'Android App 2.1'),
(17, 1027, DATEADD(minute, -480, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(18, 1029, DATEADD(minute, -485, GETDATE()), 294, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 121-130
(19, 1001, DATEADD(minute, -490, GETDATE()), 245, '192.168.1.10', 'Chrome on Windows'),
(20, 1003, DATEADD(minute, -492, GETDATE()), 211, '203.0.113.25', 'iOS App 1.3.0'),
(5, 1009, DATEADD(minute, -495, GETDATE()), 181, '172.16.0.5', 'Android App 2.1'),
(6, 1021, DATEADD(minute, -500, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(7, 1033, DATEADD(minute, -505, GETDATE()), 240, '198.51.100.14', 'Firefox on Linux'),
(8, 1041, DATEADD(minute, -510, GETDATE()), 210, '192.168.1.10', 'Chrome on Windows'),
(9, 1011, DATEADD(minute, -512, GETDATE()), 233, '203.0.113.25', 'iOS App 1.3.0'),
(10, 1015, DATEADD(minute, -515, GETDATE()), 200, '172.16.0.5', 'Android App 2.1'),
(11, 1027, DATEADD(minute, -520, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(12, 1029, DATEADD(minute, -525, GETDATE()), 294, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 131-140
(13, 1002, DATEADD(minute, -530, GETDATE()), 260, '192.168.1.10', 'Chrome on Windows'),
(14, 1004, DATEADD(minute, -532, GETDATE()), 232, '203.0.113.25', 'iOS App 1.3.0'),
(15, 1010, DATEADD(minute, -535, GETDATE()), 192, '172.16.0.5', 'Android App 2.1'),
(16, 1022, DATEADD(minute, -540, GETDATE()), 280, '10.0.0.1', 'Safari on macOS'),
(17, 1034, DATEADD(minute, -545, GETDATE()), 230, '198.51.100.14', 'Firefox on Linux'),
(18, 1042, DATEADD(minute, -550, GETDATE()), 220, '192.168.1.10', 'Chrome on Windows'),
(19, 1012, DATEADD(minute, -552, GETDATE()), 263, '203.0.113.25', 'iOS App 1.3.0'),
(20, 1016, DATEADD(minute, -555, GETDATE()), 215, '172.16.0.5', 'Android App 2.1'),
(5, 1028, DATEADD(minute, -560, GETDATE()), 280, '10.0.0.1', 'Safari on macOS'),
(6, 1030, DATEADD(minute, -565, GETDATE()), 357, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 141-150
(7, 1005, DATEADD(minute, -570, GETDATE()), 224, '192.168.1.10', 'Chrome on Windows'),
(8, 1006, DATEADD(minute, -572, GETDATE()), 225, '203.0.113.25', 'iOS App 1.3.0'),
(9, 1013, DATEADD(minute, -575, GETDATE()), 178, '172.16.0.5', 'Android App 2.1'),
(10, 1023, DATEADD(minute, -580, GETDATE()), 250, '10.0.0.1', 'Safari on macOS'),
(11, 1035, DATEADD(minute, -585, GETDATE()), 215, '198.51.100.14', 'Firefox on Linux'),
(12, 1043, DATEADD(minute, -590, GETDATE()), 230, '192.168.1.10', 'Chrome on Windows'),
(13, 1014, DATEADD(minute, -592, GETDATE()), 207, '203.0.113.25', 'iOS App 1.3.0'),
(14, 1017, DATEADD(minute, -595, GETDATE()), 198, '172.16.0.5', 'Android App 2.1'),
(15, 1031, DATEADD(minute, -600, GETDATE()), 200, '10.0.0.1', 'Safari on macOS'),
(16, 1032, DATEADD(minute, -605, GETDATE()), 220, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 151-160
(17, 1007, DATEADD(minute, -610, GETDATE()), 229, '192.168.1.10', 'Chrome on Windows'),
(18, 1008, DATEADD(minute, -612, GETDATE()), 246, '203.0.113.25', 'iOS App 1.3.0'),
(19, 1018, DATEADD(minute, -615, GETDATE()), 217, '172.16.0.5', 'Android App 2.1'),
(20, 1024, DATEADD(minute, -620, GETDATE()), 230, '10.0.0.1', 'Safari on macOS'),
(5, 1036, DATEADD(minute, -625, GETDATE()), 230, '198.51.100.14', 'Firefox on Linux'),
(6, 1044, DATEADD(minute, -630, GETDATE()), 240, '192.168.1.10', 'Chrome on Windows'),
(7, 1019, DATEADD(minute, -632, GETDATE()), 194, '203.0.113.25', 'iOS App 1.3.0'),
(8, 1020, DATEADD(minute, -635, GETDATE()), 196, '172.16.0.5', 'Android App 2.1'),
(9, 1037, DATEADD(minute, -640, GETDATE()), 250, '10.0.0.1', 'Safari on macOS'),
(10, 1038, DATEADD(minute, -645, GETDATE()), 270, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 161-170
(11, 1025, DATEADD(minute, -650, GETDATE()), 225, '192.168.1.10', 'Chrome on Windows'),
(12, 1026, DATEADD(minute, -652, GETDATE()), 240, '203.0.113.25', 'iOS App 1.3.0'),
(13, 1039, DATEADD(minute, -655, GETDATE()), 280, '172.16.0.5', 'Android App 2.1'),
(14, 1040, DATEADD(minute, -660, GETDATE()), 290, '10.0.0.1', 'Safari on macOS'),
(15, 1045, DATEADD(minute, -665, GETDATE()), 250, '198.51.100.14', 'Firefox on Linux'),
(16, 1001, DATEADD(minute, -670, GETDATE()), 245, '192.168.1.10', 'Chrome on Windows'),
(17, 1003, DATEADD(minute, -672, GETDATE()), 211, '203.0.113.25', 'iOS App 1.3.0'),
(18, 1009, DATEADD(minute, -675, GETDATE()), 181, '172.16.0.5', 'Android App 2.1'),
(19, 1021, DATEADD(minute, -680, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(20, 1033, DATEADD(minute, -685, GETDATE()), 240, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 171-180
(5, 1041, DATEADD(minute, -690, GETDATE()), 210, '192.168.1.10', 'Chrome on Windows'),
(6, 1011, DATEADD(minute, -692, GETDATE()), 233, '203.0.113.25', 'iOS App 1.3.0'),
(7, 1015, DATEADD(minute, -695, GETDATE()), 200, '172.16.0.5', 'Android App 2.1'),
(8, 1027, DATEADD(minute, -700, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(9, 1029, DATEADD(minute, -705, GETDATE()), 294, '198.51.100.14', 'Firefox on Linux'),
(10, 1001, DATEADD(minute, -710, GETDATE()), 245, '192.168.1.10', 'Chrome on Windows'),
(11, 1003, DATEADD(minute, -712, GETDATE()), 211, '203.0.113.25', 'iOS App 1.3.0'),
(12, 1009, DATEADD(minute, -715, GETDATE()), 181, '172.16.0.5', 'Android App 2.1'),
(13, 1021, DATEADD(minute, -720, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(14, 1033, DATEADD(minute, -725, GETDATE()), 240, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 181-190
(15, 1041, DATEADD(minute, -730, GETDATE()), 210, '192.168.1.10', 'Chrome on Windows'),
(16, 1011, DATEADD(minute, -732, GETDATE()), 233, '203.0.113.25', 'iOS App 1.3.0'),
(17, 1015, DATEADD(minute, -735, GETDATE()), 200, '172.16.0.5', 'Android App 2.1'),
(18, 1027, DATEADD(minute, -740, GETDATE()), 300, '10.0.0.1', 'Safari on macOS'),
(19, 1029, DATEADD(minute, -745, GETDATE()), 294, '198.51.100.14', 'Firefox on Linux'),
(20, 1002, DATEADD(minute, -750, GETDATE()), 260, '192.168.1.10', 'Chrome on Windows'),
(5, 1004, DATEADD(minute, -752, GETDATE()), 232, '203.0.113.25', 'iOS App 1.3.0'),
(6, 1010, DATEADD(minute, -755, GETDATE()), 192, '172.16.0.5', 'Android App 2.1'),
(7, 1022, DATEADD(minute, -760, GETDATE()), 280, '10.0.0.1', 'Safari on macOS'),
(8, 1034, DATEADD(minute, -765, GETDATE()), 230, '198.51.100.14', 'Firefox on Linux'),

-- Lượt 191-200
(9, 1042, DATEADD(minute, -770, GETDATE()), 220, '192.168.1.10', 'Chrome on Windows'),
(10, 1012, DATEADD(minute, -772, GETDATE()), 263, '203.0.113.25', 'iOS App 1.3.0'),
(11, 1016, DATEADD(minute, -775, GETDATE()), 215, '172.16.0.5', 'Android App 2.1'),
(12, 1028, DATEADD(minute, -780, GETDATE()), 280, '10.0.0.1', 'Safari on macOS'),
(13, 1030, DATEADD(minute, -785, GETDATE()), 357, '198.51.100.14', 'Firefox on Linux'),
(14, 1005, DATEADD(minute, -790, GETDATE()), 224, '192.168.1.10', 'Chrome on Windows'),
(15, 1006, DATEADD(minute, -792, GETDATE()), 225, '203.0.113.25', 'iOS App 1.3.0'),
(16, 1013, DATEADD(minute, -795, GETDATE()), 178, '172.16.0.5', 'Android App 2.1'),
(17, 1023, DATEADD(minute, -800, GETDATE()), 250, '10.0.0.1', 'Safari on macOS'),
(18, 1035, DATEADD(minute, -805, GETDATE()), 215, '198.51.100.14', 'Firefox on Linux');
GO

-----------------------------------------------------
-- 15. Bảng user_like_songs (Yêu cầu: 20+ dòng)
-----------------------------------------------------
INSERT INTO user_like_songs (user_id, song_id)
VALUES
(5, 1001), (5, 1003), (5, 1009), (5, 1011), (5, 1014),
(6, 1002), (6, 1007), (6, 1008), (6, 1010),
(7, 1011), (7, 1012), (7, 1013),
(8, 1014), (8, 1019),
(9, 1015), (9, 1007),
(10, 1016), (10, 1024),
(11, 1017), (11, 1018),
(12, 1020), (12, 1021), (12, 1022), (12, 1023),
(13, 1024), (14, 1025), (15, 1001), (16, 1009),
(14, 1012), (15, 1013),
(16, 1014),
(17, 1015), (18, 1016), (19, 1017), (20, 1018);
GO

-----------------------------------------------------
-- 16. Bảng user_follow_artists (Yêu cầu: 20+ dòng)
-----------------------------------------------------
INSERT INTO user_follow_artists (user_id, artist_id)
VALUES
(5, 1), (5, 2), (5, 3), (5, 5), (5, 13),
(6, 4), (6, 5), (6, 6),
(7, 2), (7, 6), (7, 7), (7, 8),
(9, 1), (9, 11), (9, 12),
(10, 10), (10, 18),
(11, 11), (12, 14), (13, 16), (14, 17), (15, 19), (16, 5),
(17, 6), (18, 14), (19, 7), (20, 19);
GO

-----------------------------------------------------
-- 17. Bảng user_follow_users (Yêu cầu: 20+ dòng)
-----------------------------------------------------
INSERT INTO user_follow_users (follower_id, following_id)
VALUES
(5, 6), (5, 7), (5, 8), (5, 9), (5, 10),
(6, 5), (6, 7), (6, 8), (6, 9), (6, 10),
(7, 5), (7, 6), (7, 8), (7, 9), (7, 10),
(8, 5), (8, 6), (8, 7), (8, 9), (8, 10),
(9, 5), (9, 6), (9, 7), (9, 8), (9, 10),
(10, 5), (10, 6), (10, 7), (10, 8), (10, 9),
(12, 11), (13, 11), (14, 11), (15, 11), (16, 11),
(17, 11), (18, 11), (19, 11), (20, 11);
GO

-----------------------------------------------------
-- 18. Bảng user_like_albums (Yêu cầu: 20+ dòng)
-----------------------------------------------------
INSERT INTO user_like_albums (user_id, album_id)
VALUES
(5, 101), (5, 102), (5, 103), (5, 105), (5, 113),
(6, 104), (6, 105), (6, 106),
(7, 102), (7, 106), (7, 107), (7, 108),
(8, 108), (8, 109), (8, 113),
(9, 101), (9, 111), (9, 112),
(10, 110), (10, 118),
(11, 111), (12, 114), (13, 116), (14, 117), (15, 119), (16, 105);
GO

-----------------------------------------------------
-- 19. Bảng user_recommendations (Yêu cầu: 20+ dòng)
-----------------------------------------------------
INSERT INTO user_recommendations (user_id, song_id, score, reason)
VALUES
(5, 1007, 0.9, N'Vì bạn thích K-Pop (BLACKPINK)'),
(5, 1011, 0.85, N'Vì bạn thích Pop (Taylor Swift)'),
(6, 1009, 0.9, N'Vì bạn thích K-Pop (BTS)'),
(6, 1012, 0.8, N'Vì bạn thích Pop (Ed Sheeran)'),
(7, 1013, 0.95, N'Vì bạn thích Pop (Taylor, Ed)'),
(7, 1014, 0.9, N'Vì bạn thích R&B/Pop (Ariana)'),
(8, 1019, 0.92, N'Vì bạn thích Electronic/Pop (The Weeknd)'),
(9, 1001, 0.88, N'Vì bạn thích V-Pop (Hà Anh Tuấn)'),
(10, 1024, 0.9, N'Vì bạn thích Alternative (Billie Eilish)'),
(11, 1001, 0.95, N'Vì bạn thích V-Pop (Hà Anh Tuấn)'),
(12, 1021, 0.8, N'Vì bạn thích Pop kinh điển (Queen)'),
(13, 1023, 0.9, N'Vì bạn thích Rock (Linkin Park)'),
(14, 1022, 0.85, N'Vì bạn thích Rock (Imagine Dragons)'),
(15, 1025, 0.9, N'Vì bạn thích Rock (Coldplay)'),
(16, 1010, 0.95, N'Vì bạn là fan K-Pop (BLACKPINK)'),
(17, 1016, 0.8, N'Vì bạn thích Rock (Linkin Park)'),
(18, 1021, 0.9, N'Vì bạn thích Soul/Pop (Adele)'),
(19, 1012, 0.8, N'Gợi ý Pop Ballad'),
(20, 1025, 0.85, N'Vì bạn thích Classic Rock (Queen)');
GO

-----------------------------------------------------
-- 20. Bảng search_history (Yêu cầu: 20+ dòng)
-----------------------------------------------------
INSERT INTO search_history (search_query_text, user_id)
VALUES
(N'Sơn Tùng M-TP', 5), (N'Taylor Swift', 5), (N'Lạc Trôi', 5),
(N'BLACKPINK', 6), (N'How You Like That', 6), (N'BTS', 6),
(N'Ed Sheeran', 7), (N'Shape of You', 7),
(N'The Weeknd', 8), (N'Blinding Lights', 8),
(N'Drake', 9), (N'Billie Eilish', 10), (N'bad guy', 10),
(N'Hà Anh Tuấn', 11), (N'Vũ Cát Tường', 12),
(N'Daft Punk', 13), (N'Queen', 14), (N'Michael Jackson', 15),
(N'Linkin Park', 16), (N'Imagine Dragons', 17),
(N'Lana Del Rey', 18), (N'Coldplay', 19), (N'Eminem', 20),
(N'beautiful in white', 12);
GO

-----------------------------------------------------
-- 21. Bảng subscriptions (Yêu cầu: 20 dòng)
-- Trigger trg_set_subscription_end sẽ tự động chạy
-----------------------------------------------------
SET IDENTITY_INSERT subscriptions ON;
-- SỬA LỖI CHECK: Thêm cột subscription_end_date để vượt qua ràng buộc CHK_active_end_date.
-- Trigger sẽ tự động cập nhật lại các giá trị này ngay sau khi chèn.
INSERT INTO subscriptions (subscription_id, subscription_start_date, user_id, plan_id, subscription_status, subscription_end_date)
VALUES
-- 5 Premium Annually
(1, '2024-01-01', 5, 3, 'active', '2024-01-01'), -- Thêm ngày giả lập
(2, '2024-02-01', 6, 3, 'active', '2024-02-01'), -- Thêm ngày giả lập
(3, '2024-03-01', 7, 3, 'active', '2024-03-01'), -- Thêm ngày giả lập
(4, '2024-04-01', 8, 3, 'active', '2024-04-01'), -- Thêm ngày giả lập
(5, '2024-05-01', 9, 3, 'active', '2024-05-01'), -- Thêm ngày giả lập
-- 5 Premium Monthly
(6, '2024-10-01', 10, 2, 'active', '2024-10-01'), -- Thêm ngày giả lập
(7, '2024-10-05', 11, 2, 'active', '2024-10-05'), -- Thêm ngày giả lập
(8, '2024-10-10', 12, 2, 'active', '2024-10-10'), -- Thêm ngày giả lập
(9, '2024-10-15', 13, 2, 'active', '2024-10-15'), -- Thêm ngày giả lập
(10, '2024-10-20', 14, 2, 'active', '2024-10-20'), -- Thêm ngày giả lập
-- 5 Free (Perpetual)
(11, '2024-01-01', 15, 1, 'active', '2024-01-01'), -- Thêm ngày giả lập
(12, '2024-01-01', 16, 1, 'active', '2024-01-01'), -- Thêm ngày giả lập
(13, '2024-01-01', 17, 1, 'active', '2024-01-01'), -- Thêm ngày giả lập
(14, '2024-01-01', 18, 1, 'active', '2024-01-01'), -- Thêm ngày giả lập
(15, '2024-01-01', 19, 1, 'active', '2024-01-01'), -- Thêm ngày giả lập
-- 5 Expired / Pending (Các trạng thái này không cần ngày giả lập, nhưng thêm vào để đồng nhất cột)
(16, '2023-01-01', 20, 2, 'expired', '2023-02-01'), -- Hết hạn
(17, '2023-05-01', 1, 2, 'expired', '2023-06-01'), -- Hết hạn
(18, '2025-12-01', 2, 2, 'pending', NULL), -- Chờ thanh toán
(19, '2025-12-02', 3, 2, 'pending', NULL), -- Chờ thanh toán
(20, '2023-09-01', 4, 3, 'expired', '2024-09-01'); -- Hết hạn
SET IDENTITY_INSERT subscriptions OFF;
GO
-- Chờ 1 giây để đảm bảo Trigger chạy xong trước khi chèn Payments
WAITFOR DELAY '00:00:01';
GO

-----------------------------------------------------
-- 22. Bảng payments (Yêu cầu: 20+ dòng)
-----------------------------------------------------
INSERT INTO payments (payment_amount, payment_method, payment_status, subscription_id)
VALUES
(51.00, 'credit_card', 'completed', 1),
(51.00, 'paypal', 'completed', 2),
(51.00, 'bank_transfer', 'completed', 3),
(51.00, 'apple_pay', 'completed', 4),
(51.00, 'credit_card', 'completed', 5),
(5.00, 'credit_card', 'completed', 6),
(5.00, 'paypal', 'completed', 7),
(5.00, 'bank_transfer', 'completed', 8),
(5.00, 'apple_pay', 'completed', 9),
(5.00, 'credit_card', 'completed', 10),
(0.00, 'credit_card', 'completed', 11), -- Free
(0.00, 'credit_card', 'completed', 12), -- Free
(0.00, 'credit_card', 'completed', 13), -- Free
(0.00, 'credit_card', 'completed', 14), -- Free
(0.00, 'credit_card', 'completed', 15), -- Free
(5.00, 'credit_card', 'completed', 16),
(5.00, 'paypal', 'completed', 17),
(5.00, 'bank_transfer', 'pending', 18),
(5.00, 'apple_pay', 'failed', 19),
(51.00, 'credit_card', 'completed', 20);
GO