//
//  EventBrowseCell.swift
//  Browse
//
//  Created by Ed Paulosky on 6/13/19.
//  Copyright © 2019 SeatGeek. All rights reserved.
//

import UIKit

class EventBrowseCell: UICollectionViewCell {

    static let defaultReuseIdentifier = "EventBrowseCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(card)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 20),

            subtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            subtitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subviews

    private(set) lazy var card: UIView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: contentView.bounds.width,
                           height: 120)
        let view = UIView(frame: frame)
        view.layer.cornerRadius = 8
        view.layer.cornerCurve = .continuous
        view.autoresizingMask = [.flexibleWidth]
        return view
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
