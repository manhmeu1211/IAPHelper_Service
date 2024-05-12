//
//  IAPHelper+PaymentQueue.swift
//
//  Created by Luong Manh on 4/5/20.
//  Copyright © 2022 Luong Manh. All rights reserved.
//

import Foundation
import StoreKit

extension IAPHelper {
    public static func validateAppStoreReceipt() {
        IAPHelper.shared
            .getAppStoreReceipt(debug: false) { result in
                switch result {
                case .failure:
                    IAPHelper.shared.getAppStoreReceipt(debug: true) { result in
                        
                        processReceipts(result)
                    }
                case .success(let response):
                    processReceipts(.success(response))
                }
        }
    }
    
    private static func processReceipts(_ response: Result<ASResponse, Error>) {
        shared.receivedReceipts.onNext(response)
    }
}

// MARK: - SKPaymentTransactionObserver
extension IAPHelper: SKPaymentTransactionObserver {
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        let completedTransactions = transactions.filter({$0.transactionState == .purchased})
        let failTransactions = transactions.filter({$0.transactionState == .failed})
        let restoredTransactions = transactions.filter({$0.transactionState == .restored})
        
        if completedTransactions.count > 0 || restoredTransactions.count > 0 {
            IAPHelper.validateAppStoreReceipt()
            
            purchased.onNext(completedTransactions + restoredTransactions)
        }
        
        if completedTransactions.count > 0 {
            completeTransaction(completedTransactions)
        }
        
        if restoredTransactions.count > 0 {
            restoreTransaction(restoredTransactions)
        }
        
        if failTransactions.count > 0 {
            failedTransaction(failTransactions)
        }
        
        (completedTransactions + restoredTransactions + failTransactions).forEach({queue.finishTransaction($0)})
        
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchased:
                break
            case .failed:
                break 
            case .restored:
                break
            case .deferred:
                debugPrint("deferred...\(transaction.payment.productIdentifier)")
                
            case .purchasing:
                debugPrint("purchasing...\(transaction.payment.productIdentifier)")
                
            @unknown default:
                break
            }
        }
    }
    
    public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        paymentQueue(queue, updatedTransactions: queue.transactions)
    }
    
    fileprivate func completeTransaction(_ transactions: [SKPaymentTransaction]) {
        debugPrint("completeTransaction...\(transactions.map({$0.payment.productIdentifier}))")
    }
    
    fileprivate func restoreTransaction(_ transactions: [SKPaymentTransaction]) {
        debugPrint("restoreTransaction... \(transactions.map({$0.payment.productIdentifier}))")
    }
    
    
    fileprivate func failedTransaction(_ transactions: [SKPaymentTransaction]) {
        debugPrint("failedTransaction...\(transactions.map({$0.payment.productIdentifier}))")
    }
}

