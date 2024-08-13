---A script creates a database.
 USE MASTER
 GO
 IF EXISTS(SELECT NAME FROM SYSDATABASES WHERE NAME ='DoAn')
 DROP DATABASE DoAn
 GO
 CREATE DATABASE DoAnCSKTPM
 GO
 USE  DoAnCSKTPM
 GO
 set dateformat DMY
-- 1: Tạo Table [Accounts] chứa tài khoản thành viên được phép sử dụng các trang quản trị ----
create table TaiKhoan
(
	TaiKhoan varchar(20) primary key not null,
	MatKhau varchar(20) not null,
	HoDem nvarchar(50) null,
	TenTV nvarchar(30) not null,
	Ngaysinh datetime ,
	GioiTinh bit default 1,
	SDT nvarchar(20),
	Email nvarchar(50),
	ĐiaChi nvarchar(250),
	TrangThai bit default 0,
	GhiChu ntext
)
go

-- 2: Tạo Table [Customers] chứa Thông tin khách hàng  ---------------------------------------
create table KhachHang
(
	MaKH varchar(10) primary key not null,
	TenKH nvarchar(50) not null,
	SDT varchar(20) ,
	Email varchar(50),
	DiaChi nvarchar(250),
	NgaySinh datetime ,
	GioiTinh bit default 1,
	GhiChu ntext
)
go

-- 3: Tạo Table [Articles] chứa thông tin về các bài viết phục vụ cho quảng bá sản phẩm, ------
--    xu hướng mua sắm hiện nay của người tiêu dùng , ...             ------------------------- 
create table BaiViet
(
	MaBV varchar(10) primary key not null,
	TenBV nvarchar(250) not null,
	HinhDD varchar(max),
	NdTomTat nvarchar(2000),
	NgayDang datetime ,
	LoaiTin nvarchar(30),
	NoiDung nvarchar(4000),
	TaiKhoan varchar(20) not null ,
	DaDuyet bit default 0,
	foreign key (TaiKhoan) references TaiKhoan(TaiKhoan) on update cascade 
)
go
-- 4: Tạo Table [LoaiSP] chứa thông tin loại sản phẩm, ngành hàng -----------------------------
create table LoaiSP
(
	MaLoai int primary key not null identity,
	TenLoai nvarchar(88) not null,
	GhiChu ntext default ''
)
go
-- 5: Tạo Table [Products] chứa thông tin của sản phẩm mà shop kinh doanh online --------------
create table SanPham
(
	MaSP varchar(10) primary key not null,
	TenSP nvarchar(500) not NULL,
	HinhDD varchar(max) DEFAULT '',
	NdTomTat nvarchar(2000) DEFAULT '',
	NgayDang DATETIME DEFAULT CURRENT_TIMESTAMP,
	MaLoai int not null references LoaiSP(maLoai),
	NoiDung nvarchar(4000) DEFAULT '',
	TaiKhoan varchar(20) not null foreign key references TaiKhoan(TaiKhoan) on update cascade,
	DVT nvarchar(32) default N'Hộp',
	DaDuyet bit default 0,
	GiaBan INTEGER DEFAULT 0,
	GiamGia INTEGER DEFAULT 0 CHECK (GiamGia>=0 AND GiamGia<=100),
	NhaSanXuat nvarchar(168) default ''
)
go
-- 6: Tạo Table [Orders] chứa danh sách đơn hàng mà khách đã đặt mua thông qua web ------------
create table DonHang
(
	SoDH varchar(10) primary key not null ,
	MaKH varchar(10) not null foreign key references KhachHang(MaKH),
	TaiKhoan varchar(20) not null foreign key references TaiKhoan(TaiKhoan) on update cascade ,
	NgayDat datetime,
	DaKichHoat bit default 1,
	NgayGH datetime,
	DiaChiGH nvarchar(250),
	GhiChu ntext
)
go	

-- 7: Tạo Table [OrderDetails] chứa thông tin chi tiết của các đơn hàng ---
--    mà khách đã đặt mua với các mặt hàng cùng số lượng đã chọn ---------- 
create table CtDonHang	
(
	SoDH varchar(10) not null foreign key references DonHang(SoDH),
	MaSP varchar(10) not null foreign key references SanPham(MaSP),
	SoLuong int,
	GiaBan bigint,
	GiamGia BIGINT,
	PRIMARY KEY (SoDH, MaSP)
)
go
/*========================== Nhập dữ liệu ==============================*/

--Nhập thông tin Tài khoản
insert into TaiKhoan 
values('huyhoang','121203',N'Lê Huy',N'Hoàng','12/12/2003',1,'0987784205','huyhoang1212.cke@gmail.com',N'984 TL10 - P.Tân Tạo - Q.Bình Tân - Tp.HCM',1,'')
insert into TaiKhoan
values('lehuyhoang','12k3',N'Lê Huy',N'Hoàng','12/12/2003',1,'0987784205','huyhoang1212.cke@gmail.com',N'984 TL10 - P.Tân Tạo - Q.Bình Tân - Tp.HCM',1,'')
insert into TaiKhoan
values('hoang','122003',N'Lê Huy',N'Hoàng','12/12/2003',1,'0987784205','huyhoang1212.cke@gmail.com',N'984 TL10 - P.Tân Tạo - Q.Bình Tân - Tp.HCM',1,'')
insert into TaiKhoan
values('lhh','1212',N'Lê Huy',N'Hoàng','12/12/2003',1,'0987784205','huyhoang1212.cke@gmail.com',N'984 TL10 - P.Tân Tạo - Q.Bình Tân - Tp.HCM',1,'')
GO

-- Nhập thông tin Khách hàng
insert into KhachHang
values('A1',N'Lê Huy Hoàng','0987784205','huyhoang1212.cke@gmail.com',N'Ninh Thới - H.Cầu Kè - T.Trà Vinh','12/12/2003',1,'')
insert into KhachHang
values('A2',N'Lý Phú Chưởng','0379018450','lyphuchuong@gmail.com',N'39 đường APĐ 1 - P.An Phú Đông - Q.12 - Tp.HCM','01/12/2003',1,'')
insert into KhachHang
values('A3',N'Võ Trí Đức','0984302291','votriduc@gmail.com',N'Q.9 - Tp.HCM','23/12/2003',1,'')
insert into KhachHang
values('A4',N'Đào Lăng Gia Hào','0984302291','giahao@gmail.com',N'Q.9 - Tp.HCM','27/07/2003',1,'')
insert into KhachHang
values('A5',N'Lê Tiến Đạt','0868804528', 'ltdat@gmail.com',N'Q.10 - Tp.HCM', '09/12/2003',1,'')
insert into KhachHang
values('A6',N'Trịnh Minh Nhựt','0862269416','minhnhut2303@gmail.com',N'Ninh Thới - H.Cầu Kè - T.Trà Vinh','11/11/2003',1,'')
insert into KhachHang
values('A7',N'Nguyễn Trường Giang','0961114544','ntgiang@gmail.com',N'Phong Thạnh - H.Cầu Kè - T.Trà Vinh','05/12/2003',1,'')
insert into KhachHang
values('A8',N'Đỗ Hoàng Phúc','0328572011','dophuc@gmail.com',N'An Phú Đông - Q.12 - Tp.HCM','12/9/2003',1,'')
insert into KhachHang
values('A9',N'Trần Thị Khánh Nhi','0765152365','khanhnhi@gmail.com',N'An Phú Đông - Q.12 - Tp.HCM', '11/04/2003',0,'')
insert into KhachHang
values('B1',N'Tạ Nguyễn Phụng Kiều','0984302291','phungkieu@gmail.com',N'An Phú Đông - Q.12 - Tp.HCM','24/07/2003',0,'')
insert into KhachHang
values('B2',N'Trần Vĩnh Tín','0386691109','tranvinhtin@gmail.com',N'69 Sa Thầy - Huyện Sa Thầy - Tỉnh Kon Tum','24/08/2003',1,'')
insert into KhachHang
values('B3',N'Nguyễn Triệu Vy','0382154012','ntrieuvy@gmail.com',N'Định Thủy - H.Mỏ Cày Nam - T.Bến Tre','08/06/2006',0,'')
insert into KhachHang
values('B4',N'Vũ Thị Ngọc Như','0963196203','2100003296@nttu.edu.vn',N'An Phú Đông - Q.12 - Tp.HCM','13/06/2003',0,'')
insert into KhachHang
values('B5',N'Ngô Minh Tùng','0918234567','minhtung1208@gmail.com',N'501 Điện Biên Phủ - Q.3 - Tp.HCM','06/10/1998',1,'')
insert into KhachHang
values('B6',N'Phạm Tuấn Minh','0933121212','tuanminh@gmail.com',N'421/32 Xô Viết Nghệ Tĩnh - Q.BÌnh Thạn - Tp.HCM','17/05/2004',1,'')
insert into KhachHang
values('B7',N'Nguyễn Thanh Minh Nguyệt','0916272727','nguyetminh@gmail.com',N'36 Hậu Giang - Q.6 - Tp.HCM','28/09/2000',0,'')
insert into KhachHang
values('B8',N'Võ Quang Cường','0903223344','quangcuong@gmail.com',N'171 Kinh Dương Vương - Q.6 - Tp.HCM','19/12/1998',1,'')
insert into KhachHang
values('B9',N'Ngô Thanh Mỹ Yến','0978558399','myyen12081206@gmail.com',N'11 Nguyễn Trãi - Q.5 - Tp.HCM','30/08/2002',0,'')
insert into KhachHang
values('C1',N'Đỗ Thị Mỹ Linh','0962556789','mylinh@gmail.com',N'971 Hoàng Văn Thụ - Q.Tân Bình - Tp.HCM','15/05/2001',0,'')
insert into KhachHang
values('C2',N'Nguyễn Trần Kim Linh','0773456789','kimlinh@gmail.com',N'127 Trần Hưng Đạo - Q.5 - Tp.HCM','29/08/2004',0,'')
GO

-- Nhập thông tin Bài viết
insert into BaiViet
values('AH1',N'Nhận xét Bánh Snack','~/Images/Banh/banh10.jpg',N'Bánh xốp mềm, thơm ngon.','16/03/2023',N' Đánh giá',N'','huyhoang', 1)
insert into BaiViet
values('AH2',N'Cảm nhận về hương vị','~/Images/Banh/banh10.jpg',N'Bánh xốp mềm, thơm ngon, không quá béo, không quá ngọt cùng lớp kem socola mềm mịn, góp phần mang lại trải nghiệm thú vị cho người dùng.','26/01/2023',N' Đánh giá',N'','lehuyhoang', 1)
insert into BaiViet
values('AH3',N'Quá trình giao hàng','~/Images/Keo/keo7.jpg',N'Sản phẩm được giao rất nhanh','19/12/2022',N' Đánh giá',N'','hoang', 1)
insert into BaiViet
values('AH4',N'Giá cả sản phẩm','~/Images/Traicaysay/trai15.jpg',N'Đây là giày có giá cả hợp lý','12/10/2022', N' Đánh giá', N'','lhh', 1)
insert into BaiViet
values('AH5',N'Chất lượng sản phẩm','~/Images/Traicaysay/trai18.jpg',N'Sản phẩm sử dụng an toàn, có chứng nhận an toàn thực phẩm','29/09/2022',N' Đánh giá',N'','lhh', 1)
insert into BaiViet
values('AH6',N'Đóng gói sản phẩm','~/Images/Traicaysay/banh15.jpg',N'Sản phẩm được đóng gói cẩn thận trong hộp','30/07/2022',N' Đánh giá',N'','hoang', 1)
Go

-- Nhập thông tin loại Sản phẩm
insert into LoaiSP(tenLoai) values(N'Bánh - Snack')
insert into LoaiSP(tenLoai) values(N'Kẹo')
insert into LoaiSP(tenLoai) values(N'Trái cây sấy - Mứt')
insert into LoaiSP(tenLoai) values(N'Bánh ngọt')
go

-- Nhập thông tin Sản Phẩm
-- Nhập thông tin loại Bánh ngọt
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('BN1',N'Bánh Macaron','~/Images/BanhNgot/banhngot1.jpg', N'Macaron là một loại bánh ngọt dựa trên bánh trứng đường (một loại bánh tráng miệng
			  đặc trưng của ẩm thực Pháp, được làm bằng cách đánh lòng trứng đều lên và thêm chút đường cùng chút axit từ chanh tây hay giấm).Ngoài lòng trắng trứng
			  đánh lên, macaron còn được làm từ các nguyên liệu khác như đường bột, đường hạt và màu thực phẩm, nhờ vậy mà bánh trông vô cùng bắt mắt và hấp dẫn.
			  Loại bánh này đặc trưng bởi 2 miếng bánh tròn kẹp giữa phần nhân bao gồm ganache, bơ hoặc mứt. Khi chạm tay vào, vỏ bánh cho cảm giác hơi gợn nhám 
			  nhưng nhìn chung, quan sát bằng mắt thường thì bề mặt bánh trông khá phẳng.', 'huyhoang','80000','20','1',N'Pháp', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('BN2',N'Bánh Pie Táo','~/Images/BanhNgot/banhngot2.jpg', N'Bánh pie táo, hay còn được gọi là bánh táo nướng, bánh táo Mỹ, là một loại bánh đặc trưng
			  và phổ biến được ựa chuộng bởi hầu như tất cả người Mỹ. Người ta thường nói đùa với nhau rằng không có một người phụ nữ nào của đất nước cờ hoa không biết
			  nướng bánh táo.Đặc trưng của món bánh táo Mỹ này đó chính là có lớp vỏ bánh giòn xốp và nhân táo mát ngọt ở bên trong.', 'huyhoang','195000','20','1',N'Mỹ', N'Cái');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('BN3',N'Bánh Donut','~/Images/BanhNgot/banhngot3.jpg', N'Bánh donut là một loại bánh ngọt được rán hoặc nướng, dùng như món tráng miệng hay món ăn
			  vặt đều được. Đây là một loại bánh rất phổ biến ở các nước phương Tây, nó được tạo hình trông như chiếc nhẫn vì có hình tròn và lỗ nhỏ ở giữa. Ngoài ra, 
			  bên ngoài chiếc bánh donut còn được phủ lớp sô cô la hoặc kem cùng với phần topping có màu sắc bắt mắt như cốm nhiều màu hoặc đường bột.', 'huyhoang','48000','20','1',N'Mỹ', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('BN4',N'Bánh Tiramisu Ý','~/Images/BanhNgot/banhngot4.png', N'Tiramisu trong tiếng Ý có nghĩa là "pick me up - hãy mang em đi" thể hiện cho một tình yêu
			  nồng cháy, sâu sắc. Bánh có độ mềm, xốp nhất định với hương vị đặc trưng của cà phê, rượu rum. Bên trong là những lớp bánh quy xen kẽ với các lớp kem phô mai,
			  bên ngoài được phủ bột ca cao hoặc cà phê, trông rất cuốn hút và sang trọng.Chiếc bánh là sự quy tụ hoàn hảo của đủ các tầng vị như ngọt, béo, đắng và hương thơm 
			  của cacao, rượu rum. Có lẽ vì vậy mà nó gợi lên cho chúng ta từng cung bậc cảm xúc trong tình yêu có cả hạnh phúc lẫn niềm đau.', 'huyhoang','220000','20','1',N'Ý', N'Cái');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('BN5',N'Bánh Mochi','~/Images/BanhNgot/banhngot5.jpg', N'Một trong các loại bánh nổi tiếng ở Nhật Bản mà bạn không thể quên thưởng thức khi tới đây là bánh Mochi.
			  Bánh Mochi không chỉ gây ấn tượng bởi vị ngon mà nó còn mang ý nghĩa là niềm ước mơ, khao khát về cuộc viên mãn, sung túc ấm no của người dân Nhật.Đây là loại bánh nhân
			  ngọt, được làm từ gạo nếp dẻo thơm, vỏ bánh mềm dai. Ngoài ra, bánh không chỉ có một loại nhân mà có rất nhiều loại nhân khác nhau tùy theo sở thích và khẩu vị của mỗi
			  địa phương như bánh mochi kem xoài, bánh mochi kem trà xanh,...', 'huyhoang','160000','20','1',N'Nhật Bản', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('BN6',N'Bánh Black Forest Đức','~/Images/BanhNgot/banhngot6.jpg', N'Một trong các loại bánh ngọt “sang chảnh” thường được phục vụ làm món tráng miệng cho những bữa
			  tối có rượu ấm thơm nồng thì bánh Black Forest tuyệt vời đến từ nước Đức vẫn đang chiếm trọn vị trí đầu tiên. Món bánh này có vị béo ngậy vì được tạo từ nhiều lớp cốt bánh
			  chocolate phủ kem, rượu anh đào. Bên ngoài, Black Forest được phủ lớp chocolate bào mỏng, trang trí thêm những trái anh đào. Đây là sự kết hợp hoàn hảo giữa sự ngọt ngào 
			  của bánh đen xen hơi ấm nồng của rượu Kirsch Wasser rất phù hợp để giúp cho mùa đông của bạn không bao giờ cảm thấy lạnh lẽo.', 'huyhoang','345000','20','1',N'Đức', N'Cái');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('BN7',N'Bánh Gateau St. Honore','~/Images/BanhNgot/banhngot7.jpg', N'Chiếc bánh Gateau St. Honore này có nguồn gốc từ Pháp nhưng qua bàn tay biến hoá,
			  kết hợp thêm nhiều loại nguyên liệu khác nhau, người Bỉ đã nâng tầm loại bánh này trở thành một trong những món tráng miệng nhẹ, thơm ngon được các chuyên gia
			  ẩm thực đánh giá cao. Bánh có hình tròn, dạng giống bánh su kem nhưng được nhúng qua chocolate, phủ đầy lớp kem tươi và caramen nên khi bạn ăn sẽ cảm nhận được
			  vị ngọt thơm, bùi béo vừa đủ, rất thích hợp để làm điểm nhấn kết thúc cho những bữa tiệc kiểu Âu thịnh soạn.', 'huyhoang','390000','20','1',N'Pháp', N'Cái');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('BN8',N'Bánh ','~/Images/BanhNgot/banhngot8.jpg', N'Bánh rán Doremon có tên là Dorayaki, là một thứ bánh cổ truyền Nhật Bản. Hình dáng của bánh rán
			  Doremon giống như bánh bao, làm từ bột đậu, vỏ phết mật ong rất ngon và bổ dưỡng. Bánh mềm quyện với nhân thơm ngon đặc trưng mang hương vị Nhật Bản chắc 
			  chắn sẽ làm là món bánh hấp dẫn trong mọi gia đình.', 'huyhoang','150000','20','1',N'Nhật Bản', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('BN9',N'Bánh Sukem','~/Images/BanhNgot/banhngot9.jpg', N'Bánh Sukem là món bánh ngọt ở dạng kem sữa được làm từ các nguyên liệu như bột mì,
			  trứng, sữa, bơ... đánh đều tạo thành một hỗn hợp và sau đó bằng thao tác ép và phun qua một cái túi để định hình thành những bánh nhỏ và cuối cùng 
			  được nướng chín. Bánh có xuất xứ từ nước Pháp. Một loại bánh tương tự như bánh su kem là profiterole (bánh phồng nhân kem), thường được phủ thêm lớp 
			  sô-cô-la.', 'huyhoang','60000','20','1',N'Pháp', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('BN10',N'Bánh Tart','~/Images/BanhNgot/banhngot10.jpeg', N'Bánh tart là một món nướng được làm từ vỏ bánh ngọt ngắn (thường là 2: 1 tỷ lệ bột: mỡ)
			  và nhân bên trong vỏ bánh không có lớp phủ bên ngoài. Tùy thuộc vào kích thước và hình dạng của khuôn, bánh tart thành phẩm rất đa dạng về kiểu dáng: 
			  kích thước lớn hoặc mini, hình tròn, hình vuông, hình chữ nhật hoặc hình hoa, …', 'huyhoang','65000','20','1',N'Bồ Đào Nha', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('BN11',N'Bánh Croissant','~/Images/BanhNgot/banhngot12.jpg', N'Bánh sừng bò còn được gọi là bánh croa-xăng (từ tiếng Pháp croissant), có nguồn gốc từ Áo,
			  là một dạng bánh ăn sáng làm từ pâte feuilletée (bột xốp), được sản xuất từ bột mì, men, bơ, sữa, và muối. Bánh croissant đúng kiểu phải thật xốp, giòn
			  và có thể xé ra từng lớp mỏng nhỏ. Bên trong ruột không được đặc, ngược lại phải khá ruỗng thoáng (đó là bằng chứng men làm bột phát triển tốt). Ở Việt Nam hầu hết
			  các tiệm bán bánh sừng bò làm theo công thức của bánh mì sữa (hoặc được gọi là bánh mì tươi). Về công thức làm bánh croissant, có thể nói là bánh này đứng giữa bánh
			  pâté chaud (xốp) và bánh mì (ruột bánh nổi bởi men).', 'huyhoang','102000','20','1',N'Áo', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('BN12',N'Bánh Mille Feuille','~/Images/BanhNgot/banhngot12.jpg', N'Khi nhắc đến các loại bánh ngọt Pháp nổi tiếng thì không thể bỏ qua Mille Feuille. Ở Việt Nam, 
			  nó còn được biết đến với cái tên bánh ngàn chiếc lá. Bởi khi ăn chúng ta có thể cảm nhận rõ vị giòn tan đến từ phần vỏ. Vỏ bánh cấu tạo nên từ nhiều lớp bột
			  đan xen giữa các lớp bơ. Ở giữa là phần kem béo ngậy, thơm ngon, tạo sự kích thích mạnh mẽ cho thị giác.  Mille Feuille thường trang trí bằng họa tiết đá cẩm
			  thạch. Mặc dù đơn giản nhưng lại mang đến sự thanh lịch, sang trọng khi bày trí lên khay hoặc đĩa. Đó là lý do ngày nay rất nhiều khách hàng đặt loại bánh 
			  này cho bữa tiệc của mình.', 'huyhoang','340000','20','1',N'Pháp', N'Cái');
go
-- Nhập thông tin loại Bánh, Snack
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('B1',N'Bánh Chocopie','~/Images/Banh/banh1.jpg', N'Bánh làm từ các thành phần tự nhiên như: Bột mì, đường glucose, chất béo thực vật, 
			  bột cacao, lúa mì, bột vani,… mang đến hương vị bánh thơm ngon, hấp dẫn. Khi thưởng thức, bạn sẽ được trải nghiệm hương vị tuyệt vời từ lớp 
			  bánh xốp mịn với sô cô la chảy ngọt ngào bên ngoài đến lớp nhân dẻo dai hấp dẫn bên trong. Thành phần có trong bánh giúp bạn bổ sung các vitamin
			  và khoáng chất cần thiết cho cơ thể mỗi ngày.', 'huyhoang','79900','20','1',N'Orion', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B2',N'Bánh Karo Trứng Tươi Chà Bông','~/Images/Banh/banh2.jpg', N'Bánh trứng tươi – chà bông Karo được làm từ nguồn nguyên liệu 100% 
			  trứng tươi và sợi thịt gà (trong đó có 22% trứng tươi, 21% sợi thịt gà). Với công nghệ tiên phong cho ra đời chiếc bánh đậm đà – thơm hương 
			  trứng, đậm vị chà bông thật hấp dẫn. Bánh mềm xốp, phồng mịn, ruốc đan xen đều khắp bánh.', 'huyhoang','39800','20','1',N'Orion',N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('B3',N'Bánh Custas','~/Images/Banh/banh3.jpg', N'Bánh Custas có thành phần nguyên liệu được lựa chọn kỹ lưỡng, không chứa hóa chất độc hại,
			  an toàn cho người dùng. Sản phẩm được sản xuất trên quy trình công nghệ hiện đại, được kiểm duyệt chặt chẽ, đảm bảo chất lượng và đây còn là sản phẩm
			  được ưa chuộng trên thị trường. Thành phần có trong bánh giúp bạn bổ sung các vitamin và khoáng chất cần thiết cho cơ thể mỗi ngày.', 'huyhoang','54000','20','1',N'Orion', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B4',N'Bánh Kem Xốp Richeese Nabati','~/Images/Banh/banh4.jpg', N'Thành phần: Đường, bột mì, chất béo thực vật, maltodextrin, bột phô mai 
			  5,76% (chứa chất điều vị E621, E635, màu thực phẩm E124), bột whey, bột sữa, tinh bột bắp, bột lòng đỏ trứng, chất nhũ hóa E322 (i), dầu thực vật
			  (có chứa chất chống oxy hóa TBHQ), muối, chất tạo xốp E500 (ii), màu thực phẩm, vitamin (A, B1, B2, B6, B12). Lớp bánh xốp giòn giòn thơm thơm mỏng
			  kẹp xen kẽ với những lớp kem phô mai hòa quyện với nhau thật hoàn hảo. Bánh xốp nhân phô mai Nabati hộp 300g thơm ngon, được đóng gói thành nhiều 
			  gói nhỏ dễ bảo quản và mang theo bên người. Bánh xốp Nabati được nhiều người tin dùng và chọn mua.', 'huyhoang','35600','20','1',N'Nabati',N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B5',N'Bánh Kem Xốp Richeese Nabati Vị Coffee','~/Images/Banh/banh5.jpg',N'Thành phần: Đường, bột mì, chất béo thực vật, maltodextrin, bột coffee 
			  5,76% (chứa chất điều vị E621, E635, màu thực phẩm E124), bột whey, bột sữa, tinh bột bắp, bột lòng đỏ trứng, chất nhũ hóa E322 (i), dầu thực vật
			  (có chứa chất chống oxy hóa TBHQ), muối, chất tạo xốp E500 (ii), màu thực phẩm, vitamin (A, B1, B2, B6, B12). Lớp bánh xốp giòn giòn thơm thơm mỏng
			  kẹp xen kẽ với những lớp kem phô mai hòa quyện với nhau thật hoàn hảo. Bánh xốp nhân phô mai Nabati hộp 300g thơm ngon, được đóng gói thành nhiều 
			  gói nhỏ dễ bảo quản và mang theo bên người. Bánh xốp Nabati được nhiều người tin dùng và chọn mua.', 'huyhoang','35600','20','1',N'Nabati',N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B6',N'Bánh Kem Xốp Richeese Nabati Vị Phúc Bồn Tử','~/Images/Banh/banh6.jpg', N'Thành phần: Đường, bột mì, chất béo thực vật, maltodextrin, bột phúc bồn tử  
			  5,76% (chứa chất điều vị E621, E635, màu thực phẩm E124), bột whey, bột sữa, tinh bột bắp, bột lòng đỏ trứng, chất nhũ hóa E322 (i), dầu thực vật
			  (có chứa chất chống oxy hóa TBHQ), muối, chất tạo xốp E500 (ii), màu thực phẩm, vitamin (A, B1, B2, B6, B12). Lớp bánh xốp giòn giòn thơm thơm mỏng
			  kẹp xen kẽ với những lớp kem phô mai hòa quyện với nhau thật hoàn hảo. Bánh xốp nhân phô mai Nabati hộp 300g thơm ngon, được đóng gói thành nhiều 
			  gói nhỏ dễ bảo quản và mang theo bên người. Bánh xốp Nabati được nhiều người tin dùng và chọn mua.', 'huyhoang','35600','20','1',N'Nabati',N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B7',N'Bánh Ăn Sáng Cest Bon Sợi Thịt Gà','~/Images/Banh/banh7.jpg', N'Thành phần: Trứng (25%), bột mì, đường, dầu thực vật, chà bông gà 
			  (ruốc thịt gà) 5.1% - thịt ức gà tươi, đường, chất điều vị (621, 627, 631) nước mắm, nước tương, muối i-ốt - glucose syrup, chất nhũ hoá, bột lòng
			  trắng trứng, cồn thực phẩm, chất giữ ẩm, isomalto oligo syrup, chất ổn định, muối i-ốt, bột chiết xuất nấm men, bơ, hương tổng hợp, chất tạo xốp,
			  chất điều chỉnh độ acid, sắt, chất chống đông vón, chất mang. Bánh ăn sáng C’est Bon sợi thịt gà là lựa chọn hoàn hảo cho bữa ăn sáng hàng ngày của
			  cả nhà. Lớp bánh bông lan mềm mịn, béo thơm hoà quyện cùng những sợi thịt gà đậm đà sẽ giúp kích thích vị giác của bạn.', 'huyhoang','759000','20','1',N'Cest Bon', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B8',N'Bánh Quy Oreo Mini Hương Vani','~/Images/Banh/banh8.jpg', N'Thành phần: Bột mì, dầu thực vật không hydro hoá (dầu cọ), bột cacao 3.9%, siro fructose, 
			  chất tạo xốp, muối, bột bắp, chất nhũ hoá nguồn gốc từ đậu nành, hương vani giống tự nhiên. Bánh quy kẹp kem vani thơm ngon, với lớp vỏ màu đen,
			  có vị đắng nhẹ nhưng lại ngọt không gắt kích thích vị giác. Bánh quy Oreo Mini hương vani hộp 230g dinh dưỡng, ngon miệng, vừa ăn vừa chơi. 
			  Bánh quy Oreo có thể chấm sữa ăn rất thú vị hoặc làm nguyên liệu làm bánh.', 'huyhoang','60000','20','1',N' Oreo', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B9',N'Bánh Quy Oreo Mini Hương Dâu','~/Images/Banh/banh9.jpg', N'Thành phần: Bột mì, dầu thực vật không hydro hoá (dầu cọ), bột cacao 3.9%, siro fructose, 
			  chất tạo xốp, muối, bột bắp, chất nhũ hoá nguồn gốc từ đậu nành, hương dâu tự nhiên. Bánh quy kẹp kem dâu thơm ngon, với lớp vỏ màu đen,
			  có vị đắng nhẹ nhưng lại ngọt không gắt kích thích vị giác. Bánh quy Oreo Mini hương dâu hộp 230g dinh dưỡng, ngon miệng, vừa ăn vừa chơi. 
			  Bánh quy Oreo có thể chấm sữa ăn rất thú vị hoặc làm nguyên liệu làm bánh.', 'huyhoang','60000','20','1',N' Oreo', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B10',N'Bánh Quy Oreo Mini Hương Matcha','~/Images/Banh/banh10.jpg',N'Thành phần: Bột mì, dầu thực vật không hydro hoá (dầu cọ), bột cacao 3.9%, 
			  siro fructose, chất tạo xốp, muối, bột bắp, chất nhũ hoá nguồn gốc từ đậu nành, hương matcha tự nhiên. Bánh quy kẹp kem matcha thơm ngon, với lớp vỏ màu đen,
			  có vị đắng nhẹ nhưng lại ngọt không gắt kích thích vị giác. Bánh quy Oreo Mini hương matcha hộp 230g dinh dưỡng, ngon miệng, vừa ăn vừa chơi. 
			  Bánh quy Oreo có thể chấm sữa ăn rất thú vị hoặc làm nguyên liệu làm bánh.', 'huyhoang','60000','20','1',N' Oreo', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B11',N'Bánh Gạo Nhật Ichi Vị Mật Ong Kameda','~/Images/Banh/banh11.jpg', N'Thành phần: Gạo Japonica (63%), đường kính trắng, dầu thực vật, 
			  mật ong, tinh bột biến tính, xì dầu. Bánh gạo nhật ichi vị mật ong kameda gói 180g từ Kameda thương hiệu bánh gạo số một Nhật Bản. Bánh gạo Ichi 
			  180g được sản xuất từ nguyên liệu và dây chuyền công nghệ Nhật Bản do chính người Nhật trực tiếp quản lý. Bánh được đóng gói nhỏ gọn, tiện dụng 
			  mang theo bất cứ đâu.', 'huyhoang','39900','20','1',N'Ichi',  N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B12',N'Bánh Danisa Hộp','~/Images/Banh/banh12.jpg', N'Thành phần: Bột lúa mì, đường, bơ (18.67%), dầu thực vật (chứa chất chống oxy hóa
			  tocopherol), glucose syrup, trứng, dừa sấy, nho kho, bột sữa tách béo, muối, chất tạo xốp E503, hương vani tổng hợp. Bánh quy bơ Danisa giòn tan,
			  cung cấp năng lượng, protein, bánh quy là sự lựa chọn hoàn hảo cho ngày mới đầy năng lượng. Bánh quy bơ Danisa hộp 681g được làm từ thiếc sang trọng,
			  thiết kế theo phong cách hoàng gia sẽ là món quà tuyệt vời dành cho người thân, bạn bè.', 'huyhoang','275000','20','1',N'Danisa',N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B13',N'Bánh Cracker Dinh Dưỡng AFC Vị Lúa Mì','~/Images/Banh/banh13.jpg', N'Thành phần: Bột mì (60%), dầu thực vật (dầu cọ), shortening 
			  (dầu cọ), đường, mạch nha, chất béo thay thế bơ, bột whey, calci carbonat (170i), chất tạo xốp (amoni hydro carbonat (503ii), natri hydro carbonat
			  (500ii)), muối, bột nếp, chất xơ, vảy khoai tây, bột phô mai, men, chất điều chỉnh độ acid (dinatri diphosphat (450i)), chất xử lý bột 
			  (enzyme protease (1101i), natri metabisulfit (223)), màu thực phẩm tổng hợp (beta-caroten (160ai)), vitamin D. Bánh quy dinh dưỡng, thơm ngon. 
			  Bánh cracker lúa mì AFC Dinh Dưỡng hộp 200g cung cấp năng lượng cho bạn hoạt động ngày dài. Bánh quy AFC là thương hiệu lớn, cho chúng ta yên tâm 
			  sử dụng và tin dùng.', 'huyhoang','29500','20','1',N'AFC', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B14',N'Bánh Pía Đậu Xanh Sầu Riêng Trứng Tân Huê Viên','~/Images/Banh/banh14.jpg', N'Đối với những thực khách đã một lần đến và thưởng thức 
			  Bánh Pía Sóc Trăng, chắc hẳn sẽ không bao giờ quên được hương vị của Bánh Pía Đậu Xanh Sầu Riêng. Đây là một loại bánh Pía truyền thông nhưng vẫn 
			  giữ được sức hút mạnh đến thời điểm hiện.  Nguyên liệu: Đậu xanh 23,8%, bột mì đường cát, sầu riêng 15,7%, dầu thực vật, mứt bí, lồng đỏ hột vịt muối,
			  mạch nha, nước, màu thực phẩm B-35-WS-P.', 'huyhoang','80000','20','1',N'Tân Huê Viên',N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B15',N'Bánh Pía Đậu Xanh Sầu Riêng 2 Trứng Tân Huê Viên','~/Images/Banh/banh15.jpg', N'Đối với những thực khách đã một lần đến và thưởng thức 
			  Bánh Pía Sóc Trăng, chắc hẳn sẽ không bao giờ quên được hương vị của Bánh Pía Đậu Xanh Sầu Riêng. Đây là một loại bánh Pía truyền thông nhưng vẫn 
			  giữ được sức hút mạnh đến thời điểm hiện.  Nguyên liệu: Đậu xanh 23,8%, bột mì đường cát, sầu riêng 15,7%, dầu thực vật, mứt bí, lồng đỏ hột vịt muối,
			  mạch nha, nước, màu thực phẩm B-35-WS-P.', 'huyhoang','80000','20','1',N'Tân Huê Viên',N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B16',N'Snack Oishi Tôm Vị Cay','~/Images/Banh/banh16.jpg', N'Snack giòn ngon, thơm thơm vị tôm cay đặc biệt, bùng nổ, kích thích vị giác 
			  vô cùng. Snack tôm cay đặc biệt Oishi gói 39g hấp dẫn, phù hợp vừa xem phim, vừa nghe nhạc vừa nhâm nhi thưởng thức. bim bim Oishi tiện lợi, nhỏ gọn,
			  dễ mang theo cho các buổi hoạt động ngoài trời. Thành phần: Bột mì, tinh bột sắn, dầu ăn, tinh bột bắp, đường, tôm 2%, muối i ốt, ớt, gia vị cay, 
			  bột ngọt, gia vị, dấm, bột ớt, màu thực phẩm E129, E102 và anti-oxydant E319, E320 hoặc E321.', 'huyhoang','16500','20','1',N'Oishi',N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B17',N'Snack Oishi Tôm Cay Đặc Biệt','~/Images/Banh/banh17.jpg', N'Snack giòn ngon, thơm thơm vị tôm cay đặc biệt, bùng nổ, kích thích vị giác 
			  vô cùng. Snack tôm cay đặc biệt Oishi gói 39g hấp dẫn, phù hợp vừa xem phim, vừa nghe nhạc vừa nhâm nhi thưởng thức. bim bim Oishi tiện lợi, nhỏ gọn,
			  dễ mang theo cho các buổi hoạt động ngoài trời. Thành phần: Bột mì, tinh bột sắn, dầu ăn, tinh bột bắp, đường, tôm 2%, muối i ốt, ớt, gia vị cay, 
			  bột ngọt, gia vị, dấm, bột ớt, màu thực phẩm E129, E102 và anti-oxydant E319, E320 hoặc E321.', 'huyhoang','16500','20','1',N'Oishi',N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B18',N'Snack Oishi Hành','~/Images/Banh/banh18.jpg', N'Snack hành giòn ngon, thơm thơm kích thích vị giác vô cùng. Snack hành Oishi Orion 
			  Rings gói 39g hấp dẫn, phù hợp vừa xem phim, vừa nghe nhạc vừa nhâm nhi thưởng thức. Snack Oishi tiện lợi, nhỏ gọn, dễ mang theo cho các buổi hoạt
			  động ngoài trời. Thành phần: Bột mì, tinh bột sắn, dầu ăn, khoai tây miếng, hành (1%), đường, muối, bột ngọt và chất chống oxy hoá (E320, E321).',
			  'huyhoang','16500','20','1',N'Oishi',N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B19',N'Snack Oishi Phomat Miếng','~/Images/Banh/banh19.jpg', N'Snack giòn ngon, thơm thơm vị phô mát kích thích vị giác vô cùng. Snack pho 
			  mát miếng Oishi gói 39g hấp dẫn, phù hợp vừa xem phim, vừa nghe nhạc vừa nhâm nhi thưởng thức. Snack Oishi tiện lợi, nhỏ gọn, dễ mang theo cho các 
			  buổi hoạt động ngoài trời. Thành phần: Bột bắp, tinh bột sắn, dầu ăn, bột phô mai (3%), sữa không kem, muối i-ốt, đường, bột ngọt, 
			  bột nổi và anti-oxydant (E320 hoặc E321).', 'huyhoang','16500','20','1',N'Oishi',  N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B20',N'Snack Oishi Bí Đỏ','~/Images/Banh/banh20.jpg', N'Snack bí đỏ giòn ngon, thơm thơm vị bò nướng kích thích vị giác vô cùng. 
			  Snack bí đỏ vị bò nướng Oishi gói 35g hấp dẫn, phù hợp vừa xem phim, vừa nghe nhạc vừa nhâm nhi thưởng thức. Snack Oishi tiện lợi, nhỏ gọn, 
			  dễ mang theo cho các buổi hoạt động ngoài trời. Thành phần: Bột mì, tinh bột sắn, dầu ăn, bí đỏ (6%), đường, muối i-ốt, bột bò 1%, chất điều vị,
			  bột hành, bột ớt, bột tỏi, màu thực phẩm tự nhiên và màu thực phẩm tổng hợp.', 'huyhoang','16500','20','1',N'Oishi', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B21',N'Snack Oishi Phồng Mực','~/Images/Banh/banh21.jpg', N'Snack giòn ngon, thơm thơm vị mực kích thích vị giác vô cùng. Snack phồng mực 
			  Oishi Indo Chips gói 39g hấp dẫn, phù hợp vừa xem phim, vừa nghe nhạc vừa nhâm nhi thưởng thức. Snack Oishi tiện lợi, nhỏ gọn, dễ mang theo cho 
			  các buổi hoạt động ngoài trời. Thành phần: Tinh bột sắn, bột mì, dầu ăn, đường, muối i-ốt, mực (2%), gia vị dấm, bột ngọt, chiết xuất dành dành, 
			  màu thực phẩm tổng hợp (E129), chất chống oxy hóa (E320, E321).', 'huyhoang','16500','20','1',N'Oishi', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B22',N'Snack Oishi Bắp Ngọt','~/Images/Banh/banh22.jpg', N'Snack bắp giòn ngon, thơm thơm vị ngọt kích thích vị giác vô cùng. Snack bắp ngọt
			  Oishi gói 35g hấp dẫn, phù hợp vừa xem phim, vừa nghe nhạc vừa nhâm nhi thưởng thức. Snack Oishi tiện lợi, nhỏ gọn, dễ mang theo cho các buổi hoạt 
			  động ngoài trời. Thành phần: Bắp (36%), dầu ăn, bột mì, bột gạo, đường, hương bắp, muối i-ốt, bột ngọt (E621) và chất chống oxy hóa (E320, E321).',
			  'huyhoang','16500','20','1',N'Oishi', N'Gói');;
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B23',N'Snack Bắp Ngọt Vị Phô Mai Oishi','~/Images/Banh/banh23.jpg', N'Snack bắp giòn ngon, thơm thơm vị ngọt kích thích vị giác vô cùng. Snack bắp ngọt Vị Phô Mai
			  Oishi gói 35g hấp dẫn, phù hợp vừa xem phim, vừa nghe nhạc vừa nhâm nhi thưởng thức. Snack Oishi tiện lợi, nhỏ gọn, dễ mang theo cho các buổi hoạt 
			  động ngoài trời. Thành phần: Bột mì, tinh bột sắn, dầu ăn, bí đỏ (6%), đường, muối i-ốt, bột bò 1%, chất điều vị,
			  bột hành, bột ớt, bột tỏi, màu thực phẩm tự nhiên và màu thực phẩm tổng hợp.', 'huyhoang','16500','20','1',N'Oishi', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B24',N'Snack Bắp  Vị Phô Mai Oishi Tom Toms','~/Images/Banh/banh25.jpg',N'Snack bắp giòn ngon, thơm thơm vị ngọt kích thích vị giác vô cùng. Snack bắp ngọt Vị Phô Mai
			  Oishi gói 35g hấp dẫn, phù hợp vừa xem phim, vừa nghe nhạc vừa nhâm nhi thưởng thức. Snack Oishi tiện lợi, nhỏ gọn, dễ mang theo cho các buổi hoạt 
			  động ngoài trời. Thành phần: Bột mì, tinh bột sắn, dầu ăn, bí đỏ (6%), đường, muối i-ốt, bột bò 1%, chất điều vị,
			  bột hành, bột ớt, bột tỏi, màu thực phẩm tự nhiên và màu thực phẩm tổng hợp.', 'huyhoang','16500','20','1',N'Oishi', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B25',N'Snack Oshi Đậu Xanh Nước Dừa','~/Images/Banh/banh26.jpg',N'Snack đậu xanh nước dừa giòn ngon, thơm thơm vị nước cốt dừa kích thích vị giác vô cùng. 
			  Snack Đâuu xanh nước dừa Oishi gói 35g hấp dẫn, phù hợp vừa xem phim, vừa nghe nhạc vừa nhâm nhi thưởng thức. Snack Oishi tiện lợi, nhỏ gọn, 
			  dễ mang theo cho các buổi hoạt động ngoài trời. Thành phần: Bột mì, tinh bột sắn, dầu ăn, đậu xanh (6%), đường, muối i-ốt, nước cốt dừa 1%, chất điều vị,
			  màu thực phẩm tự nhiên và màu thực phẩm tổng hợp.', 'huyhoang','16500','20','1',N'Oishi', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B26',N'Snack Chay Vị Da Heo Oishi','~/Images/Banh/banh27.jpg', N'Snack chay giòn ngon, thơm thơm vị da heo quay kích thích vị giác vô cùng.
			  Snack chay vị da heo quay Oishi martys gói 39g hấp dẫn, phù hợp vừa xem phim, vừa nghe nhạc vừa nhâm nhi thưởng thức. Snack Oishi tiện lợi, nhỏ gọn,
			  dễ mang theo cho các buổi hoạt động ngoài trời. Thành phần: Đậu Hà Lan, dầu ăn, tinh bột sắn, khoai tây miếng, đường, muối i ốt, bột tỏi, nước tương,
			  hương thịt chay, bột ngọt, bột hành, màu thực phẩm (E129) và anti-oxydant (E319, E320 hoặc E321).', 'huyhoang','16500','20','1',N'Oishi', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B27',N'Snack Oishi Tater Khoai Tây Siêu Mỏng Vị Tảo Biển','~/Images/Banh/banh28.jpg',N'Snack thơm nức mũi luôn, khoai tây thì mỏng, giòn rụm.
			  Vị khoai tây thật. Snack khoai tây vị tảo biển Nori Lays gói 95g ăn rất giòn luôn, vị tảo biển Nori khá thơm, đậm đà trên từng miếng khoai tây. 
			  Snack khoai tây lays được rất nhiều bạn trẻ đón nhận và sử dụng cho nhiều hoạt động nhé Thành phần: Khoai tây, dầu thực vật, bột gia vị Tảo Biển Nori
			  6% (đường, maltodetrin, muối, hương tự nhiên và giống tự nhiên, chất điều vị (E621, E627, E631), gia vị (tỏi, hành, ớt, gừng), bột nước tương tảo 
			  biển, dầu đậu nành, chất điều chỉnh độ chua (E330), chất chống đông vón (E551), chất tạo ngọt tổng hợp (E951), màu tự nhiên (E160c)).',
			  'huyhoang','16500','20','1',N'Oishi', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B28',N'Snack Cà Chua Oishi','~/Images/Banh/banh25.jpg',N'Snack giòn ngon, thơm thơm vị cà chua kích thích vị giác vô cùng. Snack cà chua 
			  Oishi Tomati gói 39g hấp dẫn, phù hợp vừa xem phim, vừa nghe nhạc vừa nhâm nhi thưởng thức. Snack Oishi tiện lợi, nhỏ gọn, dễ mang theo cho các 
			  buổi hoạt động ngoài trời. Thành phần: Bột mì, dầu ăn, tinh bột sắn, tinh bột bắp, khoai tây miếng, bột cà chua (3%), đường, muối i ốt, bột tương, 
			  bột ngọt, màu thực phẩm, chất chống oxy hóa.', 'huyhoang','16500','20','1',N'Oishi', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B29',N'Snack Khoai Tây Lays Vị Tự Nhiên Classic','~/Images/Banh/banh29.jpg', N'Snack khoai tây vị tự nhiên Classic Lays gói 52g là một sản 
			  phẩm snack nổi bật hàng đầu của thương hiệu Lays mang một hương vị cổ điển bởi đơn giản chỉ là sự kết hợp giữa khoai tây và gia vị đơn thuần, thơm
			  ngon độc đáo. Snack Lays được rất nhiều bạn trẻ đón nhận và sử dụng cho nhiều hoạt động. Thành phần: Khoai tây, dầu cọ, bột gia vị khoai tây 4,2%
			  (tinh bột, muối, đường, chất điều vị (E621, E627, E631), bột sữa whey, chất chống đông vón E551, hương liệu tự nhiên và giống tự nhiên, chất ổn định
			  (E414, E415, E339ii).', 'huyhoang','10500','20','1',N'Lays', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('B30',N'Snack Khoai Tây Lays Vị Sườn Nướng BBQ','~/Images/Banh/banh30.jpg', N'Snack khoai tây vị sườn nướng BBQ Classic Lays gói 52g là một sản 
			  phẩm snack nổi bật hàng đầu của thương hiệu Lays mang một hương vị cổ điển bởi đơn giản chỉ là sự kết hợp giữa sườn nướng BBQ và gia vị đơn thuần, thơm
			  ngon độc đáo. Snack Lays được rất nhiều bạn trẻ đón nhận và sử dụng cho nhiều hoạt động. Thành phần: Khoai tây tươi, dầu thực vật, bột gia vị thăn bò nướng (đường, hương tự nhiên, chất điều
			  vị E621, tinh bột, chất chống đông vón E551, chất tạo ngọt E951, chất làm dày E414, huơng giống tự nhiên, chất điều chỉnh độ chua (E331, E415, E300.),
			  hương tổng hợp, chất điều vị (E627, E635).', 'huyhoang','10500','20','1',N'Lays',  N'Gói');
go
-- Nhập thông tin loại Kẹo
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('K1',N'Kẹo Eikodo Vị Vải Thiều Muối','~/Images/Keo/keo1.jpg', 
			  N'Thành phần: Đường. mạch nha, muối (2.5%), chất điều chỉnh độ acid (INS330), hương vải tổng hợp, bột vải thiều (0.2%).', 'huyhoang','16200','20','1',N'Eikodo', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('K2',N'Kẹo Dẻo Mogu Vị Kiwi Và Hạt Chia','~/Images/Keo/keo2.jpg', 
			  N'Thành phần: Mạch nha, đường, nước, chất điều chỉnh độ acid (INS325, INS330, INS331 , INS332 ), chất tạo gel (INS407), hạt chia (0.81%), chất làm bóng (INS903),
			  chất chống oxy hóa (Vitamin C - INS300 <0.23%>), hương kiwi tổng hợp, màu thực phẩm tổng hợp (Tartrazine - INS102, Brilliant blue FCF - INS133).','huyhoang','21300','20','1',N'Mogu', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('K3',N'Kẹo Bơ Đường Yesco','~/Images/Keo/keo3.jpg', 
			  N'Thành phần: Glucose, đường, chất béo thực vật, bơ tách muối, kem sữa, bột whey, muối, hương bơ đường nhân tạo 0.23%, chất nhũ hóa (INS 322(i)).', 'huyhoang','18900','20','1',N'Yesco', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('K4',N'Kẹo Cà Phê Yesco','~/Images/Keo/keo4.jpg', 
			  N'Thành phần: Glucose, đường, chất béo thực vật, chiết xuất cà phê (3,03%), bột sữa, hương cà phê giống tự nhiên, muối, phẩm màu tổng hợp (INS 150a).', 'huyhoang','18900','20','1',N'Yesco', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K5',N'Kẹo Caramel Muối Aeon Topvalu','~/Images/Keo/keo5.jpg', 
			  N'Thành phần: Xi-rô tinh bột (xuất xứ Nhật Bản) 39,32 %; sữa đặc 29,36 %; đường 19,36 %; dầu và chất béo (có nguồn gốc từ sữa) 6,29 %; canxi cacbonat
			  (170(i)) 2,32 %; đá muối (xuất xứ Pháp) 1,09 %; sữa 0,47 %; kem (có thành phần sữa) 0,47 %; sốt caramel 0,47 %; chất nhũ hóa lecithin (322(i)) 0,4 %;
			  đường D-Sorbitol (420(i), 420(ii)) 0,36 %, hương vani tự nhiên 0,09 %.', 'huyhoang','99000','20','1',N'Aeon Topvalu', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K6',N'Kẹo Caramel Sữa Aeon Topvalu','~/Images/Keo/keo6.jpg',
			  N'Thành phần: Xi-rô tinh bột (xuất xứ Nhật Bản) 39,38 %; sữa đặc 29,4 %; đường 19,38 %; dầu và chất béo (có nguồn gốc từ sữa) 6,3 %; canxi cacbonat 
			  (170(i)) 2,32 %; sữa 1,42 %; kem (có thành phần sữa) 0,47 %; muối natri clorua 0,47 %; chất nhũ hóa lecithin (322(i)) 0,4 %; đường D-Sorbitol (420(i), 
			  420(ii)) 0,36 %, hương sữa tự nhiên 0,09 %', 'huyhoang','99000','20','1',N'Aeon Topvalu', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K7',N'Kẹo Socola Tiramisu Vị Dâu Tây','~/Images/Keo/keo7.jpg', 
			  N'Nguyên liệu: Hạnh nhân (xuất xứ Mỹ), bột cacao, đường, chất béo thực vật, lactose, sữa bột tách béo, bột phô mai, bột sữa, mascarpone, bột cacao/chất nhũ hóa,
			  hương liệu, (một phần có chứa thành phần sữa, hạnh nhân, đậu nành)', 'huyhoang','269000','20','1',N'Purelait', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K8',N'Kẹo Socola Tiramisu Vị Matcha','~/Images/Keo/keo8.jpg', 
			  N'Nguyên liệu: Hạnh nhân, bơ ca cao, đường, dầu thực vật, lactose, sữa bột tách béo, bột phô mai, bột kem, mascarpone, bột matcha, chất tạo màu, chất nhũ hóa 
			  (có nguồn gốc từ đậu nành), hương liệu', 'huyhoang','249000','20','1',N'Purelait', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K9',N'Kẹo Socola Tiramisu','~/Images/Keo/keo9.jpg', 
			  N'Nguyên liệu: Hạnh nhân (xuất xứ Mỹ), bột cacao, đường, chất béo thực vật, lactose, sữa bột tách béo, bột phô mai, bột sữa, mascarpone, bột cacao/chất nhũ hóa, 
			  hương liệu, (một phần có chứa thành phần sữa, hạnh nhân, đậu nành)', 'huyhoang','229000','20','1',N'Purelait', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K10',N'Kẹo Dẻo Có Nhân Hình Quả Địa Cầu Trolli','~/Images/Keo/keo10.jpg', 
			  N'Thành phần: Siro glucose; đường: đường dextrose; chất keo gelatin; axit: axit citric; hương liệu tổng hợp; chất gel kết dính: thạch; màu tổng hợp: màu đỏ son,
			  màu nghệ, màu xanh sáng FCF, carbon thực vật; dầu cọ; chất làm bóng: sáp carnauba', 'huyhoang','68900','20','1',N'Trolli', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K11',N'Kẹo Dẻo Có Nhân Hình Con Mắt Trolli','~/Images/Keo/keo11.jpg', 
			  N'Thành phần: Xi-rô glucose, đường, đường dextrose, gelatin, chất điều chỉnh độ acid: Acid citric – INS 330, hương trái cây tổng hợp, chất tạo gel: Pectin – INS 440,
			  phẩm màu tổng hợp (Carmin – INS 120, Curcumin – INS 100(i), Brilliant blue FCF – INS 133), carbon thực vật, chất làm bóng: sáp ong – INS 901 (trắng và vàng)',
			  'huyhoang','68900','20','1',N'Trolli', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K12',N'Kẹo Dẻo Valda Vị Bạc Hà Truyền Thống Túi Zip','~/Images/Keo/keo12.jpg', 
			  N'Thành phần: Đường, Glucose Syrup, Gelatin, chiết xuất hồng hoa (Safflower), Menthol, Eucalyptol, Thymol, Terpinol, màu Blue FDC No.1', 'huyhoang','30500','20','1',N' Valda', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K13',N'Kẹo Dẻo Valda Vị Chanh Bạc Hà Túi Zip','~/Images/Keo/keo13.jpg',
			  N'Thành phần: Đường, Glucose Syrup, Gelatin, chiết xuất hồng hoa (Safflower), Menthol, Eucalyptol, Thymol, Terpinol, màu Blue FDC No.1', 'huyhoang','30500','20','1',N' Valda', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K14',N'Kẹo Sâm Cao Cấp Jinny-J','~/Images/Keo/keo14.jpg', 
			  N'Thông tin chi tiết:
				- KẸO SÂM CAO CẤP JINNY-J là sản phẩm có xuất xứ từ Hàn Quốc với vị ngọt thanh dịu nhẹ và hương thơm của sâm đặc trưng cho sản phẩm.
				- Kẹo Sâm Hàn Quốc tốt cho sức khỏe người dùng, bồi bổ cơ thể suy nhược, tạo cảm giác tỉnh táo.
				- Mẫu mã hộp thiếc sang trọng, đẹp mắt, thu hút ánh nhìn rất thích hợp làm quà tặng.', 'huyhoang','89900','20','1',N' Jinny-J', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K15',N'Kẹo Xylitol Vị Bạc Hà Không Đường Aeon Topvalu','~/Images/Keo/keo15.jpg', 
			  N'Kẹo cao su hương bac kết hợp gữa hương bạc hà cùng với vị ngọt nhẹ tạo cảm giác sảng khoái.', 'huyhoang','175000','20','1',N'Aeon Topvalu', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K16',N'Kẹo Xylitol Vị Bạc Hà Mạnh Không Đường Aeon Topvalu','~/Images/Keo/keo16.jpg',
			  N'Kẹo cao su hương bạc hà với hương thơm ngon  và giúp tinh thần sảng khoái.', 'huyhoang','175000','20','1',N'Aeon Topvalu', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K17',N'Kẹo Xylitol Vị Bạc Hà Hỗn Hợp Không Đường Aeon Topvalu','~/Images/Keo/keo17.jpg',
			  N'Kẹo cao su hương bạc hà có bổ sung thêm flavonoid (tốt cho sức khỏe).', 'huyhoang','175000','20','1',N'Aeon Topvalu', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K18',N'Kẹo Thảo Mộc Trái Cây Cranberry Ricola','~/Images/Keo/keo18.jpg', 
			  N'Kẹo Thảo Mộc Trái Cây Cranberry Ricola F122678 (40g) là sản phẩm được nhập khẩu trực tiếp từ Thụy Sĩ.
				Sản phẩm nổi tiếng nhờ sự kết hợp tuyệt vời 13 loại thảo mộc thiên nhiên với trái cây từ vùng núi Thụy Sĩ.
				Vị kẹo thơm ngon, sảng khoái, thông cổ, mát họng, thơm miệng, tác động hiệu quả khi bị ho, khàn giọng.
				Sản phẩm đã được đóng hộp nhỏ gọn, tiện lợi mang theo bên mình để thưởng thức mọi lúc mọi nơi.', 'huyhoang','131400','20','1',N'Ricola', N'Hộp');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K19',N'Kẹo Vị Hồng Sâm CW Hàn Quốc','~/Images/Keo/keo19.jpg', 
			  N'Thành phần: Đường trắng, syrup, chiết xuất hồng sâm 0.5%, trà sâm 0.2%, hương liệu tổng hợp (L1.mentol, hương thảo mộc), màu tổng hợp (màu caramen I ( INS – 150a))', 'huyhoang','103900','20','1',N'CW', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)  
              values('K20',N'Kẹo Sâm Đen Korean Black Ginseng','~/Images/Keo/keo20.jpg', 
			  N'Thành phần: Đường, mạch nha, chiết xuất hắc sâm Hàn Quốc 6 năm tuổi, các chất tạo hương, màu thực phẩm caramel,…', 'huyhoang','39000','20','1',N'Ginseng', N'Gói');
go
-- Nhập thông tin loại Trái cây sấy, Mứt
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('T1',N'Mận Sấy Dẻo Vinamit','~/Images/Traicaysay/trai1.jpg', N'Thành phần: Mận tươi (95%), đường và muối.', 'huyhoang','48900','20','1',N'Vinamit', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('T2',N'Mít Sấy Vinamit','~/Images/Traicaysay/trai2.jpg', N'Thành phần: Mít tươi, dầu thực vật.', 'huyhoang','35900','20','1',N'Vinamit', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('T3',N'Khoai Lang Sấy Vinamit','~/Images/Traicaysay/trai3.jpg', N'Thành phần: Khoai lang tươi 98%, dầu thực vật.', 'huyhoang','27900','20','1',N'Vinamit', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T4',N'Chuối Sấy Vinamit','~/Images/Traicaysay/trai4.jpg', N'Thành phần: Chuối tươi, dầu thực vật.', 'huyhoang','19900','20','1',N'Vinamit', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT) 
              values('T5',N'Ổi Sấy Dẻo Vinamit','~/Images/Traicaysay/trai5.jpg', N'Thành phần: Ổi tươi (95%), đường và muối.', 'huyhoang','39100','20','1',N'Vinamit', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T6',N'Sầu Riêng Sấy Lạnh Vinamit','~/Images/Traicaysay/trai6.jpg', N'Thành phần: 100% sầu riêng.', 'huyhoang','153900','20','1',N'Vinamit', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T7',N'Trái Cây Sấy Vinamit','~/Images/Traicaysay/trai7.jpg', N'Thành phần: Trái cây tươi, dầu thực vật.', 'huyhoang','27400','20','1',N'Vinamit', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T8',N'Xoài Sấy Dẻo Vinamit ','~/Images/Traicaysay/trai8.jpg', N'Thành phần: Xoài tươi (95%), đường và muối.', 'huyhoang','49900','20','1',N'Vinamit', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T9',N'Hạt Hạnh Nhân Pams','~/Images/Traicaysay/trai9.jpg', N'Thành phần: 100% hạt hạnh nhân.', 'huyhoang','134500','20','1',N'Pams', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T10',N'Hạt Hạnh Nhân Rang Bơ Pams','~/Images/Traicaysay/trai10.jpg', N'Thành phần: 100% hạt hạnh nhân rang bơ.', 'huyhoang','107000','20','1',N'Pams', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T11',N'Hạnh Nhân Có Muối Dân Ôn','~/Images/Traicaysay/trai11.jpg', N'Thành phần: Hạnh nhân, muối.', 'huyhoang','33900','20','1',N'Dân Ôn', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T12',N'Hạnh Nhân Không Muối Dân Ôn','~/Images/Traicaysay/trai12.jpg', N'Thành phần: Hạnh nhân.', 'huyhoang','33900','20','1',N'Dân Ôn', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T13',N'Hạnh Nhân Rang Topvalu Roasted Almonds','~/Images/Traicaysay/trai13.jpg', N'Thành phần: 100% Hạnh nhân (Mỹ).', 'huyhoang','169000','20','1',N'Aeon Topvalu', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T14',N'Hạt Dẻ Cười Tili','~/Images/Traicaysay/trai14.jpg', N'Thành phần: chất béo 78.2%, các hợp chất đường 10%, Protein 9.2%, hàm lượng nước 1.5-2.5%, Kali 0.37%, Photpho 0.17%, Magnesium 0.12%. Có khả năng làm giảm Cholesterol, ngăn ngừa bệnh tim mạch.', 'huyhoang','169000','20','1',N'Tili ', N'Hủ');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T15',N'Hạt Hướng Dương Chacheer Vị Dừa','~/Images/Traicaysay/trai15.jpg', N'Thành phần: Hạt hướng dương (93,7%), muối, chất tạo ngọt tổng hợp, hương dừa tổng hợp.', 'huyhoang','22000','20','1',N'Chacheer', N'Gói');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T16',N'Mứt Dâu Golden Farm Strawberry Jam','~/Images/Traicaysay/trai16.jpg', N'Thành phần: Trái Dâu Tằm (45 – 60%), đường mía RE, sirô bắp, nước, chất ổn định: pectin (440), chất điều chỉnh độ chua: acid citric (330), chất bảo quản: kali sorbat (202), hương việt quất tổng hợp.', 'huyhoang','32600','20','1',N'Golden Farm', N'Hủ');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T17',N'Mứt Việt Quất Jam Blueberry - Golden Farm','~/Images/Traicaysay/trai17.jpg', N'Thành phần: Trái Việt Quất (45 – 60%), đường mía RE, sirô bắp, nước, chất ổn định: pectin (440), chất điều chỉnh độ chua: acid citric (330), chất bảo quản: kali sorbat (202), hương việt quất tổng hợp.', 'huyhoang','32600','20','1',N'Golden Farm', N'Hủ');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T18',N'Mứt Phúc Bồn Tử Raspberry - Golden Farm','~/Images/Traicaysay/trai18.jpg', N'Thành phần: Trái phúc bồn tử (45 - 60%), đường mía RE, sirô bắp, nước, chất ổn định: pectin (E440), chất điều chỉnh độ acid: acid citric (E330), chất bảo quản: kali sorbate (E202), hương phúc bồn tử tổng hợp, màu thực phẩm tổng hợp: ponceau 4R (E124).', 'huyhoang','32600','20','1',N'Golden Farm', N'Hủ');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T19',N'Mứt Nho Đen Every Home Lọ','~/Images/Traicaysay/trai19.jpg', N'Thành phần: Trái Nho (45 – 60%), đường mía RE, sirô bắp, nước, chất ổn định: pectin (440), chất điều chỉnh độ chua: acid citric (330), chất bảo quản: kali sorbat (202), hương nho tổng hợp, màu thực phẩm tổng hợp: ponceau 4R (124).', 'huyhoang','35000','20','1',N'Every Home', N'Hủ');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, NhaSanXuat, DVT)
              values('T20',N'Mứt Cam Topvalu Organic','~/Images/Traicaysay/trai20.jpg', N'Thành phần: Đường hữu cơ (52,78%), cam hữu cơ (40,56%), nước cam hữu cơ cô đặc (4,50%), nước chanh hữu cơ cô đặc (1,22%)/chất tạo gel (pectin (440): có nguồn gốc từ cam) ', 'huyhoang','119000','20','1',N' Aeon Topvalu', N'Hủ');
go

-- Nhập thông tin loại Đơn hàng
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ01','A1','huyhoang', '18/03/2023', 1, '25/03/2023', N'Ninh Thới - H.Cầu Kè - T.Trà Vinh', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ02','A2','lehuyhoang', '17/03/2023', 1, '25/03/2023', N'39 đường APĐ 1 - P.An Phú Đông - Q.12 - Tp.HCM', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ03','A3','hoang', '15/03/2023', 1, '25/03/2023', N'Q.9 - Tp.HCM', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ04','A4','lhh', '09/02/2023', 1, '15/02/2023', N'Q.9 - Tp.HCM', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ05','A5','hoang', '07/01/2023', 1, '25/03/2023', N'Q.10 - Tp.HCM', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ06','B2','lehuyhoang', '05/01/2023', 1, '10/01/2023', N'69 Sa Thầy - Huyện Sa Thầy - Tỉnh Kon Tum', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ07','B3','lhh', '19/12/2022', 1, '25/12/2022', N'Định Thủy - H.Mỏ Cày Nam - T.Bến Tre', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ08','B4','huyhoang', '18/12/2022', 1, '25/12/2022', N'An Phú Đông - Q.12 - Tp.HCM', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ09','B5','lehuyhoang', '12/12/2023', 1, '18/12/2022', N'501 Điện Biên Phủ - Q.3 - Tp.HCM', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ010','C1','huyhoang', '10/11/2022', 1, '25/11/2022', N'971 Hoàng Văn Thụ - Q.Tân Bình - Tp.HCM', '');
go

-- Nhập thông tin loại Chi tiết đơn hàng
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ01','B1','10','79900','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ02','B2','10','39800','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ03','B3','10','54000','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ04','B4','10','35600','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ05','B7','10','759000','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ06','K1','10','16200','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ07','K2','10','21300','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ08','T1','10','48900','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ09','T2','10','35900','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ010','T3','10','27900','20');
go
--Xuất dữ liệu--
select * from TaiKhoan
select * from KhachHang
select * from BaiViet
select * from LoaiSP
select * from SanPham
select * from DonHang
select * from CtDonHang


