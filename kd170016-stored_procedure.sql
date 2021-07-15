USE [Transport]
GO

/****** Object:  StoredProcedure [dbo].[spZahtevVozilo]    Script Date: 6/22/2021 2:35:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spZahtevVozilo] 
	@KorisnickoIme varchar(100),
	@return int output
AS
BEGIN
	 if not exists (
		select *
		from ZahtevVozilo
		where KorisnickoIme=@KorisnickoIme
	 ) begin
		set @return=0
		return
	 end

	 if exists (
		select *
		from Kurir
		where KorisnickoIme=@KorisnickoIme
	 ) begin
		set @return=0
		return
	 end

	 declare @registracioniBroj varchar(100)
	 set @registracioniBroj = (
		select RegistracioniBroj
		from ZahtevVozilo
		where KorisnickoIme=@KorisnickoIme
	 )

	 insert 
	 into Kurir
	 values (@KorisnickoIme,@registracioniBroj,0,0,0)
	 set @return=1
	 return
END
GO

