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