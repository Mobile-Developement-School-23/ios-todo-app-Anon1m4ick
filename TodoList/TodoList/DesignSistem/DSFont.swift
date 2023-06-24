import UIKit

enum DSFont{
    case largeTitle
    case title
    case headline
    case body
    case subhead
    case footnote
}

extension DSFont{
    var font: UIFont{
        var font: UIFont? = nil
        
        switch self{
        case .largeTitle:
            font =  UIFont.systemFont(ofSize: 38).withWeight(UIFont.Weight(700))
        case .title:
            font = UIFont.systemFont(ofSize: 20).withWeight(UIFont.Weight(600))
        case .headline:
            font = UIFont.systemFont(ofSize: 17).withWeight(UIFont.Weight(600))
        case .body:
            font = UIFont.systemFont(ofSize: 17).withWeight(UIFont.Weight(200))
        case .subhead:
            font = UIFont.systemFont(ofSize: 15).withWeight(UIFont.Weight(400))
        case .footnote:
            font = UIFont.systemFont(ofSize: 13).withWeight(UIFont.Weight(600))
        }
        return font ?? UIFont()
    }
}
