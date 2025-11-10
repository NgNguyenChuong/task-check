/*
=====================================================================
== TỔNG QUAN VỀ CÁC INDEX
=====================================================================
Chiến lược Index bao gồm:
1. Index trên các Khóa ngoại (FK): Hầu hết các cột `..._id` được dùng để JOIN.
2. Index hỗ trợ Tìm kiếm (Search): Các cột `..._name`, `..._title`.
3. Index hỗ trợ Sắp xếp (Sorting): `play_count`, `release_date`.
4. Index hỗ trợ Tính năng (Features):
   - Truy vấn "ngược" trên các bảng M-N (vd: xem ai đã like bài hát).
   - Hỗ trợ các tác vụ nền (vd: kiểm tra tài khoản hết hạn).
=====================================================================
*/

--===== BẢNG CHÍNH (CORE TABLES) =====

-- Bảng users
-- Hỗ trợ kiểm tra tài khoản bị khoá
CREATE INDEX idx_users_lockout ON users (user_account_locked_until);
GO

-- Bảng user_tokens
-- Tăng tốc tìm kiếm token
CREATE INDEX idx_tokens_hash ON user_tokens (token_hash);
-- Hỗ trợ join/tìm token theo user_id (FK)
CREATE INDEX idx_tokens_user_id ON user_tokens (user_id);
GO

-- Bảng artists
-- Hỗ trợ tìm kiếm nghệ sĩ theo tên
CREATE INDEX idx_artists_name ON artists (artist_name);
-- Hỗ trợ liên kết tài khoản user với nghệ sĩ (FK)
CREATE INDEX idx_artists_user_id ON artists (artist_user_id) 
    WHERE artist_user_id IS NOT NULL;
GO

-- Bảng albums
-- Hỗ trợ tìm kiếm album theo tên
CREATE INDEX idx_albums_title ON albums (album_title);
-- Hỗ trợ join/tìm album theo nghệ sĩ (FK)
CREATE INDEX idx_albums_artist_id ON albums (artist_id);
GO

-- Bảng songs
-- Hỗ trợ tìm kiếm bài hát theo tên
CREATE INDEX idx_songs_title ON songs (song_title);
-- Hỗ trợ sắp xếp "Top Hits" (Bảng xếp hạng)
CREATE INDEX idx_songs_play_count ON songs (song_play_count DESC);
-- Hỗ trợ join/tìm bài hát theo album (FK)
CREATE INDEX idx_songs_album_id ON songs (album_id);
-- Hỗ trợ tìm "Bài hát mới phát hành"
CREATE INDEX idx_songs_release_date ON songs (song_release_date DESC);
GO

-- Bảng playlists
-- Hỗ trợ tìm kiếm playlist theo tên
CREATE INDEX idx_playlists_name ON playlists (playlist_name);
GO

--===== BẢNG SUBSCRIPTION VÀ PAYMENT =====

-- Bảng subscriptions
-- Tìm tất cả subscriptions của 1 user (FK)
CREATE INDEX idx_subscriptions_user_id ON subscriptions (user_id);
-- Tìm tất cả subscriptions theo gói dịch vụ (FK)
CREATE INDEX idx_subscriptions_plan_id ON subscriptions (plan_id);
-- Hỗ trợ tác vụ nền (background job) kiểm tra gói hết hạn
CREATE INDEX idx_subscriptions_end_date ON subscriptions (subscription_end_date);
GO

-- Bảng payments 
-- Xem tất cả các payment của 1 subscription (FK)
CREATE INDEX idx_payments_subscription_id ON payments (subscription_id);
GO

--===== BẢNG TƯƠNG TÁC (INTERACTION TABLES) =====

-- Bảng search_history
-- Tìm lịch sử tìm kiếm của 1 user (FK)
CREATE INDEX idx_search_user_id ON search_history (user_id);
GO

-- Bảng listens
-- Tìm lịch sử nghe nhạc của 1 user, sắp xếp mới nhất (FK)
CREATE INDEX idx_listens_user_time ON listens (listen_user_id, listened_at DESC);
-- Đếm lượt nghe của 1 bài hát (FK)
CREATE INDEX idx_listens_song_id ON listens (listen_song_id);
GO

--===== CÁC BẢNG LIÊN KẾT (MANY-TO-MANY) =====
/*
  Các index này chủ yếu phục vụ truy vấn "ngược"
  (VD: Tìm tất cả bài hát của 1 nghệ sĩ, thay vì tìm nghệ sĩ của 1 bài hát)
*/

-- Bảng song_artists
-- Hỗ trợ tìm tất cả bài hát của 1 nghệ sĩ
CREATE INDEX idx_song_artists_artist_id ON song_artists (artist_id);
GO

-- Bảng song_genres
-- Hỗ trợ tìm tất cả bài hát của 1 thể loại
CREATE INDEX idx_song_genres_genre_id ON song_genres (genre_id);
GO

-- Bảng playlist_songs
-- Hỗ trợ tìm xem 1 bài hát nằm ở những playlist nào
CREATE INDEX idx_playlist_songs_song_id ON playlist_songs (song_id);
GO

-- Bảng user_like_songs
-- Hỗ trợ đếm/hiển thị lượt thích của 1 bài hát
CREATE INDEX idx_user_like_songs_song_id ON user_like_songs (song_id);
GO

-- Bảng user_follow_artists
-- Hỗ trợ đếm/hiển thị lượt theo dõi của 1 nghệ sĩ
-- (ĐÃ SỬA TÊN): Tên cũ của bạn bị trùng là idx_user_like_songs_song_id
CREATE INDEX idx_user_follow_artists_artist_id ON user_follow_artists (artist_id);
GO

-- Bảng user_like_albums
-- Hỗ trợ đếm/hiển thị lượt thích của 1 album
CREATE INDEX idx_user_like_albums_album_id ON user_like_albums (album_id);
GO

-- Bảng user_follow_users
-- Hỗ trợ xem ai đang theo dõi user này (Tìm "follower")
CREATE INDEX idx_user_follow_users_following_id ON user_follow_users (following_id);
GO


-- Bảng user_playlists
-- Hỗ trợ tìm tất cả user/collaborator của 1 playlist
CREATE INDEX idx_user_playlists_playlist_id ON user_playlists (playlist_id);
GO