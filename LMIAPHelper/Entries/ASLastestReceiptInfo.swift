//
//  ASLastestReceiptInfo.swift
//
//  Created by Luong Manh on 4/5/20.
//  Copyright © 2022 Luong Manh. All rights reserved.
//

import Foundation

public struct ASLastestReceiptInfo: Decodable {
    /// The appAccountToken associated with this transaction. This field is only present if your app supplied an appAccountToken(_:) or provided a UUID for the applicationUsername property when the user made the purchase.
    public var app_account_token: String?
    
    /// The time the App Store refunded a transaction or revoked it from Family Sharing, in a date-time format similar to the ISO 8601. This field is present only for refunded or revoked transactions.
    public var cancellation_date: Date?
    
    /// The time the App Store refunded a transaction or revoked it from Family Sharing, in UNIX epoch time format, in milliseconds. This field is present only for refunded or revoked transactions. Use this time format for processing dates.
    public var cancellation_date_ms: String?
    
    /// The time the App Store refunded a transaction or revoked it from Family Sharing, in Pacific Standard Time. This field is present only for refunded or revoked transactions.
    public var cancellation_date_pst: String?
    
    /// The reason for a refunded or revoked transaction. A value of 1 indicates that the customer canceled their transaction due to an actual or perceived issue within your app. A value of 0 indicates that the transaction was canceled for another reason; for example, if the customer made the purchase accidentally.
    /// Possible values: 1, 0
    public var cancellation_reason: String?
    
    /// The time an auto-renewable subscription expires or when it will renew, in a date-time format similar to the ISO 8601.
    public var expires_date: Date?
    
    /// The time an auto-renewable subscription expires or when it will renew, in UNIX epoch time format, in milliseconds. Use this time format for processing dates.
    public var expires_date_ms: String?
    
    /// The time an auto-renewable subscription expires or when it will renew, in Pacific Standard Time.
    public var expires_date_pst: String?
    
    /// A value that indicates whether the user is the purchaser of the product or is a family member with access to the product through Family Sharing.
    public var in_app_ownership_type: ASInAppOnwershipType?
    
    /// An indicator of whether an auto-renewable subscription is in the introductory price period. See is_in_intro_offer_period for more information.
    /// Possible values: true, false
    public var is_in_intro_offer_period: String?
    
    /// An indicator of whether an auto-renewable subscription is in the free trial period.
    public var is_trial_period: String?
    
    /// An indicator that an auto-renewable subscription has been canceled due to an upgrade. This field is only present for upgrade transactions.
    /// Value: true
    public var is_upgraded: String?
    
    /// The reference name of a subscription offer that you configured in App Store Connect. This field is present when a customer redeems a subscription offer code. For more information about offer codes, see Set Up Offer Codes, and Implementing Offer Codes in Your App.
    public var offer_code_ref_name: String?
    
    /// The time of the original app purchase, in a date-time format similar to ISO 8601.
    public var original_purchase_date: Date?
    
    /// The time of the original app purchase, in UNIX epoch time format, in milliseconds. Use this time format for processing dates. For an auto-renewable subscription, this value indicates the date of the subscription’s initial purchase. The original purchase date applies to all product types and remains the same in all transactions for the same product ID. This value corresponds to the original transaction’s transactionDate property in StoreKit.
    public var original_purchase_date_ms: String?
    
    /// The time of the original app purchase, in Pacific Standard Time.
    public var original_purchase_date_pst: String?
    
    /// The transaction identifier of the original purchase.
    public var original_transaction_id: String?
    
    /// The unique identifier of the product purchased. You provide this value when creating the product in App Store Connect, and it corresponds to the productIdentifier property of the SKPayment object stored in the transaction’s payment property.
    public var product_id: String?
    
    /// The identifier of the subscription offer redeemed by the user.
    public var promotional_offer_id: String?
    
    /// The time the App Store charged the user’s account for a purchased or restored product, or the time the App Store charged the user’s account for a subscription purchase or renewal after a lapse, in a date-time format similar to ISO 8601.
    public var purchase_date: Date?
    
    /// For consumable, non-consumable, and non-renewing subscription products, the time the App Store charged the user’s account for a purchased or restored product, in the UNIX epoch time format, in milliseconds. For auto-renewable subscriptions, the time the App Store charged the user’s account for a subscription purchase or renewal after a lapse, in the UNIX epoch time format, in milliseconds. Use this time format for processing dates.
    public var purchase_date_ms: String?
    
    /// The time the App Store charged the user’s account for a purchased or restored product, or the time the App Store charged the user’s account for a subscription purchase or renewal after a lapse, in Pacific Standard Time.
    public var purchase_date_pst: String?
    
    /// The number of consumable products purchased. This value corresponds to the quantity property of the SKPayment object stored in the transaction’s payment property. The value is usually 1 unless modified with a mutable payment. The maximum value is 10.
    public var quantity: String?
    
    /// The identifier of the subscription group to which the subscription belongs. The value for this field is identical to the subscriptionGroupIdentifier property in SKProduct.
    public var subscription_group_identifier: String?
    
    /// A unique identifier for purchase events across devices, including subscription-renewal events. This value is the primary key for identifying subscription purchases.
    public var web_order_line_item_id: String?
    
    /// A unique identifier for a transaction such as a purchase, restore, or renewal.
    public var transaction_id: String?
}
