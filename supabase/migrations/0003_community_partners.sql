-- Reclassify the existing community cohort as summit partners, feature three
-- partner organisations in the Digital Fair, and add future account members
-- to the public community directory automatically.

update public.people
set category = 'partner'
where category = 'community';

update public.people
set category = 'exhibitor'
where lower(name) in ('bibu', 'scalendo', 'steambox');

update public.people
set category = 'partner'
where lower(name) = 'world masterclass';

insert into public.digital_fair_exhibitors (product_name, category, description, exhibitor_contact)
select 'BIBU', 'Digital Fair Partner', 'GOAI Summit digital fair exhibitor.', ''
where not exists (select 1 from public.digital_fair_exhibitors where lower(product_name) = 'bibu');

insert into public.digital_fair_exhibitors (product_name, category, description, exhibitor_contact)
select 'Scalendo', 'Digital Fair Partner', 'GOAI Summit digital fair exhibitor and AI business solutions partner.', 'contact@scalendo.com'
where not exists (select 1 from public.digital_fair_exhibitors where lower(product_name) = 'scalendo');

insert into public.digital_fair_exhibitors (product_name, category, description, exhibitor_contact)
select 'STEAMBOX', 'Digital Fair Partner', 'GOAI Summit digital fair exhibitor.', ''
where not exists (select 1 from public.digital_fair_exhibitors where lower(product_name) = 'steambox');

create unique index if not exists people_user_id_unique
  on public.people (user_id)
  where user_id is not null;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  member_name text;
begin
  insert into public.user_profiles (user_id, email, role)
  values (
    new.id,
    coalesce(new.email, ''),
    case when lower(coalesce(new.email, '')) = 'waismahbub71@gmail.com' then 'admin' else 'member' end
  )
  on conflict (user_id) do update
    set email = excluded.email,
        role = case when lower(excluded.email) = 'waismahbub71@gmail.com' then 'admin' else public.user_profiles.role end;

  if lower(coalesce(new.email, '')) <> 'waismahbub71@gmail.com' then
    member_name := coalesce(
      nullif(trim(new.raw_user_meta_data ->> 'full_name'), ''),
      initcap(regexp_replace(split_part(coalesce(new.email, 'Member'), '@', 1), '[._-]+', ' ', 'g'))
    );

    insert into public.people (name, category, role_title, organisation, bio, user_id)
    values (member_name, 'community', 'Member', 'GOAI Summit Community', 'Registered GOAI Summit Malaysia 2026 community member.', new.id)
    on conflict (user_id) where user_id is not null do update
      set name = excluded.name,
          category = 'community';
  end if;

  return new;
end;
$$;

insert into public.people (name, category, role_title, organisation, bio, user_id)
select
  coalesce(
    nullif(trim(u.raw_user_meta_data ->> 'full_name'), ''),
    initcap(regexp_replace(split_part(coalesce(u.email, 'Member'), '@', 1), '[._-]+', ' ', 'g'))
  ),
  'community',
  'Member',
  'GOAI Summit Community',
  'Registered GOAI Summit Malaysia 2026 community member.',
  u.id
from auth.users u
where lower(coalesce(u.email, '')) <> 'waismahbub71@gmail.com'
on conflict (user_id) where user_id is not null do update
  set name = excluded.name,
      category = 'community';
