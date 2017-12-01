//
//  UserListAdapter.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import UIKit

class UserListAdapter: ArrayAdapter<User> {
    convenience init() {
        self.init(data: [])
    }
    
    required init(data: [User]) {
        super.init(data: data)
    }
    
    override func cellForCollectionView(collectionView: UICollectionView, item: User, indexPath: IndexPath) -> UICollectionViewCell {
        return UserListCollectionViewCellRenderer.render(userModel: item, indexPath: indexPath, collectionView: collectionView)
    }
    
    override func supplementaryViewForCollectionView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return nil
    }
}
