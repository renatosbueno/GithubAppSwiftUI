//
//  UserDetailView.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 30/05/23.
//

import SwiftUI

struct UserDetailView<ViewModel>: View where ViewModel: UserDetailViewModelInputProtocol {
    
    @ObservedObject var viewModel: ViewModel = .init(requestable: Networker(), username: String())
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    enum CellType: Hashable, Identifiable {
       
        case user(dto: UserDetailInfo)
        case repo(dto: UserRepoData)
        
        var id: Self {
            return self
        }
    }
    
    private func setupCellType(dataSource: AgroupedUserDetailData) -> [[CellType]] {
        let repoCells: [CellType] = dataSource.userRepos.compactMap({ .repo(dto: $0) })
        return [[.user(dto: dataSource.userDetail)], repoCells]
    }
    
    var body: some View {
        NavigationStack {
            List {
                switch viewModel.state {
                case .success(dto: let dataSource):
                    if let dataSource = dataSource as? AgroupedUserDetailData {
                        let cellTypes = setupCellType(dataSource: dataSource)
                        
                        ForEach(cellTypes, id: \.self) { cellType in
                            ForEach(cellType) { type in
                                switch type {
                                case .user(dto: let dto):
                                    let userDto = UserView.DTO(title: dto.name ?? String(), imagePath: dto.avatarUrl)
                                    let location = dto.location ?? String()
                                    let followers = dto.followers ?? 0
                                    let userInfoDto = UserDetailInfoView.DTO(leftTitle: "\(Strings.UserDetailInfo.locationTitle) \(location)", rightTitle: "\(Strings.UserDetailInfo.followersTitle) \(followers)", topInfoDto: userDto)
                                    
                                    UserDetailInfoView(dto: userInfoDto, theme: UserDetailInfoViewDefaultTheme())
                                    
                                case .repo(dto: let dto):
                                    let repoDto = RepoView.DTO(title: dto.name,
                                                               leftTitle: dto.language ?? String(),
                                                               centerTitle: "\(dto.stargazersCount)", rightTitle: "\(dto.forksCount)", centerIconImage: Image(systemName: Strings.SFSymbolsStrings.star), righIconImage: Image(systemName: Strings.SFSymbolsStrings.fork))
                                    RepoView(dto: repoDto, theme: RepoViewDefaultTheme())
                                }
                            }
                        }
                        
                    } else {
                        EmptyView()
                    }
                case .loading:
                    ProgressView()
                        .padding()
                default:
                    EmptyView()
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(viewModel.username)
            
        }
        .task {
            viewModel.fetchData()
        }
        .alert(Strings.ErrorMessage.alert,
               isPresented: $viewModel.hasError,
               presenting: viewModel.state) { handling in
            Button(Strings.ErrorMessage.actionTitle) {
                viewModel.fetchData()
            }
            .accessibilityLabel(Strings.ErrorMessage.actionTitle)
        } message: { detail in
            if case .failed(errorMessage: let message) = detail {
                Text(message)
                    .accessibilityLabel(message)
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(viewModel: UserDetailViewModel(requestable: Networker(), username: "mojombo"))
    }
}
