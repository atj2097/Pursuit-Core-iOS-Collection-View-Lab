//
//  ExchangeRateModel.swift
//  collectionViewLab
//
//  Created by God on 9/26/19.
//  Copyright © 2019 God. All rights reserved.
//

import Foundation

// MARK: - Country
struct Country: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}
