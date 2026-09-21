"use client";

import { useState } from "react";
import { createClient } from "@/lib/supabase/client";

export function AuthPage(){
  const[mode,setMode]=useState<"signup"|"signin">("signup"),[message,setMessage]=useState(""),[busy,setBusy]=useState(false);
  const submit=async(e:React.FormEvent<HTMLFormElement>)=>{e.preventDefault();setBusy(true);setMessage("");const f=new FormData(e.currentTarget),email=String(f.get("email")).trim(),password=String(f.get("password"));const supabase=createClient();
    if(mode==="signup"){
      const{data,error}=await supabase.auth.signUp({email,password,options:{emailRedirectTo:`${window.location.origin}/register?welcome=1`}});
      if(error){setMessage(error.message);setBusy(false);return}
      if(data.session)window.location.assign("/register?welcome=1");
      else{setMessage("Account created. Check your email to confirm it, then return to registration.");setTimeout(()=>window.location.assign("/register?welcome=1"),1800)}
    }else{
      const{error}=await supabase.auth.signInWithPassword({email,password});
      if(error){setMessage(error.message);setBusy(false);return}
      window.location.assign("/register?welcome=1");
    }
  };
  return <main className="auth-page"><a className="auth-brand" href="/"><span>GO</span><b>GOAI Summit Malaysia 2026</b></a><section className="auth-card"><div className="eyebrow">{mode==="signup"?"Join the summit":"Welcome back"}</div><h1>{mode==="signup"?"Create your summit account.":"Sign in to continue."}</h1><p>{mode==="signup"?"Your registration form opens immediately after sign-up.":"Members continue to registration; organiser controls remain private."}</p>{message&&<div className={`notice ${/invalid|error|unable|already/i.test(message)?"error":""}`}>{message}</div>}<form onSubmit={submit}><div className="field"><label>Email address</label><input name="email" type="email" autoComplete="email" required/></div><div className="field"><label>Password</label><input name="password" type="password" autoComplete={mode==="signup"?"new-password":"current-password"} minLength={8} required/></div><button className="button auth-submit" disabled={busy}>{busy?"Please wait…":mode==="signup"?"Sign up & register →":"Sign in →"}</button></form><button className="auth-switch" onClick={()=>{setMode(mode==="signup"?"signin":"signup");setMessage("")}}>{mode==="signup"?"Already have an account? Sign in":"New here? Create an account"}</button></section></main>
}
