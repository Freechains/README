# Freechains: Comparison

- Two main contributions:
    - communication patterns with same API
    - reputation system

A number of systems have been proposed for content dissemination in a
distributed setting.
Here we will consider publish-subscribe middlewares, federated applications,
and fully peer-to-peer systems.

## Publish-Subscribe Middlewares

At the lowest level, there are the publish-subscribe middlewares (so called
*message brokers*), which are not full applications but assist decentralization
by decoupling publishers and subscribers in the end points.
Examples of *pubsub* systems include
    [XMPP](https://en.wikipedia.org/wiki/XMPP),
    [AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol),
    [WebSub](https://en.wikipedia.org/wiki/WebSub), and
    [ActivityPub](https://en.wikipedia.org/wiki/ActivityPub).

A key aspect of *pubsub* is that, although the end points communicate without
knowledge of each other, the brokers or servers in between them still have a
special role in the network.
They do authentication, validation, etc., and ultimately serve the queues (or
topics or feeds) that connect multiple producers and consumers.
Queues are location based and hence are not abstract enough to be fully
decentralized.

Increasing the number of servers, such as in federated pubsubs, does not change
the concept, because each queue is still independent of the others and has to
be stated explicitly.
This fact breaks the local-first property of fully peer-to-peer systems since
not all possible communication can be done alone in a local instance.
For instance, publishing and subscribing to the same ID in different servers
lead to different states overall.

Overall, the missing piece here are rules to merge independent queues, which is
required for example to express
[public `N <-> N` communication](chains.md#public-forum-chain).
Trying to synchronize servers in some way would lead to the exact same issues
that we are trying to address in Freechains: how to order messages across
servers, how to deal with excess and SPAM, how to deal with fake news and
illegal content, etc.

## Federated Protocols and Applications

In a federation, client identities are attached to a single server just like in
centralized systems, but servers can communicate in a standardized way to allow
communication across borders.
E-mail ([SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol)) is
probably the most popular federated protocol, allowing users from one domain to
exchange messages with users of other domains seamlessly.
More recently,
    [Diaspora](https://en.wikipedia.org/wiki/Diaspora_(social_network)),
    [Matrix](https://en.wikipedia.org/wiki/Matrix_(protocol)), and
    [Mastodon](https://en.wikipedia.org/wiki/Mastodon_(software))
    filled the domains of social media, chat, and microblogging services.

In federated systems, although all content can be managed locally (or recovered
from servers), identities are not portable.
If a server shuts down, or is banned by the rest of the federation (or
government), or if the user becomes unsatisfied with the local policy, she will
have to grab her content, move to another server, and announce her new identity
to followers.
In fully peer-to-peer systems like Freechains, the identity is controlled by
the user itself with public-key authentication, which can be used in any server
in the same way.
In Freechains users operate on [public identity chains](chains.md#public-identity-chain)
to disseminate their content to followers, which are also independent of
specific servers.

Moderation is also a major concern in federated applications.
As examples, messages crossing server boundaries may diverge from local
policies, and public identities may be target of SPAM.
Moderation can be applied locally by the user or in the servers in as
"one-size-fits-all solution".
In either case, the messages may still propagate in the network.
With no granularity for moderation actions or any form of consensus, it is
difficult to support public forums
([`N <-> N` communication](chains.md#public-forum-chain)) as also discussed
above.

These limitations seem to be acknowledged by Matrix and they have plans to
become more
    [decentralized](https://fosdem.org/2020/schedule/event/dip_p2p_matrix/)
and to support
    [moderation](https://matrix.org/docs/guides/moderation).

<!--
- abrubt policy changes since, although inter-communication follows a standard protocol
client-server are always under control of the server
    - an example in e-mail require auth in SMTP
-->

## Peer-to-Peer Systems

`TODO`

<!--
    - Structured Topology
    - Unstructured Topology

- Aether

a kind of proof of work
carefully thought to not receive a dislike
one could argue that a bot could pass this test
ok, as long as it contributes to the chain, no problem if a bot or human
turing test
-->

<!--
- https://github.com/w3c/activitypub/issues/328

https://news.ycombinator.com/item?id=17693565
 Yes but it unfortunatly completly ignores the topic of spam and moderation. So we will have another 10 years of experimenting at the expense of the users and the standard. And we may end up with some centralisation again like with email.
Still a great tech though. I just wish the authors would think about IRL and not just assume a perfect sphere in a frictionless vaccum.
-->

<!--
https://schub.wtf/blog/2019/01/13/activitypub-final-thoughts-one-year-later.html?utm_campaign=Real-time&utm_medium=email&utm_source=ProcessOne%20newsletter

What ActivityPub is
One of the most common misunderstandings about ActivityPub I see starts at the very simple question of what ActivityPub is, and what the SocialWG wanted it to be. To answer that, we should start by looking at the Social Web Working Group Charter, which basically is the document that describes the goals of that working group:

    a common JSON-based syntax for social data, a client-side API, and a Web protocol for federating social information

So basically, they want to build two things:

    a protocol used to exchange stuff between servers, and also between servers and clients; and
    a JSON’y syntax for representing social data
-->

<!--
https://cjslep.com/c/blog/an-activitypub-philosophy
I want to give an overview of a philosophy that I’ve adopted while working on ActivityPub. Succinctly: I view ActivityPub as a transport protocol that alone is not sufficient to build an application.
-->

<!--
https://schub.wtf/blog/2018/02/01/activitypub-one-protocol-to-rule-them-all.html
The “X-Follows-Y” contact model

With all the flexibility in both ActivityPub and AcitivtyStreams, I was really surprised to see a really fixed relationship model between actors. Users follow each other. Here, this has several implications. When Bob is following Alice, Alice will send all public activities (or all activities sent to all followers) to Bob, but Bob has no obligation to return something. While this model works fine for applications like Twitter, I do not think it is a good generic solution.
-->

## Other References:

- https://medium.com/@jaygraber/decentralized-social-networks-e5a7a2603f53
