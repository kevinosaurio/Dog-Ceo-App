//
//  Dog_Ceo_AppTests.swift
//  Dog Ceo AppTests
//
//  Created by Kevin Bolivar on 05-02-22.
//

import XCTest
@testable import Dog_Ceo_App

class DogBreeedsTest: XCTestCase {

    override func setUpWithError() throws {
        DogNetwork.shared.setConfig(DogNetWorkConfig(isMock: true))
    }
    
    //MARK: - DataStore
    func testBreedsDataStoreSuccess() {
        DogNetwork.shared.setMocks([.allBreeds:"allJson"])
        let dataStore = DogBreedsDataStore()
        let mockExpectation = expectation(description: "Mock")
        dataStore.getBreedsFromCloud { error in
            XCTAssertNil(error)
            XCTAssertFalse(dataStore.breeds?.isEmpty ?? true)
            mockExpectation.fulfill()
        }
        wait(for: [mockExpectation], timeout: 2)
    }
    
    func testBreedsDataStoreError() {
        DogNetwork.shared.setMocks([.allBreeds:"allJsonError"])
        let dataStore = DogBreedsDataStore()
        let mockExpectation = expectation(description: "Mock")
        dataStore.getBreedsFromCloud { error in
            XCTAssertNotNil(error)
            mockExpectation.fulfill()
        }
        wait(for: [mockExpectation], timeout: 2)
    }
    
    //MARK: - Interactor
    func testBreedsInteractor() {
        DogNetwork.shared.setMocks([.allBreeds:"allJson"])
        let interactor = DogBreedsInteractor(dataStore: DogBreedsDataStore())
        XCTAssertNil(interactor.breeds)
        XCTAssertNil(interactor.breed(for: 100))
        XCTAssertNil(interactor.subBreeds(for: 100))
        let mockExpectation = expectation(description: "Mock")
        interactor.callGetData { error in
            XCTAssertNil(error)
            XCTAssertNotNil(interactor.breed(for: 0))
            XCTAssertNotNil(interactor.subBreeds(for: 1))
            mockExpectation.fulfill()
        }
        wait(for: [mockExpectation], timeout: 2)
    }
    
    //MARK: - Presenter
    func testBreedsPresenter() {
        DogNetwork.shared.setMocks([.allBreeds:"allJson"])
        let presenter = DogBreedsPresenter(interactor: DogBreedsInteractor(dataStore: DogBreedsDataStore()))
        let view = MyTestView()
        view.testExpectation = expectation(description: "Test")
        presenter.view = view
        XCTAssertEqual(presenter.getBreedCount(), 0)
        XCTAssertEqual(presenter.getSubBreedCount(for: 100), 0)
        XCTAssertNil(presenter.getSubBreedName(for: IndexPath(row: 0, section: 0)))
        XCTAssertNil(presenter.getBreedName(for: 0))
        presenter.callData()
        wait(for: [view.testExpectation!], timeout: 2)
        XCTAssertEqual(presenter.getBreedCount(), 2)
        XCTAssertEqual(presenter.getSubBreedCount(for: 1), 1)
        XCTAssertNotNil(presenter.getSubBreedName(for: IndexPath(row: 0, section: 1)))
        XCTAssertNotNil(presenter.getBreedName(for: 0))
        let router = MyTestRouter()
        router.testExpectation = expectation(description: "Test")
        presenter.router = router
        
        presenter.selectBreed(for: IndexPath(row: 0, section: 1))
        wait(for: [router.testExpectation!], timeout: 2)
    }
}

//MARK: - View Helper
class MyTestView: UIViewController, DogBreedBaseViewProtocol {
    var testExpectation: XCTestExpectation?
    func showLoading() {
        fulfillIsNeed()
    }
    
    func showErrorView(message: String) {
        fulfillIsNeed()
    }
    
    func refreshView() {
        fulfillIsNeed()
    }
    
    func fulfillIsNeed() {
        guard let testExpectation = testExpectation else {
            return
        }
        testExpectation.fulfill()
    }
}

class MyTestRouter: DogBreedsRouterProtocol {
    var testExpectation: XCTestExpectation?
    func showDetailView(in vc: UIViewController, dogBreed: DogBreed, selectedSubBreed: String?) {
        guard let testExpectation = testExpectation else {
            return
        }
        testExpectation.fulfill()
    }
}
