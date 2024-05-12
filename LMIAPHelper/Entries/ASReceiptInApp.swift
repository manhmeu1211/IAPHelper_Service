//
//  ASReceiptInApp.swift
//
//  Created by Luong Manh on 4/5/20.
//  Copyright © 2022 Luong Manh. All rights reserved.
//

import Foundation
/// The in_app array is not in chronological order. When parsing the array, iterate over all items to ensure all items are fulfilled. For example, you cannot assume that the last item in the array is the most recent.
/// For receipts containing auto-renewable subscriptions, check the value of the responseBody.Latest_receipt_info key of the response to get the status of the most recent renewal.
/// You can use this array to:
/// - Check for an empty array in a valid receipt, indicating that the App Store has made no in-app purchase charges.
/// - Determine which products the user purchased. Purchases for non-consumable products, auto-renewable subscriptions, and non-renewing subscriptions remain in the receipt indefinitely. For consumable products, the transaction is added to the receipt when the purchase is made, and remains until your app finishes that transaction. It no longer appears in updated receipts after you call finishTransaction(_:).
public struct ASReceiptInApp: Decodable {
    // The time the App Store refunded a transaction or revoked it from family sharing, in a date-time format similar to the ISO 8601. This field is present only for refunded or revoked transactions.
    public var cancellation_date: Date?
    
    /// The time the App Store refunded a transaction or revoked it from family sharing, in UNIX epoch time format, in milliseconds. This field is present only for refunded or revoked transactions. Use this time format for processing dates. See cancellation_date_ms for more information.
    public var cancellation_date_ms: String?
    
    /// The time the App Store refunded a transaction or revoked it from family sharing, in the Pacific Time zone. This field is present only for refunded or revoked transactions.
    public var cancellation_date_pst: String?
    
    /// The reason for a refunded or revoked transaction. A value of “1” indicates that the customer canceled their transaction due to an actual or perceived issue within your app. A value of “0” indicates that the transaction was canceled for another reason; for example, if the customer made the purchase accidentally.
    /// Possible values: 1, 0
    public var cancellation_reason: CancellationReason?
    
    /// The time a subscription expires or when it will renew, in a date-time format similar to the ISO 8601.
    public var expires_date: Date?
    
    /// The time a subscription expires or when it will renew, in UNIX epoch time format, in milliseconds. Use this time format for processing dates. See expires_date_ms for more information.
    public var expires_date_ms: String?
    
    /// The time a subscription expires or when it will renew, in the Pacific Time zone.
    public var expires_date_pst: String?
    
    /// An indicator of whether an auto-renewable subscription is in the introductory price period. See is_in_intro_offer_period for more information.
    public var is_in_intro_offer_period: String?
    
    /// An indication of whether a subscription is in the free trial period. See is_trial_period for more information.
    public var is_trial_period: String?
    
    /// The time of the original in-app purchase, in a date-time format similar to ISO 8601.
    public var original_purchase_date: Date?
    
    /// The time of the original in-app purchase, in UNIX epoch time format, in milliseconds. For an auto-renewable subscription, this value indicates the date of the subscription's initial purchase. The original purchase date applies to all product types and remains the same in all transactions for the same product ID. This value corresponds to the original transaction’s transactionDate property in StoreKit. Use this time format for processing dates.
    public var original_purchase_date_ms: String?
    
    /// The time of the original in-app purchase, in the Pacific Time zone.
    public var original_purchase_date_pst: String?
    
    /// The transaction identifier of the original purchase. See original_transaction_id for more information.
    public var original_transaction_id: String?
    
    /// The unique identifier of the product purchased. You provide this value when creating the product in App Store Connect, and it corresponds to the productIdentifier property of the SKPayment object stored in the transaction's payment property.
    public var product_id: String?
    
    /// The identifier of the subscription offer redeemed by the user. See promotional_offer_id for more information.
    public var promotional_offer_id: String?
    
    /// The time the App Store charged the user's account for a purchased or restored product, or the time the App Store charged the user’s account for a subscription purchase or renewal after a lapse, in a date-time format similar to ISO 8601.
    public var purchase_date: Date?
    
    /// For consumable, non-consumable, and non-renewing subscription products, the time the App Store charged the user's account for a purchased or restored product, in the UNIX epoch time format, in milliseconds. For auto-renewable subscriptions, the time the App Store charged the user’s account for a subscription purchase or renewal after a lapse, in the UNIX epoch time format, in milliseconds. Use this time format for processing dates.
    public var purchase_date_ms: String?
    
    /// The time the App Store charged the user's account for a purchased or restored product, or the time the App Store charged the user’s account for a subscription purchase or renewal after a lapse, in the Pacific Time zone.
    public var purchase_date_pst: String?
    
    /// The number of consumable products purchased. This value corresponds to the quantity property of the SKPayment object stored in the transaction's payment property. The value is usually “1” unless modified with a mutable payment. The maximum value is 10.
    public var quantity: String?
    
    /// A unique identifier for a transaction such as a purchase, restore, or renewal. See transaction_id for more information.
    public var transaction_id: String?
    
    /// A unique identifier for purchase events across devices, including subscription-renewal events. This value is the primary key for identifying subscription purchases.
    public var web_order_line_item_id: String?
}


extension ASReceiptInApp {
    /// The reason for a refunded or revoked transaction
    public enum CancellationReason: Int, Decodable {
        /// A value of “1” indicates that the customer canceled their transaction due to an actual or perceived issue within your app
        case otherReason
        
        ///  A value of “0” indicates that the transaction was canceled for another reason; for example, if the customer made the purchase accidentally.
        case customerCancelled
    }
}
