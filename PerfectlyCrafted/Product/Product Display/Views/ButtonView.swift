//
//  ButtonView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 7/8/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 25.0) {
                    RoundButton(imageName: "pencil") {
                    }
                    
                    RoundButton(imageName: "trash.fill") {
                    }
                    RoundButton(imageName: "square.and.arrow.up") {
                    }
                }
            }.padding(20.0)
            Spacer()
        }
        .padding(.top, 30.0)
    }
}
