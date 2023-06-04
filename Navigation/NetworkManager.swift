//
//  NetworkManager.swift
//  Navigation
//
//  Created by Александр Филатов on 31.05.2023.
//

import Foundation

struct NetworkManager {
    
    func request (for configuration: AppConfiguration) {
        
        let url = URL(string: configuration.rawValue)!
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: url) { data, responce, error in
            
            if let error {
                print (error.localizedDescription)
                return
            }
            
            if (responce as? HTTPURLResponse)?.statusCode != 200 {
                print ("responce != 200")
            }
            
            guard let data else {
                print ("data is nil")
                return
            }
            
            print ("------------DATA----------------")
            let str = String(decoding: data, as: UTF8.self)
            print (str)
            print ("-------------STATUS-CODE---------------")
            print ((responce as? HTTPURLResponse)?.statusCode as Any)
            print ("-------------ALL-HEADERS-FIELDS---------------")
            print ((responce as? HTTPURLResponse)?.allHeaderFields as Any)

        }
    
        dataTask.resume()
    }
    
}

enum AppConfiguration: String, CaseIterable {
    
    case url1 = "https://swapi.dev/api/people/8"
    case url2 = "https://swapi.dev/api/starships/3"
    case url3 = "https://swapi.dev/api/planets/5"
    
}




