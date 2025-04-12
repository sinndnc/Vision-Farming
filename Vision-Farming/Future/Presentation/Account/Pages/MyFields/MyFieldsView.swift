//
//  MyFieldsView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/11/25.
//

import SwiftUI

struct MyFieldsView: View {
    
    let fields : [Farm : [Field]]
    
    var body: some View {
        List{
            ForEach(fields.keys.sorted{ $0.uid == $1.uid }, id: \.self) { farm in
                let fieldsOfFarm = fields[farm] ?? []
                ForEach(fieldsOfFarm, id:\.self) { field in
                    Section{
                        NavigationLink{
                            Text("Hey")
                        }label:{
                            Text(field.name)
                        }
                    }header:{
                        Text(farm.name)
                    }
                }
            }
        }
        .navigationTitle(Text("My Fields"))
    }
}

#Preview {
    MyFieldsView(fields: [:])
}
