//
//  Question+CD.swift
//  QuizApp
//
//  Created by Andrea Stanic on 06.06.2021..
//

import CoreData

extension Question {

    init(with entity: CDQuestion) {
        answers = entity.answers ?? []
        correctAnswer = Int(entity.correctAnswer)
        id = Int(entity.id)
        question = entity.question ?? ""
    }

    func populate(_ entity: CDQuestion) {
        entity.answers = answers
        entity.correctAnswer = Int16(correctAnswer)
        entity.id = Int16(id)
        entity.question = question
    }

}
