//
//  DogBreedCloudStruct.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import Foundation

public struct DogBreedCloudData<M:Decodable>: Decodable {
    let message: M
    let status: String
}
