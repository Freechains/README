v0.8 (mar/21)
-------------

- Reputation system redesigned: consensus based on reputation.
- Support for binary files.
- Support for big files, except in public chains.
- Users can revoke own posts with single dislike.
- Public chains have a *pioneer* public key on join (substitutes first block).
- Small changes in the command-line interface (`join`,`heads`,`get`,`traverse`).
- Single source repository `freechains.kt` (substitutes multiple repos).
- Changes in the internal structure of blocks (`local`,`prev`).

v0.7 (jul/20)
-------------

- Split command-line interface in two commands: `freechains-host` to
  start/stop the host and `freechains` for all other commands.
- Added `freechains-sync` tool to manage peers/chains automatically in multiple
  hosts.
- Split github project: `android`, `cli`, `common`, `host`, `store`, `sync`, `tests`.

v0.6 (jun/20)
-------------

- Added prefixes in chain names (`#` for public forums, `@` for public identities, and `$` for private groups).
    - `@!` if only owner can write
    - `$` requires a shared key on `join`
- Removed `host` file (not needed anymore).
- Commands:
  - Removed `create` in favor of `start` passing directory and port.
  - Changed `chains join` to use the name prefixes and accept shared key.
  - Changed order of arguments in `chain` and `peer` (`chain <name> ...` and `peer <host> ...`).
  - Changed `--crypt` to `--encrypt`/`--decrypt` and only for `@` chains (`$` chains always encrypt).
- Internal changes in the protocol: single lines commands and arguments order.
- Improved many error messages.

v0.5 (jun/20)
-------------

- New set of `peer` commands: `ping`, `chains`, `send`, `recv` (`send`/`recv` removed from `chain`).
- New set of `chains` commands: `join`, `leave`, `list`, `listen` (`join` removed from `chain`).
- Changed local file system structure to avoid directory hierarchy: internally, `/` is substituted by `_`.

v0.4 (may/20)
-------------

- Block payload is now saved in a separate file.
- Command `get` now requires `block` or `payload` argument.
- Bug fix: `heads` calculation.
- Bud fix: `listen` timeout.
- Bud fix: `send` blocked blocks.

v0.3 (apr/20)
---------------

- (no history)
