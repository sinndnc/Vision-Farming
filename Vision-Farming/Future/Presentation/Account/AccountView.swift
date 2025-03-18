//
//  AccountView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/14/25.
//

import MapKit
import SwiftUI

struct AccountView: View {
    
    @State var position : MapCameraPosition = .automatic
    @StateObject private var viewModel : AccountViewModel = .init()
    
    @State var polygon : [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 37.68794,longitude: 32.52410),
        CLLocationCoordinate2D(latitude: 37.69794,longitude: 32.52410),
        CLLocationCoordinate2D(latitude: 37.69794,longitude: 32.53410),
        CLLocationCoordinate2D(latitude: 37.68794,longitude: 32.53410)
    ]
    
    var body: some View{
        GeometryReader{ geoProxy in
            NavigationStack{
                VStack{
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(1...3,id: \.self){ int in
                                
                            }
                        }
                    }
                }
                .navigationTitle(Text("Account"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            //TODO: profil resmi yapılacak
                        } label: {
                            Image(systemName: "person.circle")
                                .font(.title2)
                        }
                    }
                }
                .background(.black)
            }
        }
    }
    
    @ViewBuilder
    func MapWidget(polygon : [CLLocationCoordinate2D]) -> some View {
        VStack{
            Map(initialPosition: position){
                MapPolygon(coordinates: polygon)
            }
            .ignoresSafeArea(edges: .all)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack{
                VStack(alignment: .leading){
                    Text("Empty Field")
                        .font(.footnote)
                    Text("10h")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Image(systemName: "arrow.right")
            }
        }
        .padding(10)
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    AccountView()
}
