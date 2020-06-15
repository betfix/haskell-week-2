# haskell-week-2
## Guess English words from their anagrams

In order to run the program, open command prompt and type:

`stack ghci --package random --package random-shuffle`

This runs haskell repl with two additional packages. Then type:

`:load anagrams.hs`
`main`

An example session looks like this:

```Prelude> :load anagrams.hs
[1 of 1] Compiling Main             ( anagrams.hs, interpreted )
Ok, one module loaded.
\*Main> main
Guess 10 random English words 6-characters long from their anagrams
To end the game at any time, type "end"
getdub wins: 0 fails: 0
budget
dernow wins: 1 fails: 0
wonder
ateneS wins: 2 fails: 0
Senate
ultser wins: 3 fails: 0
ulster
iverra wins: 3 fails: 1
arrive
ealver wins: 4 fails: 1
reveal
tusats wins: 5 fails: 1
end
Game over.  wins: 5 fails: 1
\*Main>
```
