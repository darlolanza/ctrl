-- 1. Tablas principales
create table if not exists transactions (
    id bigint primary key,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    type text,          -- 'income' or 'expense'
    amount numeric,
    category text,
    description text,
    user_name text,     -- Mapped from 'user' in JS
    date date,
    month_key text,
    method text,
    card_id bigint,     -- Can be null
    card_name text,
    installments int,
    interest numeric,
    discount numeric,
    is_installment boolean,
    original_amount numeric
);

create table if not exists fixed_expenses (
    id bigint primary key,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    name text,
    projected numeric,
    real numeric,
    paid boolean,
    month_key text,
    end_month text
);

create table if not exists credit_cards (
    id bigint primary key,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    name text,
    bank text,
    closing_day int,
    due_day int,
    color text
);

create table if not exists savings_goals (
    id bigint primary key,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    name text,
    target numeric,
    current numeric,
    currency text
);

create table if not exists app_settings (
    key text primary key,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    value jsonb
);

-- 2. Habilitar RLS (Seguridad)
alter table transactions enable row level security;
alter table fixed_expenses enable row level security;
alter table credit_cards enable row level security;
alter table savings_goals enable row level security;
alter table app_settings enable row level security;

-- 3. Políticas de Acceso (Permitir todo para empezar)
-- IMPORTANTE: Esto hace que cualquiera con tu clave API pueda leer/escribir.
-- Para un proyecto personal está bien, pero para producción necesitarías Auth.

create policy "Enable all access for all users" on transactions for all using (true) with check (true);
create policy "Enable all access for all users" on fixed_expenses for all using (true) with check (true);
create policy "Enable all access for all users" on credit_cards for all using (true) with check (true);
create policy "Enable all access for all users" on savings_goals for all using (true) with check (true);
create policy "Enable all access for all users" on app_settings for all using (true) with check (true);
