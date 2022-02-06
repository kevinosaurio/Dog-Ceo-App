//
//  DogBreedDataStore.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import Foundation

class DogBreedsDataStore: DogBreedsDataStoreProtocol {
    var breeds: [DogBreed]?
    
    func getBreedsFromCloud(completion: @escaping (Error?) -> Void) {
        DogNetwork.shared.callBreeds { [weak self] result in
            switch result {
            case .success(let data):
                var breeds = [DogBreed]()
                data.message.forEach { (key,value) in
                    breeds.append(DogBreed(name: key, subBreeds: value))
                }
                self?.breeds = breeds.sorted(by: { $0.name < $1.name })
                completion(nil)
            case .failure(let error): completion(error)
            }
        }
    }
}
