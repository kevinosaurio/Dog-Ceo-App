//
//  DogNetWork.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import Foundation

public enum DogNetworkError: Error, LocalizedError {
    case badUrl, generic
    
    public var errorDescription: String? {
        return "Tuvimos un problema, intenta nuevamente."
    }
}

public struct DogNetWorkConfig {
    public let baseUrl: String
    public let isMock: Bool
    
    public init(baseUrl: String = DogNetworkConstants.defaultBaseUrl,
                isMock: Bool = false) {
        self.baseUrl = baseUrl
        self.isMock = isMock
    }
}

public class DogNetwork {
    //MARK: - Public properties
    public static let shared = DogNetwork()
    //MARK: - Private properties
    private var config = DogNetWorkConfig()
    
    func callGetRequest<T:Decodable>(path: DogNetworkConstants.Path, completion: @escaping (Result<T,Error>) -> Void) {
        guard let url = URL(string: config.baseUrl + path.string) else {
            return completion(.failure(DogNetworkError.badUrl))
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data, let json = try? JSONDecoder().decode(T.self, from: data) else {
                return completion(.failure(error ?? DogNetworkError.generic))
            }
            completion(.success(json))
        }

        task.resume()
    }
}

//MARK: Public Functions
public extension DogNetwork {
    func setConfig(_ config: DogNetWorkConfig){
        self.config = config
    }
    
    func callBreeds(completion: @escaping (Result<DogBreedCloudData<[String:[String]]>,Error>) -> Void) {
        callGetRequest(path: DogNetworkConstants.Path.allBreeds, completion: completion)
    }
    
    func callGetBreedImages(breed: String,
                            subBreed: String?,
                            completion: @escaping (Result<DogBreedCloudData<[String]>,Error>) -> Void) {
        callGetRequest(path: DogNetworkConstants.Path.imageBreed(breed, subBreed: subBreed), completion: completion)
    }
}
