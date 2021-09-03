//
//  Router.swift
//  VIPER
//
//  Created by Paulo Silva on 03/09/2021.
//

import UIKit

// Object
// Entry point of the architecture
typealias Entrypoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: Entrypoint? { get }
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
    var entry: Entrypoint?
    
    static func start() -> AnyRouter {
        // create all of the components of VIPER and return
        let router = UserRouter()
        // Assign the other VIP
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? Entrypoint
        
        return router
    }
    
    
}
