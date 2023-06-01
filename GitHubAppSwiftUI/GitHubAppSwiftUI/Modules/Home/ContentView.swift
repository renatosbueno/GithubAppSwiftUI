//
//  ContentView.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 29/05/23.
//

import SwiftUI

struct ContentView<ViewModel>: View where ViewModel: ViewModelInputProtocol {
    
    @ObservedObject var viewModel: ViewModel = .init(requestable: Networker())
    @State var searchText = String()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                switch viewModel.state {
                case .success:
                    let grids = [GridItem(.flexible()), GridItem(.flexible())]
                    LazyVGrid(columns: grids, spacing: 16) {
                        ForEach(viewModel.getDataSource(searchText: searchText), id: \.id) { source in
                            ZStack {
                                NavigationLink {
                                    UserDetailView(viewModel: UserDetailViewModel(requestable: Networker(), username: source.user))
                                } label: {
                                    let dto = UserView.DTO(title: source.user, imagePath: source.imagePath, imageDescription: "\(Strings.UserDetailInfo.imageDescription) \(source.user)")
                                    UserView(dto: dto, theme: UserViewDefaultTheme())
                                }
                            }
                        }
                    }
                    
                case .loading:
                    ProgressView()
                default:
                    EmptyView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Strings.Home.navigationTitle)
        }
        .accentColor(.black)
        .task {
            viewModel.fetchData()
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: HomeViewModel(requestable: Networker()))
    }
}
