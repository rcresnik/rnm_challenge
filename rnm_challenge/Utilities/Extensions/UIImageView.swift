//
//  UIImage.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

extension UIImageView {
    func image(from url: URL?, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = url
            else {
                return
        }
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async() {
                UIView.transition(with: self,
                                  duration: 0.75,
                                  options: .transitionCrossDissolve,
                                  animations: { self.image = image },
                                  completion: nil)
            }
            }.resume()
    }
}
