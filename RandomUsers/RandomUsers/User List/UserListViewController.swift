//
//  UserListViewController.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    fileprivate let dataSource: CollectionViewDataSource<UserListAdapter>
    fileprivate var presenter: UserListPresenterType

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: UserListPresenterType,
         dataSource: CollectionViewDataSource<UserListAdapter>) {
        self.presenter = presenter
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.rand_registerCell(UserListCollectionViewCell.self)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
}

extension UserListViewController: UserListView {
    func showLoadingView() {}
    func hideLoadingView() {}
    func show(users: [UserEntity]) {
        dataSource.updateSource(sectionsData: users)
        collectionView.reloadData()
    }
}

extension UserListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        presenter.didTapCell(at: indexPath)
    }
}
