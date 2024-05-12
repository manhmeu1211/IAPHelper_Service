
import StoreKit
//import MBProgressHUD
import RxSwift

public typealias ProductIdentifier = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> ()
public typealias GetAppStoreReceiptCompletionHandler = ((Result<ASResponse, Error>) -> Void)
open class IAPHelper : NSObject  {
    public static let shared = IAPHelper()
    
    
    //MARK: Key
    var getReceiptTask: URLSessionTask?
    var subscriptionSecret: String = ""
    
    public let purchased = PublishSubject<[SKPaymentTransaction]>()
    public let receivedReceipts = PublishSubject<Result<ASResponse, Error>>()
    
    private var disposeBag = DisposeBag()
    
    public override init() {
        super.init()
        observePaymentQueue()
    }
    
    private func observePaymentQueue() {
        SKPaymentQueue.default().add(self)
        
    }
}

extension IAPHelper {
    public func setSecretKey(key: String) {
        subscriptionSecret = key
    }
}

// MARK: - StoreKit API

extension IAPHelper {
    
    public func requestProducts(productIdentifiers: [String]) -> Observable<[SKProduct]> {
        return SKProduct.fetch(productIdentifiers)
    }
    
    public func buyProduct(productIdentifier: String) -> Observable<SKPaymentTransaction?>  {
        let observable = SKPaymentQueue.default().rx.transactionsUpdated.map({$0.first(where: {$0.payment.productIdentifier == productIdentifier})})
        
            requestProducts(productIdentifiers: [productIdentifier]).subscribe(onNext: { products in
            
            products.map({SKPayment(product: $0)}).forEach({SKPaymentQueue.default().add($0)})
            
        })
        .disposed(by: disposeBag)
        
        return observable 
    }
    
    public class func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    public func restorePurchases() -> Observable<[SKPaymentTransaction]> {
        let observable = SKPaymentQueue.default().rx.restoreCompletedTransactions()
        
        return observable
    }
    
    
}

extension IAPHelper {
    
    public func getAppStoreReceipt(debug: Bool, _ completion: GetAppStoreReceiptCompletionHandler?) {
        
        let SUBSCRIPTION_SECRET = self.subscriptionSecret
        
        let receiptPath = Bundle.main.appStoreReceiptURL?.path
        if FileManager.default.fileExists(atPath: receiptPath!){
            var receiptData:NSData?
            do{
                receiptData = try NSData(contentsOf: Bundle.main.appStoreReceiptURL!, options: NSData.ReadingOptions.alwaysMapped)
            }
            catch {
                completion?(.failure(error))
            }
            let base64encodedReceipt = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithCarriageReturn)
            
            let requestDictionary:[String : Any] = ["receipt-data":base64encodedReceipt!,"password":SUBSCRIPTION_SECRET, "exclude-old-transactions": true]
            
            guard JSONSerialization.isValidJSONObject(requestDictionary) else {
                completion?(.failure(NSError(domain: "requestDictionary is not valid JSON", code: -1, userInfo: nil)))
                return
            }
            do {
                let requestData = try JSONSerialization.data(withJSONObject: requestDictionary)
                
                // this works but as noted above it's best to use your own trusted server
                var validationURLString = "https://buy.itunes.apple.com/verifyReceipt"
                if debug {
                    validationURLString = "https://sandbox.itunes.apple.com/verifyReceipt"
                }
                NSLog("validation: %@", validationURLString)
                
                guard let validationURL = URL(string: validationURLString) else {
                    completion?(.failure(NSError(domain: "the validation url could not be created, unlikely error", code: -1, userInfo: nil)))
                    return }
                let session = URLSession(configuration: URLSessionConfiguration.default)
                var request = URLRequest(url: validationURL, cachePolicy: .reloadIgnoringCacheData)
                request.httpMethod = "POST"
                request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
                request.httpBody = requestData
                getReceiptTask = session.dataTask(with: request) { (data, response, error) in
                    if let data = data , error == nil {
                        do {
                            let appReceiptJSON = try JSONSerialization.jsonObject(with: data)
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .formatted(.UTCFormater)
                            let response =  try decoder.decode(ASResponse.self, from: appReceiptJSON)
                            if response.status == .mustSendFromTestEnviroment && !debug {
                                completion?(.failure(ASResponse.ResponseError.wrongEnviroment))
                            } else if response.status == .mustSendFromProductionEnviroment && debug {
                                completion?(.failure(ASResponse.ResponseError.wrongEnviroment))
                            } else {
                                completion?(.success(response))
                            }
                        } catch let error {
                            debugPrint(error)
                            completion?(.failure(error))
                        }
                    } else if let error = error {
                        completion?(.failure(error))
                    } else {
                        completion?(.failure(ASResponse.ResponseError.unknown(reason: "Unknow Error")))
                    }
                }
                getReceiptTask?.resume()
            } catch let error as NSError {
                completion?(.failure(error))
            }
        }
    }
}

extension IAPHelper {
    public func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
}


extension JSONDecoder {
    fileprivate func decode<T>(_ type: T.Type, from json: Any) throws -> T where T : Decodable {
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        return try decode(type, from: data)
    }
}
