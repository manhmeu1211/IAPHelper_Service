
## Installation

UnitAdsManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LMIAPHelper', git: 'git@github.com:manhmeu1211/LMIAPHelper.git'
```

## Usage
### In 'AppDelegate' add following code
```swift 
// Observer transations
IAPHelper.shared.purchased.subscribe(onNext :{[weak self] transactions in
    self?.completeTransaction(transactions) 
}).disposed(by: disposeBag)

// If purchase is subscrible then get receipt is required to get purchase date exprired
IAPHelper.shared.receivedReceipts.subscribe(onNext: { receipts in
    guard let lastReceiptDate = receipts.compactMap({$0.expiresDate}).max(by: { first, second -> Bool in
        return first < second
    }) else {
        return
    }
    
    guard lastReceiptDate.compare(Date()) == .orderedDescending else {
        return
    }

    // For example set purchase date to the oldest one then app can know when user no longer hase access to pro feature
    let user = RLMUser.current
    
    let realm = try! Realm()
    try! realm.write {
        user.expirationSubscriptionDate = lastReceiptDate
    }
}).disposed(by: disposeBag)
```

### Call IAP from in-app:
```swift
// To call IAP use following:
IAPHelper.shared.buyProduct(productIdentifier: VMSetting.productID)
.map({ $0?.transactionState == .purchasing })
.distinctUntilChanged()
.subscribe(onNext: { [weak self] purchasing in
    if !purchasing {
    // Purchase in progress
    } else if let self = self, hud == nil {
        // Finish purchase with result
    }
})
.disposed(by: disposeBag)

IAPHelper.shared.restorePurchases()
.subscribe(onNext: { [weak self] transactions in
    let trans = transactions.filter({$0.payment.productIdentifier == VMSetting.productID})
    
    let inprogress = trans.count > 0 && trans.filter({$0.transactionState != .restored }).count > 0
    
    if !inprogress {
        // Restore purchase in progress
    } else if let self = self, hud == nil {
        // Finish restore
    }
})
.disposed(by: disposeBag)
```
