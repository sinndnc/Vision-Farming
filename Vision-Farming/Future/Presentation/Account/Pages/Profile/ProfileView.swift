//
//  ProfileView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import SwiftUI

struct ProfileView: View {
    
    
    var body: some View {
        List{
            Section {
                Image(systemName: "")
                    .frame(width: 150,height: 150)
                    .background(.gray)
                    .clipShape(Circle())
            }
            .frame(width: 350)
            .listRowBackground(Color.clear)
            Section{
                HStack{
                    Text("Name & Surname")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("Sinan Dinç")
                        .font(.subheadline)
                }
                HStack{
                    Text("Email")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("Sinandinc77@icloud.com")
                        .font(.subheadline)
                }
                HStack{
                    Text("Phone")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("+90")
                        .font(.subheadline)
                    Text("536 636 0880")
                        .font(.subheadline)
                }
                VStack(alignment: .leading,spacing: 10){
                    Text("Address")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("Ismet Paşa Mahallesi, Yahya Kemal Sokak Sokak No:1 Daire No:1 Yalova/Turkey")
                        .font(.subheadline)
                }
            }header: {
                Text("Personel Infos")
            }
            Section{
                NavigationLink {
                    ZStack {
                        
                    }
                } label: {
                    Text("Change Password")
                        .font(.subheadline)
                }
                NavigationLink {
                    ZStack {
                        
                    }
                } label: {
                    Text("Two Factor Authentication (2FA)")
                        .font(.subheadline)
                }
                NavigationLink {
                    ZStack {
                        
                    }
                } label: {
                    Text("Account Transactions")
                        .font(.subheadline)
                }
            }header: {
                Text("Security & Privacy")
            }
            Section{
                Text("Account Transactions")
                    .font(.subheadline)
            }header: {
                Text("Information & Permissions")
            }
        }
    }
}

#Preview {
    NavigationStack{
        ProfileView()
    }
}
