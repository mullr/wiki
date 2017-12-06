This page is used to organize the next Coq Working Group (in French GT Coq). The framadate link to decide which day it will happen is:

> <https://framadate.org/O5oIlfR6mEKS2OU9>

Organization
------------

The next Coq Working Group will take place on December 18th and 19th at Inria Paris (2, rue Simone Iff). The room for the two days is Salle Philippe Flajolet, Building C, 1st floor. For non-Inria participants, due to security measures, we need to announce the list of participants in advance, so please write your name here if you intend to participate or send an email to [matthieu.sozeau@inria.fr](mailto:matthieu.sozeau@inria.fr) with your name at least the day before.

Streaming and recorded video will be available on Coq's [YouTube channel](https://www.youtube.com/channel/UCbJo6gYYr0OF18x01M4THdQ)

Topics
------

- Attributes (Maxime, 30 min)
- Integers and arrays (Maxime, 30 min)
- API (Emilio, 45 min - 1h)
- Status of the Coqlib rebindable PR (#186) (Emilio, 30 min)
- Plugin Developer Program (Emilio, 30 min)
- Report on performance testing with OExp (Emilio, 45 mins)
- Equations & the Function replacement plan (Matthieu, Cyprien, Thierry, 45 min)
  + as [pat|..|pat] / as '(x, y, z) intropatterns (15 min)
- A presentation of TLC 2.0 (covering library design, not tactics) (Arthur, 45min + questions)
- Evaluation inside Coq with non-constructive recursive definitions (Arthur, 20 min)
- Coq Meetup [Théo, Emilio] (15 min)

PRs that need to be discussed (possibly around a computer)
----------------------------------------------------------

From oldest to most recent:
- https://github.com/coq/coq/pull/313 (Scoped options) Emilio suggests that this needs to be discussed with a small group, around a computer.
- https://github.com/coq/coq/pull/400 (Reducing temporary allocations in CClosure) Pierre-Marie needs to convince Guillaume of the importance of his patch, and Emilio that this has nothing to do with Flambda.
- https://github.com/coq/coq/pull/616 (Make some keywords into normal idents) Gaetan will lead the discussion (last time this was discussed, he was not here).
- ...
- https://github.com/coq/coq/pull/1003 (intros '(x,y)) The debate is about "syntactic pollution". I guess the people that are rather against the merge of this PR (Pierre-Marie, Maxime) should explain their viewpoint.
- https://github.com/coq/coq/pull/1136 (dir-locals)