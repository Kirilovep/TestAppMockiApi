//
//  Network.swift
//  TestAppMockiApi
//
//  Created by shizo663 on 15.03.2021.
//

import Foundation
import UIKit
class NetworkManager {
        
    static func fetchData(_ completionHandler: @escaping (FeedModel?) -> ()) {
        if let url = URL(string: Network.api.rawValue) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                }
                
                if response != nil {
                    
                }
                
                if let data = data {
                    let objects = try? JSONDecoder().decode(FeedModel.self, from: data)
                    completionHandler(objects)
                }
            }
            task.resume()
        }
    }
}
