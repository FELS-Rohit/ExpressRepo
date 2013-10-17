using System.Data.Entity;
using $rootnamespace$.Models;

namespace $rootnamespace$.Data
{
	/// This class can be deleted if you already have a database context.  This is for example
	/// purposes, but it perfectly usable as your actual data context.
	/// Note, you should at least change "DataContext" to a name that matches your domain.
    public partial class DataContext : DbContext
    {
		// Example of a table in the form of a data set
        //public DbSet<User> Users { get; set; }
        
        //protected override void OnModelCreating(DbModelBuilder modelBuilder)
        //{
        //    // Your custom model configurations go here.
        //    base.OnModelCreating(modelBuilder);
        //}
    }
}