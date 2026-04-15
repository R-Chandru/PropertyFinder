//
//  ImageCarouselView.swift
//  Tahudu
//
//  Created by Chandru R on 14/04/26.
//

import SwiftUI

struct ImageCarouselView: View {

    let images: [String]

    var body: some View {
        TabView {
            ForEach(Array(images.enumerated()), id: \.offset) { _, image in
                Image(image)
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(height: AppConstants.Size.carouselHeight)
        .tabViewStyle(.page)
        .clipped()
    }
}
