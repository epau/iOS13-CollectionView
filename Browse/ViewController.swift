////
////  ViewController.swift
////  Browse
////
////  Created by Ed Paulosky on 6/13/19.
////  Copyright © 2019 SeatGeek. All rights reserved.
////

import UIKit

class ViewController: UIViewController {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .refresh,
                                                  target: self,
                                                  action: #selector(shuffle))

        dataSource = createDataSource()
        view.addSubview(collectionView)
        generateData()
    }

    // MARK: - Data

    var lists: [List] = List.browseLists {
        didSet {
            let snapshot = NSDiffableDataSourceSnapshot<List, List.Item>()
            snapshot.appendSections(lists)
            lists.forEach { snapshot.appendItems($0.items, toSection: $0) }
            dataSource.apply(snapshot)
        }
    }

    @objc func shuffle() {
        lists = lists.shuffled()
    }

    func generateData() {

        // Create a snapshot
        let snapshot = NSDiffableDataSourceSnapshot<List, List.Item>()

        // Populate the snapshot
        snapshot.appendSections(lists)
        lists.forEach { snapshot.appendItems($0.items, toSection: $0) }

        // Apply the snapshot
        dataSource.apply(snapshot)

    }


    // MARK: - Collection View

    typealias BrowseDiffableDataSource = UICollectionViewDiffableDataSource<List, List.Item>

    var dataSource: BrowseDiffableDataSource!

    private(set) lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FeaturedBrowseCell.self,
                                forCellWithReuseIdentifier: FeaturedBrowseCell.defaultReuseIdentifier)
        collectionView.register(CategoryBrowseCell.self,
                                forCellWithReuseIdentifier: CategoryBrowseCell.defaultReuseIdentifier)
        collectionView.register(EventBrowseCell.self,
                                forCellWithReuseIdentifier: EventBrowseCell.defaultReuseIdentifier)
        collectionView.register(TrendingBrowseCell.self,
                                forCellWithReuseIdentifier: TrendingBrowseCell.defaultReuseIdentifier)
        collectionView.register(ListHeaderSupplementaryView.self,
                                forSupplementaryViewOfKind: ListHeaderSupplementaryView.defaultSupplementaryViewKind,
                                withReuseIdentifier: ListHeaderSupplementaryView.defaultReuseIdentifier)
        collectionView.register(ListSeparatorSupplementaryView.self,
                                forSupplementaryViewOfKind: ListSeparatorSupplementaryView.defaultSupplementaryViewKind,
                                withReuseIdentifier: ListSeparatorSupplementaryView.defaultReuseIdentifier)
        return collectionView
    }()
}

// MARK: - Colelction View Layout

extension ViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self]
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let self = self else { return nil }

            let list = self.lists[sectionIndex]
            let isLastSection = sectionIndex == self.lists.count - 1
            let section: NSCollectionLayoutSection
            let shouldAddSeparator: Bool

            switch list.type {
            case .featured:
                section = .featuredSection(layoutEnvironment: layoutEnvironment)
                shouldAddSeparator = false
            case .category:
                section = .categorySection(layoutEnvironment: layoutEnvironment)
                shouldAddSeparator = true
            case .event:
                section = .eventSection(layoutEnvironment: layoutEnvironment)
                shouldAddSeparator = true
            case .trending:
                section = .trendingSection(layoutEnvironment: layoutEnvironment)
                shouldAddSeparator = true
            }

            if shouldAddSeparator && !isLastSection {
                let separator = NSCollectionLayoutBoundarySupplementaryItem
                    .sectionSeparator(layoutEnvironment: layoutEnvironment)
                section.boundarySupplementaryItems = section.boundarySupplementaryItems + [separator]
            }

            return section
        }
    }
}

// MARK: - Collection View Sections

fileprivate extension NSCollectionLayoutSection {

    // MARK: - Featured Section

    static func featuredSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let contentSize = layoutEnvironment.container.effectiveContentSize
        let spacing: CGFloat = 12
        let width = contentSize.width - 48

        let item = NSCollectionLayoutItem(layoutSize: .fill)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                               heightDimension: .absolute(216))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                      leading: spacing / 2,
                                                      bottom: 0,
                                                      trailing: spacing / 2)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 16,
                                                        leading: 0,
                                                        bottom: 0,
                                                        trailing: 0)

        return section
    }

    // MARK: - Category Section

    static func categorySection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let inset: CGFloat = 16
        let spacing: CGFloat = 12
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(162),
                                               heightDimension: .absolute(112))

        let item = NSCollectionLayoutItem(layoutSize: .fill)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: inset,
                                                        bottom: 30,
                                                        trailing: inset)

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem.listHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    // MARK: - Event Section

    static func eventSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {

        let inset: CGFloat = 16
        let spacing: CGFloat = 12

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(162),
                                               heightDimension: .absolute(224))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: inset,
                                                        bottom: 0,
                                                        trailing: inset)


        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem.listHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    // MARK: - Trending Section

    static func trendingSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {

        let contentSize = layoutEnvironment.container.effectiveContentSize
        let spacing: CGFloat = 16
        let width = contentSize.width - (spacing * 3)
        let height: CGFloat = 76
        let numberOfRows = 3
        let groupHeight = height * CGFloat(numberOfRows)

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                               heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: numberOfRows)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 16,
                                                        bottom: 12,
                                                        trailing: 16)

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem.listHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
}

// MARK: - Supplementary Views

extension NSCollectionLayoutBoundarySupplementaryItem {
    static func sectionSeparator(layoutEnvironment: NSCollectionLayoutEnvironment)
        -> NSCollectionLayoutBoundarySupplementaryItem {
            let contentSize = layoutEnvironment.container.effectiveContentSize
            let separatorSize = NSCollectionLayoutSize(widthDimension: .absolute(contentSize.width),
                                                       heightDimension: .absolute(8))
            return NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: separatorSize,
                elementKind: ListSeparatorSupplementaryView.defaultSupplementaryViewKind,
                alignment: .bottom)
    }

    static func listHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(68))
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: ListHeaderSupplementaryView.defaultSupplementaryViewKind,
            alignment: .top)
    }
}


// MARK: - Collection View Data Source

extension ViewController {
    func createDataSource() -> BrowseDiffableDataSource {
        let cellProvider = createCellProvider()
        let dataSource = BrowseDiffableDataSource(collectionView: collectionView,
                                                  cellProvider: cellProvider)
        dataSource.supplementaryViewProvider = createSupplementaryViewProvider()
        return dataSource
    }

    func createCellProvider() -> BrowseDiffableDataSource.CellProvider {
        return {
            [weak self]
            (collectionView: UICollectionView, indexPath: IndexPath, item: List.Item)
            -> UICollectionViewCell? in

            guard let self = self else { return nil }
            let list = self.lists[indexPath.section]

            switch list.type {
            case .featured:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FeaturedBrowseCell.defaultReuseIdentifier,
                    for: indexPath) as! FeaturedBrowseCell
                cell.contentView.backgroundColor = item.color
                return cell

            case .category:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CategoryBrowseCell.defaultReuseIdentifier,
                    for: indexPath) as! CategoryBrowseCell
                cell.contentView.backgroundColor = item.color
                return cell

            case .event:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: EventBrowseCell.defaultReuseIdentifier,
                    for: indexPath) as! EventBrowseCell
                cell.card.backgroundColor = item.color
                cell.titleLabel.text = item.title
                cell.subtitleLabel.text = item.subtitle
                return cell

            case .trending:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TrendingBrowseCell.defaultReuseIdentifier,
                    for: indexPath) as! TrendingBrowseCell
                cell.card.backgroundColor = item.color
                cell.titleLabel.text = item.title
                cell.subtitleLabel.text = item.subtitle
                return cell
            }
        }
    }


    func createSupplementaryViewProvider() -> BrowseDiffableDataSource.SupplementaryViewProvider {
        return {
            [weak self]
            (collectionView: UICollectionView, kind: String, indexPath: IndexPath)
            -> UICollectionReusableView? in

            guard let self = self else { return nil }
            let list = self.lists[indexPath.section]

            if kind == ListHeaderSupplementaryView.defaultSupplementaryViewKind {
                // Get a supplementary view of the desired kind.
                guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: ListHeaderSupplementaryView.defaultReuseIdentifier,
                    for: indexPath) as? ListHeaderSupplementaryView
                    else { return nil }

                supplementaryView.label.text = list.title
                return supplementaryView
            } else if kind == ListSeparatorSupplementaryView.defaultSupplementaryViewKind {
                // Get a supplementary view of the desired kind.
                guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: ListSeparatorSupplementaryView.defaultReuseIdentifier,
                    for: indexPath) as? ListSeparatorSupplementaryView
                    else { return nil }
                return supplementaryView
            }

            return nil
        }
    }
}
