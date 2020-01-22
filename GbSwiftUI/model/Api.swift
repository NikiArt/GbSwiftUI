//
//  Api.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 15.01.2020.
//  Copyright © 2020 Nikita Boiko. All rights reserved.
//

import Foundation
import Alamofire

class Api {
    static let shared = Api()
    
    let appId = "6768580"
    let key = "YuQ9DOn25t0BhtZSWCbV"
    let serviceKey = "5335221d5335221d5335221ddc535265d9553355335221d0f373febfb5b04c63e9df51a"
    
    private init() {}
    
    func getFriendsList() -> String? {
        guard !ConnectingPref.shared.token.isEmpty else {
            print("Пользователь не авторизован")
            return nil
        }
        AF.request("https://api.vk.com/method/friends.get?access_token=\(ConnectingPref.shared.token)&fields=nickname,photo_50&v=5.103").responseData(completionHandler: {
            (response) in
            
            guard let data = response.value else {
                return
            }
            do {
                let responseFriends = try JSONDecoder().decode(Response<ResponseFriends>.self, from: data)
                DataBinder.instance.userList = responseFriends.response.items
                DataBinder.instance.getSectionStructure()
                print(responseFriends)
            } catch {
                print(error)
            }
        })
        return ""
    }
    
    func getUserGroupsList() -> String? {
        guard !ConnectingPref.shared.token.isEmpty else {
            print("Пользователь не авторизован")
            return nil
        }
        AF.request("https://api.vk.com/method/groups.get?extended=1&access_token=\(ConnectingPref.shared.token)&v=5.103").responseData(completionHandler: {
            (response) in
            
            guard let data = response.value else {
                return
            }
            do {
                let responseGroups = try JSONDecoder().decode(Response<ResponseGroups>.self, from: data)
                DataBinder.instance.groupList = responseGroups.response.items
                print(responseGroups)
            } catch {
                print(error)
            }
        })
        return ""
    }
    
    func getUserPhotos() -> String? {
        guard !ConnectingPref.shared.token.isEmpty else {
            print("Пользователь не авторизован")
            return nil
        }
        AF.request("https://api.vk.com/method/photos.getAll?count=200&access_token=\(ConnectingPref.shared.token)&v=5.103").responseJSON(completionHandler: {
            (response) in print(response.value)
        })
        return ""
    }
    
    func searchGroups(searchString: String) -> String? {
        guard !ConnectingPref.shared.token.isEmpty else {
            print("Пользователь не авторизован")
            return nil
        }
        AF.request("https://api.vk.com/method/groups.search?q=\(searchString)&access_token=\(ConnectingPref.shared.token)&v=5.103").responseJSON(completionHandler: {
            (response) in print(response.value)
        })
        return ""
    }
    
    struct ResponseFriends: Decodable {
        var count: Int
        var items: [User]
    }
    
    struct ResponseGroups: Decodable {
        var count: Int
        var items: [Group]
    }
    
    struct Response<T: Decodable>: Decodable {
        var response: T
    }
    
}
