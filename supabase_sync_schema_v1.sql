-- The Personal Field Guides cloud sync schema v1.1
create table if not exists public.pfg_specimen_state (
  user_id uuid not null references auth.users(id) on delete cascade,
  profile text not null check (profile in ('personal','will')),
  specimen_id text not null,
  owned boolean not null default false,
  collection_status text not null default 'unmarked'
    check (collection_status in ('unmarked','want_to_smell','sampled','owned','finished')),
  updated_at timestamptz not null default now(),
  primary key (user_id, profile, specimen_id)
);

create table if not exists public.pfg_field_entries (
  user_id uuid not null references auth.users(id) on delete cascade,
  profile text not null check (profile in ('personal','will')),
  specimen_id text not null,
  entry_id uuid not null,
  entry_date date not null default current_date,
  note_text text not null default '',
  fields jsonb not null default '{}'::jsonb,
  ink jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, profile, specimen_id, entry_id)
);

alter table public.pfg_specimen_state enable row level security;
alter table public.pfg_field_entries enable row level security;


-- V0.6 page annotations
create table if not exists public.pfg_page_annotations (
  user_id uuid not null references auth.users(id) on delete cascade,
  profile text not null check (profile in ('personal','will')),
  page_number integer not null check (page_number > 0),
  strokes jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, profile, page_number)
);
alter table public.pfg_page_annotations enable row level security;


-- V0.8 stable content-anchor metadata
alter table public.pfg_page_annotations
  add column if not exists content_anchor text;

create index if not exists pfg_page_annotations_anchor_idx
  on public.pfg_page_annotations(user_id, profile, content_anchor);


-- V0.9 recommendation queues
create table if not exists public.pfg_recommendations (
  user_id uuid not null references auth.users(id) on delete cascade,
  profile text not null check (profile in ('personal','will')),
  recommendation_id uuid not null,
  fragrance_name text not null,
  house text not null default '',
  reason text not null default '',
  source_type text not null default 'reader'
    check (source_type in ('reader','book','shared')),
  linked_specimen_id text,
  state text not null default 'recommended'
    check (state in ('recommended','want_to_smell','sampled','owned','finished','archived')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, profile, recommendation_id)
);
alter table public.pfg_recommendations enable row level security;


-- V1.0 Field Sessions
create table if not exists public.pfg_field_sessions (
  user_id uuid not null references auth.users(id) on delete cascade,
  profile text not null check (profile in ('personal','will')),
  session_id uuid not null,
  title text not null default '',
  session_date date not null default current_date,
  specimen_ids jsonb not null default '[]'::jsonb,
  observations jsonb not null default '{}'::jsonb,
  comparison_note text not null default '',
  ink jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, profile, session_id)
);
alter table public.pfg_field_sessions enable row level security;
