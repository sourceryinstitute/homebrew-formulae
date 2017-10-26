Sourcery Institute Homebrew Tap
===============================

This repository is the official [Sourcery Institute] [Homebrew] tap, containing formulae
that either do not meet the popularity requirement to be included in [homebrew-core] or
are built with a non-default toolchain (i.e. [MPICH] and GCC instead of Clang).

Getting started
---------------

To have access to formulae in this tap, but not in [homebrew-core] by default run:

```
brew tap sourceryinstitute/formulae
```

If you want to prioritize the installation of formulae from this tap over [homebrew-core]
([Homebrew]'s default package repository) when packages are provided by both, then run:

```
brew tap-pin sourceryinstitute/formulae
```

To revert back to prioritizing [Homebrew] packages run

```
brew tap-unpin sourceryinstitute/formulae
```

Forulae (a.k.a. packages) in this tap
-------------------------------------

 - [PSBLAS]
 - [MLD2P4]

[Sourcery Institute]: http://www.sourceryinstitute.org
[Homebrew]: https://brew.sh
[homebrew-core]: https://github.com/homebrew/homebrew-core#readme
[MPICH]: http://www.mpich.org/
[PSBLAS]: https://github.com/sfilippone/psblas3#readme
[MLD2P4]: https://github.com/sfilippone/mld2p4-2#readme
