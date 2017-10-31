This page is the current synthesis of discussions started in PR #6036 and issue #6046.

The radio button "Approve":
- does not mean the end of discussion
- is an indication that one took time to study the code and that one is basically OK with
it (modulo comments and requests for changes that come with the review)
- does not imply that the reviewer has "certified" the code and that the code is absolutely correct
- is a bit like the signed-off-by used in other projects, that is to say, an informal "looks good to me".

It might cover:
- an approval of relevance
- an approval of the chosen implementation
- an approval of the correctness of the code
- an approval of the efficiency
- an approval of the quality of documentation

It is good to indicate in the review:
- what parts have been reviewed more thoroughly and what parts at a more superficial level
- where the author is being trusted on the details
- when further comments from others are requested if the reviewer is unsure about something
- the conditions to which the approval is given, if any
- whether further interaction with the author is requested

The goal of reviewing is to improve quality and mutual awareness by providing feedback. For instance, authors of PRs are invited to tell if they feel unsure with some parts of their code and that they'd like the reviewers to put special care at looking at these parts.

Role of the "review" as a communication tool between the authors/reviewers and the persons in charge of committing the PRs to the main branches:
- to be detailed

**EJGA:** Also doing a review works as a kind of "thank you" to the original author, maybe because you wanted the proposed change to happen.