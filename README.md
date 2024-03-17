# Lexorank


## About
Reorder your dynamically sized list without updating the whole collection.

## Usage

```swift
...
let rank = LexoRank()

let sourceList = [
  "aaaaaa",
  "aaabbb"
]

let newRank = rank.order(sourceList[0], sourceList[1])
// expected, "aaaaab"
```

## Links
- https://tmcalm.nl/blog/lexorank-jira-ranking-system-explained/

