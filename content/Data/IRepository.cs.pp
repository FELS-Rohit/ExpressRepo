using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading;
using System.Threading.Tasks;
using $rootnamespace$.Models;

namespace $rootnamespace$.Data
{
   public interface IRepository : IDisposable
    {
        int SaveChanges();
		Task<int> SaveChangesAsync();
        Task<int> SaveChangesAsync(CancellationToken cancellationToken);
    }

    public interface IRepository<T> : IRepository where T : Entity
    {
        IQueryable<T> All();
        IQueryable<T> AllIncluding(params Expression<Func<T, object>>[] includeProperties);
        Task<T> FirstOrDefaultAsync();
        Task<T> FirstOrDefaultAsync(CancellationToken cancellationToken);
        Task<T> FirstOrDefaultAsync(Expression<Func<T, bool>> predicate);
        Task<T> FirstOrDefaultAsync(Expression<Func<T, bool>> predicate, CancellationToken cancellationToken);
        T FirstOrDefault();
        T FirstOrDefault(Expression<Func<T, bool>> predicate);
        T FindById(int id);
        void Add(T entity);
        void Attach(T entity);
        void Detatch(T entity);
        void Delete(T entity);
        void Delete(Expression<Func<T, bool>> criteria);
        void Delete(IEnumerable<T> entities);
        IQueryable<T> Where(Expression<Func<T, bool>> criteria);
        int Count(Expression<Func<T, bool>> criteria);
        int Count();
        Task<int> CountAsync();
        Task<int> CountAsync(CancellationToken cancellationToken);
        Task<int> CountAsync(Expression<Func<T, bool>> predicate);
        Task<int> CountAsync(Expression<Func<T, bool>> predicate, CancellationToken cancellationToken);
    }
}
