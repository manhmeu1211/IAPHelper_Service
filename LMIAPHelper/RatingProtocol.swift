//
//  RatingProtocol.swift
//
//  Created by Luong Manh on 4/5/20.
//  Copyright © 2022 Luong Manh. All rights reserved.
//

import UIKit
import StoreKit

public protocol RatingProtocol {
//    var shouldShowRate: Bool { get }
//    var shouldShowPromotion: Bool { get }
    func rateMe()
    func showRateAlert()
//    func showPromotionAlert()
//    func increaseRateCount()
//    func increasePromotionCount()
}

extension RatingProtocol where Self: UIViewController {
    public func rateMe(forKey: String, maxCount: Int) {
        let user = UserDefaults.standard
        
        var currentValue = user.rateValue(for: forKey)
        
        if currentValue % maxCount == 0 {
            rateMe()
        }
        
        currentValue += 1
        user.setRateValue(currentValue % maxCount, forKey: forKey)
    }
    
    public func rateMe() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            showRateAlert()
        }
        
    }
    
    public func showRateAlert() {
        let alert = UIAlertController(title: "Rate me", message: "Help me make the app better for you.", preferredStyle: .alert)
        let appId = value(for: "APP_ID")
        let rateAction = UIAlertAction(title: "Rate this app", style: .destructive) {(action) in
            
            let url = URL(string: "https://itunes.apple.com/app/id\(appId)?action=write-review")!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
        let laterAction = UIAlertAction(title: "Later", style: .default) {(action) in
            //Do nothing
        }
        
        let neverAction = UIAlertAction(title: "Never show again", style: .default) {(action) in
            //Do nothing
        }
        alert.addAction(rateAction)
        alert.addAction(laterAction)
        alert.addAction(neverAction)
        present(alert, animated: true, completion: nil)
    }
    
    func value(for key: String) -> String {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) else {
            fatalError("Info.plist not found")
        }
        
        guard let value = dict.value(forKey: key) as? String else {
            fatalError("\(key) not found in Info.plist")
        }
        
        return value
    }
    
}
