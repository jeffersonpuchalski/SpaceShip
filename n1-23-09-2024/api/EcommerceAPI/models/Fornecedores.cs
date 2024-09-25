using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class Fornecedores
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int FornecedorID { get; private set; }

    required public string Nome { get; set; }
    required public string Contato { get; set; }    
}
// }
// {
//     [Key]
//     [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//     public int ProdutoID { get; private set; }

//     [ForeignKey("FornecedorID")]
//     required public int FornecedorID { get; set; }

//     required public string Nome { get; set; }
//     required public decimal Preco { get; set; }
//     required public int Estoque { get; set; }
// }