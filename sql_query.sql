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



-- câu lệnh update

-- update bio của user có username là 'chuong_user'
UPDATE users
SET user_bio = N'Đây là bio mới của tôi. Tôi thích nghe nhạc Pop.'
WHERE user_username = 'chuong_user';

-- update tên và mô tả của playlist thành Nhạc chill và mô tả thành Nhẹ nhàng, vui vẻ cho playlist có playlist_id = 5
UPDATE playlists
SET playlist_name = N'Nhạc chill',
    playlist_description = N'Nhẹ nhàng, vui vẻ'
WHERE playlist_id = 5;

-- update role của user_id = 5 trong playlist_id = 1 thành 'contributor'
UPDATE user_playlists
SET role = 'contributor'
WHERE user_id = 5 AND playlist_id = 1;

-- Tăng số lần đăng nhập thất bại của user có username là 'alice_user' lên 1 và cập nhật thời gian đăng nhập thất bại cuối cùng
UPDATE users
SET user_failed_login_attempts = user_failed_login_attempts + 1,
    user_last_failed_login = GETDATE()
WHERE user_username = 'alice_user';

-- Cập nhật trạng thái của payment có payment_id = 101 thành completed và cập nhật thời gian cập nhật payment
UPDATE payments
SET payment_status = 'completed',
WHERE payment_id = 101;

-- câu lệnh delete

-- xoá 1 lượt like, người dùng có user_id=2 bỏ thích bài hát có song_id = 50
DELETE FROM user_like_songs
WHERE user_id = 2 AND song_id = 50;

-- Xoá 1 bài hát khỏi playlist, bài hát có song_id = 30 trong playlist có playlist_id = 1
DELETE FROM playlist_songs
WHERE playlist_id = 1 and song_id = 30

-- Người dùng unfollow 1 nghệ sĩ, 
-- người dùng có user_id = 3 bỏ theo dõi nghệ sĩ có artist_id = 10
DELETE FROM user_follow_artists
WHERE user_id = 3 AND artist_id = 10;

-- Người dùng bỏ theo dõi 1 người dùng khác,
-- người dùng có user_id = 4 bỏ theo dõi người dùng có user_id = 5
DELETE FROM user_follow_users
WHERE follower_user_id = 4 AND followed_user_id = 5;

-- xoá 1 user, kích hoạt cascade xoá tất cả dữ liệu liên quan,
-- xoá user có user_id = 6
DELETE FROM users
WHERE user_id = 6;

-- Câu lệnh truy vấn SELECT

-- Đếm số lượng bài hát trong mỗi album
SELECT a.album_id, a.album_title, COUNT(s.song_id) AS so_luong_bai_hat
FROM albums a
JOIN songs s ON a.album_id = s.album_id
GROUP BY a.album_id;

-- Đếm số lượng bài hát của mỗi nghệ sĩ(với vai trò là nghệ sĩ chính)
SELECT ar.artist_id, ar.artist_name, COUNT(s.song_id) AS so_luong_bai_hat
FROM artists ar 
JOIN song_artists sa ON ar.artist_id = sa.artist_id
JOIN songs s ON sa.song_id = s.song_id
WHERE sa.role = 'primary'
GROUP BY ar.artist_id;

-- Đếm số lượng người theo dõi của mỗi nghệ sĩ
SELECT
    a.artist_name,
    COUNT(ufa.user_id) AS so_nguoi_theo_doi
FROM artists a
LEFT JOIN user_follow_artists ufa ON a.artist_id = ufa.artist_id
GROUP BY a.artist_name
ORDER BY so_nguoi_theo_doi DESC;

-- Đếm số lượng bài hát trong mỗi playlist
SELECT
    p.playlist_name,
    COUNT(ps.song_id) AS so_bai_hat
FROM playlists p
JOIN playlist_songs ps ON p.playlist_id = ps.playlist_id
GROUP BY p.playlist_name;

-- Đếm số lượng like của mỗi bài hát
SELECT
    s.song_title,
    COUNT(uls.user_id) AS tong_luot_thich
FROM songs s
LEFT JOIN user_like_songs uls ON s.song_id = uls.song_id
GROUP BY s.song_title
ORDER BY tong_luot_thich DESC;

-- Đếm số lượng album của mỗi nghệ sĩ
SELECT
    ar.artist_name,
    COUNT(DISTINCT al.album_id) AS so_luong_album
FROM artists ar
JOIN albums al ON ar.artist_id = al.artist_id
GROUP BY ar.artist_name

-- Đếm số lượng người dùng có đăng ký (subscription) đang hoạt động theo quốc gia
SELECT
    u.user_country,
    COUNT(DISTINCT s.subscription_id) AS so_nguoi_dung_premium
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
WHERE s.subscription_status = 'active'
GROUP BY u.user_country;

-- Các câu lệnh tính tổng, trung bình, tối đa, tối thiểu

-- Tính tổng lượt nghe (play count) của tất cả bài hát trong mỗi album.
SELECT
    a.album_title,
    SUM(s.song_play_count) AS tong_luot_nghe
FROM albums a
JOIN songs s ON a.album_id = s.album_id
GROUP BY a.album_title
ORDER BY tong_luot_nghe DESC;

-- Tính tổng thời lượng phát (duration) của tất cả bài hát trong mỗi playlist.
SELECT
    p.playlist_name,
    SUM(s.song_duration) AS tong_thoi_luong
FROM playlists p
JOIN playlist_songs ps ON p.playlist_id = ps.playlist_id
JOIN songs s ON ps.song_id = s.song_id
GROUP BY p.playlist_name
ORDER BY tong_thoi_luong DESC;