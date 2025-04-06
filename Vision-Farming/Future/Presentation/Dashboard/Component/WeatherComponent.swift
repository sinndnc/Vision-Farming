//
//  WeatherComponent.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/6/25.
//

import SwiftUI
import Foundation


struct WeatherComponent : View{
    
    var body : some View {
        Section{
            VStack(alignment: .leading,spacing: 20){
                HStack{
                    Image(systemName: "location.fill")
                        .font(.callout)
                    Text("Istanbul Turkiye")
                        .font(.headline)
                        .fontWeight(.medium)
                    Spacer()
                }
                HStack{
                    Text("+16")
                        .fontWeight(.semibold)
                        .font(.largeTitle)
                    VStack{
                        Text("H: 19")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray)
                        Text("L: 13")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                Divider()
                HStack{
                    VStack{
                        Image(systemName: "humidity")
                        Text("Humidity")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Text("74%")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    Spacer()
                    VStack{
                        Image(systemName: "cloud.drizzle")
                        Text("Precipitation")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Text("5mm")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    Spacer()
                    VStack{
                        Image(systemName: "tirepressure")
                        Text("Pressure")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Text("1019 hPa")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    Spacer()
                    VStack{
                        Image(systemName: "wind")
                        Text("Wind")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Text("10 km/h")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }header: {
            HStack{
                Text("Todays Weather")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.vertical)
            .background(.white)
        }
    }
}
