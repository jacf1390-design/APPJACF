-- Tabla de reconocimientos/stickers
create table if not exists reconocimientos (
  id uuid primary key default gen_random_uuid(),
  alumno_id uuid references alumnos(id) on delete cascade,
  categoria text not null,
  sticker text not null,
  mensaje text,
  maestro_id uuid references usuarios(id),
  escuela_id uuid references escuelas(id),
  created_at timestamptz default now()
);

alter table reconocimientos enable row level security;

do $$
begin
  if not exists (select 1 from pg_policies where tablename='reconocimientos' and policyname='publico') then
    execute 'create policy "publico" on reconocimientos for all using (true) with check (true)';
  end if;
end $$;
