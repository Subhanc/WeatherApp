//
//  ProfileView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Created by:")
                .font(.system(size: 20, weight: .semibold, design: .default))
                .foregroundColor(.secondary)
            Text("Subhan Chaudhry")
            .font(.system(size: 30, weight: .regular, design: .default))
            
            VStack(spacing: 10) {
                Button("Resume") {UIApplication.shared.open(URL(string: "https://drive.google.com/file/d/1CpnM3mrM9Sah3Bn9WRtXzFs6qaFuBD9b/view")!)}
                Button("LinkedIn") {UIApplication.shared.open(URL(string: "https://www.linkedin.com/in/subhanchaudhry/")!)}
                Button("Github") {UIApplication.shared.open(URL(string: "https://github.com/subhanc")!)}

            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
