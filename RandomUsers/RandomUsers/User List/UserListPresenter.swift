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
}

protocol UserListPresenterType {
    var view: UserListView? { get set }
    func viewDidLoad()
}

class UserListPresenter: UserListPresenterType {
    weak var view: UserListView?
    private let getUsersUseCase: GetUsersUseCaseType
    private let disposeBag: DisposeBag = DisposeBag()

    init(getUsersUseCase: GetUsersUseCaseType) {
        self.getUsersUseCase = getUsersUseCase
    }
    
    func viewDidLoad() {
        view?.showLoadingView()

        getUsersUseCase.execute()
            .subscribe { [weak self] singleEvent in
                self?.view?.hideLoadingView()
                switch singleEvent {
                case .success(let users):
                    print("users: \(users)")

                case .error:
                    // TODO: Show error.
                    break
                }
            }.disposed(by: disposeBag)
        
    }
}
