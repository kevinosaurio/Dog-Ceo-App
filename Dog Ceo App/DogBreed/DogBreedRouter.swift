//
//  DogBreedFactory.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import Foundation
import UIKit

public class DogBreedRouter:DogBreedsRouterProtocol {
    func showDetailView(in vc: UIViewController, dogBreed: DogBreed, selectedSubBreed: String?) {
        let presenter = DogBreedDetailPresenter(interactor: DogBreedDetailInteractor(dataStore: DogBreedDetailDataStore(breed: (selected: dogBreed, selectedSubBreed: selectedSubBreed))))
        let view = DogBreedDetailViewController(style: .plain, presenter: presenter)
        presenter.view = view
        vc.navigationController?.pushViewController(view, animated: true)
    }
}

// MARK: - Public functions
public extension DogBreedRouter {
    static func getDogBreedViewController() -> UIViewController {
        let presenter = DogBreedsPresenter(interactor: DogBreedsInteractor(dataStore: DogBreedsDataStore()))
        let view = DogBreedsViewController(style: .grouped, presenter: presenter)
        presenter.view = view
        presenter.router = DogBreedRouter()
        return view
    }
}

