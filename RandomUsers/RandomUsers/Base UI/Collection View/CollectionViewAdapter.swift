//
//  CollectionViewAdapter.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewAdapter {
    associatedtype DataType
    
    func itemCount() -> Int
    func itemCount(section: Int) -> Int?
    func sectionCount() -> Int
    func item(at indexPath: IndexPath) -> DataType
    func update(sectionsData: [[DataType]])
    func removeItem(at indexPath: IndexPath)
    func cellForCollectionView(collectionView: UICollectionView, item: DataType, indexPath: IndexPath) -> UICollectionViewCell
    func supplementaryViewForCollectionView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView?
}
