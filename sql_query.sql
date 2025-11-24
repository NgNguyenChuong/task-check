SELECT * FROM users;
SELECT * FROM user_tokens;
SELECT * FROM search_history;
SELECT * FROM playlists;
SELECT * FROM user_playlists;
SELECT * FROM artists;
SELECT * FROM albums;
SELECT * FROM songs;
SELECT * FROM lyrics;
SELECT * FROM song_artists;
SELECT * FROM genres;
SELECT * FROM song_genres;
SELECT * FROM playlist_songs;
SELECT * FROM listens;
SELECT * FROM user_like_songs;
SELECT * FROM user_follow_artists;
SELECT * FROM user_follow_users;
SELECT * FROM user_like_albums;
SELECT * FROM user_recommendations;
SELECT * FROM plans;
SELECT * FROM subscriptions;
SELECT * FROM payments;



-- Câu lệnh update

-- Cập nhật bio của user có username là 'chuong_user' thành 'Đây là bio mới của tôi. Tôi thích nghe nhạc Pop.'
UPDATE users
SET user_bio = N'Đây là bio mới của tôi. Tôi thích nghe nhạc Pop.'
WHERE user_username = 'chuong_user';

-- Cập nhật tên và mô tả của playlist thành Nhạc chill và mô tả thành Nhẹ nhàng, vui vẻ cho playlist có playlist_id = 5
UPDATE playlists
SET playlist_name = N'Nhạc chill',
    playlist_description = N'Nhẹ nhàng, vui vẻ'
WHERE playlist_id = 5;

-- Cập nhật role của user_id = 5 trong playlist_id = 1 thành 'contributor'
UPDATE user_playlists
SET role = 'contributor'
WHERE user_id = 11 AND playlist_id = 6;

-- Tăng số lần đăng nhập thất bại của user có username là 'phong_user' lên 1 và cập nhật thời gian đăng nhập thất bại cuối cùng
UPDATE users
SET user_failed_login_attempts = user_failed_login_attempts + 1,
    user_last_failed_login = GETDATE()
WHERE user_username = 'phong_user';

-- Cập nhật trạng thái của payment có payment_id = 18 thành completed và cập nhật thời gian cập nhật payment
UPDATE payments
SET payment_status = 'completed'
WHERE payment_id = 18;

-- Câu lệnh DELETE

-- Xoá 1 lượt like, người dùng có user_id=5 bỏ thích bài hát có song_id = 1003
DELETE FROM user_like_songs
WHERE user_id = 5 AND song_id = 1003;

-- xoá lời bài hát của bài hát có song_id = 1006
DELETE FROM lyrics
WHERE song_id = 1006;

-- Người dùng unfollow 1 nghệ sĩ, 
-- Người dùng có user_id = 5 bỏ theo dõi nghệ sĩ có artist_id = 1
DELETE FROM user_follow_artists
WHERE user_id = 5 AND artist_id = 1;

-- Người dùng bỏ theo dõi 1 người dùng khác,
-- Người dùng có user_id =5  bỏ theo dõi người dùng có user_id = 6
DELETE FROM user_follow_users
WHERE follower_id = 5 AND following_id = 6;

-- người dùng bỏ like 1 album,
-- Người dùng có user_id = 9 bỏ thích album có album_id = 111
DELETE FROM user_like_albums
WHERE user_id = 9 AND album_id = 111;
-- ============================================================
-- CÂU LỆNH DELETE (KÈM KIỂM TRA)
-- ============================================================

-- 1. Xoá 1 lượt like: User 5 bỏ thích bài hát 1003
SELECT * FROM user_like_songs WHERE user_id = 5 AND song_id = 1003; -- Kiểm tra trước
DELETE FROM user_like_songs
WHERE user_id = 5 AND song_id = 1003;
SELECT * FROM user_like_songs WHERE user_id = 5 AND song_id = 1003; -- Kiểm tra sau (kết quả phải rỗng)

-- 2. Xoá lời bài hát của bài hát có song_id = 1006
SELECT * FROM lyrics WHERE song_id = 1006; -- Kiểm tra trước
DELETE FROM lyrics
WHERE song_id = 1006;
SELECT * FROM lyrics WHERE song_id = 1006; -- Kiểm tra sau

-- 3. Người dùng (id=5) bỏ theo dõi nghệ sĩ (id=1)
SELECT * FROM user_follow_artists WHERE user_id = 5 AND artist_id = 1; -- Kiểm tra trước
DELETE FROM user_follow_artists
WHERE user_id = 5 AND artist_id = 1;
SELECT * FROM user_follow_artists WHERE user_id = 5 AND artist_id = 1; -- Kiểm tra sau
-- 4. Người dùng (id=5) bỏ theo dõi người dùng khác (id=6)
SELECT * FROM user_follow_users WHERE follower_id = 5 AND following_id = 6; -- Kiểm tra trước
DELETE FROM user_follow_users
WHERE follower_id = 5 AND following_id = 6;
SELECT * FROM user_follow_users WHERE follower_id = 5 AND following_id = 6; -- Kiểm tra sau

-- 5. Người dùng (id=9) bỏ like album (id=111)
SELECT * FROM user_like_albums WHERE user_id = 9 AND album_id = 111; -- Kiểm tra trước
DELETE FROM user_like_albums
WHERE user_id = 9 AND album_id = 111;
SELECT * FROM user_like_albums WHERE user_id = 9 AND album_id = 111; -- Kiểm tra sau


-- 6. Sử dụng procedure xoá user có user_id = 10
-- Kiểm tra xem user còn tồn tại không
SELECT * FROM users WHERE user_id = 10; 
-- Kiểm tra xem user này có đang follow ai không (để test logic xoá follow trước khi xoá user)
SELECT * FROM user_follow_users WHERE follower_id = 10 OR following_id = 10; 

EXEC sp_DeleteUser @UserIDToDelete = 10;

-- Kiểm tra lại (Kết quả phải rỗng ở cả 2 bảng)
SELECT * FROM users WHERE user_id = 10;
SELECT * FROM user_follow_users WHERE follower_id = 10 OR following_id = 10;


-- 7. Sử dụng procedure xoá bài hát (id=1009) khỏi playlist (id=3)
-- Kiểm tra xem bài hát đang ở vị trí (track_order) nào
SELECT * FROM playlist_songs WHERE playlist_id = 3 AND song_id = 1040;
-- Kiểm tra tổng thể playlist để xem track_order của các bài sau có tự động giảm đi 1 không
SELECT * FROM playlist_songs WHERE playlist_id = 3 ORDER BY track_order;

EXEC sp_RemoveSongFromPlaylist @PlaylistID = 3, @SongID = 1040;

-- Kiểm tra lại (Bài 1009 biến mất, các bài phía sau nhảy số thứ tự lên)
SELECT * FROM playlist_songs WHERE playlist_id = 3 AND song_id = 1040;
SELECT * FROM playlist_songs WHERE playlist_id = 3 ORDER BY track_order;




-- Câu lệnh truy vấn SELECT

--1 Đếm số lượng bài hát trong mỗi album
SELECT a.album_id, a.album_title, COUNT(s.song_id) AS so_luong_bai_hat
FROM albums a
JOIN songs s ON a.album_id = s.album_id
GROUP BY a.album_id, a.album_title;

-- 2 Đếm số lượng bài hát của mỗi nghệ sĩ(với vai trò là nghệ sĩ chính)
SELECT ar.artist_id, ar.artist_name, COUNT(s.song_id) AS so_luong_bai_hat
FROM artists ar 
JOIN song_artists sa ON ar.artist_id = sa.artist_id
JOIN songs s ON sa.song_id = s.song_id
WHERE sa.role = 'primary'
GROUP BY ar.artist_id, ar.artist_name;


-- 3 Đếm số lượng người theo dõi của mỗi nghệ sĩ
SELECT
    a.artist_name,
    COUNT(ufa.user_id) AS so_nguoi_theo_doi
FROM artists a
LEFT JOIN user_follow_artists ufa ON a.artist_id = ufa.artist_id
GROUP BY a.artist_name
ORDER BY so_nguoi_theo_doi DESC;

--4 Đếm số lượng bài hát trong mỗi playlist
SELECT
    p.playlist_name,
    COUNT(ps.song_id) AS so_bai_hat
FROM playlists p
JOIN playlist_songs ps ON p.playlist_id = ps.playlist_id
GROUP BY p.playlist_name;

--5 Đếm số lượng like của mỗi bài hát
SELECT
    s.song_title,
    COUNT(uls.user_id) AS tong_luot_thich
FROM songs s
LEFT JOIN user_like_songs uls ON s.song_id = uls.song_id
GROUP BY s.song_title
ORDER BY tong_luot_thich DESC;

--6 Đếm số lượng album của mỗi nghệ sĩ
SELECT
    ar.artist_name,
    COUNT(DISTINCT al.album_id) AS so_luong_album
FROM artists ar
JOIN albums al ON ar.artist_id = al.artist_id
GROUP BY ar.artist_name

-- 7Đếm số lượng người dùng có đăng ký (subscription) đang hoạt động theo quốc gia
SELECT
    u.user_country_code,
    COUNT(DISTINCT s.subscription_id) AS so_nguoi_dung_premium
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
WHERE s.subscription_status = 'active'
GROUP BY u.user_country_code;

-- Các câu lệnh tính tổng, trung bình, tối đa, tối thiểu

--8 Tính tổng lượt nghe (play count) của tất cả bài hát trong mỗi album.
SELECT
    a.album_title,
    SUM(s.song_play_count) AS tong_luot_nghe
FROM albums a
JOIN songs s ON a.album_id = s.album_id
GROUP BY a.album_title
ORDER BY tong_luot_nghe DESC;

--9 Tính tổng thời lượng phát (duration) của tất cả bài hát trong mỗi playlist.
SELECT
    p.playlist_name,
    SUM(s.song_duration_seconds) AS tong_thoi_luong
FROM playlists p
JOIN playlist_songs ps ON p.playlist_id = ps.playlist_id
JOIN songs s ON ps.song_id = s.song_id
GROUP BY p.playlist_name
ORDER BY tong_thoi_luong DESC;

--10 Tính thời lượng trung bình (AVG) của các bài hát theo từng thể loại (genre).
SELECT
    g.genre_name,
    AVG(s.song_duration_seconds) AS thoi_luong_trung_binh
FROM genres g
JOIN song_genres sg ON g.genre_id = sg.genre_id
JOIN songs s ON sg.song_id = s.song_id
GROUP BY g.genre_name;

--11 Tính tổng doanh thu (đã hoàn thành) theo từng gói (plan):
SELECT
    pl.plan_name,
    pl.plan_billing_cycle,
    SUM(p.payment_amount) AS tong_doanh_thu
FROM plans pl
JOIN subscriptions s ON pl.plan_id = s.plan_id
JOIN payments p ON s.subscription_id = p.subscription_id
WHERE p.payment_status = 'completed'
GROUP BY pl.plan_name, pl.plan_billing_cycle;

--12 Tìm lượt nghe cao nhất và thấp nhất cho các bài hát của mỗi nghệ sĩ
SELECT
    a.artist_name,
    MAX(s.song_play_count) AS luot_nghe_cao_nhat,
    MIN(s.song_play_count) AS luot_nghe_thap_nhat
FROM artists a
JOIN song_artists sa ON a.artist_id = sa.artist_id
JOIN songs s ON sa.song_id = s.song_id
WHERE sa.role = 'primary'
GROUP BY a.artist_name;

--13 Tìm ngày phát hành album cũ nhất và mới nhất của mỗi nghệ sĩ
SELECT
    a.artist_name,
    MIN(al.album_release_date) AS album_dau_tien,
    MAX(al.album_release_date) AS album_moi_nhat
FROM artists a
JOIN albums al ON a.artist_id = al.artist_id
GROUP BY a.artist_name;



-- 14 Tìm thời điểm like bài hát đầu tiên và cuối cùng của mỗi người dung
SELECT
    u.user_username,
    MIN(uls.liked_at) AS lan_thich_dau_tien,
    MAX(uls.liked_at) AS lan_thich_gan_nhat
FROM users u
JOIN user_like_songs uls ON u.user_id = uls.user_id
GROUP BY u.user_username;


-- 15. Tìm username của những user có token đã bị thu hồi (dựa vào token_revoked_at khác NULL)
SELECT DISTINCT u.user_username
FROM users u
JOIN user_tokens ut ON u.user_id = ut.user_id
WHERE ut.token_revoked_at IS NOT NULL;
-- 16 Lấy thông tin các bài hát nằm trong các album được phát hành bởi nghệ sĩ "Sơn Tùng M-TP"
SELECT
    s.song_title,
    a.album_title
FROM songs s
JOIN albums a ON s.album_id = a.album_id
WHERE a.artist_id IN (
    SELECT artist_id FROM artists WHERE artist_name = N'Sơn Tùng M-TP'
);

-- 17 Tìm tên những người dùng đã like ít nhất 1 bài hát thuộc thể loại "Pop"
SELECT DISTINCT
    u.user_username,
    u.user_email
FROM users u
JOIN user_like_songs uls ON u.user_id = uls.user_id
WHERE uls.song_id IN (
    SELECT sg.song_id
    FROM song_genres sg
    JOIN genres g ON sg.genre_id = g.genre_id
    WHERE g.genre_name = 'Pop'
);
-- 18 Lấy danh sách các album của những nghệ sĩ không đến từ 'VN' (Việt Nam)
SELECT
    al.album_title,
    ar.artist_name
FROM albums al
JOIN artists ar ON al.artist_id = ar.artist_id
WHERE al.artist_id NOT IN (
    SELECT artist_id FROM artists WHERE artist_country_code = 'VN'
);
--19  Lấy danh sách người dùng chưa từng nghe bất kỳ bài hát nào của nghệ sĩ "Taylor Swift"
SELECT
    u.user_username
FROM users u
LEFT JOIN subscriptions s ON u.user_id = s.user_id -- (Join 2 bảng)
WHERE u.user_id NOT IN (
    SELECT l.listen_user_id
    FROM listens l
    JOIN song_artists sa ON l.listen_song_id = sa.song_id
    JOIN artists a ON sa.artist_id = a.artist_id
    WHERE a.artist_name = 'Taylor Swift'
);

-- 20 Tìm các bài hát được like bởi hơn 2 người dùng
SELECT
    s.song_title,
    COUNT(uls.user_id) AS so_luot_thich
FROM songs s
JOIN user_like_songs uls ON s.song_id = uls.song_id
GROUP BY s.song_title
HAVING COUNT(uls.user_id) > 2;
