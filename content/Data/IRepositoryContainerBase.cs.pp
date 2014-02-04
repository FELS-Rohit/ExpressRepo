
namespace $rootnamespace$.Data
{
    public interface IRepositoryContainerBase
    {
        int SaveChanges();
        void RollBack();
    }
}
