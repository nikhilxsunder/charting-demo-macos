//
//  SwiftUIView.swift
//  test
//
//  Created by Nikhil Sunder on 1/23/25.
//

import SwiftUI

// Splash View
struct SplashView: View
{
    @State private var isActive: Bool = false
    var body: some View
    {
        VStack
        {
            if self.isActive
            {
                MainView()
            }
            else
            {
                Image("SplashIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text("Loading...")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding()
            }
        }
        .onAppear
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2)
            {
                withAnimation
                {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview
{
    SplashView()
        .frame(width: 1600, height: 900)
}

