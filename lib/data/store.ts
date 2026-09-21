"use client";
import { createClient } from "@supabase/supabase-js";
import { seedCommunications, seedExhibitors, seedParticipants, seedPeople, seedReferrals, seedSessions, seedTickets } from "./seeds";
import type { TableMap } from "./types";
const configured=Boolean(process.env.NEXT_PUBLIC_SUPABASE_URL&&process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);
const supabase=configured?createClient(process.env.NEXT_PUBLIC_SUPABASE_URL!,process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!):null;
const seeds:{[K in keyof TableMap]:TableMap[K][]}={schedule_sessions:seedSessions,people:seedPeople,digital_fair_exhibitors:seedExhibitors,tickets:seedTickets,participants:seedParticipants,communications_log:seedCommunications,affiliate_referrals:seedReferrals};
const key=(table:string)=>`goai-v1-${table}`;
const localRead=<K extends keyof TableMap>(table:K):TableMap[K][]=>{if(typeof window==="undefined")return seeds[table];const raw=localStorage.getItem(key(table));if(!raw){localStorage.setItem(key(table),JSON.stringify(seeds[table]));return seeds[table]}return JSON.parse(raw)};
const localWrite=<K extends keyof TableMap>(table:K,rows:TableMap[K][])=>localStorage.setItem(key(table),JSON.stringify(rows));
export const dataMode=configured?"supabase":"local";
export async function listRows<K extends keyof TableMap>(table:K):Promise<TableMap[K][]> {
  if(!supabase)return localRead(table);
  const order=table==="schedule_sessions"?"day_number":table==="people"?"name":"created_at";
  const first=await supabase.from(table).select("*").order(order);
  if(first.error)throw first.error;
  const current=(first.data??[])as TableMap[K][];
  let missing:TableMap[K][]=[];
  if(table==="schedule_sessions")missing=(seeds[table]as TableMap[K][]).filter((seed:any)=>!current.some((row:any)=>row.day_number===seed.day_number&&row.start_time===seed.start_time&&row.title===seed.title));
  else if(table==="people")missing=(seeds[table]as TableMap[K][]).filter((seed:any)=>!current.some((row:any)=>row.name===seed.name));
  else if(current.length===0)missing=seeds[table];
  if(!missing.length)return current;
  const payload=missing.map(row=>{const copy={...row}as Record<string,unknown>;delete copy.id;return copy});
  const inserted=await supabase.from(table).insert(payload);
  if(inserted.error)throw inserted.error;
  const refreshed=await supabase.from(table).select("*").order(order);
  if(refreshed.error)throw refreshed.error;
  return(refreshed.data??[])as TableMap[K][];
}
export async function saveRow<K extends keyof TableMap>(table:K,row:TableMap[K]):Promise<void>{if(!supabase){const rows=localRead(table)as Array<TableMap[K]>;const i=rows.findIndex(r=>r.id===row.id);if(i>=0)rows[i]=row;else rows.push({...row,id:crypto.randomUUID()});localWrite(table,rows);return}const payload={...row}as Record<string,unknown>;if(String(payload.id).startsWith("seed-")||payload.id==="new")delete payload.id;const{error}=await supabase.from(table).upsert(payload);if(error)throw error}
export async function deleteRow<K extends keyof TableMap>(table:K,id:string):Promise<void>{if(!supabase){localWrite(table,localRead(table).filter(r=>r.id!==id));return}const{error}=await supabase.from(table).delete().eq("id",id);if(error)throw error}
