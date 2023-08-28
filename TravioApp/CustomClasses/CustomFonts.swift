//
//  CustomFonts.swift
//  ContactsApp
//
//  Created by Elif Poyraz on 13.08.2023.
//

import Foundation
import UIKit

enum CustomFont
{
    case ArielNarrow(Int)
    case Avenirmedium(Int)
    case AvenirBold(Int)
    case Verdana(Int)
    case VerdanaBold(Int)
    case PoppinsBold(Int)
    case PoppinsSemiBold(Int)
    case PoppindMedium(Int)
    case PoppinsRegular(Int)
    
    var font : UIFont {
        switch self {
        case .ArielNarrow(let size):
            return UIFont(name: "Ariel Narrow", size: CGFloat(size))!
        case .Avenirmedium(let size):
            return UIFont(name: "AvenirNext-Medium", size: CGFloat(size))!
        case .AvenirBold(let size):
            return UIFont(name: "AvenirNext-Bold", size: CGFloat(size))!
        case .Verdana(let size):
            return UIFont(name: "Verdana", size: CGFloat(size))!
        case .VerdanaBold(let size):
            return UIFont(name: "Verdana Bold", size: CGFloat(size))!
        case .PoppinsBold(let size):
            return UIFont(name: "Poppins-Bold", size: CGFloat(size))!
        case .PoppinsSemiBold(let size):
            return UIFont(name: "Poppins-SemiBold", size: CGFloat(size))!
        case .PoppindMedium(let size):
            return UIFont(name: "Poppins-Medium", size: CGFloat(size))!
        case .PoppinsRegular(let size):
            return UIFont(name: "Poppins-Regular", size: CGFloat(size))!
        }
    }
}
