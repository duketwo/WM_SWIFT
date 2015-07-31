//
//  Player.swift
//  WM
//
//  Created by DB on 22/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//


// {"firstName":"Nicolas Alexis Julio","lastName":"N'Koulou N'Doubena","nickname":"N. N'Koulou","nationality":"Cameroon","age":24,"birthDate":"1990-03-27T00:00:00.000Z","birthCountry":"Cameroon","birthCity":"Yaoundé","position":"Defender","foot":"Right","image":"http://cache.images.globalsportsmedia.com/soccer/players/150x150/39105.png","heightCm":180,"weightKg":77,"goals":0,"ownGoals":0,"penaltyGoals":0,"assists":0,"teamId":"DF25ABB8-37EB-4C2A-8B6C-BDA53BF5A74D","clubId":"5AF524A1-830C-4D75-8C54-2D0BA1F9BE33","id":"D9AD1E6D-4253-4B88-BB78-0F43E02AF016","type":"Player"}
// firstName, lastName, nickName, nationality, age, birthDate, birthCountry, birthCity, position, foot, imageUrl, heightCm, weightKg, goals
// ownGoals, penaltyGoals, assists, teamId, clubId, id, type

import UIKit

class Player: NSObject {
    
    var firstName: String?
    var lastName: String?
    var nickname: String?
    var nationality: String?
    var age: Int?
    var birthDate: String?
    var birthCountry : String?
    var birthCity : String?
    var position : String?
    var foot : String?
    var imageUrl : String?
    var heightCm : Int?
    var weightKg : Int?
    var goals : Int?
    var ownGoals : Int?
    var pentalyGoals : Int?
    var assists : Int?
    var teamId : Int?
    var clubId : Int?
    var id : Int?
    var type : String?
    
    init(firstName: String?, lastName: String?, nationality: String?, age:Int?, goals: Int?, imageUrl: String?, birthCity: String?) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.nationality = nationality
        self.age = age
        self.birthCity = birthCity
        self.goals = goals
        self.imageUrl = imageUrl
    }
    
}
