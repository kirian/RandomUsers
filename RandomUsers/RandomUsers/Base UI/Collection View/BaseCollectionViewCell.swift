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
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: .gestureDidRecognizePan)
        if let gesture = panGestureRecognizer {
            gesture.delegate = self
            addGestureRecognizer(gesture)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let gesture = panGestureRecognizer {
            if (gesture.state == UIGestureRecognizerState.changed) {
                let p: CGPoint = gesture.translation(in: self)
                let width = contentView.frame.width
                let height = contentView.frame.height
                contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
                deleteLabel.frame = CGRect(x: p.x + width + deleteLabel.frame.size.width, y: 0,
                                           width: width * 0.2, height: height)
            }
        }
    }
    
    @objc fileprivate func gestureDidRecognizePan(_ panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .began:
            break
        case .changed:
            setNeedsLayout()
        default:
            performGesture(panGesture)
        }
    }
    
    private func performGesture(_ panGesture: UIPanGestureRecognizer) {
        if abs(panGesture.velocity(in: self).x) > 400 {
            if let collectionView: UICollectionView = superview as? UICollectionView,
                let indexPath: IndexPath = collectionView.indexPathForItem(at: center) {
                collectionView.delegate?.collectionView!(collectionView,
                                                         performAction:.gestureDidRecognizePan,
                                                         forItemAt: indexPath,
                                                         withSender: nil)
            }
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.setNeedsLayout()
                self.layoutIfNeeded()
            })
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


fileprivate extension Selector {
    static let gestureDidRecognizePan = #selector(BaseCollectionViewCell.gestureDidRecognizePan)
}
