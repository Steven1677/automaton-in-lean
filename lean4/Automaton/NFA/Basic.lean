import Mathlib.Data.Set.Lattice
import Automaton.Language.Basic
import Automaton.Finset.Basic

/-!
  This file contains the definition of NFA as well as a few fundemantal operations
  * `δ_star` and `accepts` functions
-/

namespace NFA

structure NFA (α : Type _)(σ : Type _) where
  q : Finset α        -- states
  init : α          -- initial state
  fs : Finset α       -- accepting states
  δ : α → σ → Finset α -- transition function
  [dec : DecidableEq α]

variable {α : Type _}{σ : Type _} [DecidableEq α] (t : NFA α σ)


-- one step in the operation of NFA, consuming one character
-- take the union of all sets of states reachable from current set of states
def δ_step  (q : Finset α) (e : σ) : Finset α := q.biUnion (fun n => t.δ n e)

-- δ* function for NFA
-- returns set of states reached after inputting a word
def δ_star : (w : word σ) → Finset α
  | [] => {t.init}
  | e :: es => δ_step t (δ_star es) e 

-- Whether a word is in the language that the NFA accepts
def nfa_accepts (w : word σ) : Prop := by
  have inter : Finset α := (δ_star t w) ∩ t.fs
  exact inter.Nonempty

-- nfa accepts nil iff init is final
theorem nfa_accepts_nil_iff_final : nfa_accepts t [] ↔ t.init ∈ t.fs := by
  apply Iff.intro
  · intro ne
    dsimp [nfa_accepts, δ_star ] at ne
    apply Finset.nonempty_inter_singleton_imp_in
    exact ne
  · intro e
    dsimp [nfa_accepts,δ_star]
    rw [Finset.singleton_inter_of_mem e]
    exact (Finset.singleton_nonempty t.init)

end NFA