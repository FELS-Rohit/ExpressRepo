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
    public class Repository
    {
        public Repository(IDataContext context)
        {
            Context = context;
        }

        protected IDataContext Context { get; set; }

        protected IQueryable<T> All<T>() where T : Entity
        {
            return Context.All<T>();
        }

        protected IQueryable<T> AllIncluding<T>(params Expression<Func<T, object>>[] includeProperties) where T : Entity
        {
            var query = Context.All<T>();

            return includeProperties.Aggregate(query, (current, includeProperty) => current.Include(includeProperty));
        }

        protected T FirstOrDefault<T>() where T : Entity
        {
            return All<T>().FirstOrDefault();
        }

        protected T FirstOrDefault<T>(Expression<Func<T, bool>> predicate) where T : Entity
        {
            return All<T>().FirstOrDefault(predicate);
        }

        protected Task<T> FirstOrDefaultAsync<T>() where T : Entity
        {
            return All<T>().FirstAsync();
        }

        protected Task<T> FirstOrDefaultAsync<T>(CancellationToken cancellationToken) where T : Entity
        {
            return All<T>().FirstAsync(cancellationToken);
        }

        protected Task<T> FirstOrDefaultAsync<T>(Expression<Func<T, bool>> predicate) where T : Entity
        {
            return All<T>().FirstAsync(predicate);
        }

        protected Task<T> FirstOrDefaultAsync<T>(Expression<Func<T, bool>> predicate, CancellationToken cancellationToken) where T : Entity
        {
            return All<T>().FirstAsync(predicate, cancellationToken);
        }

        protected T FindById<T>(int id) where T : Entity
        {
            return Where<T>(e => e.Id == id).FirstOrDefault();
        }

        protected void Add<T>(T entity) where T : Entity
        {
            Context.Add(entity);
        }

        protected void Delete<T>(T entity) where T : Entity
        {
            Context.Remove(entity);
        }

        protected void Delete<T>(Expression<Func<T, bool>> criteria) where T : Entity
        {
            var entities = Where(criteria).ToList();

            foreach (var entity in entities)
            {
                Delete(entity);
            }
        }

        protected void Delete<T>(IEnumerable<T> entities) where T : Entity
        {
            foreach (var entity in entities.ToList())
            {
                Delete(entity);
            }
        }

        protected IQueryable<T> Where<T>(Expression<Func<T, bool>> criteria) where T : Entity
        {
            return All<T>().Where(criteria);
        }

        protected int Count<T>() where T : Entity
        {
            return All<T>().Count();
        }

        protected int Count<T>(Expression<Func<T, bool>> criteria) where T : Entity
        {
            return Where(criteria).Count();
        }

        protected Task<int> CountAsync<T>() where T : Entity
        {
            return All<T>().CountAsync();
        }

        protected Task<int> CountAsync<T>(CancellationToken cancellationToken) where T : Entity
        {
            return All<T>().CountAsync(cancellationToken);
        }

        protected Task<int> CountAsync<T>(Expression<Func<T, bool>> predicate) where T : Entity
        {
            return All<T>().CountAsync(predicate);
        }

        protected Task<int> CountAsync<T>(Expression<Func<T, bool>> predicate, CancellationToken cancellationToken) where T : Entity
        {
            return All<T>().CountAsync(predicate, cancellationToken);
        }

        public int SaveChanges()
        {
            return Context.SaveChanges();
        }

        public async Task<int> SaveChangesAsync()
        {
            return await Context.SaveChangesAsync();
        } 

        public async Task<int> SaveChangesAsync(CancellationToken cancellationToken)
        {
            return await Context.SaveChangesAsync(cancellationToken);
        } 

        public void Dispose()
        {
            if (Context == null)
            {
                return;
            }

            Context.Dispose();
            Context = null;
        }
    }
}
