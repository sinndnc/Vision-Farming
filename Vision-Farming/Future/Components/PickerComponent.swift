//
//  PickerComponent.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/6/25.
//

import SwiftUI
import Foundation

protocol SelectableItem: Identifiable, Hashable {
    var displayText: String { get }
}

struct PickerComponent<T: SelectableItem>:View {
    
    @Binding var selection: T?
    let label: String
    let options: [T]
    
    var body: some View {
        Menu {
            Picker("Select", selection: $selection) {
                ForEach(options) { item in
                    Text(item.displayText).tag(item)
                }
            }
        } label: {
            HStack(spacing: 4) {
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                Text(selection?.displayText ?? "")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Image(systemName: "chevron.down")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
        .tint(.black)
    }
}
