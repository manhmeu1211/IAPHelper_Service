import StoreKit

public extension SKProduct {

    var localizedPrice: String? {
        return priceNumberFormatter.string(from: price)
    }
    
    var priceNumberFormatter: NumberFormatter {
        let priceFormatter = NumberFormatter()
        priceFormatter.formatterBehavior = .behavior10_4
        priceFormatter.numberStyle = .currency
        priceFormatter.locale = priceLocale
        return priceFormatter
    }
}
