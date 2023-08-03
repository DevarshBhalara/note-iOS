//
//  Note.swift
//  DemoProject
//
//  Created by Devarsh Bhalara on 02/08/23.
//

import FirebaseFirestore

struct Note {
    let id: String
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
    
    static func convertToModelArray(dictionaryArray: [Dictionary<String, Any>], ids: [String]) -> [Note] {
        var start = 0
        return dictionaryArray.map { dict in
            let id = ids[start]
            let title = dict["title"] as? String ?? ""
            let content = dict["content"] as? String ?? ""
            let timeStamp = dict["timeStamp"] as? Timestamp ?? Timestamp()
            start += 1
            return Note(id: id, title: title, content: content, timeStamp: timeStamp)
        }
    }
    
    static func convertToModel(dictionary: Dictionary<String, Any>, id: String) -> Note {
        let id = id
        let title = dictionary["title"] as? String ?? ""
        let content = dictionary["content"] as? String ?? ""
        let timeStamp = dictionary["timeStamp"] as? Timestamp ?? Timestamp()
        return Note(id: id, title: title, content: content, timeStamp: timeStamp)
    }
    
}
