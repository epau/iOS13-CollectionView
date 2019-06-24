//
//  ListHeaderSupplementaryView.swift
//  Browse
//
//  Created by Ed Paulosky on 6/13/19.
//  Copyright © 2019 SeatGeek. All rights reserved.
//

import UIKit

class ListHeaderSupplementaryView: UICollectionReusableView {

    static let defaultReuseIdentifier = "ListHeaderSupplementaryView"
    static let defaultSupplementaryViewKind = "section-header-element-kind"

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subviews

    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
