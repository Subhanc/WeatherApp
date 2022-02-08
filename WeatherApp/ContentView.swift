//
//  ContentView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
        
        
            .onAppear {
                Service.shared.fetchSevenDayForcast { result in
                    print(result)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
