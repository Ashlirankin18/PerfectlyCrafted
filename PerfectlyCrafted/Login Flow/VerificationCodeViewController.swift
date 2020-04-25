//
//  VerificationCodeViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 4/25/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

class VerificationCodeViewController: UIViewController {

    @IBOutlet private weak var verificationCodeTextField: UITextField!
    
    private let verificationId: String
    
    init?(coder: NSCoder, verificationId: String) {
        self.verificationId = verificationId
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction private func submitButtonTapped(_ sender: UIButton) {
        guard let verificationCode = verificationCodeTextField.text else {
            return
        }
        UserSession().signInUserWithVerificationCode(verificationCode: verificationCode, verificationId: verificationId)
    }
}
