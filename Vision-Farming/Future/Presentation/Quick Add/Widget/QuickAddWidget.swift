//
//  QuickAddWidget.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/25/25.
//

import SwiftUI

struct QuickAddWidget: View {
    
    var item : QuickAddItem
    
    var body: some View {
        NavigationLink(value: item.value){
            VStack{
                Image(systemName: item.image)
                    .frame(width: 30,height: 30)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray.opacity(0.5),lineWidth: 2)
                    }
                Text(item.name)
                    .font(.caption)
            }
        }
        .padding(5)
        .tint(.black)
        .frame(width: 80,height: 95,alignment: .top)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    QuickAddWidget(item: QuickAddItem(name: "",image: "",value: .crop))
}
