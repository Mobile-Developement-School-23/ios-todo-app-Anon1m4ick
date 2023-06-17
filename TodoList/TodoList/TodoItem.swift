import Foundation
struct TodoItem{
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let isDone: Bool
    let createDate: Date
    let changeDate: Date?
    
    enum Importance: String{
        case low = "неважная"
        case normal = "обычная"
        case high = "важная"
    }
}

extension TodoItem{
    init(id: String? = nil, text: String, importance: Importance, deadline: Date? = nil, isDone: Bool, createDate: Date = Date() ,changeDate: Date? = nil){
        self.id = id ?? UUID().uuidString
        self.text = text
        self.importance = importance
        self.deadline = deadline
        self.isDone = isDone
        self.createDate = createDate
        self.changeDate = changeDate
        
    }
}


extension TodoItem {
    static func parse(json: Any) -> TodoItem? {
        guard let dict = json as? [String: Any],
              let id = dict["id"] as? String,
              let text = dict["text"] as? String,
              let isDone = dict["isDone"] as? Bool else {
            return nil
        }
        
        let importanceString = dict["importance"] as? String
        let importance: Importance = importanceString == "неважная" ? .low :
        importanceString == "важная" ? .high :
            .normal
        
        let createDate: Date
        if let createDateTimestamp = dict["createDate"] as? TimeInterval {
            createDate = Date(timeIntervalSince1970: createDateTimestamp)
        } else {
            return nil
        }
        
        let deadline: Date? = (dict["deadline"] as? TimeInterval).flatMap { Date(timeIntervalSince1970: $0) }
        let changeDate: Date? = (dict["changeDate"] as? TimeInterval).flatMap { Date(timeIntervalSince1970: $0) }
        
        
        return TodoItem(id: id, text: text, importance: importance, deadline: deadline, isDone: isDone, createDate: createDate, changeDate: changeDate)
    }
    
    var json: Any {
        var dict: [String: Any] = [
            "id": id,
            "text": text,
            "isDone": isDone
        ]
        
        if importance != .normal {
            dict["importance"] = importance.rawValue
        }
        
        if let deadline = deadline {
            dict["deadline"] = deadline.timeIntervalSince1970
        }
        
        if let changeDate = changeDate {
            dict["changeDate"] = changeDate.timeIntervalSince1970
        }
        
        dict["createDate"] = createDate.timeIntervalSince1970
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            return jsonObject
        } catch {
            print("проблемы с инкодингом TodoItem: \(error.localizedDescription)")
            return [String: Any]()
            
        }
    }
    
}

extension TodoItem {
    static func parse(csv: String) -> TodoItem? {
        let components = csv.components(separatedBy: ";")
        guard components.count >= 5 else { return nil }
        
        let id = components[0]
        let text = components[1]
        let importance: Importance = components[2] == "важная" ? .high :
            components[2] == "неважная" ? .low : .normal
        let isDone = components[3] == "true"
        
        let createDate = Date(timeIntervalSince1970: Double(components[4]) ?? Date().timeIntervalSince1970)
        
        var deadline: Date? = nil
        if components.count > 5 {
            deadline = Date(timeIntervalSince1970: Double(components[5]) ?? Date().timeIntervalSince1970)
        }
        
        return TodoItem(id: id, text: text, importance: importance, deadline: deadline, isDone: isDone, createDate: createDate)
    }
    
    var csv: String {
        var result = "\(id);\(text);"
        if importance != .normal {
            result += "\(importance.rawValue);"
        } else {
            result += ";"
        }
        result += "\(isDone ? "true" : "false");"
        result += "\(Int(createDate.timeIntervalSince1970))"
        
        if let deadline = deadline {
            result += ";" + "\(Int(deadline.timeIntervalSince1970))"
        }
        
        return result
    }
}
