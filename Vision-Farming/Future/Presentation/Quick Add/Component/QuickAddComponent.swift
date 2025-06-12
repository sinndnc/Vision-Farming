//
//  QuickAddComponent.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/26/25.
//

import SwiftUI

struct QuickAddComponent: View {
    
    let label : String
    @State var items : [QuickAddItem]
    
    var body: some View {
        VStack(alignment:.leading){
            Text(label)
                .font(.headline)
                .padding(.horizontal)
            Grid(alignment: .topLeading) {
                ForEach(items.chunked(into: 4), id: \.self) { items in
                    GridRow {
                        ForEach(items, id: \.self) { item in
                            QuickAddWidget(item: item)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    QuickAddComponent(label: "",items: [])
}
