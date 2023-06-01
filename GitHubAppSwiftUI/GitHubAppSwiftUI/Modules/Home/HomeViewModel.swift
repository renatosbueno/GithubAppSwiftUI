//
//  HomeViewModel.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 29/05/23.
//

import SwiftUI

protocol ViewModelInputProtocol: ObservableObject {
    
    var state: HomeStateType { get }
    var hasError: Bool { get set }
    func fetchData()
    init(requestable: NetworkerProtocol)
    func getDataSource(searchText: String) -> [HomeDataSource]
}

final class HomeViewModel: ViewModelInputProtocol {
    
    @Published var state: HomeStateType = .loading
    @Published var hasError: Bool = false
    
    private lazy var userRequest: UserRequestProtocol = {
        return UserRequestWorker(requestable: requestable)
    }()
    private var users: [User] = []
    private var dataSource: [HomeDataSource] = []
    private var requestable: NetworkerProtocol
    
    init(requestable: NetworkerProtocol) {
        self.requestable = requestable
    }
    
    private func formatDataSource(from userData: [User]) -> [HomeDataSource] {
        return userData.compactMap({ HomeDataSource(id: $0.id, user: $0.login, imagePath: $0.avatarUrl) })
    }
    
    func getDataSource(searchText: String) -> [HomeDataSource] {
        if searchText.isEmpty {
            return formatDataSource(from: users)
        } else {
            let filteredUsers = users.filter({ $0.login.contains(searchText.lowercased()) })
            return formatDataSource(from: filteredUsers)
        }
    }
    
    @MainActor
    func fetchData() {
        state = .loading
        hasError = false
        Task.init {
            do {
                self.users = try await userRequest.fetchData()
                self.dataSource = formatDataSource(from: self.users)
                state = dataSource.isEmpty ? .none : .success
            } catch let error {
                let errorMessage = error.localizedDescription.isEmpty ? Strings.ErrorMessage.title : error.localizedDescription
                state = .failed(errorMessage: errorMessage)
                hasError = true
            }
        }
    }
    

}
