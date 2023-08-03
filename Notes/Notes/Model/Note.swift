//
//  Note.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import FirebaseFirestore

struct Note {
    let title: String
    let content: String
    let timeStamp: Timestamp
    
    func toDictionary() -> [String: Any] {
        return [
            "title": self.title,
            "content": self.content,
            "time": self.timeStamp
        ]
    }
    
    static func convertToModelArray(dictionaryArray: [Dictionary<String, Any>]) -> [Note] {
        return dictionaryArray.map { dict in
            let title = dict["title"] as? String ?? ""
            let content = dict["content"] as? String ?? ""
            let timeStamp = dict["timeStamp"] as? Timestamp ?? Timestamp()
            return Note(title: title, content: content, timeStamp: timeStamp)
        }
    }
}
