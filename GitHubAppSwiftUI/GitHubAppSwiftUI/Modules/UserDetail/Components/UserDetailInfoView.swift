//
//  UserDetailInfoView.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 31/05/23.
//

import SwiftUI

struct UserDetailInfoView: View {
    
    private var dto: UserDetailInfoView.DTO
    private var theme: UserDetailInfoViewThemeProtocol = UserDetailInfoViewDefaultTheme()
    
    struct DTO {
        let leftTitle: String
        let rightTitle: String
        let topInfoDto: UserView.DTO
    }
    
    init(dto: UserDetailInfoView.DTO, theme: UserDetailInfoViewThemeProtocol = UserDetailInfoViewDefaultTheme()) {
        self.dto = dto
        self.theme = theme
    }
    
    var body: some View {
        VStack {
            UserView(dto: dto.topInfoDto, theme: UserViewDefaultTheme())
            Spacer(minLength: theme.spacing)
            HStack {
                Text(dto.leftTitle)
                    .font(theme.leftLabelFont)
                    .foregroundColor(theme.leftLabelTextColor)
                    .accessibilityLabel(dto.leftTitle)
                Text(dto.rightTitle)
                    .font(theme.rightLabelFont)
                    .foregroundColor(theme.rightLabelTextColor)
                    .accessibilityLabel(dto.rightTitle)
                    .padding()
            }
        }
    }
}

struct UserDetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailInfoView(dto: .mock)
    }
}
fileprivate extension UserDetailInfoView.DTO {
    
    static let mock = UserDetailInfoView.DTO(leftTitle: "Location: San Francisco", rightTitle: "Followers: 23502", topInfoDto: UserView.DTO(title: "Tom Preston-Werner", imagePath: "https://avatars.githubusercontent.com/u/3?v=4"))
}
