//
//  RepoView.swift
//  GitHubAppSwiftUI
//
//  Created by Renato Bueno on 31/05/23.
//

import SwiftUI

struct RepoView: View {
    
    private var dto: RepoView.DTO
    private var isLoading: Bool = false
    private var theme: RepoViewThemeProtocol = RepoViewDefaultTheme()
    
    struct DTO: Equatable {
        let title, leftTitle, centerTitle, rightTitle: String
        var centerIconImage, righIconImage: Image
    }
    
    init(dto: RepoView.DTO, isLoading: Bool = false, theme: RepoViewThemeProtocol = RepoViewDefaultTheme()) {
        self.dto = dto
        self.isLoading = isLoading
        self.theme = theme
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: theme.vStackSpacing) {
            Text(dto.title)
                .font(theme.titleLabelFont)
                .accessibilityLabel(dto.title)
                .foregroundColor(theme.titleLabelTextColor)
                .redacted(reason: isLoading ? .placeholder : [])
                .padding()
            HStack {
                Text(dto.leftTitle)
                    .font(theme.descriptionLabelFont)
                    .accessibilityLabel(dto.leftTitle)
                    .foregroundColor(theme.descriptionLabelTextColor)
                    .redacted(reason: isLoading ? .placeholder : [])
                Spacer()
                dto.centerIconImage
                    .foregroundColor(theme.iconTintColor)
                    .redacted(reason: isLoading ? .placeholder : [])
                Text(dto.centerTitle)
                    .font(theme.descriptionLabelFont)
                    .accessibilityLabel(dto.centerTitle)
                    .foregroundColor(theme.descriptionLabelTextColor)
                    .redacted(reason: isLoading ? .placeholder : [])
                dto.righIconImage
                    .foregroundColor(theme.iconTintColor)
                    .redacted(reason: isLoading ? .placeholder : [])
                Text(dto.rightTitle)
                    .font(theme.descriptionLabelFont)
                    .accessibilityLabel(dto.rightTitle)
                    .foregroundColor(theme.descriptionLabelTextColor)
                    .redacted(reason: isLoading ? .placeholder : [])
                    .padding([.trailing])
            }
            .padding()
        }
    }
}

struct RepoView_Previews: PreviewProvider {
    static var previews: some View {
        RepoView(dto: .mock, isLoading: false)
    }
}

extension RepoView.DTO {
    static let mock = RepoView.DTO(title: "30daysoflaptops.github.io", leftTitle: "Javascript", centerTitle: "7", rightTitle:  "10", centerIconImage: Image(systemName: "star"), righIconImage: Image(systemName: "tuningfork"))
}
