//
//  QuestionModel.swift
//  Trivia
//
//  Created by Jason Morales on 10/5/23.
//

import Foundation

struct Question : Codable {
    var categoryFill: String
    var questionFull: String
    var answerList: [String]
    var correct: String
    
    private enum CodingKeys: String, CodingKey {
        case categoryFill = "category"
        case questionFull = "question"
        case answerList = "incorrect_answers"
        case correct = "correct_answer"
    }
}

