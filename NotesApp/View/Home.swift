//
//  Home.swift
//  NotesApp
//
//  Created by Halle V` on 10/5/23.
//

import SwiftUI

enum NoteAction {
    case edit, add
}

struct Home: View {
    
    @StateObject var viewModel: NoteViewModel = NoteViewModel()
    
    @State var showColors: Bool = false
    @State var noteAction: NoteAction = .add
    @State var currentColor: Color = Color("Blue")
    @State var animateButton: Bool = false
    @State var showNoteEditor: Bool = false
    @State var noteText: String = ""
    @State var noteId: String = UUID().uuidString
    
    var body: some View {
        HStack(spacing: 0) {
            sidebar
            notesView
        }
        .ignoresSafeArea()
        .frame(width: isMacOS() ? getRect().width / 1.7 : nil,
               height: isMacOS() ? getRect().height - 180 : nil,
               alignment: .topLeading)
        .background(Color.white.ignoresSafeArea())
        .preferredColorScheme(.light)
        .padding(.vertical)
        .padding(.horizontal, 22)
        .padding(.top, 35)
        .sheet(isPresented: $showNoteEditor) {
            NoteEditorView(noteText: $noteText, color: $currentColor, onSubmit: {
                onSubmitEdit(noteAction)
                showNoteEditor = false
            })
        }
    }
    
    func onSubmitEdit(_ action: NoteAction) {
        switch action {
        case .add:
            let note = Note(note: noteText, date: Date(), color: currentColor)
            viewModel.notes.append(note)
        case .edit:
            if let index = viewModel.notes.firstIndex(where: { $0.id == noteId.description }) {
                viewModel.notes[index].note = noteText
            }
        }
    }
    
    var notesView: some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                TextField("Search", text: .constant(""))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, isMacOS() ? 0 : 10)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    Text("Notes")
                        .font(isMacOS() ?
                            .system(size: 33, weight: .bold) : .largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    let columns = Array(repeating: GridItem(.flexible(), spacing: isMacOS() ? 25 : 15), count: isMacOS() ? 3 : 1)
                    
                    LazyVGrid(columns: columns, spacing: 25) {
                        ForEach(viewModel.notes) { note in
                            CardView(note)
                        }
                    }
                    .padding(.top, 30)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, isMacOS() ? 40 : 15)
        .padding(.horizontal, 25)
    }
    
    @ViewBuilder
    func CardView(_ note: Note) -> some View {
        VStack {
            Text(note.note)
                .foregroundColor(.white)
                .font(isMacOS() ? .title2 : .body)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(note.date, style: .date)
                    .foregroundColor(.white)
                    .opacity(0.8)
                
                Spacer(minLength: 0)
                
                Button {
                    noteText = note.note
                    currentColor = note.color
                    noteAction = .edit
                    noteId = note.id
                    showNoteEditor = true
                } label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 15, weight: .bold))
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                }
            }
            .padding(.top, 55)
        }
        .padding()
        .background(note.color)
        .cornerRadius(18)
    }
    
    var sidebar: some View {
        HStack {
            VStack {
                showColorsButton
                    .zIndex(1)
                
                VStack(spacing: 15) {
                    let colors = [
                        Color("Blue"),
                        Color("Green"),
                        Color("Purple"),
                        Color("Rose"),
                        Color("Teal"),
                    ]

                    ForEach(colors, id: \.self) { color in
                        Button {
                            currentColor = color
                            noteAction = .add
                            showNoteEditor = true
                        } label: {
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                .padding(.top, 10)
                .frame(height: showColors ? nil : 0)
                .opacity(showColors ? 1 : 0)
                .zIndex(0)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            Rectangle()
                .fill(Color.gray.opacity(0.15))
                .frame(width: 1)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.trailing)
    }
    
    var showColorsButton: some View {
        Button {
            withAnimation(.interactiveSpring(response: 0.5,
                                            dampingFraction: 0.5,
                                            blendDuration: 0.5)) {
                showColors.toggle()
                animateButton.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring()) {
                    animateButton.toggle()
                }
            }
        } label: {
            PlusButton(scaleEffectCheck: animateButton)
        }
        .rotationEffect(.init(degrees: showColors ? 45 : 0))
        .scaleEffect(animateButton ? 1.1 : 1)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
