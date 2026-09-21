create table if not exists participants (
  id uuid primary key default gen_random_uuid(),
  full_name text,
  email text,
  phone text,
  academy_affiliation text,
  ticket_category text,
  registration_source text default 'goai_form',
  status text default 'registered',
  user_id uuid,
  created_at timestamptz not null default now()
);
alter table participants enable row level security;
drop policy if exists "participants_v1_read" on participants;
create policy "participants_v1_read" on participants for select using (true);
drop policy if exists "participants_v1_write" on participants;
create policy "participants_v1_write" on participants for all using (true) with check (true);

insert into participants (full_name, email, phone, academy_affiliation, ticket_category, status) values
('Md. Zakaria Hossain', 'zakaria@aiacademybd.com', '+8801700000001', 'AI Academy Bangladesh', 'Standard', 'confirmed'),
('Capt Kazi Sarwar Alam', 'kazi@aladeen.com', '+60320000002', 'AI Academy Bangladesh', 'VIP', 'registered'),
('M. M. Zakirul Hasan', 'zakirul@etec.com', '+8801700000003', 'AI Academy Bangladesh', 'Standard', 'registered');

create table if not exists schedule_sessions (
  id uuid primary key default gen_random_uuid(),
  day_number int not null,
  day_date date,
  day_label text,
  start_time text,
  end_time text,
  title text not null,
  session_type text,
  location text,
  speakers text[],
  theme text,
  sort_order int default 0,
  user_id uuid,
  created_at timestamptz not null default now()
);
alter table schedule_sessions enable row level security;
drop policy if exists "schedule_sessions_v1_read" on schedule_sessions;
create policy "schedule_sessions_v1_read" on schedule_sessions for select using (true);
drop policy if exists "schedule_sessions_v1_write" on schedule_sessions;
create policy "schedule_sessions_v1_write" on schedule_sessions for all using (true) with check (true);

insert into schedule_sessions (day_number, day_date, day_label, start_time, end_time, title, session_type, location, speakers, theme, sort_order) values
(1, '2026-12-16', 'Day 1 — Wednesday, 16 Dec', '09:00', '10:30', 'Summit Inauguration', 'summit', 'Genting Highlands', ARRAY['Prof. Dr. Harunur Rashid'], 'Summit Inauguration & Expert Onboarding', 1),
(1, '2026-12-16', 'Day 1 — Wednesday, 16 Dec', '11:00', '13:00', 'AI Integration in Business Consultancy & Training', 'summit', 'Genting Highlands', ARRAY['Vince Tan','Dennis Sim','KT Goo','Roy Phay'], 'Summit Inauguration & Expert Onboarding', 2),
(1, '2026-12-16', 'Day 1 — Wednesday, 16 Dec', '14:30', '16:30', 'AI CRM & Soft Skills Development in Business', 'summit', 'Genting Highlands', ARRAY['John Tan','Ching Yu Tan','Ethan'], 'Summit Inauguration & Expert Onboarding', 3),
(1, '2026-12-16', 'Day 1 — Wednesday, 16 Dec', '17:00', '19:00', 'Customer Acquisition & AI Business Growth Management', 'summit', 'Genting Highlands', ARRAY['Ng Xien Puo (XP)','Larry'], 'Summit Inauguration & Expert Onboarding', 4),
(1, '2026-12-16', 'Day 1 — Wednesday, 16 Dec', '20:30', '22:00', 'Closing Session: Fundraising', 'summit', 'Genting Highlands', ARRAY['Nazril ''Nash'' Idrus'], 'Summit Inauguration & Expert Onboarding', 5),
(2, '2026-12-17', 'Day 2 — Thursday, 17 Dec', '09:00', '11:00', 'International Brand Building & eCommerce OS', 'summit', 'Genting Highlands', ARRAY['Wais Mahbub','Vanda Chan','Thao NG','Andrew Tan'], 'AI Fair & AI SaaS Tools', 1),
(2, '2026-12-17', 'Day 2 — Thursday, 17 Dec', '12:00', '13:30', 'AI Digital Fair & AI SaaS Tools Showcase', 'fair', 'Genting Highlands', ARRAY[]::text[], 'AI Fair & AI SaaS Tools', 2),
(2, '2026-12-17', 'Day 2 — Thursday, 17 Dec', '14:30', '17:30', 'AI Digital Fair & AI SaaS Tools Showcase', 'fair', 'Genting Highlands', ARRAY[]::text[], 'AI Fair & AI SaaS Tools', 3),
(2, '2026-12-17', 'Day 2 — Thursday, 17 Dec', '18:30', '19:30', 'International Strategic Partnership Development', 'summit', 'Genting Highlands', ARRAY['Wais Mahbub','Simon Leung'], 'AI Fair & AI SaaS Tools', 4),
(3, '2026-12-18', 'Day 3 — Friday, 18 Dec', '09:00', '15:00', 'Genting Highlands Visit with Lunch & Networking', 'tour', 'Genting Highlands', ARRAY[]::text[], 'Genting Highlands & Gala Dinner Night', 1),
(3, '2026-12-18', 'Day 3 — Friday, 18 Dec', '19:30', '22:30', 'Gala Dinner Night', 'tour', 'Genting Highlands', ARRAY[]::text[], 'Genting Highlands & Gala Dinner Night', 2),
(4, '2026-12-19', 'Day 4 — Saturday, 19 Dec', '09:00', '18:00', 'Kuala Lumpur City Tour with Lunch & Dinner', 'tour', 'Kuala Lumpur', ARRAY[]::text[], 'Kuala Lumpur City Tour', 1),
(5, '2026-12-20', 'Day 5 — Sunday, 20 Dec', '12:00', '14:00', 'Hotel Checkout & Airport Travel', 'departure', 'Kuala Lumpur', ARRAY[]::text[], 'Departure Day', 1);

create table if not exists people (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  category text not null,
  role_title text,
  organisation text,
  bio text,
  user_id uuid,
  created_at timestamptz not null default now()
);
alter table people enable row level security;
drop policy if exists "people_v1_read" on people;
create policy "people_v1_read" on people for select using (true);
drop policy if exists "people_v1_write" on people;
create policy "people_v1_write" on people for all using (true) with check (true);

insert into people (name, category, role_title, organisation, bio) values
('Vince Tan', 'faculty', 'Crowdfunding Investor & Founder', '#1 Entrepreneur Masterclass', 'Malaysia''s biggest crowdfunding investor; founder of the largest AI Academy in Southeast Asia.'),
('Wais Mahbub', 'faculty', 'Co-host & Founder', 'AI Academy Bangladesh', 'Co-host, GOAI Summit Malaysia 2026; Founder, AI Academy Bangladesh.'),
('Prof. Dr. Harunur Rashid', 'faculty', 'Host', 'Bangladesh Account Association', 'Host, GOAI Summit; Founder President, BAA.'),
('Vanda Chan', 'faculty', 'Ecommerce & TikTok Specialist', 'TikTok Marketplace', 'Gold Tier media agency partner for TikTok; scaled businesses to millions per month.'),
('Quazi M. Ahmed', 'faculty', 'Founder & Managing Partner', 'Quazi Consultants', 'Founder Advisor, AI Academy.'),
('Ng Xien Puo (XP)', 'faculty', 'Founder', 'Academy of Artificial Intelligence', 'Helps organisations turn AI experiments into business results.'),
('Nazril ''Nash'' Idrus', 'faculty', 'Chartered Accountant', 'KPMG Melbourne', 'Qualified C.A. from ICAA, Australia.'),
('Dr. Kamal Mahmud', 'faculty', 'Co-host & Founder', 'AI Academy Australia', 'Co-host, GOAI Summit Malaysia 2026; Founder, AI Academy Australia.'),
('Scalendo', 'partner', 'Organisational Partner', 'Scalendo', 'GOAI Summit organisational partner.'),
('BIBU', 'partner', 'Organisational Partner', 'BIBU', 'GOAI Summit organisational partner.'),
('STEAMBOX', 'partner', 'Organisational Partner', 'STEAMBOX', 'GOAI Summit organisational partner.'),
('World Masterclass', 'partner', 'Organisational Partner', 'World Masterclass', 'GOAI Summit organisational partner.'),
('Cdr. Nazmul Hasan, Bn (Retd)', 'organiser', 'Member', 'AI Academy Bangladesh', 'Summit organiser.'),
('Rubab Rashid', 'organiser', 'Founder Director', 'Daktare.com', 'Co-founder, 1st National AI Lab.'),
('Md. Masum Ibnul Hoque Khan', 'organiser', 'Managing Director', 'AI Academy Bangladesh', 'Summit organiser.'),
('Md. Zakaria Hossain', 'community', 'Member', 'AI Academy Bangladesh', 'Community partner member.'),
('Capt Kazi Sarwar Alam', 'community', 'Director', 'Aladeen Solutions Sdn. Bhd.', 'Master Mariner; Member, AI Academy Bangladesh.');

create table if not exists digital_fair_exhibitors (
  id uuid primary key default gen_random_uuid(),
  product_name text not null,
  category text,
  description text,
  exhibitor_contact text,
  user_id uuid,
  created_at timestamptz not null default now()
);
alter table digital_fair_exhibitors enable row level security;
drop policy if exists "digital_fair_exhibitors_v1_read" on digital_fair_exhibitors;
create policy "digital_fair_exhibitors_v1_read" on digital_fair_exhibitors for select using (true);
drop policy if exists "digital_fair_exhibitors_v1_write" on digital_fair_exhibitors;
create policy "digital_fair_exhibitors_v1_write" on digital_fair_exhibitors for all using (true) with check (true);

insert into digital_fair_exhibitors (product_name, category, description, exhibitor_contact) values
('AI SaaS CRM Platform', 'AI SaaS', 'AI-powered CRM for lead routing and participant management.', 'contact@scalendo.com'),
('eCommerce AI Toolkit', 'digital product', 'Automation suite for TikTok and eCommerce brand building.', 'vanda@tiktokspecialist.com'),
('AI Brand Builder', 'AI SaaS', 'Automated global digital branding strategy platform.', 'chingyu@aibrand.io');

create table if not exists tickets (
  id uuid primary key default gen_random_uuid(),
  category_name text not null,
  price_amount numeric,
  currency text default 'USD',
  inclusions text,
  refund_policy text,
  user_id uuid,
  created_at timestamptz not null default now()
);
alter table tickets enable row level security;
drop policy if exists "tickets_v1_read" on tickets;
create policy "tickets_v1_read" on tickets for select using (true);
drop policy if exists "tickets_v1_write" on tickets;
create policy "tickets_v1_write" on tickets for all using (true) with check (true);

insert into tickets (category_name, price_amount, currency, inclusions, refund_policy) values
('Standard', 499, 'USD', '5-day summit access, all sessions, meals, city tour', 'Refundable up to 30 days before event'),
('VIP', 999, 'USD', 'Standard inclusions + VIP seating, Gala Dinner priority, networking access', 'Refundable up to 15 days before event'),
('Group (5+)', 399, 'USD', 'Standard inclusions for groups of 5 or more', 'Refundable up to 30 days before event');

create table if not exists communications_log (
  id uuid primary key default gen_random_uuid(),
  channel text,
  subject text,
  audience_segment text,
  body_preview text,
  status text default 'drafted',
  sent_at timestamptz,
  user_id uuid,
  created_at timestamptz not null default now()
);
alter table communications_log enable row level security;
drop policy if exists "communications_log_v1_read" on communications_log;
create policy "communications_log_v1_read" on communications_log for select using (true);
drop policy if exists "communications_log_v1_write" on communications_log;
create policy "communications_log_v1_write" on communications_log for all using (true) with check (true);

insert into communications_log (channel, subject, audience_segment, body_preview, status, sent_at) values
('email', 'Welcome to GOAI Summit Malaysia 2026', 'all_registered', 'Your registration is confirmed. Learn. Source. Connect. Grow.', 'sent', '2026-09-21 10:00:00+08'),
('email', 'Early Bird Ticket Reminder', 'unregistered', 'Early bird pricing ends soon. Secure your spot for 16-20 Dec 2026.', 'drafted', null),
('phone', 'VIP confirmation call', 'vip', 'Called to confirm Gala Dinner seating preference.', 'sent', '2026-09-20 14:00:00+08');

create table if not exists affiliate_referrals (
  id uuid primary key default gen_random_uuid(),
  affiliate_name text,
  referred_name text,
  referred_email text,
  sale_amount numeric,
  currency text default 'USD',
  referral_status text default 'applied',
  payout_status text default 'pending',
  tax_note text,
  user_id uuid,
  created_at timestamptz not null default now()
);
alter table affiliate_referrals enable row level security;
drop policy if exists "affiliate_referrals_v1_read" on affiliate_referrals;
create policy "affiliate_referrals_v1_read" on affiliate_referrals for select using (true);
drop policy if exists "affiliate_referrals_v1_write" on affiliate_referrals;
create policy "affiliate_referrals_v1_write" on affiliate_referrals for all using (true) with check (true);

insert into affiliate_referrals (affiliate_name, referred_name, referred_email, sale_amount, currency, referral_status, payout_status, tax_note) values
('John Chong', 'Ahmad Rahman', 'ahmad@example.com', 499, 'USD', 'confirmed', 'approved', 'Withholding tax applicable'),
('Vanda Chan', 'Sarah Lim', 'sarah@example.com', 999, 'USD', 'confirmed', 'pending', 'No tax withholding'),
('Simon Leung', 'David Tan', 'david@example.com', 399, 'USD', 'applied', 'pending', null);