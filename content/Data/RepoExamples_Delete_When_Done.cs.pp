using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace $rootnamespace$.Data
{
        /// Here's a few simple examples to get you started.  Delete this file when you're done.
    public static class RepoExample
    {
        /// Standard repository examples
        public static int Create()
        {
            // Ideally you will use DI to build this automatically
            // For example, 
            // var kernel = new Ninject.StandardKernel();
            // kernel.Bind<IDataContext>().To<DataContext>();

            // Hard coded DataContext for example purposes.
            var context = new RepoContainer(new DataContext());

            context.BogusObjectRepository.Add(new BogusObject{FirstName = "Jon", LastName = "Doe"});

            return context.SaveChanges();
        }

        public static List<BogusObject> Read()
        {
            var context = new RepoContainer(new DataContext());

            var queryable = context.BogusObjectRepository.Where(s => s.FirstName == "Jon");
            queryable = queryable.Where(s => s.LastName == "Doe");

            return queryable.ToList();
        }

        public static void Update()
        {
            var context = new RepoContainer(new DataContext());

            var entity = context.BogusObjectRepository.FirstOrDefault(so => so.FirstName == "Jon");
            entity.FirstName = "Jonathan";
            context.SaveChanges();
        }

        public static void Delete()
        {
            var context = new RepoContainer(new DataContext());

            context.BogusObjectRepository.Delete(s => s.FirstName == "Jonathan");
            context.SaveChanges();
        }

        /// Async repository examples
        public static async Task<int> CreateAsync()
        {
            var context = new RepoContainer(new DataContext());

            context.BogusObjectRepository.Add(new BogusObject());
            return await context.SaveChangesAsync();
        }

        public static async Task<BogusObject> ReadAsync()
        {
            var context = new RepoContainer(new DataContext());

            return await context.BogusObjectRepository.FirstOrDefaultAsync(s => s.FirstName == "Jon");
        }

        public static async Task<BogusObject> UpdateAsync(string name)
        {
            var context = new RepoContainer(new DataContext());

            var entity = await context.BogusObjectRepository.FirstOrDefaultAsync(s => s.FirstName == name);
            entity.FirstName = "updated";
            await context.SaveChangesAsync();

            return entity;
        }

        public static void DeleteAsync()
        {
            var context = new RepoContainer(new DataContext());

            context.BogusObjectRepository.Delete(s => s.FirstName == "Jonathan");
            context.SaveChangesAsync();
        }
    }

    /// <summary>
    ///  POCO base class with an ID field
    /// </summary>
    public class Entity : IEntity
    {
        [Key]
        public int Id { get; set; }
    }

    /// This is an example Code First database entity.
    public class BogusObject : Entity
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }

    public class OtherObject : Entity
    {
        public string Value { get; set; }
    }

    /// Example repositoy container unit of work
    public class RepoContainer : RepositoryContainerBase
    {
        public RepoContainer(IDataContext dataContext) : base(dataContext)
        {
            BogusObjectRepository = new BogusObjectRepository(dataContext);
        }

        public BogusObjectRepository BogusObjectRepository { get; set; }
    }
    
    /// This is a concrete "bogus object" repository.  Generally you'll have one repo per type.
    public class BogusObjectRepository : Repository<BogusObject>
    {
        public BogusObjectRepository(IDataContext context) : base(context)
        {
        }

        /// Simple to query using built in methods.  Most use IQueryable so you 
        /// can compose complex queries.
        public BogusObject FindByName(string name)
        {
            return FirstOrDefault(s => s.FirstName == name);
        }
    }

    /// This is a repository for entities that implement IEntity and
    /// have an integer ID field.
    public class OtherObjectRepository : EntityRepository<OtherObject>
    {
        public OtherObjectRepository(IDataContext context) : base(context)
        {
        }
    }
}
