//
//  DogBreedInteractor.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import Foundation

class DogBreedsInteractor<M>:DogBreedBaseInteractor<M> where M: DogBreedsDataStoreProtocol {}

extension DogBreedsInteractor: DogBreedsInteractorProtocol {
    var breeds: [DogBreed]? {
        dataStore.breeds
    }
    
    func breed(for index: Int) -> DogBreed? {
        guard index < breeds?.count ?? 0 else {
            return nil
        }
        return breeds?[index]
    }
    
    func callGetData(completion: @escaping (Error?) -> Void) {
        dataStore.getBreedsFromCloud(completion: completion)
    }
    
    func subBreeds(for index: Int) -> [String]? {
        return breed(for: index)?.subBreeds
    }
}
