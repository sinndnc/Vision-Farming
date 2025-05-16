//
//  CategoryWidget.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI
import Foundation

struct CategoryWidget : View {
    
    let category : Category
    
    var body: some View {
        VStack(alignment: .center){
            if let data = category.image, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50,height: 50)
                    .overlay{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray, lineWidth: 1)
                    }
            }else{
                ProgressView()
                    .frame(width: 50,height: 50)
            }
            Text(category.name)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal,5)
        
    }
}
