using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SpaceEnginners.Model.SpaceShips
{
    public class SpaceShips
    {
        [Key,  DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int SpaceShipId { get; set; }
        
        public required string SpaceShipName { get; set; }

        public required string SpaceShipModel { get; set; }
        
        public required string SpaceShipYear { get; set; }

        [ForeignKey("SpaceShipTypeId")]
        public int SpaceShipTypeId { get; set; }

        public virtual SpaceShipType? SpaceShipTypes { get; set; }

    }
}