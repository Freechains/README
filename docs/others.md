# Freechains: Comparison

*(If any information here is innaccurate, please open an issue.)*

Many other systems have been proposed for content dissemination in a
distributed setting.
Here we will consider publish-subscribe middlewares, federated applications,
and fully peer-to-peer systems.

## Publish-Subscribe Middlewares

Publish-subscribe middlewares (aka *message brokers*) assist the development of
decentralized applications by decoupling publishers and subscribers at the end
points.
Examples of *pubsub* systems include
    [XMPP](https://en.wikipedia.org/wiki/XMPP),
    [AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol),
    [WebSub](https://en.wikipedia.org/wiki/WebSub), and
    [ActivityPub](https://en.wikipedia.org/wiki/ActivityPub).

A key aspect of *pubsub* is that, although the end points communicate without
knowledge of each other, the brokers or servers in between them still have a
special role in the network.
As examples, they might do authentication and validation of posts, and
ultimately serve the queues (aka topics or feeds) that connect multiple
producers and consumers.
However, queues are location based and hence are not abstract enough to be
fully decentralized.

Increasing the number of servers, such as in federated pubsubs, does not change
the underlying foundation, because each queue is still independent and has to
be stated explicitly in client actions.
This fact breaks the local-first property of peer-to-peer systems since not all
possible kinds of communication can be done alone in a local instance.
For instance, subscribing to the same identity in different servers does not
mean the same thing (i.e., they refer to different feeds).

Overall, the missing piece here are rules to merge independent queues, which is
required for example to express
public [`N<->N`](chains.md#public-forum-chain) content dissemination.
Trying to synchronize servers in some way would lead to the exact same issues
that we are trying to address in Freechains: how to order and relate messages
across servers, how to deal with excess and SPAM, how to deal with fake news
and illegal content, etc.

## Federated Protocols and Applications

In federated protocols, client identities are attached to a single server just
like in centralized systems, but servers can communicate in a standardized way
to allow communication across borders.
E-mail ([SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol)) is
probably the most popular federated protocol, allowing users from one domain to
exchange messages with users of other domains seamlessly.
More recently,
    [Diaspora](https://en.wikipedia.org/wiki/Diaspora_(social_network)),
    [Matrix](https://en.wikipedia.org/wiki/Matrix_(protocol)), and
    [Mastodon](https://en.wikipedia.org/wiki/Mastodon_(software))
filled the domains of social media, chat, and microblogging under federations.

In federated systems, although all content can be managed locally (or recovered
from servers), identities are not portable.
It is possible that a server shuts down, or is banned by the rest of the
federation (or government), or the user becomes unsatisfied with the local
server policy.
In any of these cases, the user will have to grab her content, move to another
server, and announce her new identity to followers.
In peer-to-peer systems like Freechains, the identity is controlled by the user
itself with public-key authentication, which can be used in any server in the
same way.
<!--
In Freechains users operate on
    [public identity chains](chains.md#public-identity-chain)
to disseminate their content to followers, which are also independent of
specific servers.
-->

Moderation is also a major concern in federated applications.
As examples, messages crossing server boundaries may diverge from local
policies, and identities may be target of SPAM.
Moderation can be applied locally by the user or in servers as a
one-size-fits-all solution.
In either case, the messages may still propagate in the network.
With no granularity for moderating actions or no form of consensus, it is
difficult to support public forums
([`N<->N`](chains.md#public-forum-chain) communication) as discussed in the
previous section.

These limitations with identities and moderation seem to be acknowledged by
Matrix and they have plans to become more
    [decentralized](https://fosdem.org/2020/schedule/event/dip_p2p_matrix/)
and to support
    [moderation](https://matrix.org/docs/guides/moderation)
more extensively.

As a counterpoint, federated protocols seem to be more appropriate for
stream-based real-time applications such as chats and streaming with a large
number of small messages.
The number of hops and header overhead can be much smaller in client-server
architectures in comparison to peer-to-peer systems which typically include
message signing, hash linking, and extra verification rules.

## Peer-to-Peer Systems

In peer-to-peer systems all nodes in the network have the same role, i.e.,
there are no distinctions between clients and servers.
The peers communicate directly and cooperate satisfying a protocol to achieve a
goal, e.g., maintaining a financial public ledger or simply allowing people to
communicate freely.
[Bitcoin](https://en.wikipedia.org/wiki/Bitcoin) is probably the most
successful peer-to-peer network but serves the very specific functionality of a
digital currency.
[Scuttlebutt](https://en.wikipedia.org/wiki/Secure_Scuttlebutt) and
[Aether](https://github.com/nehbit/aether) cover people's communication for
friends and groups, respectively.
[IPFS](https://en.wikipedia.org/wiki/InterPlanetary_File_System) and
[Dat](https://en.wikipedia.org/wiki/Dat_(software)) are more data centric
systems for hosting large files and applications, respectively.

IPFS is centered around immutable content-addressed data, while Dat around
mutable pubkey-addressed data.
IPFS is more suitable to share large and stable content such as movies and
archives, while Dat is more suitable for dynamic content such as
[web apps](https://en.wikipedia.org/wiki/Beaker_(web_browser)).
Both IPFS and Dat use
[DHTs](https://en.wikipedia.org/wiki/Distributed_hash_table)
as their underlying architecture, which are optimal to serve large and popular
content, but not for search and discovery.
In both cases, users need to know in advance what they are looking for, such as
the exact link to a movie or a particular identity in the network.
DHTs are probably not the best architecture to model decentralized people's
communication with continuous updates on content with semantic relationships.
The other systems that we discuss as follows do not use DHTs.

Bitcoin provides a very strong property that messages in the network are
ordered and that this order is the same in all hosts, thus reaching global
consensus.
This property is also relevant in the context of people's communication since a
conversation can be thought as an ordered list of messages.
Bitcoin uses a proof-of-work consensus algorithm that is immune to attacks such
as SPAM and forged identities (Sybil attacks), which is also fundamental to be
prevented in the context of content dissemination.
However, proof-of-work is very expensive and, in practice, control of the
network remains in the hands of a few peers, affecting the intended
decentralization of the system.
Freechains uses its [reputation system](reps.md) to prevent SPAM and Sybil
attacks which is a kind of proof or work, but for humans.
An author has to "work" to post content of quality which is evaluated by other
humans.
The main advantage is that the actual work is not arbitrary and contributes
more directly to the system itself.

From all systems discussed, Scuttlebutt and Aether are those with more
similarities with Freechains, and focus on `1->N` and `N<->N` public
communication, respectively.

Scuttlebutt is designed around public identities that follow each other to form
a graph of connections which is also replicated in the topology of the network
and data storage.
For instance, if identity `A` follows identity `B`, then the computer of `A`
will (1) connect to the computer of `B` directly and (2) store all posts of `B`
locally.
The relationships are asymmetric, which allows `B` to not follow `A` in the
given example.
Freechains is designed around chains (topics), but since chains can owned by a
[public identity](chains.md#public-identity-chain), it is possible to provide a
similar behavior.
The network topology of Freechains also relies on
[friend-to-friend](https://en.wikipedia.org/wiki/Friend-to-friend) connections,
but currently must be built outside the protocol (e.g., scripted by hand).

For group `N<->N` communication, Scuttlebutt uses the concept of channels,
which are actually hash tags, e.g. `#sports`.
Users can tag posts with channels, which appear not only on their feeds but
also in "virtual feeds" representing channels.
However, users only see posts from users they already follow.
In practice, channels just merge friends posts and filter them by tags, which
again illustrates how Scuttlebutt is designed around public identities.
In theory, to read all posts of a channel, a user would need to follow (which
also implies storing feeds) of all users in the network.
For this reason, new users may not integrate easily in the community because
they depend on other users to follow them back, which costs bandwidth, space,
and extra noise to the follower .
Without being followed back, new users have no visibility in the system at all.
As a counterpoint, assuming users behave more or less the same in different
groups, Scuttlebutt is barely susceptible to abuse.
Since Freechains is designed around chains (channels), content discovery is
much easier, since new users become visible with a single like from the
community.
In addition, following a chain requires to store posts of that chain only, not
of their users, which can still be followed individually on their own `1->N`
public chain.

Aether provides peer-to-peer public communities being more aligned with the
`N<->N` public communication of Freechains.
Posts are replicated in the network but are ephemeral in the sense that their
storage is limited within a time window.
Aether requires authors to proof-of-work their posts in order to prevent SPAM
in communities.
Also, each community relies on continuous elections for moderators to prevent
abusive behavior.
Users can also choose their own moderators individually leading to different
views of the communities.
*(It is not clear if removed content is still stored locally to reach other nodes).*
The quality of posts can be distinguished by upvotes and downvotes.
Aether employs a very pragmatic approach to confront the threats of `N<->N`
communication, using established techniques such as proof-of-work to combat
SPAM and post rating to highlight good content, and also an innovative voting
system to combat abuse.
Freechains tries to address these threats with (and only with) its reputation
system.
Reputation is a scarce resource handled autonomously by the protocol rules and
has to be used wisely inside each chain to accept new users, combat abuse, and
highlight content of quality.

## Freechains

As described in the [landing page](../README.md), Freechains has two particular
features:

- Multiple flavors of public and private communication (`1->N`, `1<-N`, `N<->N`, `1<-`)
- Per-topic reputation system for healthiness

Freechains is designed around a [minimum API](../README.md#basics):
    a `join` command to follow chains of groups and individuals,
    a `post` command to publish content into a chain (optionally with end-to-end encryption),
    a `get` command to read posts of a chain, and
    a `traverse` command to iterate on a chain to discover content.
A [public identity chain](chains.md#public-identity-chain) behaves more like
Scuttlebutt, since only its owner may be allowed to post.
Following users is also asymmetric, so it's possible to build diverse social
graphs in the same way as Scuttlebutt.
A [public forum chain](chains.md#public-forum-chain) relies on the reputation
system and behaves more like Aether, since users receive posts from other users
they do not necessarily follow.
Freechains also supports [private group chains](...) that circulates messages
among trusted peers only.

The [reputation system](reps.md) tracks the quality of posts and authors inside
each chain.
It aims to (1) combat excess by restricting the number of posts, (2) highlight
content of quality with likes, and (3) combat SPAM, fake news, and illegal
content by demanding reputation to post and by removing posts when their
likes/dislikes ratio is too negative.
However, it is a system that has never being put into practice, so its
effectiveness is yet to be proven.

Freechains also has some inherent limitations.
Posts are restricted in size (currently 128kb) and each peer holds up to 10
posts from new users waiting for approval.
This is to prevent denial of service by flooding peers with posts without
reputation.
For large blobs, users may break messages in parts or use links such as for
IPFS addresses.
Peers also must hold the full tree of posts locally to be able to validate them
and track their reputation.
This imposes computational and storage costs.
Although it's possible to limit the validity of posts and prune trees as time
goes, full persistence is still conceptually at the core of the protocol.
Validation also requires large headers in posts for the back links and
signatures.
All these overheads combined may affect the viability of the system in
real-time applications such as chats and streaming which would benefit of a
more "fire and forget" approach.
A not inherent current limitation is that the protocol does not verify if peers
are actually validating and storing the actual chains.
This would allow *freeriders* to abuse the network.
We believe it's not hard to integrate some kind of proof of storage (e.g., ask
the contents of some previous post) or integrate peer accountability in the
reputation system.

## Other Links:

- Decentralized Social Networks:
    - https://medium.com/@jaygraber/decentralized-social-networks-e5a7a2603f53
- IPFS and Dat:
    - https://medium.com/decentralized-web/comparing-ipfs-and-dat-8f3891d3a603
- Aether:
    - https://getaether.net/docs/
    - https://www.youtube.com/watch?v=A9zL2csO7t8&t=1105s
    - https://getaether.net/docs/faq/voting_and_elections/
- Matrix:
    - https://matrix.org/docs/guides/moderation
    - https://www.youtube.com/watch?v=AlndCl30OyI
