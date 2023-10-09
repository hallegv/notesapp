//
//  NoteEditorView.swift
//  NotesApp
//
//  Created by Halle V` on 10/9/23.
//

import SwiftUI

struct NoteEditorView: View {
    @Binding var noteText: String
    
    var onSubmit: (() -> ())?
    
    var body: some View {
        VStack {
            TextField("Enter your note", text: $noteText)
                .padding()
                .font(.system(.body))
                .frame(maxHeight: .infinity, alignment: .topLeading)
                .cornerRadius(25)
                .border(.black)
            
            submitButton
        }
        .padding()
    }
    
    var submitButton: some View {
        Button {
            onSubmit?()
        } label: {
            PlusButton()
                .padding()
        }
    }
}

struct NoteEditorView_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditorView(noteText: .constant("Text"))
    }
}
