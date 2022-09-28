//
//  Answer.swift
//  Answer
//
//  Created by Александр on 28.09.2022.
//

import Foundation
struct Answer: Decodable {
    let answer: String?
    let forced: Bool?
    let image: String?
    
    init(_ value: [String: Any]) {
        answer = value["answer"] as? String
        forced = value["forced"] as? Bool
        image = value["image"] as? String
    }
    
    static func getAnswer(from value: Any) -> Answer {
        guard let answerData = value as? [String: Any] else {
            print(2)
            return Answer([:]) }
        return Answer(answerData)
    }
}
