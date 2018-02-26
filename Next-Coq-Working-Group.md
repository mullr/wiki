Organization
------------

The next Coq Working Group will take place on February 26th and 27th.
We will be using video-conference equipment from Sophia and Paris.

- In Paris, at IRIF room 3058 (ask Matthieu for more details)
- In Sophia, at Inria room Euler Bleu (ask Maxime for more details)

It is also possible to connect from H323-compatible clients. If you plan
to do so, please contact Maxime.

Video streaming is available on the [YouTube channel](https://www.youtube.com/channel/UCbJo6gYYr0OF18x01M4THdQ)

Tentative schedule
------------------

- 26/02/2018

  - 10:00 8.8 final roadmap and todo list
    (please update the milestone on your PRs to reflect your current schedule)
  - 10:30 Primitive Projections: where are we, where do we want to go? (Matthieu)
  - 11:00 Break
  - 11:15 Future of `Instance` (special `{}` syntax for records, Refine Instance Mode, etc?)
    [Some related bugs: #3632]
  - 11:30 Status of the wiki (eg, look at the second page listed on the right, or the third one...) (Enrico) 5' minutes to "click on the problematic pages", 10' discussion
  - 11:45 what should run on ci and what should run in your `pre-push/commit` hook (aka: how my rants about the linter evolved into something more positive) (Enrico) 5' to explain, 10' discussion
    https://github.com/coq/coq/pull/6528
  - 12:00 Lunch
  - 14:00 - 18:00 PR discussions
    - Reducing temporary allocations in CClosure (Pierre-Marie) https://github.com/coq/coq/pull/400
    - Evar/evar order sensitivity (Matthieu) https://github.com/coq/coq/pull/786
    - mli-only files outside API (Pierre L) https://github.com/coq/coq/pull/797
    - Handling evars in the VM (Pierre-Marie) https://github.com/coq/coq/pull/935
    - Add HashConsing option (Paul) https://github.com/coq/coq/pull/1013
    - changed statements of Rpower_lt and Rle_power and added lemmas (Yves) https://github.com/coq/coq/pull/1026
    - ￼Deprecate Write/Restore State vernaculars (Maxime) https://github.com/coq/coq/pull/1145
      Also https://github.com/coq/coq/pull/1088
    - Fix/dont install make.exe (Enrico) https://github.com/coq/coq/pull/5991
    - Move `global_reference` to Kernel.Names (Emilio) https://github.com/coq/coq/pull/6156
    - [search] Thread evar_map to fix evar_map FIXMEs (Emilio) https://github.com/coq/coq/pull/6250
    - [engine] Remove and deprecate `nf_enter` et al (Emilio) https://github.com/coq/coq/pull/6343
    - Removal of unsafe 3: occur_evar_upto (Emilio) https://github.com/coq/coq/pull/6349
    - Deprecate constructors of Names.name (Emilio) https://github.com/coq/coq/pull/6440
    - Remove `intf` directory (Emilio) https://github.com/coq/coq/pull/6512
    - Restrict use of "debug" Termops printer (Emilio) https://github.com/coq/coq/pull/6524
    - Moving back interface-only files to mli after API removal (Pierre-Marie) https://github.com/coq/coq/pull/6664
    - dest_{prod,lam}: no Cast case (it's removed by whd) (Gaëtan) https://github.com/coq/coq/pull/6734
    - Scoped options (Pierre-Marie) https://github.com/coq/coq/pull/313

- 27/02/2018
  - SProp: a sort of definitionally proof irrelevant types (Gaëtan)
  - A Rusty Checker (Josh)
  - Brief discussion about UI plans for 8.8. [Emilio, 15mins]
  - https://github.com/coq/coq/pull/6676  attaching data to goals (Enrico) 15' explanation,
    see also: https://github.com/gares/ceps/blob/goal-w-state/text/000-proofview-goal-w-state.md
  - 14:00 PR discussions

Other PRs that need to be discussed (possibly around a computer)
----------------------------------------------------------



Other issues that need to be discussed (possibly around a computer)
-------------------------------------------------------------

- eq_true vs is_true #6012 
