CREATE TABLE users (
    user_id INT PRIMARY KEY IDENTITY(1,1), -- id user
    user_username VARCHAR(50) NOT NULL UNIQUE, -- use to login
    user_email VARCHAR(100) NOT NULL UNIQUE, -- email user
    user_password_hash VARCHAR(255) NOT NULL, -- password hash
    user_fullname NVARCHAR(100) NOT NULL, --user full name
    user_display_name NVARCHAR(100) NOT NULL,  -- user display name (có thể khác fullname, ví dụ như biệt danh, nghệ danh hay tên đặc biệt)
    user_avatar_url VARCHAR(255), -- url ảnh đại diện
    user_bio NVARCHAR(MAX), -- tiểu sử người dùng
    user_date_of_birth DATE, -- ngày sinh người dùng, có thể dùng để đề xuất nhạc phù hợp với độ tuổi vì ở cột song có cột song_is_explicit
    user_country_code VARCHAR(3) DEFAULT 'VN' NOT NULL, -- sử dụng khi 
    -- user_last_active DATETIME2 DEFAULT GETDATE(),
    user_created_at DATETIME2 DEFAULT GETDATE(), -- thời điểm tạo tài khoản
    user_updated_at DATETIME2 DEFAULT GETDATE(), -- thời điểm cập nhật thông tin tài khoản gần nhất
    user_role VARCHAR(10) DEFAULT 'user', -- vai trò của user trong hệ thống: 'user', 'artist', 'admin'

    -- Thêm các cột để theo dõi số lần đăng nhập thất bại và trạng thái khóa tài khoản
    user_failed_login_attempts INT DEFAULT 0, -- số lần đăng nhập thất bại
    user_last_failed_login DATETIME2 NULL, -- thời điểm đăng nhập thất bại gần nhất
    user_account_locked_until DATETIME2 NULL -- thời điểm tài khoản bị khóa hết hạn
);
-- Thêm ràng buộc kiểm tra cho cột user_role phải là một trong các giá trị 'user', 'artist', 'admin'
GO
ALTER TABLE users
ADD CONSTRAINT CK_user_role_validity
CHECK (user_role IN ('user', 'artist', 'admin'));
GO
-- thêm ràng buộc kiểm tra số lần đăng nhập thất bại phải từ 0 đến 5
ALTER TABLE users
ADD CONSTRAINT CK_user_failed_login_range
CHECK (user_failed_login_attempts >= 0 AND user_failed_login_attempts <= 5);

CREATE TABLE user_tokens (
    token_id INT PRIMARY KEY IDENTITY(1,1),
    token_hash VARCHAR(255) UNIQUE NOT NULL, -- hash của token để xác thực
    -- thời điểm hết hạn của token
    token_expires_at DATETIME2 NOT NULL, -- thời điểm hết hạn của token
    token_created_at DATETIME2 DEFAULT GETDATE(), -- thời điểm tạo token
    token_device_info VARCHAR(255),
    -- đánh dấu token đã bị thu hồi (revoked) hay chưa
    token_revoked_at DATETIME2 NULL, -- đánh dấu token đã bị thu hồi từ lúc nào
    token_ip_address VARCHAR(45), -- địa chỉ IP khi tạo token
    user_id INT NOT NULL -- FK tới bảng users
);
GO
ALTER TABLE user_tokens 
ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE; -- khi user bị xoá thì xoá luôn hết token của user đó
GO

CREATE TABLE search_history (
    search_id INT PRIMARY KEY IDENTITY(1,1), -- id tìm kiếm
    search_query_text NVARCHAR(255) NOT NULL, -- từ khoá tìm kiếm
    searched_at DATETIME2 DEFAULT GETDATE(), -- thời điểm tìm kiếm
    user_id INT NOT NULL -- FK tới bảng users
);
GO
ALTER TABLE search_history 
ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE; -- khi user bị xoá thì xoá luôn hết lịch sử tìm kiếm của user đó
GO

CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY IDENTITY(1,1),
    playlist_name NVARCHAR(100) NOT NULL, -- tên playlist
    playlist_description NVARCHAR(MAX), -- mô tả playlist
    playlist_created_at DATETIME2 DEFAULT GETDATE(), -- thời điểm tạo playlist
    playlist_updated_at DATETIME2 DEFAULT GETDATE(), -- thời điểm cập nhật playlist gần nhất(thêm sửa xoá bài hát trong playlist)
    playlist_is_public BIT DEFAULT 0 -- đánh dấu playlist có công khai hay không
);
GO

CREATE TABLE user_playlists (
    user_id INT NOT NULL, -- FK tới bảng users
    playlist_id INT NOT NULL, -- FK tới bảng playlists
    shared_at DATETIME2 DEFAULT GETDATE(), -- thời điểm user được chia sẻ playlist
    role VARCHAR(20) DEFAULT 'owner', -- vai trò của user trong playlist: 'owner', 'contributor', 'viewer'
    PRIMARY KEY (user_id, playlist_id) 
);
GO
ALTER TABLE user_playlists ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
ALTER TABLE user_playlists ADD FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id) ON DELETE CASCADE;
GO
ALTER TABLE user_playlists
ADD CONSTRAINT CHK_user_playlist_role
CHECK (role IN ('owner', 'contributor', 'viewer'));
GO

CREATE TABLE artists (
    artist_id INT PRIMARY KEY IDENTITY(1,1),
    artist_name NVARCHAR(255) NOT NULL, -- tên nghệ sĩ(có thể là tên thật hoặc nghệ danh)
    artist_avatar_url VARCHAR(255), -- url ảnh đại diện nghệ sĩ
    artist_description NVARCHAR(MAX), -- mô tả về nghệ sĩ
    artist_country_code VARCHAR(3) NOT NULL, -- mã quốc gia nghệ sĩ
    artist_created_at DATETIME2 DEFAULT GETDATE(), -- ngày nghệ sĩ được thêm vào hệ thống
    artist_updated_at DATETIME2 DEFAULT GETDATE(), -- ngày nghệ sĩ được cập nhật thông tin gần nhất
    --soft  delete
    artist_deleted_at DATETIME2 NULL, -- ngày nghệ sĩ bị xoá khỏi hệ thống
    -- artist có thể là 1 user trong hệ thống
    artist_user_id INT NULL
);
GO
ALTER TABLE artists 
ADD FOREIGN KEY (artist_user_id) REFERENCES users(user_id) ON DELETE SET NULL; -- khi user bị xoá thì set NULL cột artist_user_id 
GO

CREATE TABLE albums (
    album_id INT PRIMARY KEY IDENTITY(1,1),
    album_title NVARCHAR(255) NOT NULL, -- tiêu đề album , tên album
    album_description NVARCHAR(MAX), -- mô tả về album
   
    album_release_date DATE, -- ngày ra mắt album

    album_created_at DATETIME2 DEFAULT GETDATE(), -- ngày album được thêm vào hệ thống
    album_updated_at DATETIME2 DEFAULT GETDATE(), -- ngày album được cập nhật thông tin gần nhất
    album_deleted_at DATETIME2 NULL, -- ngày album xoá khỏi hệ thống, xoá mềm
    album_cover_url VARCHAR(255), -- url ảnh bìa album
    artist_id INT NOT NULL -- FK tới bảng artists
);
GO
ALTER TABLE albums ADD FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE NO ACTION;
GO

CREATE TABLE songs (
    song_id INT PRIMARY KEY IDENTITY(1,1), -- ID bài hát
    song_title NVARCHAR(255) NOT NULL, -- tiêu đề bài hát, tên bài hát
    song_description NVARCHAR(MAX), -- mô tả về bài hát
    song_release_date DATE, -- ngày phát hành bài hát
    song_duration_seconds INT, -- thời gian bài hát (giây)
    song_created_at DATETIME2 DEFAULT GETDATE(), -- ngày bài hát được thêm vào hệ thống
    song_updated_at DATETIME2 DEFAULT GETDATE(), -- ngày bài hát được cập nhật thông tin gần nhất
    song_deleted_at DATETIME2 NULL, -- ngày bài hát bị xoá khỏi hệ thống
    song_play_count INT DEFAULT 0, -- số lần bài hát được phát
    song_is_explicit BIT DEFAULT 0, -- đánh dấu bài hát có nội dung dành cho người lớn
    song_cover_url VARCHAR(255), -- url ảnh bìa bài hát
    song_audio_url VARCHAR(255) NOT NULL UNIQUE, -- url file audio bài hát
    album_id INT NULL -- FK tới bảng albums
);
GO
ALTER TABLE songs ADD FOREIGN KEY (album_id) REFERENCES albums(album_id) ON DELETE SET NULL;
GO
-- rằng buộc bài hát phải có thời lượng dương
ALTER TABLE songs
ADD CONSTRAINT CHK_song_duration_positive CHECK (song_duration_seconds > 0);
GO

CREATE TABLE lyrics (
    song_id INT NOT NULL PRIMARY KEY,  -- FK tới bảng songs, mỗi bài hát chỉ có 1 lời, thực thể yếu nên lấy khoá chính của tt cha làm khoá chính
    lyric_text NVARCHAR(MAX), -- nội dung lời bài hát
    FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE CASCADE -- khi bài hát bị xoá thì xoá luôn lời bài hát
);
GO

CREATE TABLE song_artists (
    song_id INT,
    artist_id INT,
    role VARCHAR(100),
    PRIMARY KEY (song_id, artist_id, role)
);
GO
ALTER TABLE song_artists ADD FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE NO ACTION;
GO
ALTER TABLE song_artists ADD FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE NO ACTION;
GO
ALTER TABLE song_artists
ADD CONSTRAINT CHK_song_artist_role
CHECK (role IN ('primary', 'featured'));
GO

CREATE TABLE genres (
    genre_id INT PRIMARY KEY IDENTITY(1,1),
    genre_name NVARCHAR(100) NOT NULL UNIQUE,
    genre_created_at DATETIME2 DEFAULT GETDATE(),
    genre_updated_at DATETIME2 DEFAULT GETDATE(),
    genre_deleted_at DATETIME2 NULL
);
GO

CREATE TABLE song_genres (
    song_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (song_id, genre_id)
);


GO
ALTER TABLE song_genres ADD FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE NO ACTION;
GO
ALTER TABLE song_genres ADD FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE NO ACTION;
GO

CREATE TABLE playlist_songs (
    added_at DATETIME2 DEFAULT GETDATE(),
    track_order INT NOT NULL,
    playlist_id INT NOT NULL,
    song_id INT NOT NULL,
    PRIMARY KEY (playlist_id, song_id)
);
GO
ALTER TABLE playlist_songs ADD FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id) ON DELETE CASCADE;
GO
ALTER TABLE playlist_songs ADD FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE NO ACTION;
GO
ALTER TABLE playlist_songs
ADD CONSTRAINT UQ_playlist_track_order
UNIQUE (playlist_id, track_order);
GO


CREATE TABLE listens(
    listen_id BIGINT PRIMARY KEY IDENTITY(1,1),
    listen_user_id INT NOT NULL,
    listen_song_id INT NOT NULL,
    listened_at DATETIME2 DEFAULT GETDATE(),
    listened_seconds INT,
    ip_address VARCHAR(45),
    device_info VARCHAR(255)
);
GO
ALTER TABLE listens ADD FOREIGN KEY (listen_user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
ALTER TABLE listens ADD FOREIGN KEY (listen_song_id) REFERENCES songs(song_id) ON DELETE NO ACTION;
GO



CREATE TABLE user_like_songs (
    liked_at DATETIME2 DEFAULT GETDATE(),
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    PRIMARY KEY (user_id, song_id)
);
GO
ALTER TABLE user_like_songs ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
ALTER TABLE user_like_songs ADD FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE NO ACTION;
GO

CREATE TABLE user_follow_artists (
    followed_at DATETIME2 DEFAULT GETDATE(),
    user_id INT NOT NULL,
    artist_id INT NOT NULL,
    PRIMARY KEY (user_id, artist_id)
);
GO
ALTER TABLE user_follow_artists ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
ALTER TABLE user_follow_artists ADD FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE NO ACTION;
GO


CREATE TABLE user_follow_users (
    followed_at DATETIME2 DEFAULT GETDATE(),
    follower_id INT NOT NULL, -- ID của người đi theo dõi
    following_id INT NOT NULL, -- ID của người được theo dõi
    PRIMARY KEY (follower_id, following_id)
)
GO
ALTER TABLE user_follow_users ADD FOREIGN KEY (follower_id) REFERENCES users(user_id) ON DELETE NO ACTION;
GO
ALTER TABLE user_follow_users ADD FOREIGN KEY (following_id) REFERENCES users(user_id) ON DELETE NO ACTION;
GO
-- có trigger xoá folloing id khi xoá user
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
ALTER TABLE user_like_albums ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
ALTER TABLE user_like_albums ADD FOREIGN KEY (album_id) REFERENCES albums(album_id) ON DELETE NO ACTION;
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
ALTER TABLE user_recommendations ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
ALTER TABLE user_recommendations ADD FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE NO ACTION;
GO

CREATE TABLE plans (
    plan_id INT PRIMARY KEY IDENTITY(1,1),
    plan_name NVARCHAR(30) NOT NULL DEFAULT 'free',
    plan_is_active BIT DEFAULT 1,
    plan_price DECIMAL(10, 2) NOT NULL,
    plan_currency VARCHAR(3) DEFAULT 'VND' NOT NULL,
    plan_billing_cycle VARCHAR(30) NOT NULL,
    plan_description NVARCHAR(MAX),
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
UNIQUE (plan_name, plan_billing_cycle, plan_currency);
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
ALTER TABLE subscriptions ADD FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
GO
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
    payment_currency VARCHAR(3) DEFAULT 'VND' NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(50) NOT NULL,
    payment_created_at DATETIME2 DEFAULT GETDATE(),
    payment_updated_at DATETIME2 DEFAULT GETDATE(),
    subscription_id INT NULL
);
GO
ALTER TABLE payments ADD FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id) ON DELETE SET NULL;
GO
ALTER TABLE payments
ADD CONSTRAINT CHK_payment_method
CHECK (payment_method IN ('credit_card', 'paypal', 'bank_transfer', 'apple_pay'));
GO
ALTER TABLE payments
ADD CONSTRAINT CHK_payment_status
CHECK (payment_status IN ('pending', 'completed', 'failed'));



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

GO

---
-- *** TRIGGER QUAN TRỌNG CHO BẢNG LISTENS ***
---

--1 khóa tài khoản khi đăng nhập thất bại >= 5 lần
GO
CREATE TRIGGER trg_LockUserAccount
ON users
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;
    IF NOT UPDATE(user_failed_login_attempts) RETURN;

    -- Thực hiện update trạng thái khóa
    UPDATE u
    SET 
        user_account_locked_until =
            CASE 
                -- Nếu sai >= 5 lần -> Khóa 15 phút tính từ hiện tại
                WHEN i.user_failed_login_attempts >= 5 
                    THEN DATEADD(MINUTE, 15, GETDATE()) 
                -- Nếu số lần sai < 5 (ví dụ đã reset về 0) -> Mở khóa (NULL)
                ELSE NULL
            END
    FROM users u
    INNER JOIN inserted i ON u.user_id = i.user_id;
END;
GO
--2 Tăng play_count khi INSERT
CREATE TRIGGER trg_increment_song_play_count
ON listens
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE s
    SET s.song_play_count = s.song_play_count + cnt.play_count
    FROM songs AS s
    INNER JOIN (
        SELECT listen_song_id, COUNT(*) AS play_count
        FROM inserted
        GROUP BY listen_song_id
    ) AS cnt
    ON s.song_id = cnt.listen_song_id;
END;
GO

--3 Giảm play_count khi DELETE (Sẽ được kích hoạt khi User bị hard-delete)
CREATE TRIGGER trg_decrement_song_play_count
ON listens
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE s
    SET s.song_play_count = s.song_play_count - cnt.play_count
    FROM songs AS s
    INNER JOIN (
        SELECT listen_song_id, COUNT(*) AS play_count
        FROM deleted
        GROUP BY listen_song_id
    ) AS cnt
    ON s.song_id = cnt.listen_song_id
    WHERE s.song_play_count >= cnt.play_count;

    -- Đảm bảo không bị âm
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
---

--4 Tự động set ngày hết hạn subscription
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

--5 Dọn dẹp playlist mồ côi (Rất quan trọng)
-- Kích hoạt khi một liên kết user-playlist bị xóa
CREATE TRIGGER trg_cleanup_orphan_playlists
ON user_playlists
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Xóa các playlist trong bảng playlists
    -- mà không còn bất kỳ 'owner' nào trong bảng user_playlists
    DELETE p
    FROM playlists AS p
    JOIN deleted AS d ON p.playlist_id = d.playlist_id -- Chỉ kiểm tra các playlist vừa bị tác động
    WHERE NOT EXISTS (
        SELECT 1
        FROM user_playlists up
        WHERE up.playlist_id = d.playlist_id AND up.role = 'owner'
    );
END;
GO


-- Procedure xoá user an toàn, tránh user follow user mồ côi


CREATE PROCEDURE sp_DeleteUser
    @UserIDToDelete INT
AS
BEGIN
    -- Tắt các thông báo "x rows affected"
    SET NOCOUNT ON;
    
    -- Transaction để đảm bảo tính toàn vẹn dữ liệu
    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Dọn dẹp thủ công bảng có vấn đề TRƯỚC
        DELETE FROM user_follow_users
        WHERE follower_id = @UserIDToDelete OR following_id = @UserIDToDelete;

        -- 2. Xóa người dùng thật S.A.U
        -- (Lệnh này sẽ kích hoạt tất cả các ON DELETE CASCADE khác)
        DELETE FROM users
        WHERE user_id = @UserIDToDelete;

        -- 3. Nếu mọi thứ thành công
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- 4. Nếu có lỗi, hủy bỏ mọi thay đổi
        ROLLBACK TRANSACTION;
        
        -- Báo lỗi ra cho ứng dụng
        THROW; 
    END CATCH
END;
GO



-- Procedure xoá bài hát khỏi playlist và cập nhật lại thứ tự bài hát
CREATE PROCEDURE sp_RemoveSongFromPlaylist
    @PlaylistID INT,
    @SongID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Bắt đầu transaction để đảm bảo tính toàn vẹn (xoá xong phải update được)
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Bước 1: Lấy track_order của bài hát sắp bị xoá
        DECLARE @DeletedOrder INT;
        
        SELECT @DeletedOrder = track_order
        FROM playlist_songs
        WHERE playlist_id = @PlaylistID AND song_id = @SongID;

        -- Nếu bài hát không tồn tại trong playlist, huỷ bỏ
        IF @DeletedOrder IS NULL
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT N'Bài hát không tồn tại trong playlist.';
            RETURN;
        END

        -- Bước 2: Xoá bài hát khỏi bảng (Tạo ra một lỗ hổng trong thứ tự)
        DELETE FROM playlist_songs
        WHERE playlist_id = @PlaylistID AND song_id = @SongID;

        -- Bước 3: Cập nhật lại (Shift left) các bài hát nằm sau bài vừa xoá
        -- Ví dụ: Xoá bài 3. Bài 4 sẽ thành 3, bài 5 sẽ thành 4.
        UPDATE playlist_songs
        SET track_order = track_order - 1
        WHERE playlist_id = @PlaylistID 
          AND track_order > @DeletedOrder;

        -- Hoàn tất
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Nếu có lỗi thì hoàn tác mọi thay đổi
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO



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
-- Thêm index hỗ trợ tác vụ nền xoá token hết hạn
CREATE INDEX idx_token_expires_at ON user_tokens(token_expires_at);
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