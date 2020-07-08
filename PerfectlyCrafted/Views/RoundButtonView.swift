//
//  RoundButtonView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 7/8/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import SwiftUI

struct RoundButton: View {
    
    private let imageName: String
    
    var action: () -> Void
    
    init(imageName: String, action: @escaping () -> Void) {
        self.imageName = imageName
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            SwiftUI.Image(systemName: imageName)
                .padding()
                .frame(width: 36.0)
                .background(Color.white)
                .clipShape(Circle())
                .font(.system(size: 20.0, weight: .medium))
                .foregroundColor(.black)
        })
    }
}
