using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
[ApiController]
[Route("api/[controller]")]
public class FornecedoresController : ControllerBase
{
    private readonly EcommerceContext _context;

    public FornecedoresController(EcommerceContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<Fornecedores>>> GetFornecedores()
    {
        return await _context.Fornecedores.ToListAsync();
    }

    [HttpPost]
    public async Task<ActionResult<Fornecedores>> PostProduto(Fornecedores fornecedores)
    {
        _context.Fornecedores.Add(fornecedores);
        await _context.SaveChangesAsync();
        return CreatedAtAction(nameof(GetFornecedores), new { id = fornecedores.FornecedorID }, fornecedores);
    }

    [HttpDelete("{id}")]
    public async Task<ActionResult<bool>> DeleteProduto(int id)
    {
        var produto = await _context.Fornecedores.FindAsync(id);
        if (produto == null)
        {
            return NotFound();
        }

        _context.Fornecedores.Remove(produto);
        await _context.SaveChangesAsync();

        return true;
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<Fornecedores>> UpdateFornecedores(int id, Fornecedores produto)
    {        
        _context.Entry(produto).State = EntityState.Modified;

        try
        {
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!FornecedoresExists(id))
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

    private bool FornecedoresExists(int id)
    {
        return _context.Fornecedores.Any(e => e.FornecedorID == id);
    }
}