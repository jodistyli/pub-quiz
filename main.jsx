import React, {useEffect, useState} from 'react';
import {createRoot} from 'react-dom/client';
import {createClient} from '@supabase/supabase-js';
import './styles.css';

const url=import.meta.env.VITE_SUPABASE_URL;
const key=import.meta.env.VITE_SUPABASE_ANON_KEY;
const supabase=url && key ? createClient(url,key) : null;
const token=new URLSearchParams(location.search).get('team');

function App(){
 const [current,setCurrent]=useState(null), [answer,setAnswer]=useState(''), [status,setStatus]=useState('');
 async function load(){
  if(!supabase) return setStatus('Die Website ist noch nicht mit Supabase konfiguriert.');
  const {data,error}=await supabase.rpc('get_current_question');
  if(error) return setStatus('Die aktuelle Frage konnte nicht geladen werden.');
  setCurrent(data?.[0]||null);
 }
 useEffect(()=>{load(); const timer=setInterval(load,10000); return()=>clearInterval(timer)},[]);
 async function submit(e){
  e.preventDefault(); setStatus('');
  if(!token) return setStatus('Dieser Team-Link ist ungültig. Bitte verwende den Link der Quizleitung.');
  if(!answer) return setStatus('Bitte wähle A, B, C oder D.');
  const {error}=await supabase.rpc('submit_current_answer',{p_token:token,p_answer:answer});
  setStatus(error ? 'Speichern nicht möglich. Prüfe bitte deinen Team-Link oder versuche es erneut.' : 'Antwort gespeichert. Du kannst sie bis zur nächsten Frage erneut ändern.');
 }
 return <main><section className="card"><p className="eyebrow">PUB-QUIZ</p><h1>Antwort abgeben</h1>
 {!current ? <p>Die aktuelle Frage wird geladen …</p> : <><p className="question">{current.round_name}<br/><strong>Frage {current.question_number}</strong></p><form onSubmit={submit}><label htmlFor="answer">Deine Antwort</label><select id="answer" value={answer} onChange={e=>setAnswer(e.target.value)}><option value="">Bitte auswählen</option>{['A','B','C','D'].map(x=><option key={x} value={x}>{x}</option>)}</select><button type="submit">Antwort aktualisieren</button></form></>}
 {status && <p className="status" role="status">{status}</p>}<button className="secondary" onClick={load}>Frage aktualisieren</button></section></main>;
}
createRoot(document.getElementById('root')).render(<App/>);