//
//  KeyEntryView.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/14/25.
//

import SwiftUI

struct KeyEntryView: View {
    @State private var apiKey: String = KeychainHelper.shared.get("api_key") ?? ""
    @State private var isSecure: Bool = true

    var body: some View {
        VStack {
            Text("Enter API Key")
                .font(.headline)

            HStack {
                if isSecure {
                    SecureField("API Key", text: $apiKey)
                } else {
                    TextField("API Key", text: $apiKey)
                }
                Button(action: { isSecure.toggle() }) {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            Button("Save API Key") {
                KeychainHelper.shared.save("api_key", value: apiKey)
            }
            .buttonStyle(.borderedProminent)
            .padding()

            Button("Delete API Key") {
                KeychainHelper.shared.delete("api_key")
                apiKey = ""
            }
            .foregroundColor(.red)
        }
        .padding()
    }
}

#Preview {
    KeyEntryView()
}
