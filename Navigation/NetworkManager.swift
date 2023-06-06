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
    
    func requestFromUrl1 (completion: @escaping (_ title: String)-> Void) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")!
        
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
            
            do {

                guard let answer  = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] else {
                    print ("answer do not cast to [Any]")
                    return
                }
                
                guard let item = answer.randomElement() as? [String: Any] else {
                    print ("item do not cast to [String: Any]")
                    return
                    }
                
                guard let title = item ["title"] as? String else {
                    print ("title not found")
                    return
                }
                completion(title)
                
            } catch {
                print (error)
            }
        }
    
        dataTask.resume()
    }
    
    func requestFromUrl2 (completion: @escaping (_ answer: String)-> Void) {
        
        let url = URL(string: "https://swapi.dev/api/planets/1")!
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
            
            do {
                let decoder = JSONDecoder()
                let item = try decoder.decode(Planet.self, from: data)
                let answer = item.orbitalPeriod
                completion(answer)
                
            } catch {
                print (error)
            }
        }
        dataTask.resume()
    }
    
    func requestResidentsArray (completion: @escaping (_ answer: [String])-> Void) {
        
        let url = URL(string: "https://swapi.dev/api/planets/1")!
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
            
            do {
                let decoder = JSONDecoder()
                let item = try decoder.decode(Planet.self, from: data)
                let answer = item.residents
                completion(answer)
                
            } catch {
                print (error)
            }
        }
        dataTask.resume()
    }
    
    
    func requestResidentName (url: String, completion: @escaping (_ name: String)-> Void) {
        
        let url = URL(string: url)!
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
            
            do {
                let decoder = JSONDecoder()
                let resident = try decoder.decode(Residents.self, from: data)
                let name = resident.name
                completion(name)
                
            } catch {
                print (error)
            }
        }
        dataTask.resume()
    }
    
}

enum AppConfiguration: String, CaseIterable {
    
    case url1 = "https://swapi.dev/api/people/8"
    case url2 = "https://swapi.dev/api/starships/3"
    case url3 = "https://swapi.dev/api/planets/5"
    
}

struct Planet: Decodable {
    
    
    var orbitalPeriod: String
    var residents: [String]
    
    enum CodingKeys: String, CodingKey{
        case orbitalPeriod = "orbital_period"
        case residents
    }
    
}

struct Residents: Decodable {
    var name: String
}



