//
//  LoginViewController.swift
//  On The Map
//
//  Created by Anan Yousef on 05/01/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    @IBAction func login(_ sender: Any) {
        
        guard let loginURL = UdacityAPI.Endpoint.udacitySessionURL.url else {
            print("Cannot create URL")
            return
        }

        self.setLogginIn(true)

        guard let email = userEmail.text else {
            return
        }

        guard let password = password.text else {
            return
        }

        func getProfileData(_ studentSession: StudentSession) {
            UdacityAPI.onLoginSucessGetProfileDataTask(studentSession: studentSession,
                                                   successHandler: { studentProfile in
                                                    self.onLoginSucess(studentProfile)
                                                   },
                                                   errorHandler: {_ in self.showErrorAlert(message: self.sessionErrorMessage)})
        }

        let request = UdacityAPI.initLoginRequest(url: loginURL, username: email, password: password)

        UdacityAPI.executeDataTask(request: request,
                                   successHandler: { data in

                                    let decoder = JSONDecoder()

                                    do {
                                        let studentSession = try decoder.decode(StudentSession.self, from: data)

                                        getProfileData(studentSession)

                                    } catch {
                                        self.showErrorAlert(message: self.sessionErrorMessage)
                                    }
                                   },

                                   errorHandler: { error in

                                    guard let udacityError = error as? UdacityError else {
                                        self.showErrorAlert(message:  error?.localizedDescription ?? "Undefined Error")
                                        return
                                    }

                                    if(udacityError.status == 403) {
                                        self.showErrorAlert(message:  udacityError.error)
                                    } else {
                                        self.showErrorAlert(message:  udacityError.error)
                                    }


                                   })
    }
    
    private lazy var sessionErrorMessage = """
    Invalid Session response.
    Please try login again.
    """
    
    private func showErrorAlert(message: String) {
        showErrorAlert(message: message, callback: { [self] in setLogginIn(false)})
    }
    
    
    private func onLoginSucess(_ studentProfile: StudentProfile) {
        DispatchQueue.main.async {
            StudentRepository.sharedInstance.studentProfile = studentProfile
            self.setLogginIn(false)
            self.segueOnLoginSuccess()
        }
    }
    
    
    private func segueOnLoginSuccess() {
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarController") as? UITabBarController
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func setLogginIn(_ loggingIn: Bool) {
        if loggingIn {
            
            activity.startAnimating()
        } else {
            activity.stopAnimating()
        }
        
        userEmail.isEnabled = !loggingIn
        password.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
    }
    
    
}
