//
//  Base.swift
//  On The Map
//
//  Created by Anan Yousef on 05/01/2021.
//

import UIKit

class Base: UIViewController {

    let parseStundentName: (StudentLocation) -> String = { studentLocation in
        "\(studentLocation.firstName) \(studentLocation.lastName)"
                .trimmingCharacters(in: .whitespaces)
    }

    var studentLocationList: [StudentLocation] = []

    private lazy var networkActivityAlert = self.showNetworkActivityAlert()

    private lazy var getStudentsListErrorMessage = """
                                                   Unable to download the students list location.
                                                   Please try again later.
                                                   """

    private lazy var logoutErrorMessage = """
                                          Unable to complete the log out.
                                          Please try again later.
                                          """

    func getStudentsList(successHandler: @escaping ([StudentLocation]) -> Void, reset: Bool) {
        guard let studentsURL = UdacityAPI.Endpoint.getListOfStudentLocation.url else {
            print("Cannot create URL")
            return
        }

        self.present(networkActivityAlert, animated: true, completion: nil)

        func handleSuccess() {
            self.studentLocationList = StudentRepository.sharedInstance.studentLocationList

            self.networkActivityAlert.dismiss(animated: false, completion: nil)

            successHandler(self.studentLocationList)
        }

        if (StudentRepository.sharedInstance.studentLocationList.count < 100 || reset) {

            UdacityAPI.getStudentsDataTask(url: studentsURL,
                    successHandler: { studentLocationList in
                        DispatchQueue.main.async {
                            StudentRepository.sharedInstance.studentLocationList = studentLocationList

                            self.networkActivityAlert.dismiss(animated: false, completion: nil)

                            self.studentLocationList = StudentRepository.sharedInstance.studentLocationList

                            successHandler(self.studentLocationList)

                        }
                    },
                    errorHandler: { _ in
                        self.networkActivityAlert.dismiss(animated: false, completion: {
                            self.showErrorAlert(message: self.getStudentsListErrorMessage)
                        })
                    })
        } else {
            handleSuccess()
        }
    }

    func AddLocation() {
        self.performSegue(withIdentifier: "AddLocation", sender: self)
    }

    func performLogout() {
        guard let logoutURL = UdacityAPI.Endpoint.udacitySessionURL.url else {
            print("Cannot create URL")
            return
        }

        self.present(networkActivityAlert, animated: true, completion: nil)

        let request = UdacityAPI.deleteSessionRequest(url: logoutURL)

        UdacityAPI.executeDataTask(request: request,
                successHandler: { data in self.onLogoutSuccess() },
                errorHandler: { _ in
                    self.networkActivityAlert.dismiss(animated: false, completion: {
                        self.showErrorAlert(message: self.logoutErrorMessage)
                    })
                })
    }

    private func onLogoutSuccess() {
        DispatchQueue.main.async {
            StudentRepository.sharedInstance.clear()
            self.segueOnLogoutSuccess()
        }
    }


    private func segueOnLogoutSuccess() {
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }

    func openBroweserIfValidMediaURL(_ subtitle: String) {
        guard let mediaURL: URL = URL(string: subtitle) else {
            return
        }

        UIApplication.shared.open(mediaURL)
    }

}

