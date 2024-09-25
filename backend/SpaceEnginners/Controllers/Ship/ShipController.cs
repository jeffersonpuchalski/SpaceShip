using System.Data.Common;
using System.Globalization;
using CsvHelper;
using Microsoft.EntityFrameworkCore;
using SpaceEnginners.Model.SpaceShips;

namespace SpaceEnginners.Repository
{
    public class ShipRepository : IShipRepository
    {
        private readonly ILogger<ShipRepository> _logger;
        private readonly NasaDbContext _context;
        private DbSet<SpaceShips> _spaceShips;
        public ShipRepository(ILogger<ShipRepository> logger, NasaDbContext nasaDbContext)
        {
            _logger = logger;
            _context = nasaDbContext;
            _spaceShips = nasaDbContext.SpaceShips;
        }
        
        private async Task Persist()
        {
            try
            {
                await _context.SaveChangesAsync();
                _logger.LogInformation("[SpaceShipRepository] SpaceShip state persisted to database");
            }
            catch (DbException)
            {
                _logger.LogInformation("[SpaceShipRepository] An error ocurred when trying to persist SpaceShip into database");
                throw;
            }
        }

        public async Task<List<SpaceShips>> GetAll()
        {
            var item = (from _spaceShips in _context.SpaceShips
                        join _spaceShipTypes in _context.SpaceShipTypes on _spaceShips.SpaceShipTypeId equals _spaceShipTypes.SpaceShipTypeId
                        select new SpaceShips
                        {
                            SpaceShipName = _spaceShips.SpaceShipName,
                            SpaceShipModel = _spaceShips.SpaceShipModel,
                            SpaceShipYear = _spaceShips.SpaceShipYear,
                            SpaceShipTypes = new SpaceShipType
                            {
                                SpaceShipTypeName = _spaceShipTypes.SpaceShipTypeName,
                                SpaceShipTypeDescription = _spaceShipTypes.SpaceShipTypeDescription
                            }
                        }).ToList();
            return item;
        }

        public async Task Save(SpaceShips ship)
        {
            await _spaceShips.AddAsync(ship);
            _logger.LogInformation("[SpaceShipsRepository] Store SpaceShip state");
            await Persist();
        }

        public async Task Import(IFormFile file)
        {
            using var reader = new StreamReader(file.OpenReadStream());

            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);
            var records = csv.GetRecordsAsync<SpaceShips>();
            await foreach (var ship in records)
            {
                await _spaceShips.AddAsync(ship);                
            }
            await Persist();
        }



        public async Task Update(SpaceShips ship)
        {
            _spaceShips.Update(ship);
            _logger.LogInformation("[SpaceShipsRepository] Updating ship state and persist to database");
            await Persist();
        }

        public async Task<SpaceShips?> GetById(int id)
        {
            return await _spaceShips.FirstOrDefaultAsync(ship => ship.SpaceShipId == id);
        }

        public async Task Delete(SpaceShips ship)
        {
            _spaceShips.Remove(ship);
            _logger.LogInformation("[SpaceShipsRepository] Deleting ship state and persist to database");
            await _context.SaveChangesAsync();
        }
    }
}

namespace SpaceEnginners.Controllers
{
    using Microsoft.AspNetCore.Mvc;
    using Repository;
    using Utils;

    [ApiController]
    [Route("[controller]")]
    public class ShipController(ILogger<ShipController> logger, ShipRepository shipRepository) : ControllerBase
    {
        private readonly ILogger<ShipController> _logger = logger;
        private readonly ShipRepository _shipRepository = shipRepository;

        

        [HttpGet(Name = "GetShip")]
        public async Task<ActionResult<List<SpaceShips>>> Get()
        {
            var ship = await _shipRepository.GetAll();
            if (ship == null) {
                return NotFound();
            }
            return ship;
        }

        [HttpPost(Name = "SaveShip")]
        [Consumes("application/json")]
        public async Task<IActionResult> Save(SpaceShips ship)
        {
            await _shipRepository.Save(ship);
            return Ok();
        }

        [HttpPut("{id}", Name = "UpdateShip")]
        [Consumes("application/json")]
        public async Task<IActionResult> Update(int id, SpaceShips ship)
        {
            if (id != ship.SpaceShipId) {
                return BadRequest();
            }
            try {
                await _shipRepository.Update(ship);
            } catch (DbUpdateConcurrencyException) {
                throw;
            }
            return NoContent();
        }

        [HttpDelete("{id}", Name = "DeleteShip")]
        public async Task<IActionResult> Delete(int id)
        {
            var ship = await _shipRepository.GetById(id);
            if (ship == null) {
                return NotFound();
            }
            await _shipRepository.Delete(ship);
            return NoContent();
        }

        [HttpPut("import/", Name ="ImportShip")]        
        public async Task<IActionResult> Import([FromForm] IFormFileCollection file)
        {
            // load cvs and import ships            
            try { 
                await _shipRepository.Import(file[0]);
                return Ok();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return BadRequest();
            }


        }
    }
}

namespace Utils { 
    // CSVReader
    public class CSVReader
    {
        
        public static IAsyncEnumerable<SpaceShips> ReadCSV(IFormFile file)
        {
            using var reader = new StreamReader(file.OpenReadStream());

            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);
            var records = csv.GetRecordsAsync<SpaceShips>();
            return records;
        }

        public static void WriteCSV(List<SpaceShips> ships)
        {
            using var writer = new StreamWriter("ships.csv");
            using var csv = new CsvWriter(writer, CultureInfo.InvariantCulture);
            csv.WriteRecords(ships);
        }
        
    }
}