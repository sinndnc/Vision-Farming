//
//  SoilMoistureComponent.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/6/25.
//

import SwiftUI

struct SoilMoistureComponent: View {
    var body: some View {
        Section{
            HStack{
                VStack{
                    ZStack{
                        Circle()
                            .stroke(lineWidth: 1)
                            .opacity(0.2)
                            .foregroundColor(.blue)
                        Circle()
                            .trim(from: 0.0, to: 0.45)
                            .stroke(
                                AngularGradient(gradient: Gradient(colors: [.blue, .cyan]), center: .center),
                                style: StrokeStyle(lineWidth: 1, lineCap: .butt)
                            )
                            .rotationEffect(Angle(degrees: -90))
                            .animation(.easeInOut, value: 0.45)
                        VStack {
                            Text("\(Int(0.45 * 100))%")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            
                            Text("12 Fields")
                                .font(.caption)
                        }
                    }
                    Text("Low")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                }
                VStack{
                    
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 1)
                            .opacity(0.2)
                            .foregroundColor(.blue)
                        
                        Circle()
                            .trim(from: 0.0, to: 0.5)
                            .stroke(
                                AngularGradient(gradient: Gradient(colors: [.blue, .cyan]), center: .center),
                                style: StrokeStyle(lineWidth: 1, lineCap: .butt)
                            )
                            .rotationEffect(Angle(degrees: -90))
                            .animation(.easeInOut, value: 0.5)
                        VStack {
                            Text("\(Int(0.5 * 100))%")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            
                            Text("25 Fields")
                                .font(.caption)
                        }
                    }
                    Text("Optimal")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                }
                VStack{
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 1)
                            .opacity(0.2)
                            .foregroundColor(.blue)
                        
                        Circle()
                            .trim(from: 0.0, to: 0.5)
                            .stroke(
                                AngularGradient(gradient: Gradient(colors: [.blue, .cyan]), center: .center),
                                style: StrokeStyle(lineWidth: 1, lineCap: .butt)
                            )
                            .rotationEffect(Angle(degrees: -90))
                            .animation(.easeInOut, value: 0.5)
                        VStack {
                            Text("\(Int(0.5 * 100))%")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            
                            Text("25 Fields")
                                .font(.caption)
                        }
                    }
                    Text("High")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                }
            }
        }header: {
            HStack{
                Text("SoilMoisture")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                HStack{
                    Text("Today")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Image(systemName: "calendar")
                }
                .padding(10)
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding(.vertical)
            .background(.white)
        }
    }
}

#Preview {
    SoilMoistureComponent()
}
