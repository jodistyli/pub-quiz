-- Pub-Quiz: Datenbank und Sicherheitsregeln für Supabase
-- Erstellt aus pub_quiz_antworten_und_punkte.xlsx
-- Diese Datei vollständig im Supabase SQL Editor ausführen.

create extension if not exists pgcrypto;

create table if not exists public.quiz_questions (
  id bigint generated always as identity primary key,
  round_name text not null,
  question_number integer not null check (question_number between 1 and 10),
  correct_answer text not null check (correct_answer in ('A','B','C','D')),
  points integer not null check (points > 0),
  unique (round_name, question_number)
);

insert into public.quiz_questions (round_name, question_number, correct_answer, points)
values
('Runde 1 – Esport', 1, 'A', 1),
('Runde 1 – Esport', 2, 'D', 1),
('Runde 1 – Esport', 3, 'A', 2),
('Runde 1 – Esport', 4, 'B', 1),
('Runde 1 – Esport', 5, 'B', 2),
('Runde 1 – Esport', 6, 'C', 1),
('Runde 1 – Esport', 7, 'B', 1),
('Runde 1 – Esport', 8, 'C', 1),
('Runde 1 – Esport', 9, 'A', 1),
('Runde 1 – Esport', 10, 'A', 1),
('Runde 2 – Erdkunde', 1, 'B', 1),
('Runde 2 – Erdkunde', 2, 'B', 1),
('Runde 2 – Erdkunde', 3, 'B', 1),
('Runde 2 – Erdkunde', 4, 'B', 2),
('Runde 2 – Erdkunde', 5, 'A', 2),
('Runde 2 – Erdkunde', 6, 'A', 1),
('Runde 2 – Erdkunde', 7, 'B', 1),
('Runde 2 – Erdkunde', 8, 'C', 1),
('Runde 2 – Erdkunde', 9, 'B', 1),
('Runde 2 – Erdkunde', 10, 'B', 1),
('Runde 3 – Rechtschreibung', 1, 'C', 1),
('Runde 3 – Rechtschreibung', 2, 'B', 1),
('Runde 3 – Rechtschreibung', 3, 'A', 1),
('Runde 3 – Rechtschreibung', 4, 'A', 2),
('Runde 3 – Rechtschreibung', 5, 'A', 2),
('Runde 3 – Rechtschreibung', 6, 'A', 1),
('Runde 3 – Rechtschreibung', 7, 'A', 1),
('Runde 3 – Rechtschreibung', 8, 'A', 1),
('Runde 3 – Rechtschreibung', 9, 'A', 1),
('Runde 3 – Rechtschreibung', 10, 'B', 1),
('Runde 4 – Logikrätsel', 1, 'C', 1),
('Runde 4 – Logikrätsel', 2, 'C', 1),
('Runde 4 – Logikrätsel', 3, 'C', 1),
('Runde 4 – Logikrätsel', 4, 'C', 2),
('Runde 4 – Logikrätsel', 5, 'B', 2),
('Runde 4 – Logikrätsel', 6, 'C', 1),
('Runde 4 – Logikrätsel', 7, 'C', 1),
('Runde 4 – Logikrätsel', 8, 'A', 1),
('Runde 4 – Logikrätsel', 9, 'C', 1),
('Runde 4 – Logikrätsel', 10, 'B', 1),
('Runde 5 – Sport', 1, 'B', 1),
('Runde 5 – Sport', 2, 'B', 1),
('Runde 5 – Sport', 3, 'C', 1),
('Runde 5 – Sport', 4, 'C', 1),
('Runde 5 – Sport', 5, 'A', 2),
('Runde 5 – Sport', 6, 'B', 2),
('Runde 5 – Sport', 7, 'B', 1),
('Runde 5 – Sport', 8, 'C', 1),
('Runde 5 – Sport', 9, 'A', 1),
('Runde 5 – Sport', 10, 'C', 1),
('Runde 6 – Film & Serien', 1, 'D', 2),
('Runde 6 – Film & Serien', 2, 'B', 1),
('Runde 6 – Film & Serien', 3, 'B', 1),
('Runde 6 – Film & Serien', 4, 'B', 2),
('Runde 6 – Film & Serien', 5, 'B', 1),
('Runde 6 – Film & Serien', 6, 'A', 1),
('Runde 6 – Film & Serien', 7, 'B', 1),
('Runde 6 – Film & Serien', 8, 'C', 1),
('Runde 6 – Film & Serien', 9, 'A', 1),
('Runde 6 – Film & Serien', 10, 'C', 1),
('Runde 7 – Deutschland', 1, 'C', 1),
('Runde 7 – Deutschland', 2, 'D', 1),
('Runde 7 – Deutschland', 3, 'D', 1),
('Runde 7 – Deutschland', 4, 'C', 2),
('Runde 7 – Deutschland', 5, 'B', 1),
('Runde 7 – Deutschland', 6, 'B', 1),
('Runde 7 – Deutschland', 7, 'B', 2),
('Runde 7 – Deutschland', 8, 'D', 1),
('Runde 7 – Deutschland', 9, 'A', 1),
('Runde 7 – Deutschland', 10, 'D', 1),
('Runde 8 – Natur & Tiere', 1, 'A', 1),
('Runde 8 – Natur & Tiere', 2, 'B', 1),
('Runde 8 – Natur & Tiere', 3, 'C', 1),
('Runde 8 – Natur & Tiere', 4, 'D', 2),
('Runde 8 – Natur & Tiere', 5, 'A', 2),
('Runde 8 – Natur & Tiere', 6, 'B', 1),
('Runde 8 – Natur & Tiere', 7, 'C', 1),
('Runde 8 – Natur & Tiere', 8, 'D', 1),
('Runde 8 – Natur & Tiere', 9, 'A', 1),
('Runde 8 – Natur & Tiere', 10, 'B', 1),
('Runde 9 – Musiktexte', 1, 'B', 2),
('Runde 9 – Musiktexte', 2, 'B', 1),
('Runde 9 – Musiktexte', 3, 'C', 1),
('Runde 9 – Musiktexte', 4, 'C', 1),
('Runde 9 – Musiktexte', 5, 'B', 1),
('Runde 9 – Musiktexte', 6, 'B', 1),
('Runde 9 – Musiktexte', 7, 'A', 1),
('Runde 9 – Musiktexte', 8, 'A', 2),
('Runde 9 – Musiktexte', 9, 'A', 1),
('Runde 9 – Musiktexte', 10, 'A', 1)
on conflict (round_name, question_number) do update
set correct_answer = excluded.correct_answer, points = excluded.points;

-- Nur eine Zeile: Die Quizleitung setzt hier die Frage, die gerade läuft.
create table if not exists public.quiz_state (
  id boolean primary key default true check (id),
  active_round text not null,
  active_question integer not null check (active_question between 1 and 10),
  updated_at timestamptz not null default now()
);
insert into public.quiz_state (id, active_round, active_question)
values (true, 'Runde 1 – Esport', 1)
on conflict (id) do nothing;

-- Bis zu zehn Teams. Den Link-Code nach dem Anlegen kopieren.
create table if not exists public.teams (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  access_token uuid not null unique default gen_random_uuid(),
  created_at timestamptz not null default now()
);

create table if not exists public.team_answers (
  team_id uuid not null references public.teams(id) on delete cascade,
  question_id bigint not null references public.quiz_questions(id) on delete cascade,
  answer text not null check (answer in ('A','B','C','D')),
  updated_at timestamptz not null default now(),
  primary key (team_id, question_id)
);

alter table public.quiz_questions enable row level security;
alter table public.quiz_state enable row level security;
alter table public.teams enable row level security;
alter table public.team_answers enable row level security;

-- Öffentliche Daten enthalten absichtlich NIE Lösungen oder Punkte.
create or replace function public.get_current_question()
returns table (round_name text, question_number integer)
language sql security definer set search_path = public as $$
  select active_round, active_question from quiz_state where id = true;
$$;

grant execute on function public.get_current_question() to anon, authenticated;

-- Antwort mit individuellem Team-Link speichern/überschreiben.
-- Es wird nur die aktuell aktive Frage akzeptiert.
create or replace function public.submit_current_answer(p_token uuid, p_answer text)
returns void
language plpgsql security definer set search_path = public as $$
declare v_team uuid; v_question bigint;
begin
  if p_answer not in ('A','B','C','D') then raise exception 'Ungültige Antwort'; end if;
  select id into v_team from teams where access_token = p_token;
  if v_team is null then raise exception 'Ungültiger Team-Link'; end if;
  select q.id into v_question
  from quiz_state s join quiz_questions q
    on q.round_name = s.active_round and q.question_number = s.active_question
  where s.id = true;
  if v_question is null then raise exception 'Keine aktive Frage'; end if;
  insert into team_answers(team_id, question_id, answer, updated_at)
  values (v_team, v_question, p_answer, now())
  on conflict (team_id, question_id) do update
    set answer = excluded.answer, updated_at = now();
end;
$$;
grant execute on function public.submit_current_answer(uuid, text) to anon, authenticated;

-- Für die geschützte Quizleitungsansicht: Supabase Auth-Nutzer mit Admin-Rolle.
create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade
);
alter table public.admin_users enable row level security;

create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from admin_users where user_id = auth.uid());
$$;

create policy "Admins manage questions" on public.quiz_questions for all using (is_admin()) with check (is_admin());
create policy "Admins manage state" on public.quiz_state for all using (is_admin()) with check (is_admin());
create policy "Admins manage teams" on public.teams for all using (is_admin()) with check (is_admin());
create policy "Admins read answers" on public.team_answers for select using (is_admin());

-- Ergebnisübersicht für die angemeldete Quizleitung, inklusive Punkte.
create or replace function public.admin_results()
returns table (round_name text, question_number integer, team_name text, answer text, correct_answer text, points_earned integer, updated_at timestamptz)
language sql security definer set search_path = public as $$
  select q.round_name, q.question_number, t.name, a.answer, q.correct_answer,
         case when a.answer = q.correct_answer then q.points else 0 end, a.updated_at
  from team_answers a join teams t on t.id=a.team_id join quiz_questions q on q.id=a.question_id
  where is_admin()
  order by q.round_name, q.question_number, t.name;
$$;
grant execute on function public.admin_results() to authenticated;

-- Nach dem Anlegen eines Supabase-Auth-Nutzers dessen UUID einsetzen:
-- insert into public.admin_users(user_id) values ('DEINE-AUTH-UUID');
-- Teams (max. 10) anlegen und jeweils den Link weitergeben:
-- insert into public.teams(name) values ('Team Rot'), ('Team Blau');
-- select name, 'https://DEINE-DOMAIN/?team=' || access_token as team_link from public.teams;
