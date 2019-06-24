//
//  CategoryBrowseCell.swift
//  Browse
//
//  Created by Ed Paulosky on 6/13/19.
//  Copyright © 2019 SeatGeek. All rights reserved.
//

import UIKit

class CategoryBrowseCell: UICollectionViewCell {

    static let defaultReuseIdentifier = "CategoryBrowseCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.cornerCurve = .continuous
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
