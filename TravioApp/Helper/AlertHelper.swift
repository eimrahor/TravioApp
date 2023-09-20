//
//  CustomAlert.swift
//  TravioApp
//
//  Created by Elif Poyraz on 16.09.2023.
//

import UIKit

enum ErrorTypes{
    
    //MARK: nil Value error
    case valuesNil
    
    //MARK: Login fail
    case emailOrPasswordNotValid
    
    //MARK: Register Success
    case registerCompletedSuccessfully(UIAlertAction,String)
    
    //MARK: empty value errors
    case nameOrMailEmpty
    case emailOrPasswordEmpty
    case galleryEmpty
    case placeNameOrCountryIsEmpty
    
    //MARK: password errors
    case passwordsDoesntMatch
    case passwordsLessThanRequiredChar
   
    //MARK: server errors
    case APIError(Error)
    case uploadImagesError(Error)
    
    //MARK: permission errors
    case cameraPermissionNotGranted
    case photoLibraryPermissionNorGranted
    
    //MARK: camera errors
    case flashCanNotUseFrontCamera
    case takingPhotoError(Error)
    case cantAccesTakenPhotoData
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
            title = "Insufficient Password"
            message = "Password must contain at least one uppercase letter, one lowercase letter and one number."
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
        case .flashCanNotUseFrontCamera:
            title = "Flash Can Not Use in Front Camera"
            message = "Switch to back camera to use flash"
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .takingPhotoError(let err):
            title = "An Error Occurred While Taking a Photo "
            message = err.localizedDescription
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .cantAccesTakenPhotoData:
            title = "Photo Data Not Found"
            message = "Can't Access Taken Photo"
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .emailOrPasswordNotValid:
            title = "Login Failed"
            message = "Email or password is not valid."
            let action = UIAlertAction(title: "OK", style: .default)
            alertActions.append(action)
        case .registerCompletedSuccessfully(let action,let msg):
            title = "Completed Succesfully"
            message = msg
            alertActions.append(action)
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for alertAction in alertActions {
            alert.addAction(alertAction)
        }
        
        return alert
    }
   
    
}
