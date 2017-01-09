//
//  AutoManufacturerPresenterTests.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import XCTest
@testable import AutoCatalog

class AutoManufacturerPresenterTests: XCTestCase {
    
    class AutoManufacturerViewMock:AutoManufacturerViewProtocol {
        var manufacturerDataDisplayed = false
        var noContentMessagedDisplayed = false
        var showLoadingViewDisplayed = false
        
        func displayManufactures(manufacturer: [AutoManufacturerItem]?) {
            manufacturerDataDisplayed = true
        }
        
        func noContentMessage(message: String) {
            noContentMessagedDisplayed = true
        }
        
        func showLoadinView(show: Bool) {
            showLoadingViewDisplayed = true
        }
        
        var presenter: AutoManufacturerPresenterProtocol?
    }
    
    class AutoManufacturerWireFrameMock:AutoManufacturerWireFrameProtocol{
    
        var autoModelsWireframe:AutoModelsWireFrameProtocol?
        
        var alertDisplayed = false
        var displayAutoModelsView = false
        
        func presentAlertMessage(message:String){
            alertDisplayed = true
        }
        
        func navigateToAutoModelsViewController(manufacturer:AutoManufacturerItem){
            displayAutoModelsView = true
        }
        
    }
    
    class AutoManufacturerInteractorMock: AutoManufacturerInteractorInputProtocol{
        
        weak var presenter: AutoManufacturerInteractorOutputProtocol?
        
        var APIDataManager: AutoManufacturerDataManagerProtocol?
        
        var expectationResult:XCTestExpectation?
        
        let manufacturers = [Manufacturer(id: "10", name: "BMW"),Manufacturer(id: "11", name: "GM"), Manufacturer(id: "12", name: "VW"), Manufacturer(id: "14", name: "AUDI")]
        
        func getManufacturers(page:Int, pageSize:Int){
            
            presenter?.provideManufacturerList(manufacturer: manufacturers, error: nil)
            
            guard let ex = expectationResult else {
                XCTFail("AutoManufacturer interator not setup correctly. Missing XCTestExpectation reference")
                return
            }
            
            DispatchQueue.main.async {
                ex.fulfill()
            }
            
        }
        
    }
    
    var view:AutoManufacturerViewMock!
    var sut:AutoManufacturerPresenter!
    var interactor:AutoManufacturerInteractorMock!
    var wireframe:AutoManufacturerWireFrameMock!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = AutoManufacturerPresenter()
        view = AutoManufacturerViewMock()
        interactor = AutoManufacturerInteractorMock()
        wireframe = AutoManufacturerWireFrameMock()
        
        view.presenter = sut
        sut.view = view
        sut.wireFrame = wireframe
        sut.interactor = interactor
        interactor.presenter =  sut
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDisplayManufacturers(){
        
        let expectationResult = expectation(description: "Get Manufacturer list")
        interactor.expectationResult = expectationResult
        
        sut.fetchManufacturers()
        
        XCTAssertTrue(view.showLoadingViewDisplayed)

        waitForExpectations(timeout: 3) { [unowned self] error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertTrue(self.view.manufacturerDataDisplayed, "Displayed manufacurer data")
        }
    }
    

    
}
