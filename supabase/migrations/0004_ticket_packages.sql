-- Apply the confirmed GOAI Summit Malaysia 2026 ticket packages and prices.

update public.tickets
set category_name = 'Executive Package',
    price_amount = 326,
    currency = 'USD'
where lower(category_name) in ('standard', 'executive package');

update public.tickets
set category_name = 'VIP Executive Package',
    price_amount = 1400,
    currency = 'USD'
where lower(category_name) in ('vip', 'vip executive package');

update public.tickets
set category_name = 'Elite Presidential',
    price_amount = 2960,
    currency = 'USD'
where lower(category_name) in ('group (5+)', 'elite presidential');
