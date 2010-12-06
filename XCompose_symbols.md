Here is an example of a .XCompose file; you can also take a look in 
"/usr/share/X11/locale/en_US.UTF-8/Compose"
or
"/usr/local/lib/X11/locale/en_US.UTF-8/Compose"
or so, according to your distribution.

{{{#!bash
<Multi_key> <f> <f> <space> : UFB00 # ﬀ
<Multi_key> <f> <i> : UFB01 # ﬁ
<Multi_key> <f> <l> : UFB02 # ﬂ
<Multi_key> <f> <f> <i> : UFB03 # ﬃ
<Multi_key> <f> <f> <l> : UFB04 # ﬄ
<Multi_key> <f> <t> : UFB05 # je sais que ce n'est pas un 'f', mais le 's' est pris ﬅ
<Multi_key> <s> <t> : UFB06 # ﬆ

<Multi_key> <space> <a> : "α"  Greek_alpha
<Multi_key> <space> <A> : "Α"  Greek_ALPHA
<Multi_key> <space> <b> : "β"  Greek_beta
<Multi_key> <space> <B> : "Β"  Greek_BETA
<Multi_key> <space> <g> : "γ"  Greek_gamma
<Multi_key> <space> <G> : "Γ"  Greek_GAMMA
<Multi_key> <space> <d> : "δ"  Greek_delta
<Multi_key> <space> <D> : "Δ"  Greek_DELTA
<Multi_key> <space> <e> : "ε"  Greek_epsilon
<Multi_key> <space> <E> : "Ε"  Greek_EPSILON
<Multi_key> <space> <z> : "ζ"  Greek_zeta
<Multi_key> <space> <Z> : "Ζ"  Greek_ZETA
<Multi_key> <space> <h> : "η"  Greek_eta
<Multi_key> <space> <H> : "Η"  Greek_ETA
<Multi_key> <space> <j> : "θ"  Greek_theta
<Multi_key> <space> <J> : "Θ"  Greek_THETA
<Multi_key> <space> <i> : "ι"  Greek_iota
<Multi_key> <space> <I> : "Ι"  Greek_IOTA
<Multi_key> <space> <k> : "κ"  Greek_kappa
<Multi_key> <space> <K> : "Κ"  Greek_KAPPA
<Multi_key> <space> <l> : "λ"  Greek_lambda
<Multi_key> <space> <L> : "Λ"  Greek_LAMBDA
<Multi_key> <space> <m> : "μ"  Greek_mu
<Multi_key> <space> <M> : "Μ"  Greek_MU
<Multi_key> <space> <n> : "ν"  Greek_nu
<Multi_key> <space> <N> : "Ν"  Greek_NU
<Multi_key> <space> <x> : "ξ"  Greek_xi
<Multi_key> <space> <X> : "Ξ"  Greek_XI
<Multi_key> <space> <o> : "ο"  Greek_omicron
<Multi_key> <space> <O> : "Ο"  Greek_OMICRON
<Multi_key> <space> <p> : "π"  Greek_pi
<Multi_key> <space> <P> : "Π"  Greek_PI
<Multi_key> <space> <r> : "ρ"  Greek_rho
<Multi_key> <space> <R> : "Ρ"  Greek_RHO
<Multi_key> <space> <s> : "σ"  Greek_sigma
<Multi_key> <space> <S> : "Σ"  Greek_SIGMA
<Multi_key> <space> <c> : "ς"  Greek_finalsmallsigma
<Multi_key> <space> <C> : "Σ"  Greek_SIGMA
<Multi_key> <space> <t> : "τ"  Greek_tau
<Multi_key> <space> <T> : "Τ"  Greek_TAU
<Multi_key> <space> <u> : "υ"  Greek_upsilon
<Multi_key> <space> <U> : "Υ"  Greek_UPSILON
<Multi_key> <space> <f> : "φ"  Greek_phi
<Multi_key> <space> <F> : "Φ"  Greek_PHI
<Multi_key> <space> <q> : "χ"  Greek_chi
<Multi_key> <space> <Q> : "Χ"  Greek_CHI
<Multi_key> <space> <y> : "ψ"  Greek_psi
<Multi_key> <space> <Y> : "Ψ"  Greek_PSI
<Multi_key> <space> <w> : "ω"  Greek_omega
<Multi_key> <space> <W> : "Ω"  Greek_OMEGA

<Multi_key> <R> <f> : U16A0 # ᚠ
<Multi_key> <R> <u> : U16A2 # ᚢ
<Multi_key> <R> <T> : U16A6 # ᚦ
<Multi_key> <R> <a> : U16A8 # ᚨ
<Multi_key> <R> <A> : U16A9 # ᚩ
<Multi_key> <R> <r> : U16B1 # ᚱ
<Multi_key> <R> <k> : U16B2 # ᚲ
<Multi_key> <R> <g> : U16B7 # ᚷ
<Multi_key> <R> <w> : U16B9 # ᚹ
<Multi_key> <R> <h> : U16BA # ᚺ
<Multi_key> <R> <n> : U16BE # ᚾ
<Multi_key> <R> <i> : U16C1 # ᛁ
<Multi_key> <R> <j> : U16C3 # ᛃ
<Multi_key> <R> <I> : U16C7 # ᛇ
<Multi_key> <R> <p> : U16C8 # ᛈ
<Multi_key> <R> <z> : U16C9 # ᛉ
<Multi_key> <R> <t> : U16CF # ᛏ
<Multi_key> <R> <b> : U16D2 # ᛒ
<Multi_key> <R> <e> : U16D6 # ᛖ
<Multi_key> <R> <m> : U16D7 # ᛗ
<Multi_key> <R> <l> : U16DA # ᛚ
<Multi_key> <R> <N> : U16DC # ᛜ
<Multi_key> <R> <d> : U16DE # ᛞ
<Multi_key> <R> <o> : U16DF # ᛟ

<Multi_key> <N> <N> : "ℕ" U2115
<Multi_key> <Z> <Z> : "ℤ" U2124
<Multi_key> <Q> <Q> : "ℚ" U211A
<Multi_key> <R> <R> : "ℝ" U211D
<Multi_key> <C> <C> : "ℂ" U2102
<Multi_key> <H> <H> : "ℍ" U210D
<Multi_key> <P> <P> : "ℙ" U2119

<Multi_key> <Up> : "↑" U2191
<Multi_key> <Right> : "→" U2192
<Multi_key> <Left> : "←" U2190
<Multi_key> <Down> : "↓" U2193

<Multi_key> <Multi_key> <Up> : "⇑" U21D1
<Multi_key> <Multi_key> <Right> : "⇒" U21D2
<Multi_key> <Multi_key> <Left> : "⇐" U21D0
<Multi_key> <Multi_key> <Down> : "⇓" U21D3
<Multi_key> <Multi_key> <Multi_key> <Right> : "⇛" U21DB
<Multi_key> <Multi_key> <Multi_key> <Left> : "⇚" U21DA

<Multi_key> <o> <plus> : "⊕" U2295
<Multi_key> <o> <minus> : "⊝" U229D
<Multi_key> <o> <asterisk> : "⊛" U229B
<Multi_key> <o> <slash> : "⊘" U2298
<Multi_key> <o> <x> : "⊗" U2297
<Multi_key> <o> <o> : "⊚" U229A
<Multi_key> <o> <period> : "⊙" U2299
<Multi_key> <o> <equal> : "⊜" U229C
<Multi_key> <v> <v> : "√" U221A
<Multi_key> <2> <v> : "√" U221A
<Multi_key> <3> <v> : "∛" U221B
<Multi_key> <4> <v> : "∜" U221C
<Multi_key> <asterisk> <asterisk> : "∗" U2217
<Multi_key> <asterisk> <x> : "×" multiply
<Multi_key> <asterisk> <period> : "·" periodcentered
<Multi_key> <asterisk> <o> : "∘" U2218

<Multi_key> <d> <e> <r> : "∂" U2202
<Multi_key> <I> <n> <t> : "∫" U222B

<Multi_key> <a> <l> <l> : "∀"  U2200
<Multi_key> <e> <x> : "∃" U2203
<Multi_key> <slash> <e> <x> : "∄" U2204

<Multi_key> <t> <o> <p> : "⊤" U22A4
<Multi_key> <b> <o> <t> : "⊥" U22A5

<Multi_key> <A> <slash> : "∁" U2201
<Multi_key> <n> <o> <t> : "¬" notsign

<Multi_key> <a> <n> <d> : "∧" U2227
<Multi_key> <A> <N> <D> : "⋀" U22C0
<Multi_key> <o> <r> : "∨" U2228
<Multi_key> <O> <R> : "⋁" U22C1

<Multi_key> <I> <N> <T> : "⋂" U22C2
<Multi_key> <U> <N> : "⋃" U22C3
<Multi_key> <i> <n> <t> : "∩" U2229
<Multi_key> <u> <n> : "∪" U222A

<Multi_key> <slash> <i> <n> <space> : "∉" U2209
<Multi_key> <i> <n> <space> : "∈" U2208
<Multi_key> <slash> <n> <i> <space> : "∌" U220C
<Multi_key> <n> <i> <space> : "∋" U220B

<Multi_key> <i> <n> <c> : "⊂" U2282
<Multi_key> <c> <n> <i> : "⊃" U2283
<Multi_key> <slash> <i> <n> <c> : "⊄" U2284
<Multi_key> <slash> <c> <n> <i> : "⊅" U2285
<Multi_key> <equal> <i> <n> <c> : "⊆" U2286
<Multi_key> <equal> <c> <n> <i> : "⊇" U2287
<Multi_key> <slash> <equal> <i> <n> <c> : "⊈" U2288
<Multi_key> <slash> <equal> <c> <n> <i> : "⊉" U2289

<Multi_key> <equal> <equal> : "≣" U2263
<Multi_key> <equal> <minus> : "≡" U2261
<Multi_key> <equal> <asciitilde> : "≅" U2245
<Multi_key> <minus> <asciitilde> : "≃" U2243
<Multi_key> <asciitilde> <asciitilde> : "≈" U2248
<Multi_key> <asciitilde> <minus> : "≂" U2242
<Multi_key> <equal> <d> : "≝" U225D
<Multi_key> <equal> <degree> : "≗" U2257
<Multi_key> <equal> <asciicircum> : "≙" U2259
<Multi_key> <equal> <v> : "≚" U225A
<Multi_key> <equal> <asterisk> : "≛" U225B
<Multi_key> <equal> <Greek_DELTA> : "≜" U225C
<Multi_key> <equal> <space> <D>: "≜" U225C
<Multi_key> <equal> <m> : "≞" U225E
<Multi_key> <equal> <question> : "≟" U225F
<Multi_key> <equal> <slash> : "≠" U2260
<Multi_key> <slash> <minus> <asciitilde> : "≄" U2244
<Multi_key> <slash> <equal> <asciitilde> : "≇" U2247
<Multi_key> <slash> <equal> <minus> : "≢" U2262

<Multi_key> <greater> <equal> : "≥" U2265
<Multi_key> <less> <equal> : "≤" U2264
<Multi_key> <greater> <asciitilde> : "≳" U2273
<Multi_key> <less> <asciitilde> : "≲" U2272
<Multi_key> <less> <less> : "≪" U226A
<Multi_key> <greater> <greater> : "≫" U226B
<Multi_key> <greater> <less> : "≶" U2276
<Multi_key> <less> <greater> : "≷" U2277
<Multi_key> <slash> <greater> <equal> : "≱" U2271
<Multi_key> <slash> <less> <equal> : "≰" U2270
<Multi_key> <slash> <greater> <asciitilde> : "≵" U2275
<Multi_key> <slash> <less> <asciitilde> : "≴" U2274
<Multi_key> <slash> <greater> <less> : "≸" U2278
<Multi_key> <slash> <less> <greater> : "≹" U2279
<Multi_key> <greater> <slash> : "≯" U226F
<Multi_key> <less> <slash> : "≮" U226E
<Multi_key> <greater> <bar> : "⊳" U22B3
<Multi_key> <less> <bar> : "⊲" U22B2
<Multi_key> <bar> <greater> <equal> : "⊵" U22B5
<Multi_key> <bar> <less> <equal> : "⊴" U22B4
<Multi_key> <slash> <greater> <bar> : "⋫" U22EB
<Multi_key> <slash> <less> <bar> : "⋪" U22EA
<Multi_key> <slash> <bar> <greater> <equal> : "⋭" U22ED
<Multi_key> <slash> <bar> <less> <equal> : "⋬" U22EC
<Multi_key> <greater> <period> : "⋗" U22D7
<Multi_key> <less> <period> : "⋖" U22D6

<Multi_key> <bar> <bar> : "∥" U2225
<Multi_key> <slash> <bar> <bar> : "∦" U2226
<Multi_key> <bar> <slash> : "∤" U2224
}}}
