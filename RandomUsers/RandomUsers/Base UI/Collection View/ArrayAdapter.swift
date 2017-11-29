//
//  ArrayAdapter.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import UIKit

class ArrayAdapter<T>: CollectionViewAdapter {
    fileprivate var data: [T]
    
    required init(data: [T]) {
        self.data = data
    }
    
    convenience init() {
        self.init(data: [])
    }
    
    func sectionCount() -> Int {
        return 1
    }
    
    func itemCount() -> Int {
        return data.count
    }
    
    func itemCount(section: Int) -> Int? {
        guard section < 1 else {
            return nil
        }
        
        return itemCount()
    }
    
    func item(at indexPath: IndexPath) -> T {
        return data[indexPath.row]
    }
    
    func update(sectionsData: [[T]]) {
        if let data = sectionsData.first {
            self.data = data
        }
    }
    
    func cellForCollectionView(collectionView: UICollectionView, item: T, indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("\(String(describing: self)) should override \(#function) method.")
    }
    
    func supplementaryViewForCollectionView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return nil
    }
}
