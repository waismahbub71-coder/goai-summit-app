"use client";

import { createContext, useContext, useEffect, useMemo, useState } from "react";
import type { User } from "@supabase/supabase-js";
import { createClient } from "@/lib/supabase/client";

type AuthState = {
  user: User | null;
  isAdmin: boolean;
  loading: boolean;
  signOut: () => Promise<void>;
};

const AuthContext = createContext<AuthState>({ user:null, isAdmin:false, loading:true, signOut:async()=>{} });

export function AuthProvider({children}:{children:React.ReactNode}){
  const[user,setUser]=useState<User|null>(null),[isAdmin,setIsAdmin]=useState(false),[loading,setLoading]=useState(true);
  const supabase=useMemo(()=>createClient(),[]);
  useEffect(()=>{
    const apply=async(next:User|null)=>{
      setUser(next);
      if(!next){setIsAdmin(false);setLoading(false);return}
      const{data}=await supabase.from("user_profiles").select("role").eq("user_id",next.id).maybeSingle();
      setIsAdmin(data?.role==="admin");
      setLoading(false);
    };
    supabase.auth.getUser().then(({data})=>apply(data.user));
    const{data:{subscription}}=supabase.auth.onAuthStateChange((_event,session)=>{apply(session?.user??null)});
    return()=>subscription.unsubscribe();
  },[supabase]);
  const value={user,isAdmin,loading,signOut:async()=>{await supabase.auth.signOut();window.location.assign("/")}};
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export const useAuth=()=>useContext(AuthContext);
