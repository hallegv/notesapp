//
//  CustomViews.swift
//  NotesApp
//
//  Created by Halle V` on 10/9/23.
//

import SwiftUI

struct PlusButton: View {
    
    var scaleEffectCheck: Bool = false
    
    var body: some View {
        Image(systemName: "plus")
            .font(.title2)
            .foregroundColor(.white)
            .scaleEffect(scaleEffectCheck ? 1.1 : 1)
            .padding(isMacOS() ? 12 : 15)
            .background(Color.black)
            .clipShape(Circle())
    }
}
