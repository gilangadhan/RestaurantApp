//
//  ProfileView.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack {
                    Image("ahmad_suyadi")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(75)
                    Text("Ahmad Suyadi ").font(.title)
                    Text("ahmadsuyadi@outlook.com")
                }
            }
        }
        .navigationBarTitle(
            Text("Profile"),
            displayMode: .automatic)
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
