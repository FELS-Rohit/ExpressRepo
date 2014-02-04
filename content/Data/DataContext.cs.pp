using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;


namespace $rootnamespace$.Data
{
	/// This class can be replaced if you already have a database context.  This is for example
	/// purposes, but it perfectly usable as your actual data context.
	/// Note, you should at least change "DataContext" to a name that matches your domain.
    public partial class DataContext : DbContext, IDataContext
    {
		// Example of a table in the form of a data set.  Add your own
        // database/model entities here.
        public DbSet<BogusObject> BogusObjects { get; set; }

        #region IDataContext Members

        public IDbSet<T> GetDbSet<T>() where T : class
        {
            return Set<T>();
        }

        public DbEntityEntry<T> GetEntry<T>(T entity) where T : class
        {
            return Entry(entity);
        }

        public new int SaveChanges()
        {
            return base.SaveChanges();
        }

        public new Task<int> SaveChangesAsync()
        {
            return base.SaveChangesAsync();
        }

        public new Task<int> SaveChangesAsync(CancellationToken cancellationToken)
        {
            return base.SaveChangesAsync(cancellationToken);
        }

	    public void Rollback()
	    {
            ChangeTracker.DetectChanges();

            var entries = ChangeTracker.Entries().Where(e => e.State != EntityState.Unchanged).ToList();

            foreach (var dbEntityEntry in entries)
            {
                var entity = dbEntityEntry.Entity;

                if (entity == null) continue;

                switch (dbEntityEntry.State)
                {
                    case EntityState.Added:
                        {
                        var set = Set(entity.GetType());
                        set.Remove(entity);
                        }
                        break;

                    case EntityState.Modified:
                        Entry(dbEntityEntry.Entity).CurrentValues.SetValues(Entry(dbEntityEntry.Entity).OriginalValues);
                        Entry(dbEntityEntry.Entity).State = EntityState.Unchanged;
                        break;
                    case EntityState.Deleted:
                        Entry(dbEntityEntry).CurrentValues.SetValues(Entry(dbEntityEntry).OriginalValues);
                        dbEntityEntry.State = EntityState.Unchanged;
                        break;
                }
            }
	    }
        #endregion

        //protected override void OnModelCreating(DbModelBuilder modelBuilder)
        //{
        //    // Your custom model configurations go here.
        //    base.OnModelCreating(modelBuilder);
        //}
    }
}