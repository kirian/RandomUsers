//
//  UICollectionViewExtension.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func rnd_users_registerCell(_ type: BaseCollectionViewCell.Type) {
        let nib = UINib(nibName: type.preferredReuseIdentifier(), bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: type.preferredReuseIdentifier())
    }
    
    func rnd_users_registerClass(_ type: BaseCollectionViewCell.Type) {
        self.register(type, forCellWithReuseIdentifier: type.preferredReuseIdentifier())
    }
}
