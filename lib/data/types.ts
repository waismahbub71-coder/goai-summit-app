export type Session = { id:string; day_number:number; day_date:string; day_label:string; start_time:string; end_time:string; title:string; session_type:string; location:string; speakers:string[]; theme:string; sort_order:number; };
export type Person = { id:string; name:string; category:string; role_title:string; organisation:string; bio:string; };
export type Exhibitor = { id:string; product_name:string; category:string; description:string; exhibitor_contact:string; };
export type Ticket = { id:string; category_name:string; price_amount:number|null; currency:string; inclusions:string; refund_policy:string; };
export type Participant = { id:string; full_name:string; email:string; phone:string; academy_affiliation:string; ticket_category:string; registration_source:string; status:string; created_at?:string; };
export type Communication = { id:string; channel:string; subject:string; audience_segment:string; body_preview:string; status:string; sent_at:string|null; created_at?:string; };
export type Referral = { id:string; affiliate_name:string; referred_name:string; referred_email:string; sale_amount:number|null; currency:string; referral_status:string; payout_status:string; tax_note:string; created_at?:string; };
export type TableMap = { schedule_sessions:Session; people:Person; digital_fair_exhibitors:Exhibitor; tickets:Ticket; participants:Participant; communications_log:Communication; affiliate_referrals:Referral };
