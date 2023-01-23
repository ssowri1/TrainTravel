//
//  UrlSession.swift
//  MyTravelHelper
//
//  Created by Sowrirajan S on 23/01/23.
//  Copyright © 2023 Sample. All rights reserved.
//

import Foundation
import XMLParsing

class ServiceWorker: NSObject {
    
    class func fetch<T: Codable>(url: URL, closureHandler: @escaping(T) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (responseData, _, error) in
            
            guard error == nil else { return }
            
            guard let response = responseData else { return }
            
            do {
                let data = try XMLDecoder().decode(T.self, from: response)

                closureHandler(data)
                
            } catch {
                print("Error found :: refer Service Worker")
            }
        }.resume()
    }
}
