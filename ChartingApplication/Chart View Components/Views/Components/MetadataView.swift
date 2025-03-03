//
//  MetadataView.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/14/25.
//

import SwiftUI
struct MetadataView: View
{
    var metadata: CoinMetadata?
    var body: some View
    {
        if let metadata = metadata
        {
            VStack
            {
                HStack
                {
                    if let logoURL = metadata.logoURL, let url = URL(string: logoURL)
                    {
                        AsyncImage(url: url)
                        {
                            image in
                            image.resizable()
                        }
                    placeholder:
                        {
                            ProgressView()
                        }
                        .frame(width: 25, height: 25)
                    }
                    Text(metadata.name)
                        .font(.headline)
                }.padding()
                Text(metadata.coinDescription ?? "No description available.")
                    .font(.subheadline)
            }
            .padding()
        }
        else
        {
            Text("Loading metadata...")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    
    }
}
