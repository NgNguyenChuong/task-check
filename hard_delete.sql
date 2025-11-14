-- Tắt các thông báo "x rows affected" để tăng hiệu suất
SET NOCOUNT ON;
GO

CREATE TABLE users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    user_username VARCHAR(50) NOT NULL UNIQUE, -- use to login
    user_email VARCHAR(100) NOT NULL UNIQUE,
    user_password_hash VARCHAR(255) NOT NULL,
    user_fullname NVARCHAR(100) NOT NULL,
    user_display_name NVARCHAR(100) NOT NULL,
    user_birthdate DATE,
    user_gender VARCHAR(10) CHECK (user_gender IN ('male', 'female', 'other')),
    user_avatar_url VARCHAR(255),
    user_bio NVARCHAR(MAX),
    user_country_code VARCHAR(3) DEFAULT 'VN' NOT NULL,
    user_created_at DATETIME2 DEFAULT GETDATE(),
    user_updated_at DATETIME2 DEFAULT GETDATE(),

    -- Đã loại bỏ user_is_active
    user_role VARCHAR(20) DEFAULT 'user',

    -- Thêm các cột để theo dõi số lần đăng nhập thất bại và trạng thái khóa tài khoản
    user_failed_login_attempts INT DEFAULT 0,
    user_last_failed_login DATETIME2 NULL,
    user_account_locked_until DATETIME2 NULL
);
-- Thêm ràng buộc kiểm tra cho cột user_role phải là một trong các giá trị 'user', 'artist', 'admin'
GO
ALTER TABLE users
ADD CONSTRAINT CK_user_role_validity
CHECK (user_role IN ('user', 'artist', 'admin'));
GO

CREATE TABLE user_tokens (
    token_id INT PRIMARY KEY IDENTITY(1,1),
    token_hash VARCHAR(255) UNIQUE NOT NULL,
    -- thời điểm hết hạn của token
    token_expires_at DATETIME2 NOT NULL,
    token_created_at DATETIME2 DEFAULT GETDATE(),
    token_device_info VARCHAR(255),
    -- đánh dấu token đã bị thu hồi (revoked) hay chưa
    token_revoked BIT DEFAULT 0,
    token_ip_address VARCHAR(45),
    user_id INT NOT NULL
);
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa user -> xóa token)
ALTER TABLE user_tokens ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO

CREATE TABLE search_history (
    search_id INT PRIMARY KEY IDENTITY(1,1),
    search_query_text NVARCHAR(255) NOT NULL,
    searched_at DATETIME2 DEFAULT GETDATE(),
    user_id INT NOT NULL
);
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa user -> xóa lịch sử tìm kiếm)
ALTER TABLE search_history ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO

CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY IDENTITY(1,1),
    playlist_name VARCHAR(100) NOT NULL,
    playlist_description NVARCHAR(MAX),
    playlist_created_at DATETIME2 DEFAULT GETDATE(),
    playlist_updated_at DATETIME2 DEFAULT GETDATE(),
    playlist_is_public BIT DEFAULT 0
);
GO

CREATE TABLE user_playlists (
    user_id INT NOT NULL, 
    playlist_id INT NOT NULL,
    shared_at DATETIME2 DEFAULT GETDATE(),
    role VARCHAR(20) DEFAULT 'owner',
    PRIMARY KEY (user_id, playlist_id)
);
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa user -> xóa liên kết playlist)
ALTER TABLE user_playlists ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
-- Giữ nguyên: ON DELETE CASCADE (Xóa playlist -> xóa liên kết user)
ALTER TABLE user_playlists ADD FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id) ON DELETE CASCADE;
GO
ALTER TABLE user_playlists
ADD CONSTRAINT CHK_user_playlist_role
CHECK (role IN ('owner', 'contributor', 'viewer'));
GO

CREATE TABLE artists (
    artist_id INT PRIMARY KEY IDENTITY(1,1),
    artist_name NVARCHAR(255) NOT NULL, 
    artist_avatar_url VARCHAR(255),
    artist_description NVARCHAR(MAX),
    artist_country_code VARCHAR(3) NOT NULL,
    artist_created_at DATETIME2 DEFAULT GETDATE(),
    artist_updated_at DATETIME2 DEFAULT GETDATE(),
    -- Đã loại bỏ artist_deleted_at
    -- artist có thể là 1 user trong hệ thống
    artist_user_id INT NULL
);
GO
-- THAY ĐỔI: ON DELETE SET NULL (Xóa user -> ngắt liên kết với artist, nhưng artist vẫn tồn tại)
ALTER TABLE artists ADD FOREIGN KEY (artist_user_id) REFERENCES users(user_id) ON DELETE SET NULL;
GO

CREATE TABLE albums (
    album_id INT PRIMARY KEY IDENTITY(1,1),
    album_title NVARCHAR(255) NOT NULL,
    -- ngày ra mắt album
    album_release_date DATE,
    -- ngày album được thêm vào hệ thống
    album_created_at DATETIME2 DEFAULT GETDATE(),
    album_updated_at DATETIME2 DEFAULT GETDATE(),
    -- Đã loại bỏ album_deleted_at
    album_cover_url VARCHAR(255),
    artist_id INT NOT NULL
);
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa artist -> xóa album)
ALTER TABLE albums ADD FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE;
GO

CREATE TABLE songs (
    song_id INT PRIMARY KEY IDENTITY(1,1),
    song_title NVARCHAR(255) NOT NULL,
    song_release_date DATE,
    song_duration_seconds INT,
    song_created_at DATETIME2 DEFAULT GETDATE(),
    song_updated_at DATETIME2 DEFAULT GETDATE(),
    -- Đã loại bỏ song_deleted_at
    song_play_count INT DEFAULT 0,
    song_is_explicit BIT DEFAULT 0,
    song_cover_url VARCHAR(255),
    song_audio_url VARCHAR(255) NOT NULL UNIQUE,
    album_id INT NULL
);
GO
-- Giữ nguyên: ON DELETE SET NULL (Xóa album -> bài hát mất liên kết album)
ALTER TABLE songs ADD FOREIGN KEY (album_id) REFERENCES albums(album_id) ON DELETE SET NULL;
GO
ALTER TABLE songs
ADD CONSTRAINT CHK_song_duration_positive CHECK (song_duration_seconds > 0);
GO

CREATE TABLE lyrics (
    lyric_id INT PRIMARY KEY IDENTITY(1,1),
    song_id INT NOT NULL UNIQUE, 
    lyric_text NVARCHAR(MAX),
    -- Giữ nguyên: ON DELETE CASCADE (Xóa bài hát -> xóa lyrics)
    FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE CASCADE
);
GO

CREATE TABLE song_artists (
    song_id INT,
    artist_id INT,
    role VARCHAR(100),
    PRIMARY KEY (song_id, artist_id, role)
);
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa bài hát -> xóa liên kết artist)
ALTER TABLE song_artists ADD FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE CASCADE;
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa artist -> xóa liên kết bài hát)
ALTER TABLE song_artists ADD FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE;
GO
ALTER TABLE song_artists
ADD CONSTRAINT CHK_song_artist_role
CHECK (role IN ('primary', 'featured'));
GO

CREATE TABLE genres (
    genre_id INT PRIMARY KEY IDENTITY(1,1),
    genre_name NVARCHAR(100) NOT NULL UNIQUE,
    genre_created_at DATETIME2 DEFAULT GETDATE(),
    genre_updated_at DATETIME2 DEFAULT GETDATE()
    -- Đã loại bỏ genre_deleted_at
);
GO

CREATE TABLE song_genres (
    song_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (song_id, genre_id)
);
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa bài hát -> xóa thẻ genre)
ALTER TABLE song_genres ADD FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE CASCADE;
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa genre -> xóa thẻ khỏi bài hát)
ALTER TABLE song_genres ADD FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE;
GO

CREATE TABLE playlist_songs (
    added_at DATETIME2 DEFAULT GETDATE(),
    track_order INT NOT NULL,
    playlist_id INT NOT NULL,
    song_id INT NOT NULL,
    PRIMARY KEY (playlist_id, song_id)
);
GO
-- Giữ nguyên: ON DELETE CASCADE (Xóa playlist -> xóa bài hát khỏi playlist)
ALTER TABLE playlist_songs ADD FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id) ON DELETE CASCADE;
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa bài hát -> xóa khỏi mọi playlist)
ALTER TABLE playlist_songs ADD FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE CASCADE;
GO
ALTER TABLE playlist_songs
ADD CONSTRAINT UQ_playlist_track_order
UNIQUE (playlist_id, track_order);
GO


CREATE TABLE listens(
    listen_id INT PRIMARY KEY IDENTITY(1,1),
    listen_user_id INT NOT NULL,
    listen_song_id INT NOT NULL,
    listened_at DATETIME2 DEFAULT GETDATE(),
    listened_seconds INT,
    ip_address VARCHAR(45),
    device_info VARCHAR(255)
);
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa user -> xóa lịch sử nghe)
ALTER TABLE listens ADD FOREIGN KEY (listen_user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa bài hát -> xóa lịch sử nghe)
ALTER TABLE listens ADD FOREIGN KEY (listen_song_id) REFERENCES songs(song_id) ON DELETE CASCADE;
GO

CREATE TABLE user_like_songs (
    liked_at DATETIME2 DEFAULT GETDATE(),
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    PRIMARY KEY (user_id, song_id)
);
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa user -> xóa like)
ALTER TABLE user_like_songs ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa bài hát -> xóa like)
ALTER TABLE user_like_songs ADD FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE CASCADE;
GO

CREATE TABLE user_follow_artists (
    followed_at DATETIME2 DEFAULT GETDATE(),
    user_id INT NOT NULL,
    artist_id INT NOT NULL,
    PRIMARY KEY (user_id, artist_id)
);
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa user -> xóa follow)
ALTER TABLE user_follow_artists ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa artist -> xóa follow)
ALTER TABLE user_follow_artists ADD FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE;
GO

CREATE TABLE user_follow_users (
    followed_at DATETIME2 DEFAULT GETDATE(),
    follower_id INT NOT NULL, -- ID của người đi theo dõi
    following_id INT NOT NULL, -- ID của người được theo dõi
    PRIMARY KEY (follower_id, following_id)
)
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa follower -> xóa liên kết)
ALTER TABLE user_follow_users ADD FOREIGN KEY (follower_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa following -> xóa liên kết)
ALTER TABLE user_follow_users ADD FOREIGN KEY (following_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
ALTER TABLE user_follow_users 
ADD CONSTRAINT CHK_no_self_follow 
CHECK (follower_id <> following_id);
GO

CREATE TABLE user_like_albums (
    liked_at DATETIME2 DEFAULT GETDATE(),
    user_id INT NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (user_id, album_id)
);
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa user -> xóa like)
ALTER TABLE user_like_albums ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa album -> xóa like)
ALTER TABLE user_like_albums ADD FOREIGN KEY (album_id) REFERENCES albums(album_id) ON DELETE CASCADE;
GO

CREATE TABLE user_recommendations (
    recommended_at DATETIME2 DEFAULT GETDATE(),
    score FLOAT,
    reason NVARCHAR(MAX),
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    PRIMARY KEY (user_id, song_id)
);
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa user -> xóa gợi ý)
ALTER TABLE user_recommendations ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa bài hát -> xóa gợi ý)
ALTER TABLE user_recommendations ADD FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE CASCADE;
GO

CREATE TABLE plans (
    plan_id INT PRIMARY KEY IDENTITY(1,1),
    plan_name NVARCHAR(30) NOT NULL DEFAULT 'free',
    plan_is_active BIT DEFAULT 1,
    plan_price DECIMAL(10, 2) NOT NULL,
    plan_billing_cycle VARCHAR(30) NOT NULL,
    plan_description NVARCHAR(MAX),
    -- Đã loại bỏ plan_deleted_at
    plan_deleted_at DATETIME2 NULL,
    plan_created_at DATETIME2 DEFAULT GETDATE(),
    plan_updated_at DATETIME2 DEFAULT GETDATE()
);
GO
ALTER TABLE plans
ADD CONSTRAINT CHK_plan_name
CHECK (plan_name IN ('free', 'premium'));
GO
ALTER TABLE plans
ADD CONSTRAINT CHK_plan_billing_cycle
CHECK (plan_billing_cycle IN ('monthly', 'annually', 'perpetual'));
GO
ALTER TABLE plans
ADD CONSTRAINT UQ_plan_name_cycle
UNIQUE (plan_name, plan_billing_cycle);
GO

CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY IDENTITY(1,1),
    subscription_start_date DATE NOT NULL,
    subscription_end_date DATE,
    subscription_created_at DATETIME2 DEFAULT GETDATE(),
    subscription_updated_at DATETIME2 DEFAULT GETDATE(),
    subscription_is_active BIT DEFAULT 1,
    subscription_status VARCHAR(10) DEFAULT 'active' NOT NULL CHECK (subscription_status IN ('active', 'expired', 'pending')),
    user_id INT NOT NULL,
    plan_id INT NOT NULL
);
GO
-- THAY ĐỔI: ON DELETE CASCADE (Xóa user -> xóa subscription)
ALTER TABLE subscriptions ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
-- Giữ nguyên: ON DELETE NO ACTION (Không cho xóa plan nếu đang có subscription)
ALTER TABLE subscriptions ADD FOREIGN KEY (plan_id) REFERENCES plans(plan_id) ON DELETE NO ACTION;
GO
ALTER TABLE subscriptions
ADD CONSTRAINT CHK_subscription_dates
CHECK (subscription_end_date >= subscription_start_date);
GO
ALTER TABLE subscriptions
ADD CONSTRAINT CHK_active_end_date
CHECK (subscription_status != 'active' OR subscription_end_date IS NOT NULL);
GO

CREATE TABLE payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    payment_amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(50) NOT NULL,
    payment_created_at DATETIME2 DEFAULT GETDATE(),
    payment_updated_at DATETIME2 DEFAULT GETDATE(),
    subscription_id INT NULL
);
GO
-- Giữ nguyên: ON DELETE SET NULL (Xóa subscription -> giữ lại payment, ngắt liên kết)
ALTER TABLE payments ADD FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id) ON DELETE SET NULL;
GO
ALTER TABLE payments
ADD CONSTRAINT CHK_payment_method
CHECK (payment_method IN ('credit_card', 'paypal', 'bank_transfer', 'apple_pay'));
GO
ALTER TABLE payments
ADD CONSTRAINT CHK_payment_status
CHECK (payment_status IN ('pending', 'completed', 'failed'));
GO

-- trigger
-- Tắt các thông báo "x rows affected" để tăng hiệu suất
SET NOCOUNT ON;
GO

-- 1. Bảng users
CREATE TRIGGER trg_Update_users
ON users
AFTER UPDATE
AS
BEGIN
    UPDATE T
    SET user_updated_at = GETDATE()
    FROM users AS T
    INNER JOIN inserted AS I
        ON T.user_id = I.user_id;
END;
GO

-- 2. Bảng playlists
CREATE TRIGGER trg_Update_playlists
ON playlists
AFTER UPDATE
AS
BEGIN
    UPDATE T
    SET playlist_updated_at = GETDATE()
    FROM playlists AS T
    INNER JOIN inserted AS I
        ON T.playlist_id = I.playlist_id;
END;
GO

-- 3. Bảng artists
CREATE TRIGGER trg_Update_artists
ON artists
AFTER UPDATE
AS
BEGIN
    UPDATE T
    SET artist_updated_at = GETDATE()
    FROM artists AS T
    INNER JOIN inserted AS I
        ON T.artist_id = I.artist_id;
END;
GO

-- 4. Bảng albums
CREATE TRIGGER trg_Update_albums
ON albums
AFTER UPDATE
AS
BEGIN
    UPDATE T
    SET album_updated_at = GETDATE()
    FROM albums AS T
    INNER JOIN inserted AS I
        ON T.album_id = I.album_id;
END;
GO

-- 5. Bảng songs
CREATE TRIGGER trg_Update_songs
ON songs
AFTER UPDATE
AS
BEGIN
    UPDATE T
    SET song_updated_at = GETDATE()
    FROM songs AS T
    INNER JOIN inserted AS I
        ON T.song_id = I.song_id;
END;
GO

-- 6. Bảng plans
CREATE TRIGGER trg_Update_plans
ON plans
AFTER UPDATE
AS
BEGIN
    UPDATE T
    SET plan_updated_at = GETDATE()
    FROM plans AS T
    INNER JOIN inserted AS I
        ON T.plan_id = I.plan_id;
END;
GO

-- 7. Bảng subscriptions
CREATE TRIGGER trg_Update_subscriptions
ON subscriptions
AFTER UPDATE
AS
BEGIN
    UPDATE T
    SET subscription_updated_at = GETDATE()
    FROM subscriptions AS T
    INNER JOIN inserted AS I
        ON T.subscription_id = I.subscription_id;
END;
GO

-- 8. Bảng payments
CREATE TRIGGER trg_Update_payments
ON payments
AFTER UPDATE
AS
BEGIN
    UPDATE T
    SET payment_updated_at = GETDATE()
    FROM payments AS T
    INNER JOIN inserted AS I
        ON T.payment_id = I.payment_id;
END;
GO


-- Tăng play_count trong bảng songs khi có bản ghi mới trong bảng listens
CREATE TRIGGER trg_increment_song_play_count
ON listens
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Cập nhật play count cho từng bài hát được nghe
    UPDATE s
    SET s.song_play_count = s.song_play_count + cnt.play_count
    FROM songs AS s
    INNER JOIN (
        -- Đếm số lượt nghe trên từng song_id được chèn
        SELECT listen_song_id, COUNT(*) AS play_count
        FROM inserted
        GROUP BY listen_song_id
    ) AS cnt
    ON s.song_id = cnt.listen_song_id;
END;
GO

-- *** TRIGGER MỚI ***
-- Giảm play_count trong bảng songs khi bản ghi bị xóa khỏi bảng listens
CREATE TRIGGER trg_decrement_song_play_count
ON listens
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Cập nhật (giảm) play count cho từng bài hát
    UPDATE s
    SET s.song_play_count = s.song_play_count - cnt.play_count
    FROM songs AS s
    INNER JOIN (
        -- Đếm số lượt nghe trên từng song_id bị xóa
        SELECT listen_song_id, COUNT(*) AS play_count
        FROM deleted
        GROUP BY listen_song_id
    ) AS cnt
    ON s.song_id = cnt.listen_song_id
    -- Đảm bảo play count không bao giờ bị âm
    WHERE s.song_play_count >= cnt.play_count;

    -- Xử lý trường hợp play_count có thể bị âm (nếu dữ liệu không nhất quán)
    UPDATE s
    SET s.song_play_count = 0
    FROM songs AS s
    INNER JOIN (
        SELECT listen_song_id
        FROM deleted
        GROUP BY listen_song_id
    ) AS cnt
    ON s.song_id = cnt.listen_song_id
    WHERE s.song_play_count < 0;
END;
GO

-- Tự động thiết lập subscription_end_date dựa trên plan_billing_cycle khi tạo mới subscription
CREATE TRIGGER trg_set_subscription_end
ON subscriptions
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE s
    SET s.subscription_end_date =
        CASE p.plan_billing_cycle
            WHEN 'monthly' THEN DATEADD(MONTH, 1, s.subscription_start_date)
            WHEN 'annually' THEN DATEADD(YEAR, 1, s.subscription_start_date)
            WHEN 'perpetual' THEN '2099-12-31'
            ELSE NULL
        END
    FROM subscriptions s
    JOIN plans p ON s.plan_id = p.plan_id
    JOIN inserted i ON i.subscription_id = s.subscription_id;
END;
GO