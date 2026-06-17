-- O Ponto da Locação
-- Execute este arquivo uma vez no Supabase: SQL Editor > New query > Run.

create table if not exists public.locacao_app_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.locacao_app_state enable row level security;

drop policy if exists "locacao_app_state_select_own" on public.locacao_app_state;
drop policy if exists "locacao_app_state_insert_own" on public.locacao_app_state;
drop policy if exists "locacao_app_state_update_own" on public.locacao_app_state;
drop policy if exists "locacao_app_state_delete_own" on public.locacao_app_state;

create policy "locacao_app_state_select_own"
on public.locacao_app_state
for select
to authenticated
using (auth.uid() = user_id);

create policy "locacao_app_state_insert_own"
on public.locacao_app_state
for insert
to authenticated
with check (auth.uid() = user_id);

create policy "locacao_app_state_update_own"
on public.locacao_app_state
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create policy "locacao_app_state_delete_own"
on public.locacao_app_state
for delete
to authenticated
using (auth.uid() = user_id);

create or replace function public.touch_locacao_app_state_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists touch_locacao_app_state_updated_at on public.locacao_app_state;

create trigger touch_locacao_app_state_updated_at
before update on public.locacao_app_state
for each row
execute function public.touch_locacao_app_state_updated_at();
