//
//  UserListAdapter.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import UIKit

class UserListAdapter: ArrayAdapter<UserEntity> {
    convenience init() {
        self.init(data: [])
    }
    
    required init(data: [UserEntity]) {
        super.init(data: data)
    }
    
    override func cellForCollectionView(collectionView: UICollectionView, item: UserEntity, indexPath: IndexPath) -> UICollectionViewCell {
        return UserListCollectionViewCellRenderer.render(userModel: item, indexPath: indexPath, collectionView: collectionView)
    }
    
    override func supplementaryViewForCollectionView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return nil
    }
}
