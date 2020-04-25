//
//  LoginFlowViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/25/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

final class LoginFlowViewController: UIViewController {

    @IBOutlet private weak var phoneNumberTexfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func createAccountButtonTapped(_ sender: UIButton) {
        guard let phoneNumberString = phoneNumberTexfield.text else {
            return
        }
        UserSession().createAccountUsingPhoneAuth(phoneNumber: phoneNumberString) { (result) in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(verificationString):
                let verificationController = UIStoryboard(name: "Verification", bundle: Bundle.main).instantiateViewController(identifier: "VerificationViewController") { coder in
                    VerificationCodeViewController(coder: coder, verificationId: verificationString)
                }
                self.show(verificationController, sender: self)
            }
        }
    }
}
