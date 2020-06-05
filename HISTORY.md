v0.6 (jun/20)
-------------

- Added prefixes in chain names (`#` for public forums, `@` for public identities, and `$` for private groups).
- Removed `host` file (not needed anymore).
- Commands:
  - Removed `create` in favor of `start` passing directory and port.
  - Changed `chains join` to use the name prefixes.
  - Changed order of arguments in `chain` and `peer` (`chain <name> ...` and `peer <host> ...`).
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
