USE [Transport]
GO

/****** Object:  Trigger [dbo].[TR_TransportOffer_OdobriPonudu]    Script Date: 6/22/2021 2:36:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TR_TransportOffer_OdobriPonudu]
   ON [dbo].[OdobrenaPonuda]
   AFTER INSERT
AS 
BEGIN	
	declare @kursor cursor
	declare @IdPonuda int
	declare @IdPaket int

	set @kursor = cursor for
	select IdPonuda
	from inserted

	open @kursor

	fetch
	from @kursor
	into @IdPonuda

	set @IdPaket = (
		select IdPaket
		from Ponuda
		where IdPonuda=@IdPonuda
	)

	delete 
	from Ponuda
	where IdPonuda!=@IdPonuda and IdPaket=@IdPaket
	
END
GO

ALTER TABLE [dbo].[OdobrenaPonuda] ENABLE TRIGGER [TR_TransportOffer_OdobriPonudu]
GO

