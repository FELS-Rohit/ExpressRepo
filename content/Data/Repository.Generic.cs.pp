using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using System.Threading;
using System.Threading.Tasks;
using $rootnamespace$.Models;

namespace $rootnamespace$.Data
{
     public class Repository<T> : Repository where T : Entity
     {
        public Repository(IDataContext context) : base(context)
        {
        }

        public IQueryable<T> All()
        {
            return Context.All<T>();
        }

        public IQueryable<T> AllIncluding(params Expression<Func<T, object>>[] includeProperties)
        {
            var query = Context.All<T>();

            return includeProperties.Aggregate(query, (current, includeProperty) => current.Include(includeProperty));
        }

        public T FirstOrDefault()
        {
            return All<T>().FirstOrDefault();
        }

        public T FirstOrDefault(Expression<Func<T, bool>> predicate)
        {
            return All().FirstOrDefault(predicate);
        }

        public Task<T> FirstOrDefaultAsync()
        {
            return All<T>().FirstAsync();
        }

        public Task<T> FirstOrDefaultAsync(CancellationToken cancellationToken)
        {
            return All<T>().FirstAsync(cancellationToken);
        }

        public Task<T> FirstOrDefaultAsync(Expression<Func<T, bool>> predicate)
        {
            return All<T>().FirstAsync(predicate);
        }

        public Task<T> FirstOrDefaultAsync(Expression<Func<T, bool>> predicate, CancellationToken cancellationToken)
        {
            return All<T>().FirstAsync(predicate, cancellationToken);
        }

        public T FindById(int id)
        {
            return Where<T>(e => e.Id == id).FirstOrDefault();
        }

        public void Attach(T entity)
        {
            Context.Attach(entity);
        }

        public void Detatch(T entity)
        {
            Context.Detatch(entity);
        }

        public void Add(T entity)
        {
            Context.Add(entity);
        }

        public void Delete(T entity)
        {
            Context.Remove(entity);
        }

        public void Delete(Expression<Func<T, bool>> criteria)
        {
            var entities = Where(criteria).ToList();

            foreach (var entity in entities)
            {
                Delete(entity);
            }
        }

        public void Delete(IEnumerable<T> entities)
        {
            foreach (T entity in entities.ToList())
            {
                Delete(entity);
            }
        }

        public IQueryable<T> Where(Expression<Func<T, bool>> criteria)
        {
            return All<T>().Where(criteria);
        }

        public int Count()
        {
            return Count<T>();
        }

        public int Count(Expression<Func<T, bool>> criteria)
        {
            return Count<T>(criteria);
        }

        public Task<int> CountAsync()
        {
            return CountAsync<T>();
        }

        public Task<int> CountAsync(CancellationToken cancellationToken)
        {
            return CountAsync<T>(cancellationToken);
        }

        public Task<int> CountAsync(Expression<Func<T, bool>> criteria)
        {
            return CountAsync<T>(criteria);
        }

        public Task<int> CountAsync(Expression<Func<T, bool>> criteria, CancellationToken cancellationToken)
        {
            return CountAsync<T>(criteria, cancellationToken);
        }
    }
}
