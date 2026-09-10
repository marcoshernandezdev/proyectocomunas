using Microsoft.EntityFrameworkCore;
using ProyectoComunas.Datos.Models;

namespace ProyectoComunas.Datos;

public sealed class ApplicationDbContext
    : DbContext
{
    public ApplicationDbContext(
        DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public DbSet<Region> Regiones => Set<Region>();
    public DbSet<Comuna> Comunas => Set<Comuna>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Region>(entity =>
        {
            entity.ToTable("Region");

            entity.HasKey(x => x.IdRegion);

            entity.Property(x => x.NombreRegion)
                .HasColumnName("NombreRegion")
                .HasMaxLength(128)
                .IsRequired(false);
        });

        modelBuilder.Entity<Comuna>(entity =>
        {
            entity.ToTable("Comuna");

            entity.HasKey(x => x.IdComuna);

            entity.Property(x => x.IdRegion)
                .HasColumnName("IdRegion")
                .IsRequired(false);

            entity.Property(x => x.NombreComuna)
                .HasColumnName("NombreComuna")
                .HasMaxLength(128)
                .IsRequired(false);

            entity.Property(x => x.InformacionAdicional)
                .HasColumnName("InformacionAdicional")
                .HasColumnType("xml")
                .IsRequired(false);

            entity.HasOne<Region>()
                .WithMany()
                .HasForeignKey(x => x.IdRegion)
                .IsRequired(false);
        });
    }
}