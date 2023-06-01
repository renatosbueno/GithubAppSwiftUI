//
//  UserDetailViewModel.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 31/05/23.
//

import Foundation

protocol UserDetailViewModelInputProtocol: ObservableObject {
    associatedtype DataSource: Equatable
    
    var state: RenderStateType<DataSource> { get }
    var username: String { get }
    var hasError: Bool { get set }
    func fetchData()
    init(requestable: NetworkerProtocol, username: String)
}

final class UserDetailViewModel: UserDetailViewModelInputProtocol {

    @Published var state: RenderStateType<DataSource> = .loading
    @Published var hasError: Bool = false
    typealias DataSource = AgroupedUserDetailData
    
    private var requestable: NetworkerProtocol
    private var data: AgroupedUserDetailData?
    var username: String = String()
    
    init(requestable: NetworkerProtocol, username: String) {
        self.requestable = requestable
        self.username = username
    }
    
    @MainActor
    func fetchData() {
        Task.init {
            state = .loading
            hasError = false
            do {
                self.data = try await UserDetailsRequestFacade(requestable: requestable, username: username).fetch()
                guard let data = self.data else {
                    state = .none
                    return
                }
                state = .success(dto: data)
            } catch {
                state = .failed(errorMessage: Strings.ErrorMessage.title)
                hasError = true
            }
        }
    }
    
}
