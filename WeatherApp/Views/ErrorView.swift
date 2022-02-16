//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-14.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    
    let errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                    .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text(errorText)
        }
        .padding()
    }
}
