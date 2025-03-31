//
//  AppearanceView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/21/25.
//

import SwiftUI

struct AppearanceView: View {
    
    @Environment(\.colorScheme) var systemColorScheme
    @StateObject private var viewModel = AppearanceViewModel()

    var body: some View {
        List {
            Section(header: Text("Appearance")) {
                Picker("Theme",selection: $viewModel.themeSetting) {
                    ForEach(Theme.allCases,id: \.self){ theme in
                        Text("\(theme.rawValue)")
                            .font(.callout)
                            .fontWeight(.medium)
                    }
                    .pickerStyle(.menu)
                }
                .font(.callout)
                .fontWeight(.medium)
                
                Picker("Language",selection: $viewModel.languageSetting) {
                    ForEach(Language.allCases,id: \.self){ language in
                        Text("\(language.rawValue)")
                            .font(.callout)
                            .fontWeight(.medium)
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                .font(.callout)
                .fontWeight(.medium)
            }
        }
        .navigationTitle("Appearance")
    }
}



#Preview {
    NavigationStack{
        AppearanceView()
    }
}
