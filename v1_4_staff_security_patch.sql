-- Noshville POS V1.4 staff security patch
-- New self-signups are created inactive. Manager-created users are activated by the secure Edge Function.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles(id, full_name, role, is_active)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name',''), 'salesperson', false)
  on conflict (id) do nothing;
  return new;
end;
$$;
