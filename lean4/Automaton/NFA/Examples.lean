import Automaton.NFA.Basic
import Automaton.DFA.Minimization
import Automaton.DFA.ToNFA
import Automaton.NFA.ToDFA
import Automaton.NFA.ENFA

-- normal automaton

open NFA DFA εNFA

def Q₁ : Finset (Fin 2) := {0,1}
def σ₁ : Finset (Fin 2) := {0,1}

def δ₁ : Q₁ → σ₁ → Finset Q₁
  | ⟨0, _⟩ , ⟨1,_⟩ => {⟨1,by simp⟩}
  | ⟨0, _⟩ , ⟨0,_⟩ => {⟨0,by simp⟩}
  | ⟨1, _⟩ , ⟨1,_⟩ => {⟨1,by simp⟩}
  | ⟨1, _⟩ , ⟨0,_⟩ => {⟨0,by simp⟩}

def nfa₁ : NFA Q₁ σ₁ := {q₀ := ⟨0,by simp⟩, fs := {⟨1,by simp⟩} , δ := δ₁}

def w₁₁ : word σ₁ := []
def w₁₂ : word σ₁ := [⟨1, by simp⟩ , ⟨0, by simp⟩]
def w₁₃ : word σ₁ := [⟨0, by simp⟩ , ⟨1, by simp⟩]

#eval nfa_accepts nfa₁ w₁₁
#eval nfa_accepts nfa₁ w₁₂
#eval nfa_accepts nfa₁ w₁₃

#eval dfa_accepts (ToDFA.nfa_to_dfa nfa₁) w₁₁
#eval dfa_accepts (ToDFA.nfa_to_dfa nfa₁) w₁₂
#eval dfa_accepts (ToDFA.nfa_to_dfa nfa₁) w₁₃

#eval nfa_accepts (ToNFA.dfa_to_nfa (ToDFA.nfa_to_dfa nfa₁)) w₁₁
#eval nfa_accepts (ToNFA.dfa_to_nfa (ToDFA.nfa_to_dfa nfa₁)) w₁₂
#eval nfa_accepts (ToNFA.dfa_to_nfa (ToDFA.nfa_to_dfa nfa₁)) w₁₃


def Q₂ : Finset (Fin 4) := {0,1,2,3}
def σ₂ : Finset (Fin 3) := {0,1,2}

def δ₂ : Q₂ → Option σ₂ → Finset Q₂
  | ⟨0, _⟩ , some ⟨0,_⟩ => {⟨0,by simp⟩}
  | ⟨0, _⟩ , none => {⟨1,by simp⟩}
  | ⟨1, _⟩ , some ⟨1,_⟩ => {⟨1,by simp⟩}
  | ⟨1, _⟩ , none => {⟨2,by simp⟩}
  | ⟨2, _⟩ , some ⟨2,_⟩ => {⟨3,by simp⟩}
  | _ , _ => ∅

-- accepts any number of 0s followed by any number of 1s followed by exactly one 2
def εnfa₂ : εNFA σ₂ Q₂ := {q₀ := ⟨0,by simp⟩, fs := {⟨3,by simp⟩}, δ := δ₂}


def w₂₁ : word σ₂ := []
def w₂₂ : word σ₂ := [⟨0,by simp⟩]
def w₂₃ : word σ₂ := [⟨1,by simp⟩]
def w₂₄ : word σ₂ := [⟨2,by simp⟩]
def w₂₅ : word σ₂ := [⟨0,by simp⟩, ⟨0,by simp⟩, ⟨0,by simp⟩, ⟨1,by simp⟩, ⟨2,by simp⟩]
def w₂₆ : word σ₂ := [⟨0,by simp⟩, ⟨0,by simp⟩, ⟨0,by simp⟩, ⟨1,by simp⟩]

#eval εnfa_accepts εnfa₂ w₂₁
#eval εnfa_accepts εnfa₂ w₂₂
#eval εnfa_accepts εnfa₂ w₂₃
#eval εnfa_accepts εnfa₂ w₂₄
#eval εnfa_accepts εnfa₂ w₂₅
#eval εnfa_accepts εnfa₂ w₂₆

#eval nfa_accepts (εnfa_to_nfa εnfa₂) w₂₁
#eval nfa_accepts (εnfa_to_nfa εnfa₂) w₂₂
#eval nfa_accepts (εnfa_to_nfa εnfa₂) w₂₃
#eval nfa_accepts (εnfa_to_nfa εnfa₂) w₂₄
#eval nfa_accepts (εnfa_to_nfa εnfa₂) w₂₅
#eval nfa_accepts (εnfa_to_nfa εnfa₂) w₂₆
