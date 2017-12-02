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
    @IBOutlet fileprivate weak var activityIndicatorView: UIActivityIndicatorView!
    fileprivate let dataSource: CollectionViewDataSource<UserListAdapter>
    fileprivate var presenter: UserListPresenterType
    fileprivate let searchBar: UISearchBar

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: UserListPresenterType,
         dataSource: CollectionViewDataSource<UserListAdapter>) {
        self.presenter = presenter
        self.dataSource = dataSource

        searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal

        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
        searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBar
        setupCollectionView()
        presenter.viewDidLoad()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.rnd_users_registerCell(UserListCollectionViewCell.self)
    }
}

extension UserListViewController: UserListView {
    func showLoadingView() {
        activityIndicatorView.isHidden = false
    }
    
    func hideLoadingView() {
        activityIndicatorView.isHidden = true
    }
    
    func show(users: [User]) {
        dataSource.updateSource(sectionsData: users)
        collectionView.reloadData()
    }
    
    func scrollToItem(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    func didRemoveUser(dataSourceIndex: Int, indexPath: IndexPath) {
        collectionView.deleteItems(at: [indexPath])
    }
}

extension UserListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        presenter.didTapCell(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.willDisplayItem(at: indexPath.row, itemCount: dataSource.adapter.itemCount())
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        let user = dataSource.adapter.item(at: indexPath)
        presenter.willRemoveUser(user: user, at: indexPath)
        dataSource.adapter.removeItem(at: indexPath)
    }
}

extension UserListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filterUsers(by: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        presenter.didTapSearchCancel()
    }
}
