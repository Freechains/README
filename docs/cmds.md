# Freechains: Command-Line Interface

```
freechains v0.4.x
Usage:
    freechains host create <dir> [<port>]
    freechains host start <dir>
    freechains [options] host stop
    freechains [options] crypto create (shared | pubpvt) <passphrase>
    freechains [options] chain join <chain> [trusted] [ [owner-only] <pub> ]
    freechains [options] chain genesis <chain>
    freechains [options] chain heads <chain> (all | linked | blocked)
    freechains [options] chain get <chain> (block | payload) <hash>
    freechains [options] chain post <chain> (file | inline | -) [<path_or_text>]
    freechains [options] chain (like | dislike) <chain> <hash>
    freechains [options] chain reps <chain> <hash_or_pub>
    freechains [options] chain remove <chain> <hash>
    freechains [options] chain traverse <chain> (all | linked) <hashes>...
    freechains [options] chain listen <chain>
    freechains [options] chain (send | recv) <chain> <host:port>

Options:
    --help              [none]            displays this help
    --version           [none]            displays version information
    --host=<addr:port>  [all]             sets address and port to connect [default: localhost:8330]
    --sign=<pvtkey>     [post|(dis)like]  signs post with given private key
    --crypt=<key>       [get|post]        (de|en)crypts post with given shared or private key
    --why=<text>        [(dis)like]       reason for the like or dislike

More Information:

    http://www.freechains.org/

    Please report bugs at <http://github.com/Freechains/jvm>.
```

Except for `host create` and `host start`, all other commands accept an
optional host to use:

- `--host=<addr:port>`: `[optional]` use daemon running at given address and port  (default: `localhost:8330`)

## Host

### `host create`

Prepares a local directory to host a Freechains node.

```
freechains host create <dir> [<port>]
```

- `<dir>`: path to a local directory to create
- `<port>`: `[optional]` alternative listening port (default: `8330`)

- Examples:

```
freechains host create /var/freechains
freechains host create /tmp/freechains 8331
```

### `host start`

Starts a deamon to serve in the given directory.

```
freechains host start <dir>
```

- Examples:

```
freechains host start /var/freechains
freechains host start /tmp/freechains
```

- `<dir>`: path to local directory to serve

### `host stop`

Stops a running deamon.

```
freechains [options] host stop
```

- Examples:

```
freechains host stop
freechains host stop --host=localhost:8331
```

## Crypto

### `crypto create`

Creates symmetric and asymmetric cryptographic keys.

```
freechains [options] crypto create (shared | pubpvt) <passphrase>
```

- `(shared | pubpvt)`
    - `shared`: creates a symmetric key to encrypt posts
    - `pubpvt`: creates a pair of public/private keys to sign and encrypt posts
- `<passphrase>`: password to generate keys deterministically

- Examples:

```
freechains crypto create shared "My very strong password"
freechains crypto create pubpvt "My very strong password"
```

## Chain

### `chain join`

Prepares host to serve a chain.

```
freechains [options] chain join <chain> [trusted] [ [owner-only] <pub> ]
```

- `<chain>`:    name of the chain (must begin with `/`)
- `trusted`:    `[optional]` all peers are trusted, blindly accept all blocks
- public identity: `[optional]` chain serves a public identity
    - `owner-only`: `[optional]` only owner can post in the chain
    - `<pub>`: public key of the chain owner

- Examples:

```
freechains chain join /
freechains chain join /sports
freechains chain join /obama B2853F4570903EF3ECC941F3497C08EC9FB9B03C4154D9B27FF3E331BC7B6431
freechains chain join /friends trusted
freechains chain join /cnn owner-only C1733F457A90DEF3ECC941F349DCA8EC9FB9CA3C41D4D9B27FF3EDD1CC3B6431
```

### `chain genesis`

Gets the genesis block for the chain.

```
freechains [options] chain genesis <chain>
```

- `<chain>`: name of the chain

- Examples:

```
freechains chain genesis /
```

### `chain heads`

Gets the hash of the heads in the chains.

```
freechains [options] chain heads <chain> (all | linked | blocked)
```

- `<chain>`: name of the chain
- `(all | linked | blocked)`
    - `all`:     gets all heads
    - `linked`:  gets only heads linked (accepted or hidden) in the chain
    - `blocked`: gets only heads blocked in the chain

```
freechains chain heads / all
freechains chain heads /mail blocked
freechains chain heads /sports linked
```

### `chain get`

Gets the block with the given hash.

```
freechains [options] chain get <chain> (block | payload) <hash>
```

- `<chain>`: name of the chain
- `(block | payload)`
    - `block`:   gets information about the block
    - `payload`: gets the actual message in the block
- `<hash>`:  hash of the block to get
- `--crypt=<key>`: decrypts post with given shared or private key

- Examples:

```
freechains chain get / block 1_CAC69BBC21388FA75F808B9AF0D652D059DEFF49FEE6B2E7E432C3F6DFD72C7A
freechains chain get /trusted-friends payload 2_CBBBE2CB4... --crypt=<shared-key>
```

### `chain post`

Posts a new block in the chain.

```
freechains [options] chain post <chain> (file | inline | -) [<path_or_text>]
```

Freechains only accepts posts in `UTF-8`.
Binary files must be encoded as text with `uuencode` or `base64`, for example.

- `<chain>`: name of the chain
- (file | inline | -)
    - `file`:   post contents of given file
    - `inline`: post given text
    - `-`:      post contents from standard input
- `<path_or_text>`:  `[file | inline]` file name or text to post
- `--sign=<pvtkey>`: `[optional]`      signs post with given private key
- `--crypt=<key>`:   `[optional]`      encrypts post with given shared or private key

- Examples:

```
freechains chain post / inline "Hello World!"
freechains chain post /chat inline "Message from myself!" --sign=<my-pvtkey>
freechains chain post /some-person inline "Crypted message from myself!" --crypt=<some-person-pubkey> --sign=<my-pvtkey>
freechains chain post /trusted-friends inline "Crypted message to my friends" --crypt=<shared-key>
echo "Hello World!" | freechains chain post / -

uuencode mypic.jpg mypic.jpg > mypic.uu
freechains chain post /mychain file mypic.uu --sign=<my-pvtkey>
```

### `chain (like | dislike)`

Likes or dislikes block in the chain.

```
freechains [options] chain (like | dislike) <chain> <hash>
```

- `(like | dislike)`
    - `like`:    likes    given block
    - `dislike`: dislikes given block
- `<chain>`: name of the chain
- `<hash>`:  hash of the block to (dis)like
- `--sign=<pvtkey>`: signs (dis)like with given private key
- `--why=<text>`:    `[optional]` reason for the like or dislike

- Examples

```
freechains --sign=<my-pvtkey> --why="Very funny" like /jokes 3_51C7BD...
freechains --sign=<my-pvtkey> dislike / 4_29A673...
```

### `chain reps`

Gets the reputation of post (block hash) or author (public key).

```
freechains [options] chain reps <chain> <hash_or_pub>
```

- `<chain>`: name of the chain
- `<hash_or_pub>`
    - `<hash>`: hash of block
    - `<pub>`:  public key of author

- Examples:

```
freechains chain reps / 4_29A673...
freechains chain reps / B2853F45...
```

### `chain remove`

Removes blocked block laying in the host.

```
freechains [options] chain remove <chain> <hash>
```

- `<chain>`: name of the chain
- `<hash>`:  hash of the block to remove

Freechains limits the number of blocked blocks in the host to prevent excess.
Blocks that are not accepted should be removed by hand after some period.

- Examples:

```
freechains chain remove / 6_A56F33...
```

### `chain traverse`

Traverses and gets the hashes of a sub-tree of blocks in the chain.
Starts from the heads and traverses down to the given block hashes (excluded).

```
freechains [options] chain traverse <chain> (all | linked) <hashes>...
```

- `<chain>`: name of the chain
- `(all | linked)`
    - `all`:    traverses all blocks
    - `linked`: traverses only linked blocks
- `<hashes>...`: list of hashes to stop traversing

The given hashes are typically the previous heads in the chain that were
already processed by an application.
To process new blocks in the chain, these old heads are used to stop the
traversal.

- Examples:

```
freechains chain traverse / all /1_CAC69B...
freechains chain traverse / linked /2_CBBBE2... /3_D3DB32...
```

### `chain listen`

Listens for incoming blocks in the given chain.

```
freechains [options] chain listen <chain>
```

- `<chain>`: name of the chain

The command never terminates and outputs the hash of new blocks as they arrive.

- Examples:

```
freechains listen /
```

### `chain (send | recv)`

Synchronize the given chain with a remote peer.

```
freechains [options] chain (send | recv) <chain> <host:port>
```

- `<chain>`: name of the chain
- `(send | recv)`
    - `send`: sends   missing blocks to   remote peer
    - `recv`: receive missing blocks from remote peer
- `<host:port>`: remote host to synchronize

A `send` started in host `A` passing host `B` is equivalent to a
  `recv` started in host `B` passing host `A`.

- Examples:

```
freechains chain send / 10.1.1.2
freechains --host=10.1.1.2 chain recv / 10.1.1.1
```
