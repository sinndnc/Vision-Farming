//
//  SensorsView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/21/25.
//

import SwiftUI

struct SensorsView: View {
    
    let fields : [Farm : [Field]]
    let sensors : [Field :[Sensor]]
        
    var body: some View {
        List{
            ForEach(fields.keys.sorted{$0.uid == $1.uid }, id: \.self) { farm in
                let fieldsOfFarm = fields[farm] ?? []
                ForEach(fieldsOfFarm, id:\.self) { field in
                    let sensorsOfField = sensors[field] ?? []
                    Section{
                        ForEach(sensorsOfField,id:\.self){ sensor in
                            NavigationLink {
                                Text("Hey")
                            } label: {
                                HStack{
                                    Text(sensor.name)
                                    Spacer()
                                    Text("\(sensorsOfField.count)")
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                    }header:{
                        Text(field.name)
                    } footer:{
                        Text(farm.name)
                    }
                }
            }
        }
        .navigationTitle("Sensors")
    }
    
    struct SensorRowView: View {
        
        var sensors: [Sensor]
        
        var body: some View {
            List{
                
            }
        }
    }
    
}


#Preview {
    NavigationStack{
        SensorsView(fields:[:],sensors: [:])
    }
}
