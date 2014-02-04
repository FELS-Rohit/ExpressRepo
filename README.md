Express Repo
===========

Super simple C# repository pattern with async and generics support for Entity Framework.

##Installation

install-package ExpressRepo

NuGet will install a collection of files to suppport Entity Framework SQL access using a standard repository pattern.  The repository has full support for generic types as well as async support.

## Usage

1.  Create your model with POCO classes.
2.  Create your repositories for your model types.
3.  Done!


```
public class MyEntity{
    [Key] public int Id{get;set;}
    public string SomeValue{get;set;}
}

public class MyEntityRepo : Repository<MyEntity>{
    public MyEntityRepo(IDataContext context) : base(context){}
    
    public MyEntity FindBySomeValue(string someValue){
        return FirstOrDefault(entity => entity.SomeValue == someValue);
    }
}

```
