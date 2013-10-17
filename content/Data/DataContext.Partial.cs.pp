using System;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using $rootnamespace$.Models;

namespace $rootnamespace$.Data
{
    public partial class DataContext : IDataContext
    {
        #region IDataContext Members

        public IQueryable<T> All<T>() where T : Entity
        {
            return Set<T>().AsQueryable();
        }

        public void Add<T>(T entity) where T : Entity
        {
            Set<T>().Add(entity);
        }

        public void Remove<T>(T entity) where T : Entity
        {
            Set<T>().Remove(entity);
        }

        public void Attach<T>(T entity) where T : Entity
        {
            var entry = Entry(entity);

            if (entry.State != EntityState.Detached)
            {
                return;
            }

            var set = Set<T>();
            var attachedEntity = set.Find(entity.Id);

            if (attachedEntity != null)
            {
                var attached = Entry(attachedEntity);
                attached.CurrentValues.SetValues(entity);
            }
            else
            {
                entry.State = EntityState.Modified;
            }
        }

        public void Detatch<T>(T entity) where T : Entity
        {
            var entry = Entry(entity);
            entry.State = EntityState.Detached;
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

        public IDbConnection CurrentConnection { get { return Database.Connection; }}

        #endregion
    }

    public interface IDataContext : IDisposable
    {
        IQueryable<T> All<T>() where T : Entity;
        void Add<T>(T entity) where T : Entity;
        void Remove<T>(T entity) where T : Entity;
        void Attach<T>(T entity) where T : Entity;
        void Detatch<T>(T entity) where T : Entity;
        int SaveChanges();
        Task<int> SaveChangesAsync();
        Task<int> SaveChangesAsync(CancellationToken cancellationToken);
        IDbConnection CurrentConnection { get; }
    }
}
