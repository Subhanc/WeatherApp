//
//  Image.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import SwiftUI

extension Image {
    enum Icon {
        case newspaper
        case profile
        case placeholder
        case chevronRight
        case chevronLeft
    }
    init(icon: Icon) {
        switch icon {
       
        case .newspaper:
            self.init(systemName: "newspaper.fill")
        case .profile:
            self.init(systemName: "person.2.fill")
        case .placeholder:
            self.init(systemName: "staroflife.fill")
        case .chevronRight:
            self.init(systemName: "chevron.right")
        case .chevronLeft:
            self.init(systemName: "chevron.left")
        }
    }
}


extension UIImage {
    
    /// Passing in API url
    convenience init(fromUrl url: String) {
        /// Creates a url
        let imageURL = URL(string: url)
        
        /// Downloading the image from the given url
        if let imageData = try? Data(contentsOf: imageURL!) {
            print("DownloadedImage")
            self.init(data: imageData)!
        } else {
            print("Failed to download image from: \(url)")
            self.init()
        }
    }
}
