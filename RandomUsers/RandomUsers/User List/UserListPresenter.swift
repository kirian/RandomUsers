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
    func didRemoveUser(dataSourceIndex: Int, indexPath: IndexPath)
}

protocol UserListPresenterType {
    var view: UserListView? { get set }
    func viewDidLoad()
    func willDisplayItem(at index: Int, itemCount: Int)
    func filterUsers(by text: String)
    func didTapCell(at index: Int)
    func didTapSearchCancel()
    func willRemoveUser(user: User, at indexPath: IndexPath)
}

class UserListPresenter: UserListPresenterType {
    weak var view: UserListView?
    private let getUsersUseCase: GetUsersUseCaseType
    private let removeUserUseCase: RemoveUserUseCaseType
    private let userDetailRouter: UserDetailRouterType?
    private let disposeBag: DisposeBag = DisposeBag()
    fileprivate var users: [User] = []
    fileprivate var filteredUsers: [User] = []
    fileprivate var isFiltering:Bool = false
    
    init(getUsersUseCase: GetUsersUseCaseType,
         removeUserUseCase: RemoveUserUseCaseType,
         userDetailRouter: UserDetailRouterType?) {
        self.getUsersUseCase = getUsersUseCase
        self.removeUserUseCase = removeUserUseCase
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
        if let view = view as? UIViewController,
            let router = userDetailRouter {
            let user = isFiltering ? filteredUsers[index]: users[index]
            router.navigateTo(user: user, sourceViewController: view)
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
    
    func willRemoveUser(user: User, at indexPath: IndexPath) {
        removeUserUseCase.execute(user: user)
            .subscribe { [weak self] singleEvent in
                switch singleEvent {
                case .success:
                    if let idx = self?.users.index(where: { u -> Bool in
                            u.email == user.email
                    }) {
                    self?.users.remove(at: idx)
                    self?.view?.didRemoveUser(dataSourceIndex: idx, indexPath: indexPath)
                    }
                case .error:
                    break
                }
            }.disposed(by: disposeBag)
    }
    
    //MARK: Retrieve random users
    private func getUsers() {
        getUsersUseCase.execute(results: 10)
            .subscribe { [weak self] singleEvent in
                self?.view?.hideLoadingView()
                switch singleEvent {
                case .success(let users):
                    self?.users = users
                    if let users = self?.users {
                        self?.view?.show(users: users)
                    }
                    
                case .error:
                    break
                }
            }.disposed(by: disposeBag)
    }
}
