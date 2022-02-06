//
//  DogBreedContract.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import Foundation
import UIKit

//MARK: - Base
protocol DogBreedBaseViewProtocol: AnyObject {
    func showLoading()
    func showErrorView(message: String)
    func refreshView()
}

protocol DogBreedBasePresenterProtocol: AnyObject {
    func callData()
}

protocol DogBreedBaseInteractorProtocol: AnyObject {
    func callGetData(completion: @escaping (Error?) -> Void)
}

//MARK: - Breeds
protocol DogBreedsPresenterProtocol: DogBreedBasePresenterProtocol  {
    func getBreedCount() -> Int
    func getSubBreedCount(for index: Int) -> Int
    func getSubBreedName(for indexPath: IndexPath) -> String?
    func getBreedName(for index: Int) -> String?
    func selectBreed(for indexPath: IndexPath)
}

protocol DogBreedsInteractorProtocol: DogBreedBaseInteractorProtocol {
    var breeds: [DogBreed]? { get }
    func subBreeds(for index: Int) -> [String]?
    func breed(for index: Int) -> DogBreed?
}

protocol DogBreedsDataStoreProtocol: AnyObject {
    var breeds: [DogBreed]? {get set}
    func getBreedsFromCloud(completion: @escaping (Error?) -> Void)
}

protocol DogBreedsRouterProtocol: AnyObject {
    func showDetailView(in vc: UIViewController, dogBreed: DogBreed, selectedSubBreed: String?)
}

//MARK: - Detail
protocol DogBreedDetailDataStoreProtocol: AnyObject {
    var breed:(selected:DogBreed,selectedSubBreed:String?) {get}
    var imagesUrlString: [String] {get set}
    func getImagesFromCloud(completion: @escaping (Error?) -> Void)
}

protocol DogBreedDetailInteractorProtocol: DogBreedBaseInteractorProtocol {
    var selectedBreed: DogBreed { get }
    var selectedSubBreed: String? { get }
    func getImagesUrl() -> [String] 
}

protocol DogBreedDetailPresenterProtocol: DogBreedBasePresenterProtocol  {
    var breedName: String { get }
    var subBreedName: String? { get }
    func getImagesCount() -> Int
    func getImage(for index:Int) -> String
}
