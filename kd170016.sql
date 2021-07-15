
CREATE TYPE [String100]
	FROM VARCHAR(100) NULL
go

CREATE TYPE [ID]
	FROM INTEGER NULL
go

CREATE TYPE [Real]
	FROM DECIMAL(10,3) NULL
go

CREATE TABLE [Administrator]
( 
	[KorisnickoIme]      [String100]  NOT NULL 
)
go

CREATE TABLE [Grad]
( 
	[IdGrad]             [ID]  IDENTITY  NOT NULL ,
	[Naziv]              [String100]  NULL ,
	[PostanskiBroj]      [String100]  NULL 
)
go

CREATE TABLE [Korisnik]
( 
	[KorisnickoIme]      [String100]  NOT NULL ,
	[Ime]                [String100]  NOT NULL ,
	[Prezime]            [String100]  NOT NULL ,
	[Sifra]              [String100]  NOT NULL ,
	[BrojPoslatihPaketa] integer  NOT NULL 
)
go

CREATE TABLE [Kurir]
( 
	[KorisnickoIme]      [String100]  NOT NULL ,
	[RegistracioniBroj]  [String100]  NOT NULL ,
	[BrojIsporucenihPaketa] integer  NULL ,
	[Profit]             [Real]  NULL ,
	[Status]             bit  NOT NULL 
)
go

CREATE TABLE [OdobrenaPonuda]
( 
	[IdPonuda]           [ID]  NOT NULL 
)
go

CREATE TABLE [Opstina]
( 
	[IdOpstina]          [ID]  IDENTITY  NOT NULL ,
	[Naziv]              [String100]  NOT NULL ,
	[X]                  [Real]  NOT NULL ,
	[Y]                  [Real]  NOT NULL ,
	[IdGrad]             [ID]  NOT NULL 
)
go

CREATE TABLE [Paket]
( 
	[IdPaket]            [ID]  IDENTITY  NOT NULL ,
	[Status]             integer  NOT NULL ,
	[Cena]               [Real]  NULL ,
	[VremePrihvatanja]   datetime  NULL ,
	[Tip]                integer  NOT NULL ,
	[Tezina]             [Real]  NOT NULL ,
	[KorisnickoIme]      [String100] 
)
go

CREATE TABLE [Ponuda]
( 
	[Procenat]           [Real]  NOT NULL ,
	[Kurir]              [String100] ,
	[KorisnickoIme]      [String100] ,
	[IdPaket]            [ID] ,
	[IdPonuda]           [ID]  IDENTITY  NOT NULL 
)
go

CREATE TABLE [Sadrzi]
( 
	[IdVoznja]           [ID]  NOT NULL ,
	[IdPaket]            [ID]  NOT NULL ,
	[Profit]             [Real] 
)
go

CREATE TABLE [Vozilo]
( 
	[RegistracioniBroj]  [String100]  NOT NULL ,
	[TipGoriva]          integer  NOT NULL ,
	[Potrosnja]          [Real]  NULL 
)
go

CREATE TABLE [Voznja]
( 
	[IdVoznja]           [ID]  IDENTITY  NOT NULL ,
	[KorisnickoIme]      [String100] ,
	[IdOpstina]          [ID] 
)
go

CREATE TABLE [ZahtevPrevoz]
( 
	[KorisnickoIme]      [String100]  NOT NULL ,
	[IdPaket]            [ID]  NOT NULL ,
	[IdOpstinaOd]        [ID]  NOT NULL ,
	[IdOpstinaDo]        [ID]  NOT NULL 
)
go

CREATE TABLE [ZahtevVozilo]
( 
	[RegistracioniBroj]  [String100]  NOT NULL ,
	[KorisnickoIme]      [String100]  NOT NULL 
)
go

ALTER TABLE [Administrator]
	ADD CONSTRAINT [XPKAdministrator] PRIMARY KEY  CLUSTERED ([KorisnickoIme] ASC)
go

ALTER TABLE [Grad]
	ADD CONSTRAINT [XPKGrad] PRIMARY KEY  CLUSTERED ([IdGrad] ASC)
go

ALTER TABLE [Korisnik]
	ADD CONSTRAINT [XPKKorisnik] PRIMARY KEY  CLUSTERED ([KorisnickoIme] ASC)
go

ALTER TABLE [Kurir]
	ADD CONSTRAINT [XPKKurir] PRIMARY KEY  CLUSTERED ([KorisnickoIme] ASC)
go

ALTER TABLE [OdobrenaPonuda]
	ADD CONSTRAINT [XPKOdobrenaPonuda] PRIMARY KEY  CLUSTERED ([IdPonuda] ASC)
go

ALTER TABLE [Opstina]
	ADD CONSTRAINT [XPKOpstina] PRIMARY KEY  CLUSTERED ([IdOpstina] ASC)
go

ALTER TABLE [Paket]
	ADD CONSTRAINT [XPKPaket] PRIMARY KEY  CLUSTERED ([IdPaket] ASC)
go

ALTER TABLE [Ponuda]
	ADD CONSTRAINT [XPKPonuda] PRIMARY KEY  CLUSTERED ([IdPonuda] ASC)
go

ALTER TABLE [Sadrzi]
	ADD CONSTRAINT [XPKSadrzi] PRIMARY KEY  CLUSTERED ([IdVoznja] ASC,[IdPaket] ASC)
go

ALTER TABLE [Vozilo]
	ADD CONSTRAINT [XPKVozilo] PRIMARY KEY  CLUSTERED ([RegistracioniBroj] ASC)
go

ALTER TABLE [Voznja]
	ADD CONSTRAINT [XPKVoznja] PRIMARY KEY  CLUSTERED ([IdVoznja] ASC)
go

ALTER TABLE [ZahtevPrevoz]
	ADD CONSTRAINT [XPKZahtevPrevoz] PRIMARY KEY  CLUSTERED ([KorisnickoIme] ASC,[IdPaket] ASC)
go

ALTER TABLE [ZahtevVozilo]
	ADD CONSTRAINT [XPKZahtevVozilo] PRIMARY KEY  CLUSTERED ([RegistracioniBroj] ASC,[KorisnickoIme] ASC)
go


ALTER TABLE [Administrator]
	ADD CONSTRAINT [R_2] FOREIGN KEY ([KorisnickoIme]) REFERENCES [Korisnik]([KorisnickoIme])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go


ALTER TABLE [Kurir]
	ADD CONSTRAINT [R_3] FOREIGN KEY ([KorisnickoIme]) REFERENCES [Korisnik]([KorisnickoIme])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go

ALTER TABLE [Kurir]
	ADD CONSTRAINT [R_6] FOREIGN KEY ([RegistracioniBroj]) REFERENCES [Vozilo]([RegistracioniBroj])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [OdobrenaPonuda]
	ADD CONSTRAINT [R_15] FOREIGN KEY ([IdPonuda]) REFERENCES [Ponuda]([IdPonuda])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go


ALTER TABLE [Opstina]
	ADD CONSTRAINT [R_1] FOREIGN KEY ([IdGrad]) REFERENCES [Grad]([IdGrad])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Paket]
	ADD CONSTRAINT [R_27] FOREIGN KEY ([KorisnickoIme]) REFERENCES [Kurir]([KorisnickoIme])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Ponuda]
	ADD CONSTRAINT [R_24] FOREIGN KEY ([Kurir]) REFERENCES [Kurir]([KorisnickoIme])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Ponuda]
	ADD CONSTRAINT [R_26] FOREIGN KEY ([KorisnickoIme],[IdPaket]) REFERENCES [ZahtevPrevoz]([KorisnickoIme],[IdPaket])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Sadrzi]
	ADD CONSTRAINT [R_20] FOREIGN KEY ([IdVoznja]) REFERENCES [Voznja]([IdVoznja])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Sadrzi]
	ADD CONSTRAINT [R_28] FOREIGN KEY ([IdPaket]) REFERENCES [Paket]([IdPaket])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Voznja]
	ADD CONSTRAINT [R_29] FOREIGN KEY ([KorisnickoIme]) REFERENCES [Kurir]([KorisnickoIme])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Voznja]
	ADD CONSTRAINT [R_30] FOREIGN KEY ([IdOpstina]) REFERENCES [Opstina]([IdOpstina])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [ZahtevPrevoz]
	ADD CONSTRAINT [R_7] FOREIGN KEY ([KorisnickoIme]) REFERENCES [Korisnik]([KorisnickoIme])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [ZahtevPrevoz]
	ADD CONSTRAINT [R_8] FOREIGN KEY ([IdPaket]) REFERENCES [Paket]([IdPaket])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [ZahtevPrevoz]
	ADD CONSTRAINT [R_10] FOREIGN KEY ([IdOpstinaOd]) REFERENCES [Opstina]([IdOpstina])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [ZahtevPrevoz]
	ADD CONSTRAINT [R_11] FOREIGN KEY ([IdOpstinaDo]) REFERENCES [Opstina]([IdOpstina])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [ZahtevVozilo]
	ADD CONSTRAINT [R_22] FOREIGN KEY ([RegistracioniBroj]) REFERENCES [Vozilo]([RegistracioniBroj])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [ZahtevVozilo]
	ADD CONSTRAINT [R_23] FOREIGN KEY ([KorisnickoIme]) REFERENCES [Korisnik]([KorisnickoIme])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


CREATE TRIGGER tD_Administrator ON Administrator FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Administrator */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /*   Administrator on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00014648", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="KorisnickoIme" */
    IF EXISTS (SELECT * FROM deleted,
      WHERE
        /* %JoinFKPK(deleted,," = "," AND") */
        deleted.KorisnickoIme = KorisnickoIme AND
        NOT EXISTS (
          SELECT * FROM Administrator
          WHERE
            /* %JoinFKPK(Administrator,," = "," AND") */
            Administrator.KorisnickoIme = KorisnickoIme
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Administrator because  exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Administrator ON Administrator FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Administrator */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insKorisnickoIme String100,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /*   Administrator on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001657b", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="KorisnickoIme" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,
        WHERE
          /* %JoinFKPK(inserted,) */
          inserted.KorisnickoIme = KorisnickoIme
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Administrator because  does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Grad ON Grad FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Grad */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Grad  Opstina on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00010202", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Opstina"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdGrad" */
    IF EXISTS (
      SELECT * FROM deleted,Opstina
      WHERE
        /*  %JoinFKPK(Opstina,deleted," = "," AND") */
        Opstina.IdGrad = deleted.IdGrad
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Grad because Opstina exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Grad ON Grad FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Grad */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdGrad ID,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Grad  Opstina on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00015aad", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Opstina"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdGrad" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdGrad)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdGrad = inserted.IdGrad
        FROM inserted
      UPDATE Opstina
      SET
        /*  %JoinFKPK(Opstina,@ins," = ",",") */
        Opstina.IdGrad = @insIdGrad
      FROM Opstina,inserted,deleted
      WHERE
        /*  %JoinFKPK(Opstina,deleted," = "," AND") */
        Opstina.IdGrad = deleted.IdGrad
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Grad update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Korisnik ON Korisnik FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Korisnik */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Korisnik  ZahtevVozilo on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00039cd6", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevVozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="KorisnickoIme" */
    IF EXISTS (
      SELECT * FROM deleted,ZahtevVozilo
      WHERE
        /*  %JoinFKPK(ZahtevVozilo,deleted," = "," AND") */
        ZahtevVozilo.KorisnickoIme = deleted.KorisnickoIme
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because ZahtevVozilo exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  ZahtevPrevoz on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="KorisnickoIme" */
    IF EXISTS (
      SELECT * FROM deleted,ZahtevPrevoz
      WHERE
        /*  %JoinFKPK(ZahtevPrevoz,deleted," = "," AND") */
        ZahtevPrevoz.KorisnickoIme = deleted.KorisnickoIme
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because ZahtevPrevoz exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /*   Kurir on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="KorisnickoIme" */
    DELETE Kurir
      FROM Kurir,deleted
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.KorisnickoIme = deleted.KorisnickoIme

    /* erwin Builtin Trigger */
    /*   Administrator on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="KorisnickoIme" */
    DELETE Administrator
      FROM Administrator,deleted
      WHERE
        /*  %JoinFKPK(Administrator,deleted," = "," AND") */
        Administrator.KorisnickoIme = deleted.KorisnickoIme


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Korisnik ON Korisnik FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Korisnik */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insKorisnickoIme String100,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Korisnik  ZahtevVozilo on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00058e4e", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevVozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="KorisnickoIme" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,ZahtevVozilo
      WHERE
        /*  %JoinFKPK(ZahtevVozilo,deleted," = "," AND") */
        ZahtevVozilo.KorisnickoIme = deleted.KorisnickoIme
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Korisnik because ZahtevVozilo exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  ZahtevPrevoz on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="KorisnickoIme" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insKorisnickoIme = inserted.KorisnickoIme
        FROM inserted
      UPDATE ZahtevPrevoz
      SET
        /*  %JoinFKPK(ZahtevPrevoz,@ins," = ",",") */
        ZahtevPrevoz.KorisnickoIme = @insKorisnickoIme
      FROM ZahtevPrevoz,inserted,deleted
      WHERE
        /*  %JoinFKPK(ZahtevPrevoz,deleted," = "," AND") */
        ZahtevPrevoz.KorisnickoIme = deleted.KorisnickoIme
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /*   Kurir on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="KorisnickoIme" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insKorisnickoIme = inserted.KorisnickoIme
        FROM inserted
      UPDATE Kurir
      SET
        /*  %JoinFKPK(Kurir,@ins," = ",",") */
        Kurir.KorisnickoIme = @insKorisnickoIme
      FROM Kurir,inserted,deleted
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.KorisnickoIme = deleted.KorisnickoIme
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade  update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /*   Administrator on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="KorisnickoIme" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insKorisnickoIme = inserted.KorisnickoIme
        FROM inserted
      UPDATE Administrator
      SET
        /*  %JoinFKPK(Administrator,@ins," = ",",") */
        Administrator.KorisnickoIme = @insKorisnickoIme
      FROM Administrator,inserted,deleted
      WHERE
        /*  %JoinFKPK(Administrator,deleted," = "," AND") */
        Administrator.KorisnickoIme = deleted.KorisnickoIme
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade  update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Kurir ON Kurir FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Kurir */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Kurir  Voznja on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0004fdf8", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="KorisnickoIme" */
    IF EXISTS (
      SELECT * FROM deleted,Voznja
      WHERE
        /*  %JoinFKPK(Voznja,deleted," = "," AND") */
        Voznja.KorisnickoIme = deleted.KorisnickoIme
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurir because Voznja exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="KorisnickoIme" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.KorisnickoIme = deleted.KorisnickoIme
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurir because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Ponuda on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Kurir" */
    IF EXISTS (
      SELECT * FROM deleted,Ponuda
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.Kurir = deleted.KorisnickoIme
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurir because Ponuda exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vozilo  Kurir on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="RegistracioniBroj" */
    IF EXISTS (SELECT * FROM deleted,Vozilo
      WHERE
        /* %JoinFKPK(deleted,Vozilo," = "," AND") */
        deleted.RegistracioniBroj = Vozilo.RegistracioniBroj AND
        NOT EXISTS (
          SELECT * FROM Kurir
          WHERE
            /* %JoinFKPK(Kurir,Vozilo," = "," AND") */
            Kurir.RegistracioniBroj = Vozilo.RegistracioniBroj
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Kurir because Vozilo exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /*   Kurir on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="KorisnickoIme" */
    IF EXISTS (SELECT * FROM deleted,
      WHERE
        /* %JoinFKPK(deleted,," = "," AND") */
        deleted.KorisnickoIme = KorisnickoIme AND
        NOT EXISTS (
          SELECT * FROM Kurir
          WHERE
            /* %JoinFKPK(Kurir,," = "," AND") */
            Kurir.KorisnickoIme = KorisnickoIme
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Kurir because  exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Kurir ON Kurir FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Kurir */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insKorisnickoIme String100,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Kurir  Voznja on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0005a4fc", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="KorisnickoIme" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Voznja
      WHERE
        /*  %JoinFKPK(Voznja,deleted," = "," AND") */
        Voznja.KorisnickoIme = deleted.KorisnickoIme
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Kurir because Voznja exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Paket on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="KorisnickoIme" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.KorisnickoIme = deleted.KorisnickoIme
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Kurir because Paket exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Ponuda on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Kurir" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Ponuda
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.Kurir = deleted.KorisnickoIme
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Kurir because Ponuda exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Vozilo  Kurir on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="RegistracioniBroj" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(RegistracioniBroj)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Vozilo
        WHERE
          /* %JoinFKPK(inserted,Vozilo) */
          inserted.RegistracioniBroj = Vozilo.RegistracioniBroj
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Kurir because Vozilo does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /*   Kurir on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="KorisnickoIme" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,
        WHERE
          /* %JoinFKPK(inserted,) */
          inserted.KorisnickoIme = KorisnickoIme
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Kurir because  does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_OdobrenaPonuda ON OdobrenaPonuda FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on OdobrenaPonuda */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Kurir  OdobrenaPonuda on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00014a99", PARENT_OWNER="", PARENT_TABLE="Ponuda"
    CHILD_OWNER="", CHILD_TABLE="OdobrenaPonuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="IdPonuda" */
    IF EXISTS (SELECT * FROM deleted,Kurir
      WHERE
        /* %JoinFKPK(deleted,Kurir," = "," AND") */
        deleted.IdPonuda = Kurir.IdPonuda AND
        NOT EXISTS (
          SELECT * FROM OdobrenaPonuda
          WHERE
            /* %JoinFKPK(OdobrenaPonuda,Kurir," = "," AND") */
            OdobrenaPonuda.IdPonuda = Kurir.IdPonuda
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last OdobrenaPonuda because Kurir exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_OdobrenaPonuda ON OdobrenaPonuda FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on OdobrenaPonuda */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdPonuda ID,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Kurir  OdobrenaPonuda on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001666d", PARENT_OWNER="", PARENT_TABLE="Ponuda"
    CHILD_OWNER="", CHILD_TABLE="OdobrenaPonuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="IdPonuda" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdPonuda)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurir
        WHERE
          /* %JoinFKPK(inserted,Kurir) */
          inserted.IdPonuda = Kurir.IdPonuda
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update OdobrenaPonuda because Kurir does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Opstina ON Opstina FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Opstina */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Opstina  Voznja on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00040cf1", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="IdOpstina" */
    IF EXISTS (
      SELECT * FROM deleted,Voznja
      WHERE
        /*  %JoinFKPK(Voznja,deleted," = "," AND") */
        Voznja.IdOpstina = deleted.IdOpstina
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Opstina because Voznja exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Opstina  ZahtevPrevoz on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="IdOpstinaDo" */
    IF EXISTS (
      SELECT * FROM deleted,ZahtevPrevoz
      WHERE
        /*  %JoinFKPK(ZahtevPrevoz,deleted," = "," AND") */
        ZahtevPrevoz.IdOpstinaDo = deleted.IdOpstina
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Opstina because ZahtevPrevoz exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Opstina  ZahtevPrevoz on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="IdOpstinaOd" */
    IF EXISTS (
      SELECT * FROM deleted,ZahtevPrevoz
      WHERE
        /*  %JoinFKPK(ZahtevPrevoz,deleted," = "," AND") */
        ZahtevPrevoz.IdOpstinaOd = deleted.IdOpstina
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Opstina because ZahtevPrevoz exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Grad  Opstina on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Opstina"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdGrad" */
    IF EXISTS (SELECT * FROM deleted,Grad
      WHERE
        /* %JoinFKPK(deleted,Grad," = "," AND") */
        deleted.IdGrad = Grad.IdGrad AND
        NOT EXISTS (
          SELECT * FROM Opstina
          WHERE
            /* %JoinFKPK(Opstina,Grad," = "," AND") */
            Opstina.IdGrad = Grad.IdGrad
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Opstina because Grad exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Opstina ON Opstina FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Opstina */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdOpstina ID,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Opstina  Voznja on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0005368a", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="IdOpstina" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdOpstina)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Voznja
      WHERE
        /*  %JoinFKPK(Voznja,deleted," = "," AND") */
        Voznja.IdOpstina = deleted.IdOpstina
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Opstina because Voznja exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Opstina  ZahtevPrevoz on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="IdOpstinaDo" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdOpstina)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdOpstina = inserted.IdOpstina
        FROM inserted
      UPDATE ZahtevPrevoz
      SET
        /*  %JoinFKPK(ZahtevPrevoz,@ins," = ",",") */
        ZahtevPrevoz.IdOpstinaDo = @insIdOpstina
      FROM ZahtevPrevoz,inserted,deleted
      WHERE
        /*  %JoinFKPK(ZahtevPrevoz,deleted," = "," AND") */
        ZahtevPrevoz.IdOpstinaDo = deleted.IdOpstina
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Opstina update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Opstina  ZahtevPrevoz on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="IdOpstinaOd" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdOpstina)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdOpstina = inserted.IdOpstina
        FROM inserted
      UPDATE ZahtevPrevoz
      SET
        /*  %JoinFKPK(ZahtevPrevoz,@ins," = ",",") */
        ZahtevPrevoz.IdOpstinaOd = @insIdOpstina
      FROM ZahtevPrevoz,inserted,deleted
      WHERE
        /*  %JoinFKPK(ZahtevPrevoz,deleted," = "," AND") */
        ZahtevPrevoz.IdOpstinaOd = deleted.IdOpstina
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Opstina update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Grad  Opstina on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Opstina"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdGrad" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdGrad)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Grad
        WHERE
          /* %JoinFKPK(inserted,Grad) */
          inserted.IdGrad = Grad.IdGrad
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Opstina because Grad does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Paket ON Paket FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Paket */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Paket  Sadrzi on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002ff36", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Sadrzi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="IdPaket" */
    IF EXISTS (
      SELECT * FROM deleted,Sadrzi
      WHERE
        /*  %JoinFKPK(Sadrzi,deleted," = "," AND") */
        Sadrzi.IdPaket = deleted.IdPaket
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Paket because Sadrzi exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Paket  ZahtevPrevoz on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="IdPaket" */
    IF EXISTS (
      SELECT * FROM deleted,ZahtevPrevoz
      WHERE
        /*  %JoinFKPK(ZahtevPrevoz,deleted," = "," AND") */
        ZahtevPrevoz.IdPaket = deleted.IdPaket
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Paket because ZahtevPrevoz exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Paket on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="KorisnickoIme" */
    IF EXISTS (SELECT * FROM deleted,Kurir
      WHERE
        /* %JoinFKPK(deleted,Kurir," = "," AND") */
        deleted.KorisnickoIme = Kurir.KorisnickoIme AND
        NOT EXISTS (
          SELECT * FROM Paket
          WHERE
            /* %JoinFKPK(Paket,Kurir," = "," AND") */
            Paket.KorisnickoIme = Kurir.KorisnickoIme
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Paket because Kurir exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Paket ON Paket FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Paket */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdPaket ID,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Paket  Sadrzi on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003e2c4", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Sadrzi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="IdPaket" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdPaket)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sadrzi
      WHERE
        /*  %JoinFKPK(Sadrzi,deleted," = "," AND") */
        Sadrzi.IdPaket = deleted.IdPaket
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Paket because Sadrzi exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Paket  ZahtevPrevoz on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="IdPaket" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdPaket)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdPaket = inserted.IdPaket
        FROM inserted
      UPDATE ZahtevPrevoz
      SET
        /*  %JoinFKPK(ZahtevPrevoz,@ins," = ",",") */
        ZahtevPrevoz.IdPaket = @insIdPaket
      FROM ZahtevPrevoz,inserted,deleted
      WHERE
        /*  %JoinFKPK(ZahtevPrevoz,deleted," = "," AND") */
        ZahtevPrevoz.IdPaket = deleted.IdPaket
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Paket update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Paket on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="KorisnickoIme" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurir
        WHERE
          /* %JoinFKPK(inserted,Kurir) */
          inserted.KorisnickoIme = Kurir.KorisnickoIme
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.KorisnickoIme IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Paket because Kurir does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Ponuda ON Ponuda FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Ponuda */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Kurir  OdobrenaPonuda on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00034c28", PARENT_OWNER="", PARENT_TABLE="Ponuda"
    CHILD_OWNER="", CHILD_TABLE="OdobrenaPonuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="IdPonuda" */
    DELETE OdobrenaPonuda
      FROM OdobrenaPonuda,deleted
      WHERE
        /*  %JoinFKPK(OdobrenaPonuda,deleted," = "," AND") */
        OdobrenaPonuda.IdPonuda = deleted.IdPonuda

    /* erwin Builtin Trigger */
    /* ZahtevPrevoz  Ponuda on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ZahtevPrevoz"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="KorisnickoIme""IdPaket" */
    IF EXISTS (SELECT * FROM deleted,ZahtevPrevoz
      WHERE
        /* %JoinFKPK(deleted,ZahtevPrevoz," = "," AND") */
        deleted.KorisnickoIme = ZahtevPrevoz.KorisnickoIme AND
        deleted.IdPaket = ZahtevPrevoz.IdPaket AND
        NOT EXISTS (
          SELECT * FROM Ponuda
          WHERE
            /* %JoinFKPK(Ponuda,ZahtevPrevoz," = "," AND") */
            Ponuda.KorisnickoIme = ZahtevPrevoz.KorisnickoIme AND
            Ponuda.IdPaket = ZahtevPrevoz.IdPaket
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Ponuda because ZahtevPrevoz exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Ponuda on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Kurir" */
    IF EXISTS (SELECT * FROM deleted,Kurir
      WHERE
        /* %JoinFKPK(deleted,Kurir," = "," AND") */
        deleted.Kurir = Kurir.KorisnickoIme AND
        NOT EXISTS (
          SELECT * FROM Ponuda
          WHERE
            /* %JoinFKPK(Ponuda,Kurir," = "," AND") */
            Ponuda.Kurir = Kurir.KorisnickoIme
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Ponuda because Kurir exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Ponuda ON Ponuda FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Ponuda */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdPonuda ID,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Kurir  OdobrenaPonuda on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00047a2f", PARENT_OWNER="", PARENT_TABLE="Ponuda"
    CHILD_OWNER="", CHILD_TABLE="OdobrenaPonuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="IdPonuda" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdPonuda)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdPonuda = inserted.IdPonuda
        FROM inserted
      UPDATE OdobrenaPonuda
      SET
        /*  %JoinFKPK(OdobrenaPonuda,@ins," = ",",") */
        OdobrenaPonuda.IdPonuda = @insIdPonuda
      FROM OdobrenaPonuda,inserted,deleted
      WHERE
        /*  %JoinFKPK(OdobrenaPonuda,deleted," = "," AND") */
        OdobrenaPonuda.IdPonuda = deleted.IdPonuda
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Kurir update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* ZahtevPrevoz  Ponuda on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ZahtevPrevoz"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="KorisnickoIme""IdPaket" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(KorisnickoIme) OR
    UPDATE(IdPaket)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,ZahtevPrevoz
        WHERE
          /* %JoinFKPK(inserted,ZahtevPrevoz) */
          inserted.KorisnickoIme = ZahtevPrevoz.KorisnickoIme and
          inserted.IdPaket = ZahtevPrevoz.IdPaket
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.KorisnickoIme IS NULL AND
      inserted.IdPaket IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Ponuda because ZahtevPrevoz does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Ponuda on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Kurir" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Kurir)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurir
        WHERE
          /* %JoinFKPK(inserted,Kurir) */
          inserted.Kurir = Kurir.KorisnickoIme
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Kurir IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Ponuda because Kurir does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Sadrzi ON Sadrzi FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Sadrzi */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Paket  Sadrzi on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000250b1", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Sadrzi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="IdPaket" */
    IF EXISTS (SELECT * FROM deleted,Paket
      WHERE
        /* %JoinFKPK(deleted,Paket," = "," AND") */
        deleted.IdPaket = Paket.IdPaket AND
        NOT EXISTS (
          SELECT * FROM Sadrzi
          WHERE
            /* %JoinFKPK(Sadrzi,Paket," = "," AND") */
            Sadrzi.IdPaket = Paket.IdPaket
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sadrzi because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Voznja  Sadrzi on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Voznja"
    CHILD_OWNER="", CHILD_TABLE="Sadrzi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="IdVoznja" */
    IF EXISTS (SELECT * FROM deleted,Voznja
      WHERE
        /* %JoinFKPK(deleted,Voznja," = "," AND") */
        deleted.IdVoznja = Voznja.IdVoznja AND
        NOT EXISTS (
          SELECT * FROM Sadrzi
          WHERE
            /* %JoinFKPK(Sadrzi,Voznja," = "," AND") */
            Sadrzi.IdVoznja = Voznja.IdVoznja
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sadrzi because Voznja exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Sadrzi ON Sadrzi FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Sadrzi */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdVoznja ID, 
           @insIdPaket ID,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Paket  Sadrzi on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00029df8", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Sadrzi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="IdPaket" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdPaket)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Paket
        WHERE
          /* %JoinFKPK(inserted,Paket) */
          inserted.IdPaket = Paket.IdPaket
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sadrzi because Paket does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Voznja  Sadrzi on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Voznja"
    CHILD_OWNER="", CHILD_TABLE="Sadrzi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="IdVoznja" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdVoznja)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Voznja
        WHERE
          /* %JoinFKPK(inserted,Voznja) */
          inserted.IdVoznja = Voznja.IdVoznja
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sadrzi because Voznja does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Vozilo ON Vozilo FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vozilo */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vozilo  ZahtevVozilo on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001ff24", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="ZahtevVozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="RegistracioniBroj" */
    IF EXISTS (
      SELECT * FROM deleted,ZahtevVozilo
      WHERE
        /*  %JoinFKPK(ZahtevVozilo,deleted," = "," AND") */
        ZahtevVozilo.RegistracioniBroj = deleted.RegistracioniBroj
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vozilo because ZahtevVozilo exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vozilo  Kurir on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="RegistracioniBroj" */
    IF EXISTS (
      SELECT * FROM deleted,Kurir
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.RegistracioniBroj = deleted.RegistracioniBroj
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vozilo because Kurir exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Vozilo ON Vozilo FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Vozilo */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insRegistracioniBroj String100,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vozilo  ZahtevVozilo on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="000324b3", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="ZahtevVozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="RegistracioniBroj" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(RegistracioniBroj)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insRegistracioniBroj = inserted.RegistracioniBroj
        FROM inserted
      UPDATE ZahtevVozilo
      SET
        /*  %JoinFKPK(ZahtevVozilo,@ins," = ",",") */
        ZahtevVozilo.RegistracioniBroj = @insRegistracioniBroj
      FROM ZahtevVozilo,inserted,deleted
      WHERE
        /*  %JoinFKPK(ZahtevVozilo,deleted," = "," AND") */
        ZahtevVozilo.RegistracioniBroj = deleted.RegistracioniBroj
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Vozilo update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Vozilo  Kurir on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="RegistracioniBroj" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(RegistracioniBroj)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insRegistracioniBroj = inserted.RegistracioniBroj
        FROM inserted
      UPDATE Kurir
      SET
        /*  %JoinFKPK(Kurir,@ins," = ",",") */
        Kurir.RegistracioniBroj = @insRegistracioniBroj
      FROM Kurir,inserted,deleted
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.RegistracioniBroj = deleted.RegistracioniBroj
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Vozilo update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Voznja ON Voznja FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Voznja */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Voznja  Sadrzi on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000336a5", PARENT_OWNER="", PARENT_TABLE="Voznja"
    CHILD_OWNER="", CHILD_TABLE="Sadrzi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="IdVoznja" */
    IF EXISTS (
      SELECT * FROM deleted,Sadrzi
      WHERE
        /*  %JoinFKPK(Sadrzi,deleted," = "," AND") */
        Sadrzi.IdVoznja = deleted.IdVoznja
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Voznja because Sadrzi exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Opstina  Voznja on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="IdOpstina" */
    IF EXISTS (SELECT * FROM deleted,Opstina
      WHERE
        /* %JoinFKPK(deleted,Opstina," = "," AND") */
        deleted.IdOpstina = Opstina.IdOpstina AND
        NOT EXISTS (
          SELECT * FROM Voznja
          WHERE
            /* %JoinFKPK(Voznja,Opstina," = "," AND") */
            Voznja.IdOpstina = Opstina.IdOpstina
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Voznja because Opstina exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Voznja on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="KorisnickoIme" */
    IF EXISTS (SELECT * FROM deleted,Kurir
      WHERE
        /* %JoinFKPK(deleted,Kurir," = "," AND") */
        deleted.KorisnickoIme = Kurir.KorisnickoIme AND
        NOT EXISTS (
          SELECT * FROM Voznja
          WHERE
            /* %JoinFKPK(Voznja,Kurir," = "," AND") */
            Voznja.KorisnickoIme = Kurir.KorisnickoIme
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Voznja because Kurir exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Voznja ON Voznja FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Voznja */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdVoznja ID,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Voznja  Sadrzi on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0004376b", PARENT_OWNER="", PARENT_TABLE="Voznja"
    CHILD_OWNER="", CHILD_TABLE="Sadrzi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="IdVoznja" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdVoznja)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdVoznja = inserted.IdVoznja
        FROM inserted
      UPDATE Sadrzi
      SET
        /*  %JoinFKPK(Sadrzi,@ins," = ",",") */
        Sadrzi.IdVoznja = @insIdVoznja
      FROM Sadrzi,inserted,deleted
      WHERE
        /*  %JoinFKPK(Sadrzi,deleted," = "," AND") */
        Sadrzi.IdVoznja = deleted.IdVoznja
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Voznja update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Opstina  Voznja on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="IdOpstina" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdOpstina)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Opstina
        WHERE
          /* %JoinFKPK(inserted,Opstina) */
          inserted.IdOpstina = Opstina.IdOpstina
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.IdOpstina IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Voznja because Opstina does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Voznja on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="KorisnickoIme" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurir
        WHERE
          /* %JoinFKPK(inserted,Kurir) */
          inserted.KorisnickoIme = Kurir.KorisnickoIme
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.KorisnickoIme IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Voznja because Kurir does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_ZahtevPrevoz ON ZahtevPrevoz FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ZahtevPrevoz */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* ZahtevPrevoz  Ponuda on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0005df6f", PARENT_OWNER="", PARENT_TABLE="ZahtevPrevoz"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="KorisnickoIme""IdPaket" */
    IF EXISTS (
      SELECT * FROM deleted,Ponuda
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.KorisnickoIme = deleted.KorisnickoIme AND
        Ponuda.IdPaket = deleted.IdPaket
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete ZahtevPrevoz because Ponuda exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Opstina  ZahtevPrevoz on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="IdOpstinaDo" */
    IF EXISTS (SELECT * FROM deleted,Opstina
      WHERE
        /* %JoinFKPK(deleted,Opstina," = "," AND") */
        deleted.IdOpstinaDo = Opstina.IdOpstina AND
        NOT EXISTS (
          SELECT * FROM ZahtevPrevoz
          WHERE
            /* %JoinFKPK(ZahtevPrevoz,Opstina," = "," AND") */
            ZahtevPrevoz.IdOpstinaDo = Opstina.IdOpstina
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ZahtevPrevoz because Opstina exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Opstina  ZahtevPrevoz on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="IdOpstinaOd" */
    IF EXISTS (SELECT * FROM deleted,Opstina
      WHERE
        /* %JoinFKPK(deleted,Opstina," = "," AND") */
        deleted.IdOpstinaOd = Opstina.IdOpstina AND
        NOT EXISTS (
          SELECT * FROM ZahtevPrevoz
          WHERE
            /* %JoinFKPK(ZahtevPrevoz,Opstina," = "," AND") */
            ZahtevPrevoz.IdOpstinaOd = Opstina.IdOpstina
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ZahtevPrevoz because Opstina exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Paket  ZahtevPrevoz on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="IdPaket" */
    IF EXISTS (SELECT * FROM deleted,Paket
      WHERE
        /* %JoinFKPK(deleted,Paket," = "," AND") */
        deleted.IdPaket = Paket.IdPaket AND
        NOT EXISTS (
          SELECT * FROM ZahtevPrevoz
          WHERE
            /* %JoinFKPK(ZahtevPrevoz,Paket," = "," AND") */
            ZahtevPrevoz.IdPaket = Paket.IdPaket
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ZahtevPrevoz because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  ZahtevPrevoz on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="KorisnickoIme" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.KorisnickoIme = Korisnik.KorisnickoIme AND
        NOT EXISTS (
          SELECT * FROM ZahtevPrevoz
          WHERE
            /* %JoinFKPK(ZahtevPrevoz,Korisnik," = "," AND") */
            ZahtevPrevoz.KorisnickoIme = Korisnik.KorisnickoIme
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ZahtevPrevoz because Korisnik exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_ZahtevPrevoz ON ZahtevPrevoz FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ZahtevPrevoz */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insKorisnickoIme String100, 
           @insIdPaket ID,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* ZahtevPrevoz  Ponuda on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00066a50", PARENT_OWNER="", PARENT_TABLE="ZahtevPrevoz"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="KorisnickoIme""IdPaket" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(KorisnickoIme) OR
    UPDATE(IdPaket)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Ponuda
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.KorisnickoIme = deleted.KorisnickoIme AND
        Ponuda.IdPaket = deleted.IdPaket
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update ZahtevPrevoz because Ponuda exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Opstina  ZahtevPrevoz on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="IdOpstinaDo" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdOpstinaDo)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Opstina
        WHERE
          /* %JoinFKPK(inserted,Opstina) */
          inserted.IdOpstinaDo = Opstina.IdOpstina
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ZahtevPrevoz because Opstina does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Opstina  ZahtevPrevoz on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="IdOpstinaOd" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdOpstinaOd)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Opstina
        WHERE
          /* %JoinFKPK(inserted,Opstina) */
          inserted.IdOpstinaOd = Opstina.IdOpstina
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ZahtevPrevoz because Opstina does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Paket  ZahtevPrevoz on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="IdPaket" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdPaket)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Paket
        WHERE
          /* %JoinFKPK(inserted,Paket) */
          inserted.IdPaket = Paket.IdPaket
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ZahtevPrevoz because Paket does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  ZahtevPrevoz on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="KorisnickoIme" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.KorisnickoIme = Korisnik.KorisnickoIme
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ZahtevPrevoz because Korisnik does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_ZahtevVozilo ON ZahtevVozilo FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ZahtevVozilo */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Korisnik  ZahtevVozilo on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000289d1", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevVozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="KorisnickoIme" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.KorisnickoIme = Korisnik.KorisnickoIme AND
        NOT EXISTS (
          SELECT * FROM ZahtevVozilo
          WHERE
            /* %JoinFKPK(ZahtevVozilo,Korisnik," = "," AND") */
            ZahtevVozilo.KorisnickoIme = Korisnik.KorisnickoIme
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ZahtevVozilo because Korisnik exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vozilo  ZahtevVozilo on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="ZahtevVozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="RegistracioniBroj" */
    IF EXISTS (SELECT * FROM deleted,Vozilo
      WHERE
        /* %JoinFKPK(deleted,Vozilo," = "," AND") */
        deleted.RegistracioniBroj = Vozilo.RegistracioniBroj AND
        NOT EXISTS (
          SELECT * FROM ZahtevVozilo
          WHERE
            /* %JoinFKPK(ZahtevVozilo,Vozilo," = "," AND") */
            ZahtevVozilo.RegistracioniBroj = Vozilo.RegistracioniBroj
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ZahtevVozilo because Vozilo exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_ZahtevVozilo ON ZahtevVozilo FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ZahtevVozilo */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insRegistracioniBroj String100, 
           @insKorisnickoIme String100,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Korisnik  ZahtevVozilo on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002bc5a", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevVozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="KorisnickoIme" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(KorisnickoIme)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.KorisnickoIme = Korisnik.KorisnickoIme
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ZahtevVozilo because Korisnik does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Vozilo  ZahtevVozilo on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="ZahtevVozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="RegistracioniBroj" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(RegistracioniBroj)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Vozilo
        WHERE
          /* %JoinFKPK(inserted,Vozilo) */
          inserted.RegistracioniBroj = Vozilo.RegistracioniBroj
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ZahtevVozilo because Vozilo does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


