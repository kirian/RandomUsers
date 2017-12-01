//
//  ImageViewExtension.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 1/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import Kingfisher

/**
 * Transform downloaded image to circle before displaying and caching
 */
extension UIImageView {
    func rnd_users_rounded(url: URL?) {
        rnd_users_rounded(url: url, placeholder: nil)
    }
    
    func rnd_users_rounded(url: URL?, placeholder: UIImage?) {
        let radius:CGFloat = image?.size.height ?? 128
        let processor = RoundCornerImageProcessor(cornerRadius: radius * 0.5, targetSize: nil, roundingCorners: .all, backgroundColor: .white)
        kf.setImage(with: url, placeholder: placeholder, options: [.processor(processor)])
    }
}
