//
//  CollectionViewDataSource.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewDataSource<T: CollectionViewAdapter>: NSObject, UICollectionViewDataSource {
    let adapter: T
    
    init(adapter: T) {
        self.adapter = adapter
    }
    
    func updateSource(sectionsData: [T.DataType]...) {
        adapter.update(sectionsData: sectionsData)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let itemCount = adapter.itemCount(section: section) else {
            return 0
        }
        
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return adapter.cellForCollectionView(collectionView: collectionView, item: adapter.item(at: indexPath), indexPath: indexPath)
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return adapter.sectionCount()
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return adapter.supplementaryViewForCollectionView(collectionView: collectionView, kind: kind, indexPath: indexPath) ?? UICollectionReusableView()
    }
}
