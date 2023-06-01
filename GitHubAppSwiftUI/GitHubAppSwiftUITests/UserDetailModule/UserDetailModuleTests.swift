//
//  UserDetailModuleTests.swift
//  GitHubAppTests
//
//  Created by Renato Bueno on 28/05/23.
//

import XCTest
@testable import GitHubAppSwiftUI

final class UserDetailModuleTests: XCTestCase {

    private var username = "roland"

    func testViewModelSpy() {
        let viewModel = UserDetailViewModelSpy(requestable: MockNetworker(), username: username)
        viewModel.fetchData()
        XCTAssertTrue(viewModel.fetchDataCalled)
    }
    
    @MainActor
    func testSuccessfullFlow() {
        let viewModel = UserDetailViewModel(requestable: MockNetworker(), username: username)
        
        let exp = XCTestExpectation(description: "waiting for request")
        viewModel.fetchData()
        XCTWaiter().wait(for: [exp], timeout: 1.0)
        
        XCTAssertFalse(viewModel.hasError)
        guard case RenderStateType.success(dto: let data) = viewModel.state else {
            return
        }
        let dataSource = data
        let mockUserDetail = UserDetailInfo(avatarUrl: "https://avatars.githubusercontent.com/u/28?v=4",
                                            login: "roland",
                                            location: "Tirana",
                                            name: "Roland Guy",
                                            id: 28,
                                            followers: 22)
        
        let mockRepoDetail = UserRepoData(id: 26899533,
                                          forksCount: 4,
                                          stargazersCount: 7,
                                          name: "30daysoflaptops.github.io",
                                          language: "CSS")
        
        XCTAssertEqual(dataSource.userDetail, mockUserDetail)
        XCTAssertEqual(dataSource.userRepos.first, mockRepoDetail)
    }

    @MainActor
    func testErrorFlow() {
        let viewModel = UserDetailViewModel(requestable: MockFailingNetworker(), username: username)
        
        let exp = XCTestExpectation(description: "waiting for request")
    
        viewModel.fetchData()
        XCTWaiter().wait(for: [exp], timeout: 1.0)
        
        XCTAssertTrue(viewModel.hasError)
    }

}

fileprivate final class UserDetailViewModelSpy: UserDetailViewModelInputProtocol {
 
    typealias DataSource = AgroupedUserDetailData
    
    var state: RenderStateType<DataSource> = .loading
    var hasError: Bool = false
    var username: String
    private var requestable: NetworkerProtocol = MockNetworker()
    
    init(requestable: NetworkerProtocol, username: String) {
        self.requestable = requestable
        self.username = username
    }
    
    private(set) var fetchDataCalled: Bool = false
    
    func fetchData() {
        fetchDataCalled = true
    }
}
