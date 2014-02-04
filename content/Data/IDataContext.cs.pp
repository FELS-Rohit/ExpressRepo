using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Threading;
using System.Threading.Tasks;

namespace $rootnamespace$.Data
{
    public interface IDataContext : IDisposable
    {
        IDbSet<T> GetDbSet<T>() where T : class;
        DbEntityEntry<T> GetEntry<T>(T entity) where T : class;
        int SaveChanges();
        Task<int> SaveChangesAsync();
        Task<int> SaveChangesAsync(CancellationToken cancellationToken);
		void Rollback();
    }
}
