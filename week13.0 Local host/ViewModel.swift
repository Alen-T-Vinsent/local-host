//
//  ViewModel.swift
//  week13.0 Local host
//
//  Created by Apple  on 06/12/22.
//

import Foundation
import SwiftUI


class ViewModel:ObservableObject{
    @Published var items = [PostModel]()
    //    let prefixUrl = "http://127.0.0.1:8000"
    let prefixUrl = "http://localhost:3000"
    @Published  var array1 = Array<String>()
    init(){
        fetchPosts()
    }
    
    
    
    
    func fetchPosts(){
        guard let url = URL(string: "\(prefixUrl)/post") else {
            
            
            print("Not found url")
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if error != nil{
                print("error - - - -  " , error?.localizedDescription ?? "")
                return
            }
            
            print(url)
            do{
                if let data = data{
                    
                    print("data is this from fetch === \(data)")
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    print(" result.data - - - - - \(result.data)")
                    DispatchQueue.main.async {
                        self.items = result.data
                    }
                }else{
                    print("No data")
                }
                
            }catch let JsonError{
                print("fetch json error : ",JsonError.localizedDescription)
            }
        }
        .resume()
    }
    
    
    
    
    
    func createPost2(parameters:[String:Any]){
        guard let url = URL(string: "\(prefixUrl)/createPost") else {
            print("Not found url")
            return
        }
        
        let session = URLSession.shared
        
        var request = URLRequest(url:url)
        
        request.httpMethod = "POST"
        
        do{
            
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, res, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
    }
    
    
    
    
    
    func createPost(parameters:[String:Any]){
        
        print(parameters)
        
        guard let url = URL(string: "\(prefixUrl)/createPost") else {
            print("Not found url")
            return
        }
        
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        //        print("data is this from fetch ++++ \(data)")
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = data
        //        print("url -- -- \(url)")
        //        print("data is this \(data)" )
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with:request) { data ,res ,error in
            if error != nil{
                print("error 1")
                print("error - - - -  " , error?.localizedDescription ?? "nil coleasing")
                return
            }
            
            if let data = data{
                do{
                    let decoder = JSONDecoder()
                    
                    let user  = try decoder.decode(DataModel.self,from: data)
                    DispatchQueue.main.async {
                        self.items = user.data
                        print(" result.data create post - - - - - \(user.data)")
                        print(" self.items create post - - - - - \(self.items)")
                    }
                }catch let err{
                    print("error 2  catch of create \(err.localizedDescription)")
                }
            }else{
                print("no data is available to post from create post")
            }
        }
        .resume()
    }
    
    
    
    
    func updatePost(parameters:[String:Any]){
        guard let url = URL(string: "\(prefixUrl)/updatePost") else {
            print("Not found url")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url:url)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { data, res, error in
            if error != nil{
                print("error - - - -  " , error?.localizedDescription ?? "failed to print error" )
                return
            }
            
            do{
                if let data = data{
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        self.items = result.data
                    }
                }else{
                    print("No data")
                }
                
            }catch let JsonError{
                print("fetch json error : ",JsonError.localizedDescription)
            }
        }
        .resume()
    }
    
    
    
    
    
    
    
    func deletePost(parameters:[String:Any]){
        guard let url = URL(string: "\(prefixUrl)/deletePost") else {
            print("Not found url")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url:url)
        request.httpMethod = "DELETE"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { data, res, error in
            if error != nil{
                print("error - - - -  " , error?.localizedDescription)
                return
            }
            
            do{
                if let data = data{
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        self.items = result.data
                    }
                }else{
                    print("No data")
                }
                
                
            }catch let JsonError{
                print("fetch json error : ",JsonError.localizedDescription)
            }
        }
        .resume()
    }
}
