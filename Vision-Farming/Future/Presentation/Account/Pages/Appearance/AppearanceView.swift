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
                Label {
                    HStack{
                        Text("Theme")
                        Spacer()
                        Menu {
                            VStack{
                                ForEach(Theme.allCases,id: \.rawValue){ theme in
                                    Button {
                                        viewModel.setTheme(theme)
                                    } label: {
                                        Text("\(theme.rawValue.capitalized) Mode")
                                    }
                                }
                            }
                        } label: {
                            Text(viewModel.currentTheme.rawValue.capitalized)
                                .foregroundStyle(.gray)
                            Image(systemName: "arrow.up.and.down")
                                .foregroundStyle(.gray)
                        }
                    }
                } icon: {
                    Image(systemName: "moon")
                }
                
                Label {
                    HStack{
                        Text("Language")
                        Spacer()
                        Menu {
                            VStack{
                                ForEach(Language.allCases,id: \.rawValue){ language in
                                    Button {
                                        viewModel.setLanguage(language)
                                    } label: {
                                        Text("\(language.rawValue.capitalized)")
                                    }
                                }
                            }
                        } label: {
                            Text(viewModel.currentLanguage.rawValue.capitalized)
                                .foregroundStyle(.gray)
                            Image(systemName: "arrow.up.and.down")
                                .foregroundStyle(.gray)
                        }
                    }
                } icon: {
                    Image(systemName: "translate")
                }
               
            }
        }
        .navigationTitle("Appearance")
    }
}


extension Theme{
    
    var toColorScheme : ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return .none
        }
    }
}

#Preview {
    NavigationStack{
        AppearanceView()
    }
}
