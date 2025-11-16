-----------------------------------------------------
-- 1. Bảng plans (Yêu cầu: 5 dòng)
-- CẬP NHẬT: Thêm các gói VND
-- Giả sử: $1 = 25,000 VND
-----------------------------------------------------
SET IDENTITY_INSERT plans ON;
INSERT INTO plans (plan_id, plan_name, plan_is_active, plan_price, plan_currency, plan_billing_cycle, plan_description)
VALUES
-- Gói Free (Mặc định VND)
(1, N'free', 1, 0.00, 'VND', 'perpetual', N'Nghe nhạc có quảng cáo, chất lượng tiêu chuẩn.'),

-- Gói Premium USD
(2, N'premium', 1, 5.00, 'USD', 'monthly', N'Gói Premium hàng tháng (USD), không quảng cáo.'),
(3, N'premium', 1, 51.00, 'USD', 'annually', N'Gói Premium hàng năm (USD) (Tiết kiệm 15%).'),

-- Gói Premium VND (Tương đương)
(4, N'premium', 1, 125000.00, 'VND', 'monthly', N'Gói Premium hàng tháng (VND), không quảng cáo.'),
(5, N'premium', 1, 1275000.00, 'VND', 'annually', N'Gói Premium hàng năm (VND) (Tiết kiệm 15%).');
SET IDENTITY_INSERT plans OFF;
GO
-----------------------------------------------------
-- 21. Bảng subscriptions (Yêu cầu: 20 dòng)
-- CẬP NHẬT: Sửa 'plan_id' để trỏ đến các gói USD và VND
-----------------------------------------------------
SET IDENTITY_INSERT subscriptions ON;
INSERT INTO subscriptions (subscription_id, subscription_start_date, user_id, plan_id, subscription_status, subscription_end_date)
VALUES
-- 3 Premium Annually (USD) - plan_id = 3
(1, '2024-01-01', 5, 3, 'active', '2024-01-01'),
(2, '2024-02-01', 6, 3, 'active', '2024-02-01'),
(3, '2024-03-01', 7, 3, 'active', '2024-03-01'),
-- 2 Premium Annually (VND) - plan_id = 5
(4, '2024-04-01', 8, 5, 'active', '2024-04-01'),
(5, '2024-05-01', 9, 5, 'active', '2024-05-01'),

-- 3 Premium Monthly (USD) - plan_id = 2
(6, '2024-10-01', 10, 2, 'active', '2024-10-01'),
(7, '2024-10-05', 11, 2, 'active', '2024-10-05'),
(8, '2024-10-10', 12, 2, 'active', '2024-10-10'),
-- 2 Premium Monthly (VND) - plan_id = 4
(9, '2024-10-15', 13, 4, 'active', '2024-10-15'),
(10, '2024-10-20', 14, 4, 'active', '2024-10-20'),

-- 5 Free (Perpetual) - plan_id = 1 (VND)
(11, '2024-01-01', 15, 1, 'active', '2024-01-01'),
(12, '2024-01-01', 16, 1, 'active', '2024-01-01'),
(13, '2024-01-01', 17, 1, 'active', '2024-01-01'),
(14, '2024-01-01', 18, 1, 'active', '2024-01-01'),
(15, '2024-01-01', 19, 1, 'active', '2024-01-01'),

-- 5 Expired / Pending
(16, '2023-01-01', 20, 2, 'expired', '2023-02-01'), -- Gói tháng USD
(17, '2023-05-01', 1, 2, 'expired', '2023-06-01'), -- Gói tháng USD
(18, '2025-12-01', 2, 4, 'pending', NULL), -- Chờ thanh toán gói tháng VND
(19, '2025-12-02', 3, 4, 'pending', NULL), -- Chờ thanh toán gói tháng VND
(20, '2023-09-01', 4, 3, 'expired', '2024-09-01'); -- Gói năm USD
SET IDENTITY_INSERT subscriptions OFF;
GO

WAITFOR DELAY '00:00:01';
GO

-----------------------------------------------------
-- 22. Bảng payments (Yêu cầu: 20+ dòng)
-- CẬP NHẬT: 'payment_amount' và 'payment_currency' phải
-- khớp với plan_id của subscription tương ứng.
-----------------------------------------------------
INSERT INTO payments (payment_amount, payment_currency, payment_method, payment_status, subscription_id)
VALUES
-- Thanh toán cho 3 gói năm USD (Plan 3 - $51.00)
(51.00, 'USD', 'credit_card', 'completed', 1),
(51.00, 'USD', 'paypal', 'completed', 2),
(51.00, 'USD', 'bank_transfer', 'completed', 3),
-- Thanh toán cho 2 gói năm VND (Plan 5 - 1,275,000 VND)
(1275000.00, 'VND', 'apple_pay', 'completed', 4),
(1275000.00, 'VND', 'credit_card', 'completed', 5),

-- Thanh toán cho 3 gói tháng USD (Plan 2 - $5.00)
(5.00, 'USD', 'credit_card', 'completed', 6),
(5.00, 'USD', 'paypal', 'completed', 7),
(5.00, 'USD', 'bank_transfer', 'completed', 8),
-- Thanh toán cho 2 gói tháng VND (Plan 4 - 125,000 VND)
(125000.00, 'VND', 'apple_pay', 'completed', 9),
(125000.00, 'VND', 'credit_card', 'completed', 10),

-- Thanh toán cho 5 gói Free (Plan 1 - 0 VND)
(0.00, 'VND', 'credit_card', 'completed', 11),
(0.00, 'VND', 'credit_card', 'completed', 12),
(0.00, 'VND', 'credit_card', 'completed', 13),
(0.00, 'VND', 'credit_card', 'completed', 14),
(0.00, 'VND', 'credit_card', 'completed', 15),

-- Thanh toán cho 5 gói Expired/Pending
(5.00, 'USD', 'credit_card', 'completed', 16), -- (Plan 2)
(5.00, 'USD', 'paypal', 'completed', 17), -- (Plan 2)
(125000.00, 'VND', 'bank_transfer', 'pending', 18), -- (Plan 4)
(125000.00, 'VND', 'apple_pay', 'failed', 19), -- (Plan 4)
(51.00, 'USD', 'credit_card', 'completed', 20); -- (Plan 3)
GO