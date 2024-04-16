using SpaceEnginners.Model.SpaceShips;

interface IShipRepository
{
    public Task Save(SpaceShips ship);

    public Task<List<SpaceShips>> GetAll();

    public Task<SpaceShips?> GetById(int id);

    public Task Delete(SpaceShips ship);

    public Task Update(SpaceShips ship);
    
}