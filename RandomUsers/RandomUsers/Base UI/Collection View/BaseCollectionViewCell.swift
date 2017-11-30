//
//  BaseCollectionViewCell.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer?
    fileprivate var deleteLabel: UILabel = {
        let label = UILabel()
        label.text = "delete"
        label.textColor = UIColor.white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    static func preferredReuseIdentifier() -> String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
    func setupView() {
        backgroundColor = UIColor.red
        insertSubview(deleteLabel, belowSubview: contentView)
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPanGestureRecognizer(_:)))
        if let pan = panGestureRecognizer {
            pan.delegate = self
            addGestureRecognizer(pan)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let pan = panGestureRecognizer else {
            return
        }
        
        if (pan.state == UIGestureRecognizerState.changed) {
            let p: CGPoint = pan.translation(in: self)
            let width = contentView.frame.width
            let height = contentView.frame.height
            contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
            deleteLabel.frame = CGRect(x: p.x + width + deleteLabel.frame.size.width, y: 0, width: 100, height: height)
        }
    }
    
    @objc func onPanGestureRecognizer(_ panGesture: UIPanGestureRecognizer) {
        if panGesture.state == UIGestureRecognizerState.began {
            
        } else if panGesture.state == UIGestureRecognizerState.changed {
            setNeedsLayout()
        } else {
            if abs(panGesture.velocity(in: self).x) > 500 {
                let collectionView: UICollectionView = superview as! UICollectionView
                let indexPath: IndexPath = collectionView.indexPathForItem(at: center)!
                collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPanGestureRecognizer(_:)), forItemAt: indexPath, withSender: nil)
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                })
            }
        }
    }
}

extension BaseCollectionViewCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let pan = panGestureRecognizer else {
            return false
        }
        
        return ((pan.velocity(in: pan.view)).x) < 0
    }
}
