import Foundation

func recursiveSlowWork(_ n: Int) -> Int {
    if n <= 1 { return n }
    return recursiveSlowWork(n - 1) + recursiveSlowWork(n - 2)
}
