using Microsoft.EntityFrameworkCore;

public class EcommerceContext : DbContext
{
    public EcommerceContext(DbContextOptions<EcommerceContext> options) : base(options) { }

    public DbSet<Produtos> Produtos { get; set; }

    public DbSet<Fornecedores> Fornecedores { get; set; }
}