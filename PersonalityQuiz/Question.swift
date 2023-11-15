//
//  Question.swift
//  PersonalityQuiz
//
//  Created by user243757 on 10/5/23.
//

import Foundation

struct Question{
    var text:String
    var type:ResponseType
    var answers:[Answer]
}

enum ResponseType{
    case single, multiple, ranged
}

struct Answer{
    var text: String
    var type: AnswerTYpe
}

enum AnswerTYpe :Character{
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"
    
    var definition :String{
        switch self{
        case .dog:
            return "You are incredibly outgoing. You surround yourself with people you love and enjoy activities with your friends."
        case .cat:
            return "Mischevious yet mild-tempered, you enjoy doing things in your own terms."
        case .rabbit:
            return "You love everything that's soft. You are healthy and full of energy."
        case .turtle:
            return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
        }
    }
}


