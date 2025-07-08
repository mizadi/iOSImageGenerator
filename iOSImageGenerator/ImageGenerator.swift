//
//  ImageGenerator.swift
//  iOSImageGenerator
//
//  Created by Adi Mizrahi on 08/07/2025.
//


import Foundation
import UIKit
import ImagePlayground

enum ImageGenerator {
    static func generate(from prompt: String) async throws -> UIImage? {
        let creator = try await ImageCreator()
        let results = creator.images(for: [.text(prompt)], style: .illustration, limit: 1)

        if let first = try await results.first(where: { _ in true }) {
            return UIImage(cgImage: first.cgImage)
        }

        return nil
    }
}
