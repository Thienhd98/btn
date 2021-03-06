create database KhuVuiChoi
go
use KhuVuiChoi
go
create table KhuTroChoi
(
	MaKhu int identity primary key,
	TenKhu nvarchar(50),
	GiaTreEm int,
	GiaNguoiLon int,
	GioMoCua time,
	GioDongCua time
)
go
create table PhongBan
(
	MaPB int identity primary key,
	TenPB nvarchar(50),
	MaTP int,
	NgayNC date,
	DiaDiem nvarchar(50)
)
go
create table TroChoi
(
	MaTro int identity primary key,
	TenTro nvarchar(50),
	MaKhu int references KHUTROCHOI(MaKhu)
)
go
create table DichVu
(
	MaDV int identity primary key,
	TenDV nvarchar(50),
	GiaDV int,
	MaKhu int references KHUTROCHOI(MaKhu)
)
go
create table NhanVien
(	
	MaNV int identity primary key,
	HoTen nvarchar(50),
	NgaySinh date,
	GioiTinh nvarchar(3) check (GioiTinh in (N'Nam',N'Nữ')),
	QueQuan nvarchar(50),
	ChucVu nvarchar(50),
	Luong int,
	MaPB int references PhongBan(MaPB),
	MaKhu int references KhuTroChoi(MaKhu),
	MaTro int references TroChoi(MaTro)
)
go
create table Ve
(
	MaVe int identity primary key,
	NgayBan datetime,
	SLTE int,
	SLNL int,
	TongThu int,
	MaNV int references NHANVIEN(MaNV),
	MaKhu int references KHUTROCHOI(MaKhu)
)
go
create table HoaDon
(
	MaHD int identity primary key,
	NgaySD datetime
)
go

create table HoaDon_ChiTiet
(
	MaHD int references HOADON(MaHD),
	MaDV int references DICHVU(MaDV),
	SoLuong int,
	ThanhTien int,
	primary key (MaHD,MaDV)
)
alter table HoaDon_ChiTiet add TenKH nvarchar(50)
go
create table Account
(
	usename nchar(30) primary key,
	password nchar(30) not null
)
go
--============================================
--Phòng Ban
create proc sp_KhuTroChoi_Insert
	@Tenpb nvarchar(50),
	@Matp int,
	@Ngaync date,
	@Diadiem nvarchar(50)
as
begin
	insert into PhongBan(TenPB,MaTP,NgayNC,DiaDiem)
	values (
			@Tenpb ,
			@Matp ,
			@Ngaync ,
			@Diadiem )
	print @@identity
end
go
alter proc sp_PhongBan_Update
	@Mapb int,
	@Tenpb nvarchar(50),
	@Matp int,
	@Ngaync date,
	@Diadiem nvarchar(50)
as
begin
	update PhongBan
	set TenPB = @Tenpb,
		MaTP = @Matp,
		NgayNC = @Ngaync,
		DiaDiem = @Diadiem
	where MaPB = @Mapb
end
go
create proc sp_PhongBan_Delete
	@Mapb int
as
begin
	delete from PhongBan
	where MaPB = @Mapb
end
go
create proc sp_PhongBan_Select
as
begin
	select MaPB,TenPB,MaTP,NgayNC,DiaDiem
	from PhongBan
	order by MaPB
end
go

--Khu Trò Chơi

create proc sp_Khutrochoi_Insert
	@Tenkhu nvarchar(50),
	@Giatreem int,
	@Gianguoilon int,
	@Giomocua time,
	@Giodongcua time
as
begin
	insert into Khutrochoi(Tenkhu,Giatreem,Gianguoilon,Giomocua,Giodongcua)
	values (
			@Tenkhu ,
			@Giatreem ,
			@Gianguoilon ,
			@Giomocua ,
			@Giodongcua )
	print @@identity
end
go
create proc sp_Khutrochoi_Update
	@Makhu int,
	@Tenkhu nvarchar(50),
	@Giatreem int,
	@Gianguoilon int,
	@Giomocua time,
	@Giodongcua time
as
begin
	update KhuTroChoi
	set TenKhu = @Tenkhu ,
		Giatreem = @Giatreem ,
		Gianguoilon = @Gianguoilon ,
		Giomocua = @Giomocua ,
		Giodongcua = @Giodongcua
	where MaKhu = @Makhu
end
go
create proc sp_Khutrochoi_Delete
	@MaKhu int
as
begin
	delete from KhuTroChoi
	where MaKhu = @Makhu
end
go
create proc sp_Khutrochoi_Select
as
begin
	select MaKhu,Tenkhu,Giatreem,Gianguoilon,Giomocua,Giodongcua
	from KhuTroChoi
	order by MaKhu
end
go

--Trò chơi
create proc sp_Trochoi_Insert
	@Tentro nvarchar(50),
	@Makhu int
as
begin 
	insert into TroChoi(TenTro,MaKhu)
	values (@Tentro,@Makhu)
	print @@identity
end
go

create proc sp_Trochoi_Update
	@Matro int,
	@Tentro nvarchar(50),
	@Makhu int
as
begin
	update TroChoi
	set TenTro = @Tentro,
		MaKhu = @Makhu
	where MaTro = @Matro
end
go
create proc sp_Trochoi_Delete
	@Matro int
as
begin
	delete from TroChoi
	where MaTro = @Matro
end
go
create proc sp_Trochoi_Select
as
begin
	select Matro , Tentro,MaKhu
	from TroChoi
	order by Matro
end
go

--Dịch vụ
create proc sp_Dichvu_Insert
	@TenDV nvarchar(50),
	@GiaDV int,
	@Makhu int
as
begin 
	insert into DichVu(TenDV,GiaDV,MaKhu)
	values (@TenDV,@GiaDV,@Makhu)
	print @@identity
end
go

create proc sp_Dichvu_Update
	@MaDV int,
	@TenDV nvarchar(50),
	@GiaDV int,
	@Makhu int
as
begin
	update DichVu
	set TenDV = @TenDV,
		GiaDV = @GiaDV,
		MaKhu = @Makhu
	where MaDV = @MaDV
end
go
create proc sp_Dichvu_Delete
	@MaDV int
as
begin
	delete from DichVu
	where MaDV = @MaDV
end
go
create proc sp_Dichvu_Select
as
begin
	select MaDV,TenDV,GiaDV,MaKhu
	from DichVu
	order by MaDV
end
go

--Nhân Viên
alter proc sp_Nhanvien_Insert
	@TenNV nvarchar(50),
	@Ngaysinh date,
	@Gioitinh nvarchar(3),
	@Quequan nvarchar(50),
	@Chucvu nvarchar(50),
	@Luong int,
	@MaPB int,
	@Makhu int,
	@Matro int
as
begin
	insert into NhanVien(HoTen,NgaySinh,GioiTinh,QueQuan,ChucVu,Luong,MaPB,MaKhu,MaTro)
	values (@TenNV,@Ngaysinh,@Gioitinh,@Quequan,@Chucvu,@Luong,@MaPB,@Makhu,@Matro)
	print @@identity
end
go

create proc sp_Nhanvien_Update
	@MaNV int,
	@TenNV nvarchar(50),
	@Ngaysinh date,
	@Gioitinh nvarchar(3),
	@Quequan nvarchar(50),
	@Chucvu nvarchar(50),
	@Luong int,
	@MaPB int,
	@Makhu int,
	@Matro int
as
begin
	update NhanVien
	set HoTen = @TenNV,
		NgaySinh = @Ngaysinh,
		GioiTinh = @Gioitinh,
		QueQuan = @Quequan,
		ChucVu = @Chucvu,
		Luong = @Luong,
		MaPB = @MaPB,
		MaKhu = @Makhu,
		MaTro = @Matro
	where MaNV = @MaNV
end
go
create proc sp_Nhanvien_Delete
	@MaNV int
as
begin
	delete from NhanVien
	where MaNV = @MaNV
end
go
create proc sp_Nhanvien_Select
as
begin
	select MaNV,HoTen,NgaySinh,GioiTinh,QueQuan,ChucVu,Luong,MaPB,MaKhu,MaTro
	from NhanVien
	order by MaNV
end
go
--Vé

alter proc sp_Ve_Insert
	@Ngayban date,
	@SLTE int,
	@SLNL int,
	@MaNV int,
	@Makhu int
as
begin 
	insert into Ve(NgayBan,SLTE,SLNL,MaNV,MaKhu)
	values (@Ngayban,@SLTE,@SLNL,@MaNV,@Makhu)
	print @@identity
end
go

alter proc sp_Ve_Update
	@Mave int,
	@Ngayban date,
	@SLTE int,
	@SLNL int,
	@MaNV int,
	@Makhu int
as
begin
	update Ve
	set NgayBan = @Ngayban,
		SLTE = @SLTE,
		SLNL = @SLNL,
		MaNV = @MaNV,
		MaKhu = @Makhu
	where MaVe = @Mave
end
go
create proc sp_Ve_Delete
	@Mave int
as
begin
	delete from Ve
	where MaVe = @Mave
end
go
create proc sp_Ve_Select
as
begin
	select MaVe,NgayBan,SLTE,SLNL,TongThu,MaNV,MaKhu
	from Ve
	order by MaVe
end
go

--Hóa đơn
alter proc sp_Hoadon_Insert
	@NgaySD date
as
begin 
	insert into HoaDon(NgaySD)
	values (@NgaySD)
	print @@identity
end
go

alter proc sp_HoaDon_Update
	@MaHD int,
	@NgaySD date
as
begin
	update HoaDon
	set NgaySD = @NgaySD
	where MaHD = @MaHD
end
go
alter proc sp_HoaDon_Delete
	@MaHD int
as
begin
	delete from HoaDon
	where MaHD = @MaHD
end
go
alter proc sp_HoaDon_Select
as
begin
	select MaHD,NgaySD
	from HoaDon
	order by MaHD
end
go

--Hóa đơn chi tiết
alter proc sp_Hoadon_ChiTiet_Insert
	@MaHD int,
	@MaDV int,
	@Soluong int,
	@TenKH nvarchar(50)
as
begin 
	insert into HoaDon_ChiTiet(MaHD,MaDV,SoLuong,TenKH)
	values (@MaHD,@MaDV,@Soluong,@TenKH)
end
go

alter proc sp_HoaDon_ChiTiet_Update
	@MaHD int,
	@MaDV int,
	@Soluong int,
	@TenKH nvarchar(50)
as
begin
	update HoaDon_ChiTiet
	set 
		SoLuong = @Soluong,
		TenKH = @TenKH
	where MaHD = @MaHD and
		  MaDV = @MaDV
end
go
create proc sp_HoaDon_ChiTiet_Delete
	@MaHD int,
	@MaDV int
as
begin
	delete from HoaDon_ChiTiet
	where MaHD = @MaHD and
		  MaDV = @MaDV
end
go
create proc sp_HoaDon_ChiTiet_Select
as
begin
	select MaHD,MaDV,SoLuong,ThanhTien,TenKH
	from HoaDon_ChiTiet
	order by MaHD
end
go

--Login
create proc sp_Login
	@usename nvarchar(50),
	@password nvarchar(50)
as 
begin
	select usename, password  
	from Account 
	where usename = @usename and
		  password = @password
end
go
---===============================
-- TRIGGER
-- xóa hóa đơn
alter trigger XoaHD on HoaDon instead of delete
as
begin
	declare @Mahd int
	select @Mahd = MaHD from deleted
	delete HoaDon_ChiTiet
	where MaHD = @Mahd
	delete HoaDon
	where MaHD = @Mahd
end
go
--xóa dịch vụ
alter trigger XoaDV on DichVu instead of delete
as
begin
	declare @MaDV int
	select @MaDV = MaDV from deleted
	delete HoaDon_ChiTiet
	where MaDV = @MaDV
	delete DichVu
	where MaDV = @MaDV
end
go
sp_Dichvu_delete 3
-- xóa khu trò chơi
alter trigger XoaKhu on Khutrochoi instead of delete
as
begin
	declare @MaKhu int
	select @MaKhu  = Makhu from deleted
	update NhanVien
	set MaKhu = NULL
	where MaKhu = @MaKhu
	delete Ve
	where MaKhu = @MaKhu
	delete TroChoi
	where MaKhu = @MaKhu
	delete DichVu
	where MaKhu = @MaKhu
	delete KhuTroChoi
	where MaKhu = @MaKhu
end
go
--xóa phòng ban
alter trigger XoaPB on PhongBan instead of delete
as
begin
	declare @MaPB int,
			@MaNV int
	select @MaPB = MaPB from deleted
	update Nhanvien
	set MaPB = null
	where MaPB = @MaPB
	delete PhongBan
	where MaPB = @MaPB 
end
go
--xóa nhân viên
alter trigger XoaNV on Nhanvien instead of delete
as
begin
	declare @MaNV int,
			@MaPB int
	select @MaNV = MaNV from deleted
	select @MaPB = MaPB from deleted
	update Ve
	set MaNV = NULL
	where MaNV = @MaNV
	update PhongBan
	set MaTP = NULL
	where MaPB = @MaPB
	delete NhanVien
	where MaNV = @MaNV
end
go
--xóa trò chơi
create trigger XoaTro on Trochoi instead of delete
as
begin
	declare @Matro int
	select @Matro = Matro from TroChoi
	update NhanVien
	set MaTro = NULL
	where MaKhu = @Matro
	delete TroChoi
	where MaTro = @Matro
end
go
alter trigger Thanhtoan on HoaDon_Chitiet for Insert,Update
as
begin
	declare @sldv int,
			@Madv int,
			@Giadv int,
			@Mahd int
	select @Mahd = MaHD from inserted
	select @sldv = SoLuong from inserted
	select @Madv = MaDV from inserted
	select @Giadv = GiaDV from DICHVU where MaDV = @Madv
	update HoaDon_ChiTiet
	set ThanhTien = @sldv * @Giadv
	where MaHD = @Mahd and MaDV = @Madv
end
go
--
create trigger Tongthu on Ve for insert,update
as
begin
	declare @slte int,
			@slnl int,
			@Giate int,
			@Gianl int,
			@makhu int,
			@Mave int
	select @slte = slte from inserted
	select @slnl = slnl from inserted
	select @makhu = MaKhu from inserted
	select @Mave = MaVe from inserted
	select @Giate = Giatreem from KhuTroChoi
	select @Gianl = Gianguoilon from KhuTroChoi
	update Ve
	set TongThu = @slte * @Giate + @slnl * @Gianl
	where MaVe = @Mave
end
go

create proc sp_CheckMaHD (@MaHD int)
as
begin
	select MaHD from HoaDon
	where MaHD  = @MaHD
end
go

create proc sp_CheckMaNV(@MaNV int)
as
begin
	select MaNV from NhanVien
	where MaNV = @MaNV
end
go
create proc sp_CheckMaPB(@MaPB int)
as
begin
	select MaPB from PhongBan
	where MaPB = @MaPB
end
go
create proc sp_CheckMaKhu(@MaKhu int)
as
begin
	select MaKhu from KhuTroChoi 
	where MaKhu = @MaKhu
end
go
create proc sp_CheckMaDV(@MaDV int)
as
begin
	select MaDV from DichVu
	where MaDV = @MaDV
end
go
create proc sp_CheckMaTro(@MaTro int)
as
begin
	select MaTro from  TroChoi
	where MaTro = @MaTro
end
go
alter proc CheckMa
@MaPB int,
@MaKhu int,
@MaTro int
as
begin
	--if(@MaPB = '' and @MaKhu = '' and @MaTro = '')
		
	if(@MaKhu = '' and @MaPB ='')
		select MaTro from  TroChoi
		where MaTro = @MaTro
	else if (@MaKhu = '' and @MaTro = '')
		select MaPB from PhongBan
		where MaPB = @MaPB
	else if (@MaPB = '' and @MaTro = '')
		select MaKhu from KhuTroChoi 
		where MaKhu = @MaKhu
	else if (@MaKhu = '')
		begin
			select MaTro from  TroChoi
			where MaTro = @MaTro
			select MaPB from PhongBan
			where MaPB = @MaPB
		end
	else if (@MaPB = '')
		begin
			select MaTro from  TroChoi
			where MaTro = @MaTro
			select MaKhu from KhuTroChoi 
			where MaKhu = @MaKhu
		end
	else if (@MaTro = '')
		begin
			select MaPB from PhongBan
			where MaPB = @MaPB
			select MaKhu from KhuTroChoi 
			where MaKhu = @MaKhu
		end
	else if(@MaKhu != '' and @MaPB !='' and @MaTro != '')
		begin
			select MaPB from PhongBan
			where MaPB = @MaPB
			select MaKhu from KhuTroChoi 
			where MaKhu = @MaKhu
			select MaTro from  TroChoi
			where MaTro = @MaTro
		end
end
go

--================================
sp_Phongban_Insert N'Nhân sự','3','01/18/2018',N'Hà Nội'
sp_Dichvu_Insert N'Cho thuê kính bơi',20000,1
sp_Hoadon_Insert '11/15/2018'
sp_Hoadon_ChiTiet_Insert 2,1,4,N'Nguyễn Đình Nam'
sp_ve_Insert '11/19/2018',2,2,1,2

sp_Nhanvien_insert N'Nguyễn văn a','11/11/1999',N'Nam',N'Thái Bình',N'Nhân viên',1231231,null,null,null
