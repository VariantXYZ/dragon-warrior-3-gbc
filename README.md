This is a disassembly project of Dragon Warrior 3 for the Game Boy Color.

# Building

The master branch is focused on extracting components of the game and making sure that the rebuilt output is identical to the originals.

Remove or comment out the 'cmp -l' line in the Makefile to do stuff.

## Dependencies

* Dragon Warrior 3 US ROM (sha1 581a12695ae42becaa078ac2694a11767a96dc61)
* Make 4 or greater
* Python 3.6 or greater, aliased to 'python3'
* [rgbds toolchain](https://github.com/rednex/rgbds) v0.4.2 or greater

## Make

1. Name the original ROM 'baserom_en.gbc'
1. Place the renamed ROMs into the root folder of the project
1. Execute make (optionally pass -j to speed up the build)
1. dq3_en.gbc will be generated in the root folder along with a symbol and map file

# Dumping

1. Execute make dump (optionally with -j)
1. Ideally, no changed files should appear as they're all checked in