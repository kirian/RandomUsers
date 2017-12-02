//
//  UserDetailViewController.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 30/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import UIKit
import MapKit

class UserDetailViewController: UIViewController {
    fileprivate var presenter: UserDetailPresenterType
    @IBOutlet fileprivate weak var mapView: MKMapView!
    @IBOutlet fileprivate weak var alertLabel: UILabel!
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var fullNameLabel: UILabel!
    @IBOutlet fileprivate weak var registeredDateLabel: UILabel!
    @IBOutlet fileprivate weak var emailLabel: UILabel!
    @IBOutlet fileprivate weak var addressLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: UserDetailPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension UserDetailViewController: UserDetailView {
    
    func updateInfo(user: User) {
        fullNameLabel.text = user.fullName
        emailLabel.text = user.email
        addressLabel.text = user.location?.address
        registeredDateLabel.text = user.registered
        if let picture = user.picture {
            imageView.rnd_users_rounded(url:  URL(string: picture))
        }
    }
    
    func addPlacemark(placemark: CLPlacemark) {
        let mkPlacemark = MKPlacemark(placemark: placemark)
        mapView.addAnnotation(mkPlacemark)
        
        if let location = mkPlacemark.location {
            let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func hideMap(address: String) {
        mapView.alpha = 0.3
        mapView.isUserInteractionEnabled = false
        alertLabel.text = "The address '" + address + "' was not found in Maps"
    }
}
