//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import SwiftUI

struct ForcastDetailsView: View {
    let forcastDetails: ForcastDetails
    var body: some View {
        VStack {
          Text(forcastDetails.main)
          Text("Description: \(forcastDetails.description)")
          AsyncImage(url: forcastDetails.icon) { image in
                  image.frame(width: 100, height: 100)
              } placeholder: {
                  ProgressView()
            }
        }
    }
}
