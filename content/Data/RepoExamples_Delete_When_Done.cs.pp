using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using $rootnamespace$.Models;

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
            // kernel.Bind<ISomeObjectRepository>().To<SomeObjectRepository>();
            // kernel.Bind<IDataContext>().To<DataContext>();
            
            // Hard coded for example purposes.
            ISomeObjectRepository repo = new SomeObjectRepository(new DataContext());

            repo.Add(new SomeObject());
            return repo.SaveChanges();
        }
        
        public static List<SomeObject> Read()
        {
            ISomeObjectRepository repo = new SomeObjectRepository(new DataContext());
            var queryable = repo.Where(s => s.FirstName == "John");
            queryable = queryable.Where(s => s.LastName == "Doe");

            return queryable.ToList();
        }

        public static void Update()
        {
            ISomeObjectRepository repo = new SomeObjectRepository(new DataContext());
            
            var entity = repo.FindByName("example");
            entity.FirstName = "updated";
            repo.SaveChanges();
        }

        public static void Delete()
        {
            ISomeObjectRepository repo = new SomeObjectRepository(new DataContext());

            repo.Delete(s => s.FirstName == "Bob");
            repo.SaveChanges();
        }

        /// Async repository examples
        public static async Task<int> CreateAsync()
        {
            ISomeObjectRepository repo = new SomeObjectRepository(new DataContext());

            repo.Add(new SomeObject());
            return await repo.SaveChangesAsync();
        }

        public static async Task<SomeObject> ReadAsync()
        {
            ISomeObjectRepository repo = new SomeObjectRepository(new DataContext());
            return await repo.FirstOrDefaultAsync(s => s.FirstName == "Karl");
        }

        public static async Task<SomeObject> UpdateAsync(string name)
        {
            ISomeObjectRepository repo = new SomeObjectRepository(new DataContext());

            var entity = await repo.FirstOrDefaultAsync(s => s.FirstName == name);
            entity.FirstName = "updated";
            await repo.SaveChangesAsync();

            return entity;
        }
        
        public static void DeleteAsync()
        {
            ISomeObjectRepository repo = new SomeObjectRepository(new DataContext());

            repo.Delete(s => s.FirstName == "Bob");
            repo.SaveChangesAsync();
        }
    }

    /// This is an example Code First database entity.  It inherits from
    /// "Entity" (in your Models folder by default) in order to work with 
    /// the generic repository methods.
    public class SomeObject : Entity
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }

        public virtual List<SomeOtherObject> Children { get; set; } 
    }
    
    /// Example for showing complex (join) queries
    public class SomeOtherObject : Entity
    {
        public string Color { get; set; }

        public int SomeObjectId { get; set; }
        public virtual SomeObject Parent { get; set; }
    }
    
    /// This is an object-specific repository interface,  You'll create these for your database types.  
    /// It's used for DI and unit testing purposes.  The concrete implementation is below.
    public interface ISomeObjectRepository : IRepository<SomeObject>
    {
        SomeObject FindByName(string name);
    }
    
    /// This is a concrete repository instance.  Generally you'll have one repo per type.
    /// You can easily query other object types using the generic base methods when 
    /// cross-object queries are necessary.
    public class SomeObjectRepository : Repository<SomeObject>, ISomeObjectRepository
    {
        public SomeObjectRepository(IDataContext context) : base(context)
        {
        }

        /// Simple to query using built in methods.  Most use IQueryable so you 
        /// can compose complex queries.
        public SomeObject FindByName(string name)
        {
            return FirstOrDefault(s => s.FirstName == name);
        }

        /// Querying across objects
        public IQueryable<SomeObject> FindByChildColor(string color)
        {
            // Easy to query other entity types.  You can do joins, grouping, etc...
            // This example is simply showing a one-to-many fluent query.
            var childObjects = Where<SomeOtherObject>(s => s.Color == color);

            return childObjects.Select(c => c.Parent);
        }
    }
}
