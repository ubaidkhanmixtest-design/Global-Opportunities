-- Global Opportunities: Supabase database setup
-- Run this in Supabase SQL Editor. Replace ADMIN_EMAIL with your own email.
create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade,
  email text not null unique,
  created_at timestamptz not null default now()
);

create table if not exists public.demands (
  id uuid primary key default gen_random_uuid(),
  country text not null,
  job_title text not null,
  quantity integer not null check (quantity > 0),
  salary text not null,
  contract_period text,
  requirements text,
  description text,
  status text not null default 'draft' check (status in ('draft','published','closed')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create or replace function public.is_go_admin()
returns boolean language sql stable security definer set search_path = public
as $$ select exists (select 1 from public.admin_users where user_id = auth.uid()); $$;

alter table public.admin_users enable row level security;
alter table public.demands enable row level security;

-- Public visitors can only read published demands.
drop policy if exists "Public can read published demands" on public.demands;
create policy "Public can read published demands" on public.demands
for select using (status = 'published');

-- Only the account explicitly listed in admin_users can manage demands.
drop policy if exists "Admins can manage demands" on public.demands;
create policy "Admins can manage demands" on public.demands
for all using (public.is_go_admin()) with check (public.is_go_admin());

-- Admin can read their own admin record; public cannot enumerate admins.
drop policy if exists "Admins can read own admin record" on public.admin_users;
create policy "Admins can read own admin record" on public.admin_users
for select using (user_id = auth.uid());

-- Add a timestamp trigger.
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$ begin new.updated_at = now(); return new; end; $$;
drop trigger if exists demands_updated_at on public.demands;
create trigger demands_updated_at before update on public.demands
for each row execute function public.set_updated_at();

-- After creating your account in Supabase Authentication > Users, run this:
-- insert into public.admin_users (user_id, email)
-- select id, email from auth.users where lower(email) = lower('ADMIN_EMAIL');
