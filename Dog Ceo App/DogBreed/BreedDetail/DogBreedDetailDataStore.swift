//
//  DogBreedDetailDataStore.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 06-02-22.
//

import Foundation

class DogBreedDetailDataStore: DogBreedDetailDataStoreProtocol {
    let breed: (selected: DogBreed, selectedSubBreed: String?)
    var imagesUrlString: [String] = []
    
    init(breed:(selected: DogBreed, selectedSubBreed: String?)) {
        self.breed = breed
    }
    
    func getImagesFromCloud(completion: @escaping (Error?) -> Void) {
        DogNetwork.shared.callGetBreedImages(breed: breed.selected.name,
                                             subBreed: breed.selectedSubBreed,
                                             completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.imagesUrlString = data.message
                completion(nil)
            case .failure(let error): completion(error)
            }
        })
    }
}
