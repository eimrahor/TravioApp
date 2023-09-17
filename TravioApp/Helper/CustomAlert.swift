//
//  CustomAlert.swift
//  TravioApp
//
//  Created by Elif Poyraz on 16.09.2023.
//

import UIKit

enum ErrorTypes{
    case valuesNil
    case nameOrMailEmpty
    case passwordsDoesntMatch
    case passwordsLessThanRequiredChar
    case emailOrPasswordEmpty
    case APIError(Error)
    case uploadImagesError(Error)
    case placeNameOrCountryIsEmpty
    case galleryEmpty
    case cameraPermissionNotGranted
    case photoLibraryPermissionNorGranted
}

class AlertHelper {

    static let shared = AlertHelper()
    
    func showAlert(currentVC:UIViewController,errorType:ErrorTypes){
        let alert = create(errorType: errorType)
        currentVC.present(alert, animated: true)
    }
    private func create(errorType:ErrorTypes)->UIAlertController{
        
        var alertActions = [UIAlertAction]()
        var title = String()
        var message = String()
        
        switch errorType {
        case .valuesNil:
            title = "Nil Value"
            message = "Some Values were returned as nil."
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .nameOrMailEmpty:
            title = "Name and Email Required"
            message = "Name and email fields can not be empty."
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .passwordsDoesntMatch:
            title = "Password Matches required"
            message = "Password fields did not match."
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .passwordsLessThanRequiredChar:
            title = "Insufficient Password Characters"
            message = "Password cannot be less than 6 characters."
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .emailOrPasswordEmpty:
            title = "Email and Password Required"
            message = "Email and password fields can not be empty."
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .APIError(let err):
            title = "API Error"
            message = err.localizedDescription
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .uploadImagesError(let err):
            title = "Images could not be loaded."
            message = err.localizedDescription
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .placeNameOrCountryIsEmpty:
            title = "Place Name and Country Required"
            message = "Place Name and country fields can not be empty."
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .galleryEmpty:
            title = "Gallery Required"
            message = "Please add three images from your travel."
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .cameraPermissionNotGranted:
            title = "Camera Permission Required"
            message = "Change your camera permission preference by going to settings."
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .photoLibraryPermissionNorGranted:
            title = "Photo Library Permission Required"
            message = "Change your photo library permission preference by going to settings."
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for alertAction in alertActions {
            alert.addAction(alertAction)
        }
        
        return alert
    }
   
    
}
