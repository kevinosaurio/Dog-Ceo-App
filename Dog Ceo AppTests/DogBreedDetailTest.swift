//
//  DogBreedDetailTest.swift
//  Dog Ceo AppTests
//
//  Created by Kevin Bolivar on 06-02-22.
//

import XCTest
@testable import Dog_Ceo_App

class DogBreeedDetailTest: XCTestCase {

    override func setUpWithError() throws {
        DogNetwork.shared.setConfig(DogNetWorkConfig(isMock: true))
    }
    
    //MARK: - DataStore
    func testBreedDetailDataStoreSuccess() {
        let selectedBreed = (selected: DogBreed(name: "perro1", subBreeds: ["perro2"]),
                             selectedSubBreed:"perro2")
        let dataStore = DogBreedDetailDataStore(breed: selectedBreed)
        DogNetwork.shared.setMocks([.imageBreed(selectedBreed.selected.name,
                                                subBreed: selectedBreed.selectedSubBreed):"images"])
        let mockExpectation = expectation(description: "Mock")
        dataStore.getImagesFromCloud { error in
            XCTAssertNil(error)
            XCTAssertFalse(dataStore.imagesUrlString.isEmpty)
            mockExpectation.fulfill()
        }
        wait(for: [mockExpectation], timeout: 2)
    }
    
    func testBreedDetailDataStoreError() {
        let selectedBreed = (selected: DogBreed(name: "perro1", subBreeds: ["perro2"]),
                             selectedSubBreed:"perro2")
        let dataStore = DogBreedDetailDataStore(breed: selectedBreed)
        DogNetwork.shared.setMocks([.imageBreed(selectedBreed.selected.name,
                                                subBreed: selectedBreed.selectedSubBreed):"imagesError"])
        let mockExpectation = expectation(description: "Mock")
        dataStore.getImagesFromCloud { error in
            XCTAssertNotNil(error)
            XCTAssertTrue(dataStore.imagesUrlString.isEmpty)
            mockExpectation.fulfill()
        }
        wait(for: [mockExpectation], timeout: 2)
    }
    
    //MARK: - Interactor
    func testBreedDetailInteractor() {
        let selectedBreed = (selected: DogBreed(name: "perro1", subBreeds: ["perro2"]),
                             selectedSubBreed:"perro2")
        DogNetwork.shared.setMocks([.imageBreed(selectedBreed.selected.name,
                                                subBreed: selectedBreed.selectedSubBreed):"images"])
        let interactor = DogBreedDetailInteractor(dataStore: DogBreedDetailDataStore(breed: selectedBreed))
        XCTAssertEqual(interactor.selectedBreed.name, selectedBreed.selected.name)
        XCTAssertEqual(interactor.selectedSubBreed, selectedBreed.selectedSubBreed)
        XCTAssertTrue(interactor.getImagesUrl().isEmpty)
        let mockExpectation = expectation(description: "Mock")
        interactor.callGetData { error in
            XCTAssertNil(error)
            XCTAssertEqual(interactor.getImagesUrl().count, 2)
            mockExpectation.fulfill()
        }
        wait(for: [mockExpectation], timeout: 2)
    }
    
    //MARK: - Presenter
    func testBreedsPresenter() {
        let selectedBreed = (selected: DogBreed(name: "perro1", subBreeds: ["perro2"]),
                             selectedSubBreed:"perro2")
        DogNetwork.shared.setMocks([.imageBreed(selectedBreed.selected.name,
                                                subBreed: selectedBreed.selectedSubBreed):"images"])
        let presenter = DogBreedDetailPresenter(interactor: DogBreedDetailInteractor(dataStore: DogBreedDetailDataStore(breed: selectedBreed)))
        XCTAssertEqual(presenter.getImagesCount(), 0)
        XCTAssertEqual(presenter.breedName, selectedBreed.selected.name)
        XCTAssertEqual(presenter.subBreedName, selectedBreed.selectedSubBreed)
        XCTAssertNil(presenter.getImage(for: 100))
        presenter.callData()
        XCTAssertEqual(presenter.getImagesCount(), 2)
        XCTAssertNotNil(presenter.getImage(for: 0))
    }
    
    //MARK: - Test Inits
    func testDetailtInits() {
        let selectedBreed = (selected: DogBreed(name: "perro1", subBreeds: ["perro2"]),
                             selectedSubBreed:"perro2")
        XCTAssertFalse(DogNetworkConstants.Path.imageBreed(selectedBreed.selected.name,
                                                           subBreed: selectedBreed.selectedSubBreed).string.isEmpty)
        let vc = DogBreedDetailViewController(style: .plain, presenter: DogBreedDetailPresenter(interactor: DogBreedDetailInteractor(dataStore: DogBreedDetailDataStore(breed: selectedBreed))))
        vc.loadViewIfNeeded()
        XCTAssertNotNil(vc)
    }
}

