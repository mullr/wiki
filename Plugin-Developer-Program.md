_[warning, this is an in-progress draft and not meant for public consumption]_

## The Coq Plugin Developer Program

The Coq Plugin Developer Program (CPDP) aims to improve the status of
3rd-party plugins in the Coq ecosystem. To that purpose, 3rd-party
plugin developers are encouraged to sign-up for the program, by doing
so they can enjoy the following benefits:

- use a badge in their project page "part of the Coq Plugin Developer Program",
- if desired, the plugin can be distributed with Coq itself on releases,
- extended support and testing.

On their side, the Coq project ask authors willing to join the program to:

- be reasonably reactive with maintenance,
- maintain a version of the plugin that be compiled against `Coq` master (*),
- implement developers feedback on recommended Coq API practices.

(*) Joining the program means that 3rd party plugin developers get
    extended assistance and patches from the Coq team in order to keep
    their development current.

In order to apply for the program, 3rd party developers must submit an
issue to the Coq's issue tracker, describing their plugin and
mentioning any question that they think relevant. Note that as the
process is basically in beta-stage, we expect to be quite flexible
with the first submissions.

### Application Process
The application process consists of two parts:

- initial application, questions and discussion about the plugin and its role in Coq,
- integration in the CI system / code review / compliance of recommended practices.

Once everybody is happy with the state of the plugin and the
integration within Coq infrastructure, the plugin is officially part of the CPDP!

### What the CPDP does not mean.

Joining the CPDP does not mean that:

- the Coq development team will perform any judgment over the purpose
  or utility of your plugin,
- the Coq development team will be allowed to influence features or
  directions on your development
- that you have to host your plugin in Coq's infrastructure.

Again, the primary purpose of the program is to ensure that 3rd party
developers have having a smooth experience developing on top of the
Coq platform.
