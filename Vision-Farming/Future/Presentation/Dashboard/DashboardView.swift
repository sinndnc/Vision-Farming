//
//  DashboardView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject private var viewModel: DashboardViewModel = .init()
    
    var body: some View {
        GeometryReader { GeometryProxy in
            NavigationStack(){
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30){
                        WeatherWidget()
                        SoilMoistureWidget()
                        SensorWidget()
                    }
                }
                .padding(.horizontal)
                .navigationTitle(Text("Dashboard"))
                .toolbar {
                    Button{
                        
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func SoilMoistureWidget() -> some View {
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
    }
    
    @ViewBuilder
    func SensorWidget() -> some View {
        VStack{
            HStack{
                Text("Sensors")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Text("All Sensors")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
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
        }
    }
    
    @ViewBuilder
    func WeatherWidget() -> some View {
        VStack{
            HStack{
                Text("Todays Weather")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
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
        }
    }
}

#Preview {
    DashboardView()
}
