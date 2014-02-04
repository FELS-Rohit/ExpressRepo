using System.Threading;
using System.Threading.Tasks;

namespace $rootnamespace$.Data
{
    public abstract class RepositoryContainerBase : IRepositoryContainerBase
    {
        private readonly IDataContext _dataContext;

        protected RepositoryContainerBase(IDataContext dataContext)
        {
            _dataContext = dataContext;
        }

        public int SaveChanges()
        {
            return _dataContext.SaveChanges();
        }

        public void RollBack()
        {
            _dataContext.Rollback();
        }

        public Task<int> SaveChangesAsync()
        {
            return _dataContext.SaveChangesAsync();
        }

        public Task<int> SaveChangesAsync(CancellationToken cancellationToken)
        {
            return _dataContext.SaveChangesAsync(cancellationToken);            
        }
    }
}
