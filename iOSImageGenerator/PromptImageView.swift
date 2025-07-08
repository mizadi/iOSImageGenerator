//
//  PromptImageView.swift
//  iOSImageGenerator
//
//  Created by Adi Mizrahi on 08/07/2025.
//


import SwiftUI

struct PromptImageView: View {
    @State private var prompt: String = ""
    @State private var image: UIImage? = nil
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter your prompt...", text: $prompt)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: {
                    generateImage(from: prompt)
                }) {
                    Text("Generate Image")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(prompt.trimmingCharacters(in: .whitespaces).isEmpty)
                .padding(.horizontal)

                if isLoading {
                    ProgressView("Generating...")
                        .padding()
                } else if let uiImage = image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                        .cornerRadius(12)
                        .padding()
                } else if let error = errorMessage {
                    Text("⚠️ \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .navigationTitle("AI Image Generator")
        }
    }

    private func generateImage(from prompt: String) {
        isLoading = true
        image = nil
        errorMessage = nil

        Task {
            do {
                let generatedImage = try await ImageGenerator.generate(from: prompt)
                image = generatedImage
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}

#Preview {
    PromptImageView()
}
