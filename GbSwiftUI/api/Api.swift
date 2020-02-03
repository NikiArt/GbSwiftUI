//
//  Api.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 15.01.2020.
//  Copyright © 2020 Nikita Boiko. All rights reserved.
//

import Foundation
import Alamofire

enum RequestError: Error {
    case failedRequest(message: String)
    case decodableError
}

class Api {
    static let shared = Api()
    
    let appId = "6768580"
    let key = "YuQ9DOn25t0BhtZSWCbV"
    let serviceKey = "5335221d5335221d5335221ddc535265d9553355335221d0f373febfb5b04c63e9df51a"
    let vkUrl = "https://api.vk.com/method/"
    
    private init() {}
    
    func requestServer<T: Decodable>(request: String, params: Parameters, completion: @escaping (Swift.Result<T, Error>)-> Void) {
        AF.request(request, method: .post, parameters: params).responseData{ (response) in
            switch response.result {
            case .failure(let error):
                print(RequestError.failedRequest(message: error.localizedDescription))
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(RequestError.decodableError))
                }
            }
            
        }
    }
    
    func getFriendsList() {
        guard !ConnectingPref.shared.token.isEmpty else {
            print("Пользователь не авторизован")
            return
        }
        
        let requestUrl = vkUrl + "friends.get"
        let params = ["access_token": ConnectingPref.shared.token,
                      "order":"name",
                      "fields":"nickname,photo_100",
                      "v":"5.103"] as [String: Any]
        
        requestServer(request: requestUrl, params: params) { (users: Swift.Result<Response<ResponseFriends>, Error>) in
            switch users {
            case .failure(let error):
                print(error)
            case .success(let friends):
                DbRepo.shared.addToDb(arrayOf: friends.response.items)
            }
        }
    }
    
    func getUserGroupsList() {
        guard !ConnectingPref.shared.token.isEmpty else {
            print("Пользователь не авторизован")
            return
        }
       
        let requestUrl = vkUrl + "friends.get"
        let params = ["access_token": ConnectingPref.shared.token,
                      "extended":"1",
                      "v":"5.103"] as [String: Any]
        
        requestServer(request: requestUrl, params: params) { (groupsRequest: Swift.Result<Response<ResponseGroups>, Error>) in
            switch groupsRequest {
            case .failure(let error):
                print(error)
            case .success(let groups):
                DbRepo.shared.addToDb(arrayOf: groups.response.items)
                DataBinder.instance.groupList = groups.response.items
            }
        }
    }
    
    func getUserPhotos(userId: String) -> String? {
        guard !ConnectingPref.shared.token.isEmpty else {
            print("Пользователь не авторизован")
            return nil
        }
        AF.request("https://api.vk.com/method/photos.getAll?count=200&owner_id=\(userId)&access_token=\(ConnectingPref.shared.token)&v=5.103").responseData(completionHandler: {
            (response) in
            
            guard let data = response.value else {
                return
            }
//            do {
//                let responseGroups = try JSONDecoder().decode(Response<ResponseGroups>.self, from: data)
//                DataBinder.instance.groupList = responseGroups.response.items
//                print(responseGroups)
//            } catch {
//                print(error)
//            }
        })
        return ""
    }
    
    func searchGroups(searchString: String) -> String? {
        guard !ConnectingPref.shared.token.isEmpty else {
            print("Пользователь не авторизован")
            return nil
        }
        AF.request("https://api.vk.com/method/groups.search?q=\(searchString)&access_token=\(ConnectingPref.shared.token)&v=5.103").responseData(completionHandler: {
            (response) in
            
            guard let data = response.value else {
                return
            }
            do {
                let responseGroups = try JSONDecoder().decode(Response<ResponseGroups>.self, from: data)
                DataBinder.instance.globalGroupList = responseGroups.response.items
                //print(responseGroups)
            } catch {
                //print(error)
            }
        })
        return ""
    }
}
