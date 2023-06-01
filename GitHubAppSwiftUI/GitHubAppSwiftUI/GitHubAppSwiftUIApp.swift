//
//  GitHubAppSwiftUIApp.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 29/05/23.
//

import SwiftUI

@main
struct GitHubAppSwiftUIApp: App {
    var body: some Scene {
        WindowGroup<ContentView> {
            ContentView(viewModel: HomeViewModel(requestable: Networker()))
        }
    }
}
