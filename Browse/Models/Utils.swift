//
//  Utils.swift
//  Browse
//
//  Created by Ed Paulosky on 6/14/19.
//  Copyright © 2019 SeatGeek. All rights reserved.
//

import UIKit

extension UIColor {
    static let allColors: [UIColor] = [
        .systemPink,
        .systemRed,
        .systemBlue,
        .systemTeal,
        .systemIndigo,
        .systemOrange,
        .systemGreen,
        .systemPurple,
        .systemYellow
    ]

    static var random: UIColor {
        let i = Int.random(in: 0..<allColors.count)
        return allColors[i]
    }
}

extension NSCollectionLayoutSize {
    static var fill: NSCollectionLayoutSize {
        NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                               heightDimension: .fractionalHeight(1.0))
    }
}
