using Microsoft.EntityFrameworkCore;
using SpaceEnginners.Model.SpaceShips;

public class NasaDbContext : DbContext { 
    public DbSet<SpaceShips> SpaceShips { get; set; }
    public DbSet<SpaceShipType> SpaceShipTypes { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer("Server=localhost;User=sa;Password=SqlServer2019!;Database=Nasa;trusted_connection=false;Persist Security Info=False;Encrypt=False");
    }
}