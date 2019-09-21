# minou

A scheme like language that is compiled on the fly with LLVM.  It is not intended to be in any way standards compliant but should be familiar.

| Features / Limitations | Status / Comment                     |
|------------------------|--------------------------------------|
| Garbage Collection     | works but no stack walking right now |
| Cons cells             | works on the normal lists            |
| Tagged atoms           | for symbols, booleans, integers      |
| Native code generation | uses LLVM and no intrepreter         |
| 64 bit targets only    |                                      |
| Macros                 | need tests                           |
| Closures               | with escape analysis as well         |


| Things I want to do                                   |
|-------------------------------------------------------|
| stack walking gc                                      |
| threads                                               |
| compile helper functions to llvm bitcode for inlining |
| remove some of the globals that creeped in            |
| async io                                              |
| exceptions                                            |
| unwind-protect                                        |
| benchmark / profile                                   |
| delimited continuations                               |
| finish a simple standard library                      |






[![Build Status](https://travis-ci.org/ibawt/minou.svg?branch=master)](https://travis-ci.org/ibawt/minou)
