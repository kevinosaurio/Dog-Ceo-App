//
//  DogBreedDetailInteractor.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 06-02-22.
//

import Foundation

class DogBreedDetailInteractor<M>:DogBreedBaseInteractor<M>, DogBreedDetailInteractorProtocol where M: DogBreedDetailDataStoreProtocol {
    var selectedBreed: DogBreed {
        dataStore.breed.selected
    }
    
    var selectedSubBreed: String? {
        dataStore.breed.selectedSubBreed
    }
    
    func callGetData(completion: @escaping (Error?) -> Void) {
        dataStore.getImagesFromCloud(completion: completion)
    }
    
    func getImagesUrl() -> [String] {
        dataStore.imagesUrlString
    }
}
