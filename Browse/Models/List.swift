//
//  List.swift
//  Browse
//
//  Created by Ed Paulosky on 6/13/19.
//  Copyright © 2019 SeatGeek. All rights reserved.
//

import UIKit

struct List: Hashable {
    let type: Type
    let title: String?
    let items: [Item]

    // MARK: - Hashable

    let identifier = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

extension List {
    enum `Type` {
        case featured
        case trending
        case category
        case event
    }
}

extension List {
    struct Item: Hashable {
        let title: String?

        let subtitle: String?

        let color: UIColor = .random

        init(title: String? = nil, subtitle: String? = nil) {
            self.title = title
            self.subtitle = subtitle
        }

        // MARK: - Hashable

        let identifier = UUID()

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }

        // MARK: - Factories

        static func forEvent() -> Item {
            return Item(title: "The Meadows Music and Arts Festival",
                        subtitle: "Jul 22 \u{00B7} Metlife Stadium, Flushing NY")
        }

        static func forTrendingEvent() -> Item {
            return Item(title: "Vampire Weekend",
                        subtitle: "Fri 9/6 \u{00B7} Madison Square Garden, NYC")
        }
    }
}

extension List {
    static var browseLists: [List] {
        return [
            .featuredList,
            .categoryList,
            .trendingList,
            .recentlyViewed,
            .popularTonight
        ]
    }

    fileprivate static var featuredList: List {
        return List(
            type: .featured,
            title: nil,
            items: (0...4).map { _ in Item() }
        )
    }

    fileprivate static var categoryList: List {
        return List(
            type: .category,
            title: "Categories",
            items: (0...50).map { _ in Item() }
        )
    }

    fileprivate static var trendingList: List {
        return List(
            type: .trending,
            title: "Trending Events",
            items: (0...14).map { _ in Item.forTrendingEvent() }
        )
    }

    fileprivate static var recentlyViewed: List {
        return List(
            type: .event,
            title: "Recently Viewed",
            items: (0...9).map { _ in Item.forEvent() }
        )
    }

    fileprivate static var popularTonight: List {
        return List(
            type: .event,
            title: "Popular Tonight",
            items: (0...9).map { _ in Item.forEvent() }
        )
    }
}
