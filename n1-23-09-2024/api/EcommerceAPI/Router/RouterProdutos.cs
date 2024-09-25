using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
[ApiController]
[Route("api/[controller]")]
public class ProdutosController : ControllerBase
{
    private readonly EcommerceContext _context;

    public ProdutosController(EcommerceContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<Produtos>>> GetProdutos()
    {
        return await _context.Produtos.ToListAsync();
    }

    [HttpPost]
    public async Task<ActionResult<Produtos>> PostProduto(Produtos produto)
    {
        _context.Produtos.Add(produto);
        await _context.SaveChangesAsync();
        return CreatedAtAction(nameof(GetProdutos), new { id = produto.ProdutoID }, produto);
    }

    [HttpDelete("{id}")]
    public async Task<ActionResult<bool>> DeleteProduto(int id)
    {
        var produto = await _context.Produtos.FindAsync(id);
        if (produto == null)
        {
            return NotFound();
        }

        _context.Produtos.Remove(produto);
        await _context.SaveChangesAsync();

        return true;
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<Produtos>> UpdateFornecedores(int id, Fornecedores produto)
    {        
        _context.Entry(produto).State = EntityState.Modified;

        try
        {
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!ProdutoExists(id))
            {
                return NotFound();
            }
            else
            {
                throw;
            }
        }

        return NoContent();
    }

    private bool ProdutoExists(int id)
    {
        return _context.Produtos.Any(e => e.ProdutoID == id);
    }
}