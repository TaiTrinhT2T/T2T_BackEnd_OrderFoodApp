USE [DatHangAn]
GO
/****** Object:  StoredProcedure [dbo].[Login_CheckAccount]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Login_CheckAccount]
(
	@NameOrEmail NVARCHAR(50),
	@Password NVARCHAR(50)
)
as
begin
	DECLARE @result INT
	IF( (SELECT COUNT(*) FROM TaiKhoan WHERE TenTaiKhoan = @NameOrEmail and MatKhau = @Password) > 0 OR
		(SELECT COUNT(*) FROM TaiKhoan WHERE Email = @NameOrEmail and MatKhau = @Password) > 0)
		SET @result = 1
	ELSE 
	BEGIN
		SET @result = 0
	END
	SELECT @result
end
GO
/****** Object:  StoredProcedure [dbo].[Login_SelectAccount]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Login_SelectAccount]
(
	@NameOrEmail NVARCHAR(50),
	@Password NVARCHAR(50)
)
as
begin
	SELECT * FROM TaiKhoan WHERE 
			(TenTaiKhoan = @NameOrEmail and MatKhau = @Password) 
			OR (Email = @NameOrEmail and MatKhau = @Password)
end
GO
/****** Object:  StoredProcedure [dbo].[SelectAll_MonAn]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[SelectAll_MonAn]
as
begin
	select M.*, G.GiaBan, G.GiaKhuyenMai from MonAn M, GiaBan G where M.ID_MonAn = G.ID_MonAn
end
GO
/****** Object:  StoredProcedure [dbo].[TaiKhoan_Insert]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[TaiKhoan_Insert]
(
	@TenTaiKhoan NVARCHAR(50),
	@Email NVARCHAR(50),
	@SoDienThoai NVARCHAR(50),
	@MatKhau NVARCHAR(50)
)
as
begin
	DECLARE @result INT
	IF( (SELECT COUNT(*) FROM TaiKhoan WHERE Email = @Email) > 0)
	begin
		SET @result = 0
	end
	ELSE 
	BEGIN
		insert into TaiKhoan( TenTaiKhoan, Email, SoDienThoai, TienNap, MatKhau, Online)
		values ( @TenTaiKhoan, @Email, @SoDienThoai, '0', @MatKhau, 0)
		SET @result = 1
	END
	SELECT @result
end
GO
/****** Object:  Table [dbo].[DatHang]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatHang](
	[ID_DonHang] [int] NOT NULL,
	[ID_MonAn] [int] NOT NULL,
	[SoLuong] [int] NULL,
 CONSTRAINT [PK_DatHang] PRIMARY KEY CLUSTERED 
(
	[ID_DonHang] ASC,
	[ID_MonAn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[ID_DonHang] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NOT NULL,
	[ID_NhaHang] [int] NOT NULL,
	[ThoiGian] [datetime] NULL,
	[TrangThai] [int] NULL,
 CONSTRAINT [PK_DonHang_1] PRIMARY KEY CLUSTERED 
(
	[ID_DonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GiaBan]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaBan](
	[ID_GiaBan] [int] NOT NULL,
	[ID_MonAn] [int] NOT NULL,
	[GiaBan] [nvarchar](50) NULL,
	[GiaKhuyenMai] [nvarchar](50) NULL,
	[ThoiGianBatDau] [datetime] NULL,
	[ThoiGianKetThuc] [datetime] NULL,
 CONSTRAINT [PK_GiaBan] PRIMARY KEY CLUSTERED 
(
	[ID_GiaBan] ASC,
	[ID_MonAn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Loai]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loai](
	[ID_LoaiMonAn] [int] IDENTITY(1,1) NOT NULL,
	[Tên] [nvarchar](50) NULL,
	[MoTa] [nvarchar](500) NULL,
 CONSTRAINT [PK_Loai] PRIMARY KEY CLUSTERED 
(
	[ID_LoaiMonAn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoaiMonAn]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiMonAn](
	[ID_MonAn] [int] NOT NULL,
	[ID_LoaiMonAn] [int] NOT NULL,
 CONSTRAINT [PK_LoaiMonAn] PRIMARY KEY CLUSTERED 
(
	[ID_MonAn] ASC,
	[ID_LoaiMonAn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MonAn]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonAn](
	[ID_MonAn] [int] IDENTITY(1,1) NOT NULL,
	[TenMonAn] [nvarchar](50) NULL,
	[MoTa] [nvarchar](500) NULL,
	[SrcImg] [nvarchar](500) NULL,
 CONSTRAINT [PK_MonAn] PRIMARY KEY CLUSTERED 
(
	[ID_MonAn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MonAnYeuThich]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonAnYeuThich](
	[ID_TaiKhoan] [int] NOT NULL,
	[ID_MonAn] [int] NOT NULL,
	[YeuThich] [bit] NULL,
 CONSTRAINT [PK_MonAnYeuThich] PRIMARY KEY CLUSTERED 
(
	[ID_TaiKhoan] ASC,
	[ID_MonAn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhaHang]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaHang](
	[ID_NhaHang] [int] IDENTITY(1,1) NOT NULL,
	[TenNhaHang] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[ViTri] [nvarchar](500) NULL,
	[SoDienThoai] [nvarchar](50) NULL,
	[MoTa] [nvarchar](500) NULL,
 CONSTRAINT [PK_NhaHang] PRIMARY KEY CLUSTERED 
(
	[ID_NhaHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhaHang_MonAn]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaHang_MonAn](
	[ID_NhaHang] [int] NOT NULL,
	[ID_MonAn] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 03/06/2018 11:17:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[ID_TaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[TenTaiKhoan] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[SoDienThoai] [nvarchar](50) NULL,
	[TienNap] [nvarchar](50) NULL,
	[MatKhau] [nvarchar](50) NULL,
	[Online] [bit] NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[DatHang] ([ID_DonHang], [ID_MonAn], [SoLuong]) VALUES (1, 1, 1)
INSERT [dbo].[DatHang] ([ID_DonHang], [ID_MonAn], [SoLuong]) VALUES (2, 2, 1)
INSERT [dbo].[DatHang] ([ID_DonHang], [ID_MonAn], [SoLuong]) VALUES (3, 3, 1)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (1, 1, N'140000', N'85000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (2, 2, N'45000', N'25000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (3, 3, N'60000', N'44000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (4, 4, N'45000', N'31000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (5, 5, N'50000', N'28000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (6, 6, N'36000', N'21900', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (7, 7, N'70000', N'42000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (8, 8, N'70000', N'42300', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (9, 9, N'70000', N'41500', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (10, 10, N'60000', N'25100', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (11, 11, N'50000', N'30500', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (12, 12, N'15000', N'9000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (13, 13, N'40000', N'29300', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (14, 14, N'60000', N'40000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (15, 15, N'40000', N'30000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (16, 16, N'60000', N'55000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (17, 17, N'40000', N'35000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (18, 18, N'60000', N'50000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (19, 19, N'50000', N'45000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (20, 20, N'75000', N'60000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (21, 21, N'60000', N'50000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (22, 22, N'60000', N'50000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (23, 23, N'45000', N'40000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (24, 24, N'60000', N'50000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (25, 25, N'60000', N'50000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (26, 26, N'70000', N'66500', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (27, 27, N'115000', N'100000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (28, 28, N'50000', N'45000', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (29, 29, N'50000', N'47500', NULL, NULL)
INSERT [dbo].[GiaBan] ([ID_GiaBan], [ID_MonAn], [GiaBan], [GiaKhuyenMai], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (30, 30, N'60000', N'55000', NULL, NULL)
SET IDENTITY_INSERT [dbo].[MonAn] ON 

INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (1, N'Pizza', N'Pizza hải sản, bò, xúc xích', N'pizza')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (2, N'Nâu đá/ Nâu nóng', N'Cafe truyền thống pha với sữa đặc', N'nau_da')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (3, N'Cappuccino', N'Cafe espresso pha với sữa tươi và kem sữa mặt', N'cappuccino')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (4, N'Chanh tuyết', N'Mát lạnh, hương thơm mát và rất giàu vitamin', N'chanh_tuyet')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (5, N'Trà cam đào', N'Sự kết hợp của trà đào, cam và nước ép', N'tra_dao')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (6, N'Đen đá/ Đen nóng', N'Cà phê đen truyền thống', N'den_da')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (7, N'Cà phê cốt dừa', N'Sự kết hợp giữa espresso với sữa đặc, nước cốt dừa và đá', N'ca_phe_cot_dua')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (8, N'Matcha', N'Matcha trà xanh', N'matcha')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (9, N'Sữa chua xoài', N'Sữa chua vị xoài', N'sua_chua_xoai')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (10, N'Bánh ngọt', N'Tiramisu, Việt quất, Chanh leo, Bánh táo ...', N'banh_ngot')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (11, N'Americano (nóng/đá)', N'Phong cách pha cafe được yêu thích nhất tại Mỹ', N'americano')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (12, N'Lavie', N'Sự kết hợp giữa nguồn nước trong lành và 06 loại khoáng thiên nhiên', N'lavie')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (13, N'Kem', N'Socola, Vani, Caramel, Dâu, Dừa, Xoài, Hạt dẻ, ...', N'kem')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (14, N'Bún chả', N'Bún chả hương vị truyền thống', N'bun_cha')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (15, N'Bánh mỳ thịt nướng BBQ', N'Bánh mỳ nóng giòn nhân thịt nướng BBQ đậm đà cùng rau thơm và các loại sốt', N'banh_my_bbq')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (16, N'Fresh Juice (Nước Ép)', N'Nước ép Cam, Bưởi, Dừa, Dứa, Cà rốt, Chanh leo', N'nuoc_ep')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (17, N'Phô Mai Que', N'Phô mai que chiên giòn', N'pho_mai_que')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (18, N'Trà sữa', N'Trà sửa Ô long, trà nhài matcha, trà vải', N'tra_sua')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (19, N'Trà Thái xanh', N'Trà Thái pa với sữa tươi, sữa đặc và đá', N'tra_thai_xanh')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (20, N'Freeze', N'Cà phê với đá xanh mát lạnh vị HazeInut, Vanilla, Caramel', N'freeze')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (21, N'Latte (M)', N'Sự kết hợp tuyệt vời giữa Espresso và sữa', N'latte')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (22, N'Trà hoa quả', N'Trà Cam Quế, trà Vải, trà Gừng', N'tra_hoa_qua')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (23, N'Sữa chua', N'Sữa chua', N'sua_chua')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (24, N'Sinh tố', N'Sinh tố bơ, sinh tố xoài thơm ngon mát lạnh', N'sinh_to')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (25, N'Cà phê trứng', N'Sự kết hợp giữa cà phê, sữa và lòng đỏ trứng.', N'ca_phe_trung')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (26, N'Đồ ăn sáng', N'California, Omelette, Croque Monsieur', N'do_an_sang')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (27, N'Mỳ Ý', N'Mỳ ý sốt bò băm', N'my_y')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (28, N'Beer', N'Haniken, Hà Nội, Tiger,...', N'beer')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (29, N'Khoai tây chiên', N'Khoai chiên qua nguyên vị', N'khoai_tay_chien')
INSERT [dbo].[MonAn] ([ID_MonAn], [TenMonAn], [MoTa], [SrcImg]) VALUES (30, N'Italian Soda', N'Citrus Cocler, Red Sunset, Blue Ocean', N'italian_soda')
SET IDENTITY_INSERT [dbo].[MonAn] OFF
SET IDENTITY_INSERT [dbo].[NhaHang] ON 

INSERT [dbo].[NhaHang] ([ID_NhaHang], [TenNhaHang], [DiaChi], [ViTri], [SoDienThoai], [MoTa]) VALUES (1, N'Hello - 66 Bảo Tàng', N'66 Nguyễn Văn Huyên, Cầu Giấy', N'13°19.717'';200.20', N'043666777', NULL)
INSERT [dbo].[NhaHang] ([ID_NhaHang], [TenNhaHang], [DiaChi], [ViTri], [SoDienThoai], [MoTa]) VALUES (2, N'Hello - 57 Đinh Tiên Hoàng', N'57 Đinh Tiên Hoàng', N'100,11;200,22', N'043555777', NULL)
INSERT [dbo].[NhaHang] ([ID_NhaHang], [TenNhaHang], [DiaChi], [ViTri], [SoDienThoai], [MoTa]) VALUES (3, N'Hello - 47 Bà Triệu', N'47 Bà Triệu', N'100,11;200,22', N'043444777', NULL)
INSERT [dbo].[NhaHang] ([ID_NhaHang], [TenNhaHang], [DiaChi], [ViTri], [SoDienThoai], [MoTa]) VALUES (4, N'Hello - 2 Đào Tấn', N'2 Đào Tấn', N'100,11;200,22', N'043444222', NULL)
INSERT [dbo].[NhaHang] ([ID_NhaHang], [TenNhaHang], [DiaChi], [ViTri], [SoDienThoai], [MoTa]) VALUES (5, N'Hello - 25 Lý Thường Kiệt', N'25 Lý Thường Kiệt', N'100,11;200,22', N'043222555', NULL)
SET IDENTITY_INSERT [dbo].[NhaHang] OFF
INSERT [dbo].[NhaHang_MonAn] ([ID_NhaHang], [ID_MonAn]) VALUES (1, 1)
INSERT [dbo].[NhaHang_MonAn] ([ID_NhaHang], [ID_MonAn]) VALUES (1, 2)
INSERT [dbo].[NhaHang_MonAn] ([ID_NhaHang], [ID_MonAn]) VALUES (1, 3)
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (1, N'Admin', N'admin@gmail.com', N'01234567899', N'1000000', N'123456789', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (2, N'NguoiDung1', N'nguoidung1@gmail.com', N'09876543211', N'100000', N'111111111', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (3, N'NguoiDung2', N'nguoidung2@gmail.com', N'09878787878', N'200000', N'222222222', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (4, N'NguoiDung3', N'nguoidung3@gmail.com', N'01212121212', N'300000', N'333333333', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (5, N'NguoiDung4', N'nguoidung4@gmail.com', N'04545454545', N'400000', N'444444444', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (6, N'NguoiDung5', N'nguoidung5@gmail.com', N'49289284932', N'500000', N'555555555', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (7, N'NguoiDung6', N'nguoidung6@gmail.com', N'13321213321', N'600000', N'666666666', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (8, N'NguoiDung7', N'nguoidung7@gmail.com', N'13321213321', N'700000', N'666666666', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (9, N'NguoiDung8', N'nguoidung8@gmail.com', N'13321213321', N'800000', N'888888888', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (10, N'NguoiDung9', N'nguoidung9@gmail.com', N'13321213321', N'600000', N'999999999', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (1008, N'NguoiDung10', N'NguoiDung10@gmail.com', N'2341674131', N'0', N'1010101010', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (1009, N'NguoiDung11', N'NguoiDung11@gmail.com', N'9918115631', N'0', N'111111111', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (1010, N'abc', N'abc@gmail.com', N'12309872124', N'0', N'111111', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (1011, N'aaa', N'aaa@gmail.com', N'01293847565', N'0', N'111111', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (1012, N'bbb', N'bbb@gmail.com', N'01929283321', N'0', N'111111', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (1013, N'nhat', N'nhat@gmail.com', N'0112845364', N'0', N'111111', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (1014, N'aaaaa', N'aaaaa@gmail.com', N'0123456789', N'0', N'111111', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (1015, N'Tai2', N'tai2@gmail.com', N'01010101011', N'0', N'111111', 0)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenTaiKhoan], [Email], [SoDienThoai], [TienNap], [MatKhau], [Online]) VALUES (1016, N'huy', N'huy@gmail.com', N'012345', N'0', N'111111', 0)
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_NhaHang] FOREIGN KEY([ID_NhaHang])
REFERENCES [dbo].[NhaHang] ([ID_NhaHang])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK_DonHang_NhaHang]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_TaiKhoan] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK_DonHang_TaiKhoan]
GO
ALTER TABLE [dbo].[GiaBan]  WITH CHECK ADD  CONSTRAINT [FK_GiaBan_MonAn] FOREIGN KEY([ID_MonAn])
REFERENCES [dbo].[MonAn] ([ID_MonAn])
GO
ALTER TABLE [dbo].[GiaBan] CHECK CONSTRAINT [FK_GiaBan_MonAn]
GO
ALTER TABLE [dbo].[LoaiMonAn]  WITH CHECK ADD  CONSTRAINT [FK_LoaiMonAn_Loai] FOREIGN KEY([ID_LoaiMonAn])
REFERENCES [dbo].[Loai] ([ID_LoaiMonAn])
GO
ALTER TABLE [dbo].[LoaiMonAn] CHECK CONSTRAINT [FK_LoaiMonAn_Loai]
GO
ALTER TABLE [dbo].[LoaiMonAn]  WITH CHECK ADD  CONSTRAINT [FK_LoaiMonAn_MonAn] FOREIGN KEY([ID_MonAn])
REFERENCES [dbo].[MonAn] ([ID_MonAn])
GO
ALTER TABLE [dbo].[LoaiMonAn] CHECK CONSTRAINT [FK_LoaiMonAn_MonAn]
GO
ALTER TABLE [dbo].[MonAnYeuThich]  WITH CHECK ADD  CONSTRAINT [FK_MonAnYeuThich_MonAn] FOREIGN KEY([ID_MonAn])
REFERENCES [dbo].[MonAn] ([ID_MonAn])
GO
ALTER TABLE [dbo].[MonAnYeuThich] CHECK CONSTRAINT [FK_MonAnYeuThich_MonAn]
GO
ALTER TABLE [dbo].[MonAnYeuThich]  WITH CHECK ADD  CONSTRAINT [FK_MonAnYeuThich_TaiKhoan] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[MonAnYeuThich] CHECK CONSTRAINT [FK_MonAnYeuThich_TaiKhoan]
GO
