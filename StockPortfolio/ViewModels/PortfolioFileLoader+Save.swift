import Foundation

extension PortfolioFileLoader {
    /// Persists the portfolio weights. This implementation stores a [String: Double]
    /// dictionary in UserDefaults under a fixed key. It complements `load()` which
    /// should read from the same source or provide defaults if missing.
    static func save(_ weights: [String: Double]) {
        let key = "PortfolioWeightsStorageKey"
        UserDefaults.standard.set(weights, forKey: key)
    }
}
