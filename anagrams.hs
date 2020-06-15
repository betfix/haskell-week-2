import System.IO
import System.Random
import System.Random.Shuffle

main:: IO()
main = do
  let wordLength = 6
  let wordCount = 10
  content <- readFile "dictionary.txt"
  r1 <- randomIO
  r2 <- randomIO

  let randomWordsGenerator = mkStdGen r1
  let anagramGenerator = mkStdGen r2
  let filteredWords = filter (\x -> length x == wordLength) (lines content)
  let randomWords = take wordCount (shuffle' filteredWords (length filteredWords) randomWordsGenerator )
  putStrLn ("Guess " ++ (show wordCount) ++ " random English words " ++ (show wordLength) ++ "-characters long from their anagrams")
  putStrLn "To end the game at any time, type \"end\""

  loop randomWords 0 0 anagramGenerator

loop:: [String] -> Int -> Int -> StdGen -> IO()
loop randomWords wins fails generator = do
  let anagram = makeAnagram (head randomWords) generator
  putStrLn (anagram ++ " wins: " ++ (show wins) ++ " fails: " ++ (show fails))
  guess <- getLine

  let (isGuess, isEnd) = checkState guess randomWords
  let (wins', fails') = updateCounters (isGuess, isEnd) (wins, fails)
  if isEnd
    then putStrLn ("Game over. " ++ " wins: " ++ (show wins') ++ " fails: " ++ (show fails'))
    else loop (tail randomWords) wins' fails' generator

makeAnagram:: String -> StdGen -> String
makeAnagram word generator =
  shuffle' word (length word) generator

checkState:: String -> [String] -> (Bool, Bool)
checkState guess randomWords = (
  guess /= "end" && guess == head randomWords,
  guess == "end" || length (tail randomWords) == 0)

updateCounters:: (Bool, Bool) -> (Int, Int) -> (Int, Int)
updateCounters (isGuess, isEnd) (wins, fails) = (
  if (not isEnd) && isGuess then wins + 1 else wins,
  if (not isEnd) && (not isGuess) then fails + 1 else fails)
