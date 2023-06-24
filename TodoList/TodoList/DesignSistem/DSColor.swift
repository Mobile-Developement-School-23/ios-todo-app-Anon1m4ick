import UIKit

enum DSColor{
    case backElevated
    case backSecondary
    case backPrimary
    case backIosPrimary
    case colorRed
    case colorGreen
    case colorBlue
    case colorGray
    case colorGrayLight
    case colorWhite
    case labelPrimary
    case labelSecondary
    case labelTertiary
    case labelDisable
    case supportSeparator
    case supportOverlay
    case supportNavBarBlur
}

extension DSColor{
    var color: UIColor{
        var color: UIColor? = nil
        
        switch self{
        case .backElevated:
            color = UIColor(named: "back_elevated")
        case .backIosPrimary:
            color = UIColor(named: "back_ios_primary")
        case .backPrimary:
            color = UIColor(named: "back_primary")
        case .backSecondary:
            color = UIColor(named: "back_secondary")
        case .colorBlue:
            color = UIColor(named: "color_blue")
        case .colorGrayLight:
            color = UIColor(named: "color_gray_light")
        case .colorGray:
            color = UIColor(named: "color_gray")
        case .colorGreen:
            color = UIColor(named: "color_green")
        case .colorRed:
            color = UIColor(named: "color_red")
        case .colorWhite:
            color = UIColor(named: "color_white")
        case .labelDisable:
            color = UIColor(named: "label_disable")
        case .labelPrimary:
            color = UIColor(named: "label_primary")
        case .labelSecondary:
            color = UIColor(named: "label_secondary")
        case .labelTertiary:
            color = UIColor(named: "label_tertiary")
        case .supportNavBarBlur:
            color = UIColor(named: "support_nav_bar_blur")
        case .supportOverlay:
            color = UIColor(named: "support_overlay")
        case .supportSeparator:
            color = UIColor(named: "support_separator")
        }
        return color ?? UIColor()
        }
    }

