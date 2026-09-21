export type Session = { id:string; day_number:number; day_date:string; day_label:string; start_time:string; end_time:string; title:string; session_type:string; location:string; speakers:string[]; theme:string; sort_order:number; };
export type Person = { id:string; name:string; category:string; role_title:string; organisation:string; bio:string; };
export type TableMap = { schedule_sessions:Session; people:Person };
