//
//  QuizRepository.swift
//  QuizApp
//
//  Created by Andrea Stanic on 05.06.2021..
//

class QuizRepository {
    
    private let networkDataSource: QuizNetworkDataSource
    private let databaseDataSource: QuizDatabaseDataSource
    
    init(networkDataSource: QuizNetworkDataSource, databaseDataSource: QuizDatabaseDataSource) {
        self.networkDataSource = networkDataSource
        self.databaseDataSource = databaseDataSource
    }
    
    func fetchRemoteData() throws {
        let quizzes = try networkDataSource.fetchQuizzesFromNetwork()
        coreDataSource.saveNewQuizzes(quizzes)
    }

    func fetchLocalData(filter: FilterSettings) -> [Quiz] {
        coreDataSource.fetchQuizzesFromCoreData(filter: filter)
    }

    func deleteLocalData(withId id: Int) {
        coreDataSource.deleteQuiz(withId: id)
    }
}


