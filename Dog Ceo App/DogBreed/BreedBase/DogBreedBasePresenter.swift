//
//  DogBreedBasePresenter.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 06-02-22.
//

import Foundation
import UIKit

class DogBreedBasePresenter<Interactor:DogBreedBaseInteractorProtocol> {
    let interactor: Interactor
    weak var view: (DogBreedBaseViewProtocol & UIViewController)?
    
    init(interactor: Interactor) {
        self.interactor = interactor
    }
    
    func callData() {
        self.view?.showLoading()
        self.interactor.callGetData { [weak self] error in
            DispatchQueue.main.async {
                guard let error = error else {
                    self?.view?.refreshView()
                    return
                }
                self?.view?.showErrorView(message: error.localizedDescription)
            }
        }
    }
}
