using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SpaceEnginners.Model.SpaceShips
{
    public class SpaceShipType
    {
        [Key]
        public int SpaceShipTypeId { get; set; }

        public required string SpaceShipTypeName { get; set; }

        public required string SpaceShipTypeDescription { get; set; }
        
        
    }
}