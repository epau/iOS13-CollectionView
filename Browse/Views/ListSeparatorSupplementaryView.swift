//
//  ListSeparatorSupplementaryView.swift
//  Browse
//
//  Created by Ed Paulosky on 6/13/19.
//  Copyright © 2019 SeatGeek. All rights reserved.
//

import UIKit

class ListSeparatorSupplementaryView: UICollectionReusableView {

    static let defaultReuseIdentifier = "ListSeparatorSupplementaryView"
    static let defaultSupplementaryViewKind = "section-footer-element-kind"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
