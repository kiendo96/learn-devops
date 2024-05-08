# Get data type of a table
```
select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Products';
```

# Add unique key with a name
```
alter table Categories add  constraint UC_Categories Unique(categoryname);
```
- Categories: name of table
- UC_Categories: name of unique key
- categoryname: name of column

