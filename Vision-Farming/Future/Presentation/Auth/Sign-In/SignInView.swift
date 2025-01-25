//
//  SignInView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack {
            TextField("email", text: .constant(""))
            TextField("password", text: .constant(""))
        }
    }
}

#Preview {
    SignInView()
}
