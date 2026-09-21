"use client";
import { createClient } from "@supabase/supabase-js";
import { seedExhibitors, seedParticipants, seedPeople, seedSessions, seedTickets } from "./seeds";
import type { TableMap } from "./types";
const configured=Boolean(process.env.NEXT_PUBLIC_SUPABASE_URL&&process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);
const supabase=configured?createClient(process.env.NEXT_PUBLIC_SUPABASE_URL!,process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!):null;
const seeds:{[K in keyof TableMap]:TableMap[K][]}={schedule_sessions:seedSessions,people:seedPeople,digital_fair_exhibitors:seedExhibitors,tickets:seedTickets,participants:seedParticipants};
const key=(table:string)=>`goai-v1-${table}`;
const localRead=<K extends keyof TableMap>(table:K):TableMap[K][]=>{if(typeof window==="undefined")return seeds[table];const raw=localStorage.getItem(key(table));if(!raw){localStorage.setItem(key(table),JSON.stringify(seeds[table]));return seeds[table]}return JSON.parse(raw)};
const localWrite=<K extends keyof TableMap>(table:K,rows:TableMap[K][])=>localStorage.setItem(key(table),JSON.stringify(rows));
export const dataMode=configured?"supabase":"local";
export async function listRows<K extends keyof TableMap>(table:K):Promise<TableMap[K][]> {if(!supabase)return localRead(table);const order=table==="schedule_sessions"?"day_number":table==="people"?"name":"created_at";const{data,error}=await supabase.from(table).select("*").order(order);if(error)throw error;return(data??[])as TableMap[K][]}
export async function saveRow<K extends keyof TableMap>(table:K,row:TableMap[K]):Promise<void>{if(!supabase){const rows=localRead(table)as Array<TableMap[K]>;const i=rows.findIndex(r=>r.id===row.id);if(i>=0)rows[i]=row;else rows.push({...row,id:crypto.randomUUID()});localWrite(table,rows);return}const payload={...row}as Record<string,unknown>;if(String(payload.id).startsWith("seed-")||payload.id==="new")delete payload.id;const{error}=await supabase.from(table).upsert(payload);if(error)throw error}
export async function deleteRow<K extends keyof TableMap>(table:K,id:string):Promise<void>{if(!supabase){localWrite(table,localRead(table).filter(r=>r.id!==id));return}const{error}=await supabase.from(table).delete().eq("id",id);if(error)throw error}
