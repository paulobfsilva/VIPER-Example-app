//
//  Interactor.swift
//  VIPER
//
//  Created by Paulo Silva on 03/09/2021.
//

import Foundation

// object
// needs a protocol
// reference to the presenter
// it's job it to interact, get data and hand it to the presenter
// API calls...

// https://jsonplaceholder.typicode.com/users

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
                
            } catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
            
        }
    }
}
