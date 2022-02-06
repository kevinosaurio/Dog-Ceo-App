//
//  DogBreedDetailPresenter.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 06-02-22.
//

import Foundation
import UIKit

class DogBreedDetailPresenter<I>:DogBreedBasePresenter<I> where I:DogBreedDetailInteractorProtocol {}

extension DogBreedDetailPresenter: DogBreedDetailPresenterProtocol {
    func getImage(for index: Int) -> String {
        interactor.getImagesUrl()[index]
    }
    
    func getImagesCount() -> Int {
        interactor.getImagesUrl().count
    }

    var breedName: String {
        interactor.selectedBreed.name
    }
    
    var subBreedName: String? {
        interactor.selectedSubBreed
    }
}
