-- Authentication profiles and admin-only management policies.
-- The initial summit co-founder/admin is tied to the confirmed email below.

create table if not exists public.user_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  email text not null,
  role text not null default 'member' check (role in ('member', 'admin')),
  created_at timestamptz not null default now()
);

alter table public.user_profiles enable row level security;

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.user_profiles
    where user_id = auth.uid() and role = 'admin'
  );
$$;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
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
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert or update of email on auth.users
  for each row execute procedure public.handle_new_user();

insert into public.user_profiles (user_id, email, role)
select id, coalesce(email, ''),
  case when lower(coalesce(email, '')) = 'waismahbub71@gmail.com' then 'admin' else 'member' end
from auth.users
on conflict (user_id) do update
  set email = excluded.email,
      role = case when lower(excluded.email) = 'waismahbub71@gmail.com' then 'admin' else public.user_profiles.role end;

drop policy if exists "profiles_self_read" on public.user_profiles;
create policy "profiles_self_read" on public.user_profiles
  for select using (auth.uid() = user_id or public.is_admin());

drop policy if exists "profiles_admin_manage" on public.user_profiles;
create policy "profiles_admin_manage" on public.user_profiles
  for all using (public.is_admin()) with check (public.is_admin());

-- Public programme tables: everyone can read; only the co-founder/admin manages.
do $$
declare table_name text;
begin
  foreach table_name in array array['schedule_sessions','people','digital_fair_exhibitors','tickets'] loop
    execute format('drop policy if exists %I on public.%I', table_name || '_v1_read', table_name);
    execute format('drop policy if exists %I on public.%I', table_name || '_v1_write', table_name);
    execute format('drop policy if exists %I on public.%I', table_name || '_public_read', table_name);
    execute format('drop policy if exists %I on public.%I', table_name || '_admin_manage', table_name);
    execute format('create policy %I on public.%I for select using (true)', table_name || '_public_read', table_name);
    execute format('create policy %I on public.%I for all using (public.is_admin()) with check (public.is_admin())', table_name || '_admin_manage', table_name);
  end loop;
end $$;

-- Registration remains open, but participant data and changes are admin-only.
drop policy if exists "participants_v1_read" on public.participants;
drop policy if exists "participants_v1_write" on public.participants;
drop policy if exists "participants_admin_read" on public.participants;
drop policy if exists "participants_public_register" on public.participants;
drop policy if exists "participants_admin_manage" on public.participants;
drop policy if exists "participants_admin_delete" on public.participants;
create policy "participants_admin_read" on public.participants
  for select using (public.is_admin());
create policy "participants_public_register" on public.participants
  for insert with check (true);
create policy "participants_admin_manage" on public.participants
  for update using (public.is_admin()) with check (public.is_admin());
create policy "participants_admin_delete" on public.participants
  for delete using (public.is_admin());

-- Private organiser tables are visible and writable only to the admin.
do $$
declare table_name text;
begin
  foreach table_name in array array['communications_log','affiliate_referrals'] loop
    execute format('drop policy if exists %I on public.%I', table_name || '_v1_read', table_name);
    execute format('drop policy if exists %I on public.%I', table_name || '_v1_write', table_name);
    execute format('drop policy if exists %I on public.%I', table_name || '_admin_only', table_name);
    execute format('create policy %I on public.%I for all using (public.is_admin()) with check (public.is_admin())', table_name || '_admin_only', table_name);
  end loop;
end $$;

grant select on public.user_profiles to authenticated;
grant execute on function public.is_admin() to anon, authenticated;
