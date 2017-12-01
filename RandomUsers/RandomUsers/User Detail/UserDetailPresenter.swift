//
//  UserDetailPresenter.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 30/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import CoreLocation

protocol UserDetailView: class {
    func updateInfo(user: User)
    func addPlacemark(placemark: CLPlacemark)
    func hideMap(address: String)
}

protocol UserDetailPresenterType {
    var view: UserDetailView? { get set }
    func viewDidLoad()
}

class UserDetailPresenter: UserDetailPresenterType {
    weak var view: UserDetailView?
    private let user: User
    
    init(user: User) {
        self.user = user
    }

    func viewDidLoad() {
        view?.updateInfo(user: user)
        let geocoder: CLGeocoder = CLGeocoder()
        if let city = user.location?.city {
            geocoder.geocodeAddressString(city, completionHandler: { (placemarks:[CLPlacemark]?, error: Error?) in
                if let placemark = placemarks?.first {
                    self.view?.addPlacemark(placemark: CLPlacemark(placemark: placemark))
                } else {
                    self.view?.hideMap(address: city)
                }
            })
        }
    }
}
