import XCTest
@testable import ToDoList

//в консоль пишется только это строка, хз почему(2023-06-17 01:31:51.593790+0200 TodoListUITests-Runner[25437:518163] Running tests...),
//но все тесты проходятся, оно билдится и тест саксиид и 87,9 покрытия туда айтема

class TodoItemTests: XCTestCase {
    
    // Функция, которая запускается перед каждым тестом
    override func setUp() {
        super.setUp()
    }

    // Функция, которая запускается после каждого теста
    override func tearDown() {
        super.tearDown()
    }
    //тупо само генерит айди и проверяет, когда мы его не указываем
    func testTodoItemInitWithDefaultId() {
            let todoItem = TodoItem(text: "Test", importance: .normal, isDone: false)
            XCTAssertNotNil(todoItem.id)
        }
    //вообще на работоспособность
    func testTodoItemInit() {
        let todoItem = TodoItem(id: "1", text: "Test", importance: .normal, deadline: nil, isDone: false, createDate: Date(), changeDate: nil)
        XCTAssertEqual(todoItem.id, "1")
        XCTAssertEqual(todoItem.text, "Test")
        XCTAssertEqual(todoItem.importance, .normal)
        XCTAssertNil(todoItem.deadline)
        XCTAssertFalse(todoItem.isDone)
    }
    //так же тест с важностью норм, которая становится нилом ибо не записываем
    func testTodoItemToJson() {
            let todoItem = TodoItem(id: "1", text: "Test", importance: .normal, deadline: nil, isDone: false, createDate: Date(), changeDate: nil)
            let json = todoItem.json as? [String: Any]
            XCTAssertNotNil(json)
            XCTAssertEqual(json?["id"] as? String, "1")
            XCTAssertEqual(json?["text"] as? String, "Test")
            XCTAssertEqual(json?["importance"] as? String, nil)
            XCTAssertFalse(json?["isDone"] as? Bool ?? true)
        }
    // как в название - из джейсона в тудушку
    func testTodoItemParseFromJson() {
        let json: [String: Any] = [
            "id": "1",
            "text": "Test",
            "importance": "обычная",
            "isDone": false,
            "createDate": Date().timeIntervalSince1970
        ]
        
        let todoItem = TodoItem.parse(json: json)
        XCTAssertNotNil(todoItem)
        if let todoItem = todoItem {
            XCTAssertEqual(todoItem.id, "1")
            XCTAssertEqual(todoItem.text, "Test")
            XCTAssertEqual(todoItem.importance, .normal)
            XCTAssertFalse(todoItem.isDone)
        }
    }
    //как и в название, тест с пропущенными полями
    func testTodoItemParseFromJsonMissingFields() {
        let json: [String: Any] = [
            "id": "1",
            "text": "Test",
            "isDone": false,
            "createDate": Date().timeIntervalSince1970
        ]
        
        let todoItem = TodoItem.parse(json: json)
        XCTAssertNotNil(todoItem)
        if let todoItem = todoItem {
            XCTAssertEqual(todoItem.id, "1")
            XCTAssertEqual(todoItem.text, "Test")
            XCTAssertEqual(todoItem.importance, .normal) // default importance
            XCTAssertFalse(todoItem.isDone)
        }
    }

    //тест с важностью норм, которую мы не записываем
    func testTodoItemToCsv() {
            let todoItem = TodoItem(id: "1", text: "Test", importance: .normal, deadline: nil, isDone: false, createDate: Date(), changeDate: nil)
            let csv = todoItem.csv
            let components = csv.components(separatedBy: ";")
            XCTAssertEqual(components[0], "1")
            XCTAssertEqual(components[1], "Test")
            XCTAssertEqual(components[2], "")
            XCTAssertEqual(components[3], "false")
        }

    func testTodoItemParseFromCsv() {
        let csv = "1;Test;обычная;false;\(Int(Date().timeIntervalSince1970))"
        let todoItem = TodoItem.parse(csv: csv)
        XCTAssertNotNil(todoItem)
        if let todoItem = todoItem {
            XCTAssertEqual(todoItem.id, "1")
            XCTAssertEqual(todoItem.text, "Test")
            XCTAssertEqual(todoItem.importance, .normal)
            XCTAssertFalse(todoItem.isDone)
        }
    }
    // тоже с пропущенными полями но цсв
    func testTodoItemParseFromCsvMissingFields() {
        let csv = "1;Test;;false;\(Int(Date().timeIntervalSince1970))"
        let todoItem = TodoItem.parse(csv: csv)
        XCTAssertNotNil(todoItem)
        if let todoItem = todoItem {
            XCTAssertEqual(todoItem.id, "1")
            XCTAssertEqual(todoItem.text, "Test")
            XCTAssertEqual(todoItem.importance, .normal) // default importance
            XCTAssertFalse(todoItem.isDone)
        }
    }

    //проверяет соответствие важностей
    func testTodoItemImportanceFromString() {
            let importanceLow = TodoItem.Importance(rawValue: "неважная")
            let importanceNormal = TodoItem.Importance(rawValue: "обычная")
            let importanceHigh = TodoItem.Importance(rawValue: "важная")
            
            XCTAssertEqual(importanceLow, .low)
            XCTAssertEqual(importanceNormal, .normal)
            XCTAssertEqual(importanceHigh, .high)
        }
    // и в обратную сторону
    func testTodoItemImportanceToString() {
           XCTAssertEqual(TodoItem.Importance.low.rawValue, "неважная")
           XCTAssertEqual(TodoItem.Importance.normal.rawValue, "обычная")
           XCTAssertEqual(TodoItem.Importance.high.rawValue, "важная")
       }
    
    // с неправильной важность которую он переделывает в нормал
    func testInvalidImportanceInit() {
        let todoItem = TodoItem(id: "1", text: "Test", importance: TodoItem.Importance(rawValue: "неизвестно") ?? .normal, deadline: nil, isDone: false, createDate: Date(), changeDate: nil)
        XCTAssertEqual(todoItem.importance, .normal) // Should default to normal
    }

    // без текста
    func testInitWithEmptyText() {
        let todoItem = TodoItem(id: "1", text: "", importance: .normal, deadline: nil, isDone: false, createDate: Date(), changeDate: nil)
        XCTAssertEqual(todoItem.text, "") // Should be empty string
    }

    // с важной важностью
    func testTodoItemToJsonHighImportance() {
        let todoItem = TodoItem(id: "1", text: "Test", importance: .high, deadline: nil, isDone: false, createDate: Date(), changeDate: nil)
        let json = todoItem.json as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["importance"] as? String, "важная")
    }

    // когда есть дедлайн
    func testTodoItemToJsonWithDeadline() {
        let deadline = Date().addingTimeInterval(3600)
        let todoItem = TodoItem(id: "1", text: "Test", importance: .normal, deadline: deadline, isDone: false, createDate: Date(), changeDate: nil)
        let json = todoItem.json as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["deadline"] as? Double, deadline.timeIntervalSince1970)
    }

    // меняю дату
    func testTodoItemToJsonWithChangeDate() {
        let changeDate = Date().addingTimeInterval(-3600)
        let todoItem = TodoItem(id: "1", text: "Test", importance: .normal, deadline: nil, isDone: false, createDate: Date(), changeDate: changeDate)
        let json = todoItem.json as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["changeDate"] as? Double, changeDate.timeIntervalSince1970)
    }
    func testParsingJsonWithInvalidDeadline() {
        // Парсинг JSON с некорректным значением дедлайна
        let json: [String: Any] = [
            "id": "555",
            "text": "Task 5",
            "importance": "обычная",
            "isDone": false,
            "deadline": "invalid_date" // Некорректное значение дедлайна
        ]

        let todoItem = TodoItem.parse(json: json)
        XCTAssertNil(todoItem?.deadline) // Дедлайн должен быть nil из-за неправильного формата даты
    }

}
