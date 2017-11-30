//
//  UserListCollectionViewCellRenderer.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import UIKit

class UserListCollectionViewCellRenderer {
    static func render(userModel: UserEntity, indexPath: IndexPath, collectionView: UICollectionView) -> UserListCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserListCollectionViewCell.preferredReuseIdentifier(), for: indexPath) as! UserListCollectionViewCell

        if let name = userModel.nameFirst,
            let surname = userModel.nameLast {
            cell.name = name + " " + surname
        } else {
            cell.name = nil
        }

        cell.email = userModel.email
        cell.phone = userModel.phone
        
        if let picture = userModel.picture {
            cell.imageURL = URL(string: picture)
        } else {
            cell.imageURL = nil
        }
        
        return cell
    }
}
