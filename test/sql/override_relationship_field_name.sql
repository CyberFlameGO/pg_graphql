begin;

    create table account(
        id serial primary key
    );

    create table blog(
        id serial primary key,
        owner_id integer not null references account(id)
    );

    comment on constraint blog_owner_id_fkey
    on blog
    is E'@graphql({"foreign_name": "author", "local_name": "blogz"})';

    -- expect: 'author'
    select
        name
    from
        graphql.field
    where
        parent_type = 'Blog'
        and foreign_columns is not null;

    -- expect: 'blogz'
    select
        name
    from
        graphql.field
    where
        parent_type = 'Account'
        and foreign_columns is not null;

rollback;
