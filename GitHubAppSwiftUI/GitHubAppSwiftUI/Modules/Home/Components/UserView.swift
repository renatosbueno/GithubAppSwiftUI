//
//  UserView.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 29/05/23.
//

import SwiftUI

struct UserView: View {
    
    private var dto: DTO
    private var theme: UserViewThemeProtocol = UserViewDefaultTheme()
    
    init(dto: DTO, theme: UserViewThemeProtocol = UserViewDefaultTheme()) {
        self.dto = dto
        self.theme = theme
    }
    
    struct DTO {
        let title, imagePath: String
        var imageDescription: String?
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: dto.imagePath)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: theme.imageContentMode)
                    .accessibilityLabel(dto.imageDescription ?? String())
            } placeholder: {
                Color.gray
            }
            .border(theme.borderColor)
            .foregroundColor(.clear)
            .clipShape(Circle())
            Spacer(minLength: theme.stackSpacing)
            Text(dto.title)
                .font(theme.titleLabelFont)
                .foregroundColor(theme.titleLabelTextColor)
                .accessibilityLabel(dto.title)
        }
        .padding(theme.spacing)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(dto: .mockValue)
    }
}
fileprivate extension UserView.DTO {
    
    static let mockValue = UserView.DTO(title: "Mojombo", imagePath: "https://avatars.githubusercontent.com/u/1?v=4")
    
}
