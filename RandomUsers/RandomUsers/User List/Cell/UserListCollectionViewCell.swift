//
//  UserListCollectionViewCell.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import UIKit
import Kingfisher

class UserListCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var emailLabel: UILabel!
    @IBOutlet fileprivate weak var phoneLabel: UILabel!
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var imageURL: URL? {
        didSet {
            imageView.kf.setImage(with: imageURL)
        }
    }
    
    var email: String? {
        didSet {
            emailLabel.text = email
        }
    }

    var phone: String? {
        didSet {
            phoneLabel.text = phone
        }
    }

    override func setupView() {
        super.setupView()
    }
}
