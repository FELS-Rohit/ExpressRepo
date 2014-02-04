using System.Threading.Tasks;

namespace $rootnamespace$.Data
{
	public class EntityRepository<T> : Repository<T> where T : class, IEntity
    {
        public EntityRepository(IDataContext context) : base(context)
        {  
        }

        public async Task<T> FindByIdAsync(int id)
        {
            return await FirstOrDefaultAsync(e => e.Id == id);
        }
    }
}