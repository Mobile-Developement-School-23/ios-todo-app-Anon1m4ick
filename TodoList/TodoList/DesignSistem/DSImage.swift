import UIKit

enum DSImage{
    case add
    case priorityHigh
    case priorityLow
}

extension DSImage{
    var image: UIImage{
        var image: UIImage? = nil
        
        switch self{
        case .add:
            image = UIImage(named: "add")
        case .priorityHigh:
            image = UIImage(named: "priority_high")
        case .priorityLow:
            image = UIImage(named: "priority_low")
        }
        return image ?? UIImage()
    }
}
