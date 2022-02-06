//
//  DogNetworkConstants.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import Foundation

public enum DogNetworkConstants {
    public static let defaultBaseUrl = "https://dog.ceo/api/"
    
    public enum Path: Hashable {
        case allBreeds
        case imageBreed(_ breed: String, subBreed: String? = nil)
        
        var string: String {
            switch self {
            case .allBreeds: return "breeds/list/all"
            case .imageBreed(let breed, let subBreed):
                let subBreedPath: String = {
                    if let subBreed = subBreed, !subBreed.isEmpty {
                        return "/" + subBreed
                    }
                    return ""
                }()
                return "breed/\(breed)\(subBreedPath)/images"
            }
        }
    }
}
