-- =====================================================
-- Innovizta ERP - Initial Schema Migration
-- =====================================================
-- This migration creates the base schema with Row Level Security (RLS).
-- Update this file based on business-logic/*.md files from your team.
-- =====================================================

-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- =====================================================
-- USERS TABLE (extends Supabase auth.users)
-- =====================================================
create table public.profiles (
  id uuid references auth.users(id) on delete cascade primary key,
  email text not null,
  full_name text,
  role text not null check (role in ('partner', 'worker', 'client')),
  avatar_url text,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);

comment on table public.profiles is 'Extended user profiles with role-based access';

-- =====================================================
-- ROW LEVEL SECURITY (RLS)
-- =====================================================
alter table public.profiles enable row level security;

-- Users can read their own profile
create policy "Users can view own profile"
  on public.profiles for select
  using (auth.uid() = id);

-- Users can update their own profile
create policy "Users can update own profile"
  on public.profiles for update
  using (auth.uid() = id);

-- Partners can view all profiles
create policy "Partners can view all profiles"
  on public.profiles for select
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'partner'
    )
  );

-- =====================================================
-- FUNCTION: Handle new user signup
-- =====================================================
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, email, role)
  values (new.id, new.email, 'client'); -- Default role: client
  return new;
end;
$$;

-- Trigger on new user creation
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- =====================================================
-- TODO: Add more tables based on business-logic/*.md files
-- =====================================================
-- Examples to add later:
-- - projects table
-- - resource_requests table
-- - progress_tracking table
-- - notifications table
-- =====================================================
