//
//  DogBreedBasePresenter.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 06-02-22.
//

import Foundation

class DogBreedBaseInteractor<M: AnyObject> {
    let dataStore: M
    
    init(dataStore: M) {
        self.dataStore = dataStore
    }
}
