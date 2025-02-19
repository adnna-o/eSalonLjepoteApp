using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace eSalonLjepote.Service.Database;

public partial class ESalonLjepoteContext : DbContext
{
    public ESalonLjepoteContext()
    {
    }

    public ESalonLjepoteContext(DbContextOptions<ESalonLjepoteContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Administrator> Administrators { get; set; }

    public virtual DbSet<Galerija> Galerijas { get; set; }

    public virtual DbSet<Klijenti> Klijentis { get; set; }

    public virtual DbSet<Korisnik> Korisniks { get; set; }

    public virtual DbSet<KorisnikUloga> KorisnikUlogas { get; set; }

    public virtual DbSet<Narudzba> Narudzbas { get; set; }

    public virtual DbSet<Novosti> Novostis { get; set; }

    public virtual DbSet<Placanje> Placanjes { get; set; }

    public virtual DbSet<Proizvod> Proizvods { get; set; }

    public virtual DbSet<RadnoVrijeme> RadnoVrijemes { get; set; }

    public virtual DbSet<Recenzije> Recenzijes { get; set; }

    public virtual DbSet<SalonLjepote> SalonLjepotes { get; set; }

    public virtual DbSet<Termini> Terminis { get; set; }

    public virtual DbSet<Uloga> Ulogas { get; set; }

    public virtual DbSet<Usluga> Uslugas { get; set; }

    public virtual DbSet<Zaposleni> Zaposlenis { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=localhost; Initial Catalog=eSalonLjepote; User Id=sa; Password=ad12!Obr; TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Administrator>(entity =>
        {
            entity.HasKey(e => e.AdministratorId).HasName("PK__Administ__ACDEFED39E30171F");

            entity.ToTable("Administrator");

            entity.Property(e => e.DatumZaposlenja).HasColumnType("datetime");
            entity.Property(e => e.OpisPosla).HasMaxLength(255);

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Administrators)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Korisnik_Administrator");
        });

        modelBuilder.Entity<Galerija>(entity =>
        {
            entity.HasKey(e => e.GalerijaId).HasName("PK__Galerija__39DCA3DB934C538C");

            entity.ToTable("Galerija");

            entity.HasOne(d => d.Administrator).WithMany(p => p.Galerijas)
                .HasForeignKey(d => d.AdministratorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Administrator_Galerija");
        });

        modelBuilder.Entity<Klijenti>(entity =>
        {
            entity.HasKey(e => e.KlijentId).HasName("PK__Klijenti__5F05D8AE56D1252D");

            entity.ToTable("Klijenti");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Klijentis)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Korisnik_Klijenti");
        });

        modelBuilder.Entity<Korisnik>(entity =>
        {
            entity.HasKey(e => e.KorisnikId).HasName("PK__Korisnik__80B06D41211C7C55");

            entity.ToTable("Korisnik");

            entity.Property(e => e.DatumRodjenja).HasColumnType("datetime");
            entity.Property(e => e.Email).HasMaxLength(255);
            entity.Property(e => e.Ime).HasMaxLength(100);
            entity.Property(e => e.KorisnickoIme).HasMaxLength(100);
            entity.Property(e => e.LozinkaHash).HasMaxLength(255);
            entity.Property(e => e.LozinkaSalt).HasMaxLength(250);
            entity.Property(e => e.Prezime).HasMaxLength(100);
            entity.Property(e => e.Spol).HasMaxLength(5);
            entity.Property(e => e.Telefon).HasMaxLength(100);
        });

        modelBuilder.Entity<KorisnikUloga>(entity =>
        {
            entity.HasKey(e => e.KorisnikUlogaId).HasName("PK__Korisnik__1608726E523E7C40");

            entity.ToTable("KorisnikUloga");

            entity.Property(e => e.DatumIzmjene).HasColumnType("datetime");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikUlogas)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Korisnik_KorisniciUloga");

            entity.HasOne(d => d.Uloga).WithMany(p => p.KorisnikUlogas)
                .HasForeignKey(d => d.UlogaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Uloga_KorisniciUloga");
        });

        modelBuilder.Entity<Narudzba>(entity =>
        {
            entity.HasKey(e => e.NarudzbaId).HasName("PK__Narudzba__FBEC1377EFA0DB96");

            entity.ToTable("Narudzba");

            entity.Property(e => e.DatumNarudzbe).HasColumnType("datetime");
            entity.Property(e => e.IznosNarudzbe).HasColumnType("decimal(10, 2)");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Narudzbas)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Korisnik_Narudzba");

            entity.HasOne(d => d.Placanje).WithMany(p => p.Narudzbas)
                .HasForeignKey(d => d.PlacanjeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Placanje_Narudzba");

            entity.HasOne(d => d.Proizvod).WithMany(p => p.Narudzbas)
                .HasForeignKey(d => d.ProizvodId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Proizvod_Narudzba");
        });

        modelBuilder.Entity<Novosti>(entity =>
        {
            entity.HasKey(e => e.NovostiId).HasName("PK__Novosti__451A108B7338A4FF");

            entity.ToTable("Novosti");

            entity.Property(e => e.DatumObjave).HasColumnType("datetime");
            entity.Property(e => e.Naziv).HasMaxLength(200);
            entity.Property(e => e.OpisNovisti).HasMaxLength(255);

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Novostis)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Korisnik_Novosti");
        });

        modelBuilder.Entity<Placanje>(entity =>
        {
            entity.HasKey(e => e.PlacanjeId).HasName("PK__Placanje__DDE16DECD82236A6");

            entity.ToTable("Placanje");

            entity.Property(e => e.NacinPlacanja).HasMaxLength(100);
        });

        modelBuilder.Entity<Proizvod>(entity =>
        {
            entity.HasKey(e => e.ProizvodId).HasName("PK__Proizvod__21A8BFF863D092F1");

            entity.ToTable("Proizvod");

            entity.Property(e => e.Cijena).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.NazivProizvoda).HasMaxLength(200);
        });

        modelBuilder.Entity<RadnoVrijeme>(entity =>
        {
            entity.HasKey(e => e.RadnoVrijemeId).HasName("PK__RadnoVri__715793313FEB1A8E");

            entity.ToTable("RadnoVrijeme");

            entity.Property(e => e.KolektivniOdmor).HasMaxLength(255);
            entity.Property(e => e.NeradniDani).HasMaxLength(100);
            entity.Property(e => e.RadnoVrijemeDo).HasColumnType("datetime");
            entity.Property(e => e.RadnoVrijemeOd).HasColumnType("datetime");
        });

        modelBuilder.Entity<Recenzije>(entity =>
        {
            entity.HasKey(e => e.RecenzijeId).HasName("PK__Recenzij__C077A33644BE8AAA");

            entity.ToTable("Recenzije");

            entity.Property(e => e.OpisRecenzije).HasMaxLength(255);

            entity.HasOne(d => d.Klijent).WithMany(p => p.Recenzijes)
                .HasForeignKey(d => d.KlijentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Klijent_Recenzije");

            entity.HasOne(d => d.Usluga).WithMany(p => p.Recenzijes)
                .HasForeignKey(d => d.UslugaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Usluga_Recenzije");

            entity.HasOne(d => d.Zaposleni).WithMany(p => p.Recenzijes)
                .HasForeignKey(d => d.ZaposleniId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Zaposleni_Recenzije");
        });

        modelBuilder.Entity<SalonLjepote>(entity =>
        {
            entity.HasKey(e => e.SalonLjepoteId).HasName("PK__SalonLje__E16A2127A1A571C5");

            entity.ToTable("SalonLjepote");

            entity.Property(e => e.Adresa).HasMaxLength(200);
            entity.Property(e => e.Email).HasMaxLength(100);
            entity.Property(e => e.NazivSalona).HasMaxLength(255);
            entity.Property(e => e.Telefon).HasMaxLength(100);

            entity.HasOne(d => d.Administrator).WithMany(p => p.SalonLjepotes)
                .HasForeignKey(d => d.AdministratorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Administrator_SalonLjepote");

            entity.HasOne(d => d.RadnoVrijeme).WithMany(p => p.SalonLjepotes)
                .HasForeignKey(d => d.RadnoVrijemeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RadnoVrijeme_SalonLjepote");
        });

        modelBuilder.Entity<Termini>(entity =>
        {
            entity.HasKey(e => e.TerminId).HasName("PK__Termini__42126C9559EA80B6");

            entity.ToTable("Termini");

            entity.Property(e => e.DatumTermina).HasColumnType("datetime");

            entity.HasOne(d => d.Klijent).WithMany(p => p.Terminis)
                .HasForeignKey(d => d.KlijentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Klijent_Termini");

            entity.HasOne(d => d.Usluga).WithMany(p => p.Terminis)
                .HasForeignKey(d => d.UslugaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Usluga_Termini");

            entity.HasOne(d => d.Zaposleni).WithMany(p => p.Terminis)
                .HasForeignKey(d => d.ZaposleniId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Zaposleni_Termini");
        });

        modelBuilder.Entity<Uloga>(entity =>
        {
            entity.ToTable("Uloga");

            entity.Property(e => e.NazivUloge).HasMaxLength(100);
        });

        modelBuilder.Entity<Usluga>(entity =>
        {
            entity.HasKey(e => e.UslugaId).HasName("PK__Usluga__0BE5E72F452B3D17");

            entity.ToTable("Usluga");

            entity.Property(e => e.Cijena).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.NazivUsluge).HasMaxLength(100);
        });

        modelBuilder.Entity<Zaposleni>(entity =>
        {
            entity.HasKey(e => e.ZaposleniId).HasName("PK__Zaposlen__8D3A91B7793939DB");

            entity.ToTable("Zaposleni");

            entity.Property(e => e.DatumZaposlenja).HasColumnType("datetime");
            entity.Property(e => e.Zanimanje).HasMaxLength(100);

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Zaposlenis)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Korisnik_Zaposleni");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
