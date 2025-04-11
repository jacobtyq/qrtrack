create table
    user_qr_codes (
        id uuid default uuid_generate_v4 () primary key,
        user_id uuid references auth.users (id) on delete cascade,
        data text not null, -- encoded QR data
        qr_image_url text, -- optional, URL to qr code stored in storage
        created_at timestamp
        with
            time zone default now (),
            updated_at timestamp
        with
            time zone default now (),
            deleted_at timestamp
        with
            time zone
    );

-- Set up Row Level Security (RLS)
alter table user_qr_codes enable row level security;

create policy "Users can view their own QR codes" on user_qr_codes for
select
    using (
        user_id = auth.uid ()
        and deleted_at is null
    );

create policy "Users can insert their own qr codes." on user_qr_codes for insert
with
    check (
        (
            select
                auth.uid ()
        ) = id
    );

create policy "Users can update their own qr codes." on user_qr_codes for
update using (
    (
        select
            auth.uid ()
    ) = id
);

-- This trigger automatically updates the `update_atd` column whenever a row changes
create or replace function public.update_updated_at_column()
returns trigger as $$
begin
  NEW.updated_at = now();
  return NEW;
end;
$$ language plpgsql;