//
//  UserListPresenter.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import RxSwift

protocol UserListView: class {
    func showLoadingView()
    func hideLoadingView()
    func show(users: [User])
    func scrollToItem(at index: Int)
}

protocol UserListPresenterType {
    var view: UserListView? { get set }
    func viewDidLoad()
    func willDisplayItem(at index: Int, itemCount: Int)
    func filterUsers(by text: String)
    func didTapCell(at index: Int)
    func didTapSearchCancel()
}

class UserListPresenter: UserListPresenterType {
    weak var view: UserListView?
    private let getUsersUseCase: GetUsersUseCaseType
    private let userDetailRouter: UserDetailRouterType
    private let disposeBag: DisposeBag = DisposeBag()
    fileprivate var users: [User] = []
    fileprivate var filteredUsers: [User] = []
    fileprivate var isFiltering:Bool = false
    
    init(getUsersUseCase: GetUsersUseCaseType,
         userDetailRouter: UserDetailRouterType) {
        self.getUsersUseCase = getUsersUseCase
        self.userDetailRouter = userDetailRouter
    }
    
    func viewDidLoad() {
        view?.showLoadingView()
        getUsers()
    }
    
    func filterUsers(by text: String) {
        isFiltering = !text.isEmpty
        if isFiltering {
            let lowercasedText = text.lowercased()
            filteredUsers = users.filter { user -> Bool in
                return user.nameFirst?.lowercased().range(of:lowercasedText) != nil ||
                    user.nameLast?.lowercased().range(of:lowercasedText) != nil ||
                    user.email?.lowercased().range(of:lowercasedText) != nil
            }
            view?.show(users: filteredUsers)
        } else {
            view?.show(users: users)
        }
    }
    
    func didTapCell(at index: Int) {
        if let view = view as? UIViewController {
            userDetailRouter.navigateTo(user: users[index], sourceViewController: view)
        }
    }
    
    func didTapSearchCancel() {
        isFiltering = false
        filteredUsers.removeAll()
        view?.show(users: users)
    }
    
    func willDisplayItem(at index: Int, itemCount: Int) {
        if !isFiltering {
            if index == itemCount - 1 {
                let row = itemCount - 2
                view?.scrollToItem(at: row > 0 ? row: 0)
                getUsers()
            }
        }
    }
    
    //MARK: Retrieve random users
    private func getUsers() {
        getUsersUseCase.execute()
            .subscribe { [weak self] singleEvent in
                self?.view?.hideLoadingView()
                switch singleEvent {
                case .success(let users):
                    self?.users.append(contentsOf: users)
                    if let users = self?.users {
                        self?.view?.show(users: users)
                    }
                    
                case .error:
                    // TODO: Show error.
                    break
                }
            }.disposed(by: disposeBag)
    }
}
