CREATE TABLE public.user
(
    id       int PRIMARY KEY,
    identity text,
    email    text
);

select * from public.user;

select replace(identity, 'Antho', 'Anthony') from public.user;

-- pas simple pour l'update
update public.user set identity = replace(identity, 'Antho', 'Anthony')
    where id = 1;



update public.user set identity = replace(identity, 'antho', 'Anth')
    where id = 3;

insert into public.user(id, identity, email) values (1, 'Antho, Cassaigne', 'antho@foo.foo');
insert into public.user(id, identity, email) values (2, 'Jean, Palies', 'jean@foo.foo');
insert into public.user(id, identity, email) values (3, 'anthony, hhhanthokkkk', 'hhh@foo.foo');