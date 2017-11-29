//
//  UserListViewController.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    fileprivate var presenter: UserListPresenterType

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: UserListPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension UserListViewController: UserListView {
    func showLoadingView() {}
    func hideLoadingView() {}
}
