# Freechains: Reputation System

In Freechains, each chain is controlled by an autonomous reputation system that
receives input from users (authors) with likes and dislikes to posts.
The reputation system tracks the reputation of posts and authors in the chain.
Each chain is independent, so the reputation of a given author may vary across
chains.
The unit of reputation is known as *rep* and can be created, spent, and
transferred in many ways:

- Create:
    - The first post in the chain accounts *+30 reps* to its author.
    - A post older than 24h, aka *consolidated post*, accounts *+1 rep* to its author.
- Spend:
    - A post younger than 24h, aka *new post*, accounts *-1 rep* to its author.
- Transfer:
    - A like    from author `A` to post `P` with author `B` accounts *-1 rep*
      to `A` and *+1 rep* to `B`.
    - A dislike from author `A` to post `P` with author `B` accounts *-1 rep*
      to `A` and *-1 rep* to `B`. If a post reaches *5 dislikes* and twice as
      many dislikes as likes, its content becomes hidden in the chain.

- Additional rules:
    - Peers trying to synchronize a chain with different first authors never
      succeed.
    - A new post requires previous reputation from the author or at least one
      like from other authors.
      Therefore, posts from new users are initially rejected, until they get a
      like from an author with reputation.
    - A like or dislike also requires previous reputation from the author.
    - An author is limited to *+30 reps*.
    - At most one consolidated post accounts per day: if an author has 10
      consolidated posts in the past 7 days, s/he will get *+7 reps*.
    - For any of the rules, only posts younger than 90 days are considered.

- Special cases:
    - In a [public identity chain](chains.md#TODO), its owner has infinite
      reputation. Other users might be allowed to post or not. If allowed, they
      follow the general rules above.
    - In a [private group chain](chains.md#TODO), all users have infinite
      reputation.

See also the command-line interface for
    [likes and dislikes](cmds.md#chain-like--dislike) to posts
    and to [check the reputation](cmds.md#chain-reps) of posts and authors.

## Design Goals

The reputation system of Freechains aims to preserve in a chain its quality of
contents and fairness among authors.

The quality of posts is subjective and is up to users to judge with likes,
dislikes or simply abstaining.
A user can dislike a post for a number of reasons, such as for considering it
offensive, SPAM, fake, illegal, or even for disagreement.
On the one hand, since likes and dislikes are finite (i.e., they spend
reputation), users have to ponder before using them.
On the other hand, reputation also expires after a few months, so users have
incentives to cooperate with the quality of the chain.
The contents of a post can be hidden if the number of dislikes is much higher
than the number of likes.
This rule is not intended to eliminate disagreements of opinion, but only to
ban malicious users (e.g. a *troll*, *spammer*, or *abuser*).
The excess of dislikes will not only hide a post, but also consume the
reputation of its author to the point that s/he cannot post again.

We consider that in a fair chain, users have equal opportunities to speak, or
at least that the amount of noise is limited.
Freechains restricts the number of posts in two ways: first, new posts penalize
authors for their first 24 hours; second, at most one post per day can generate
reputation for an author.
The first rule prevents that an author posts too many messages in sequence at
the cost of decreasing its reputation too fast.
The second rule limits the amount of reputation the user can collect over time,
which also affects the frequency in which users post.
These rules mostly apply to neutral posts that do not receive much attention
from other users with likes and dislikes.
However, if a given author receives a lot of likes in her posts, it means that
the other authors are conceding their own voices to the author.
Similarly, a dislike means that the other authors are conceding their own
voices to mute the author.

The bootstrap of chains is also a situation that deserves clarification.
At the beginning, only the author of the first post has reputation.
Since new posts require previous reputation, no other author can post in the
chain unless the first author approves it.
After some time, other authors can self-approve their own posts and build up
reputation.
However, the first author can still interfere early in the process with enough
dislikes to clear someone else's reputation at the point of banning.
The early dynamics of a chain determines how the community evolves, since new
users can inspect the actions of the first author and authors that emerge with
reputation.
Ultimately, users can always recreate or join chains that better adhere to
their principles.

The size of the "economy" of each chain is its amount of consolidated posts.
Likes and dislikes only transfer reputation between authors, and the initial
reputation for the first author becomes negligible as time goes.
The number of accountable consolidated posts is also limited to at most one per
day per author.
Hence, the size of the economy highly depends on the number of active authors
in the chain.
This mechanism creates incentives to welcome new users to participate and post
in the chain.
In contrast, this mechanism also disincentives authors to dislike posts, since
they drain *2 reps* into the void.
On the one hand, we believe that this fact contributes to sustain healthy
discussions with a reasonable degree of disagreement, otherwise the economy of
chains would collapse with an outbreak of dislikes.
On the other hand, clear undesired content like SPAM is rapidly eliminated,
along with its author, with a few dislikes that does not affect the economy.

## Scenarios

`TODO`

<!--
- uber
- mercado livre
- homogeneous group
- heterogeneous group
- news site
-->
