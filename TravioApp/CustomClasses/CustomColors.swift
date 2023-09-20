//
//  CustomColors.swift
//  ContactsApp
//
//  Created by Elif Poyraz on 13.08.2023.
//

import Foundation
import UIKit

enum CustomColor
{
    case Blue
    case White
    case LightGray
    case DarkGray
    case Black
    
    case TravioWhite
    case TravioGreen
    case TravioBlack
    case TravioLightGray
    case TravioWhiteHalfAlpha
    
    case Transparent
    
    var color :UIColor {
       
        switch self {
        case .Blue:
            return #colorLiteral(red: 0, green: 0.5138835311, blue: 1, alpha: 1)
        case .White:
            return #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
        case .LightGray:
            return #colorLiteral(red: 0.9333333373, green: 0.9333333373, blue: 0.9333333373, alpha: 1)
        case .DarkGray:
            return #colorLiteral(red: 0.5843136907, green: 0.5843136907, blue: 0.5843136907, alpha: 1)
        case .Black:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
        case .TravioWhite:
            return #colorLiteral(red: 0.9782040715, green: 0.9782040715, blue: 0.9782039523, alpha: 1)
        case .TravioGreen:
            return #colorLiteral(red: 0.2196078431, green: 0.6784313725, blue: 0.662745098, alpha: 1)
        case .TravioBlack:
            return #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1)
        case .TravioLightGray:
            return #colorLiteral(red: 0.662745098, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
        case .TravioWhiteHalfAlpha:
            return #colorLiteral(red: 0.9782040715, green: 0.9782040715, blue: 0.9782039523, alpha: 0.4599544702)
            
        case .Transparent:
            return #colorLiteral(red: 0.662745098, green: 0.6588235294, blue: 0.6588235294, alpha: 0)

        }
    }
}
