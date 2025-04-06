//
//  SensorComponent.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/6/25.
//

import SwiftUI

struct SensorComponent: View {
    
    
    var body: some View {
        
        Section{
            HStack{
                VStack{
                    Text("135")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Online")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.green.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                VStack{
                    Text("2")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Low")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                VStack{
                    Text("0")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Offline")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.red.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }header: {
            HStack{
                Text("Sensors")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Text("All Sensors")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .padding(.vertical)
            .background(.white)
        }
    }
}

#Preview {
    SensorComponent()
}
