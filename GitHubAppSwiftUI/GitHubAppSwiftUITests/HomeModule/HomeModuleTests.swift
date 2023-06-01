//
//  GitHubAppTests.swift
//  GitHubAppTests
//
//  Created by Renato Bueno on 28/05/23.
//

import XCTest
@testable import GitHubAppSwiftUI

final class HomeModuleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testViewModelSpyCalls() {
        let viewModel = HomeViewModelSpy(requestable: MockNetworker())
        viewModel.fetchData()
        XCTAssertTrue(viewModel.fetchDataCalled)
        
        _ = viewModel.getDataSource(searchText: "")
        XCTAssertTrue(viewModel.getDataSourceCalled)
        XCTAssertTrue(viewModel.searchText.isEmpty)
        
        _ = viewModel.getDataSource(searchText: "moj")
        XCTAssertEqual(viewModel.searchText, "moj")
    }
    
    @MainActor
    func testViewModelCalls() {
        let viewModel = HomeViewModel(requestable: MockNetworker())
        let exp = XCTestExpectation(description: "waiting for request")
    
        viewModel.fetchData()
        XCTWaiter().wait(for: [exp], timeout: 1.0)
        
        XCTAssertFalse(viewModel.hasError)
        
        XCTAssertEqual(viewModel.getDataSource(searchText: String()).first, HomeDataSource(id: 1, user: "mojombo", imagePath: "https://avatars.githubusercontent.com/u/1?v=4"))
        
        XCTAssertEqual(viewModel.getDataSource(searchText: "Pjhy").first, HomeDataSource(id: 3, user: "pjhyett", imagePath: "https://avatars.githubusercontent.com/u/3?v=4"))
    }
    
    @MainActor
    func testViewModelErrorCalls() {
        let viewModel = HomeViewModel(requestable: MockFailingNetworker())
        let exp = XCTestExpectation(description: "waiting for request")
    
        viewModel.fetchData()
        XCTWaiter().wait(for: [exp], timeout: 1.0)
        
        XCTAssertTrue(viewModel.hasError)
        XCTAssertTrue(viewModel.getDataSource(searchText: String()).isEmpty)
    }
}

fileprivate final class HomeViewModelSpy: ViewModelInputProtocol {
    
    private(set) var fetchDataCalled: Bool = false

    private(set) var searchText: String = String()
    private(set) var getDataSourceCalled: Bool = false
    
    var state: HomeStateType = .loading
    
    var hasError: Bool = false
    private var requestable: NetworkerProtocol = MockNetworker()
    
    func fetchData() {
        fetchDataCalled = true
    }
    
    init(requestable: NetworkerProtocol) {
        self.requestable = requestable
    }

    func getDataSource(searchText: String) -> [HomeDataSource] {
        self.searchText = searchText
        getDataSourceCalled = true
        return []
    }
}
