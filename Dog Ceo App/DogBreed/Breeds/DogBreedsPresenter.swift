//
//  DogBreedPresenter.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import Foundation
import UIKit

class DogBreedsPresenter<I>:DogBreedBasePresenter<I> where I:DogBreedsInteractorProtocol {
    var router: DogBreedsRouterProtocol?
}

extension DogBreedsPresenter: DogBreedsPresenterProtocol {
    func getBreedCount() -> Int {
        interactor.breeds?.count ?? 0
    }
    
    func getBreedName(for index: Int) -> String? {
        return interactor.breed(for: index)?.name
    }
    
    func getSubBreedName(for indexPath: IndexPath) -> String? {
        guard let subBreeds = interactor.subBreeds(for: indexPath.section), indexPath.row < subBreeds.count else {
            return nil
        }
        return subBreeds[indexPath.row]
    }
    
    func getSubBreedCount(for index: Int) -> Int {
        interactor.subBreeds(for: index)?.count ?? 0
    }
    
    func selectBreed(for indexPath: IndexPath) {
        guard let view = view, let selectedBreed = interactor.breed(for: indexPath.section) else {
            return
        }
        router?.showDetailView(in: view,
                               dogBreed: selectedBreed,
                               selectedSubBreed: indexPath.row < selectedBreed.subBreeds.count ? selectedBreed.subBreeds[indexPath.row]:nil)
    }
}

