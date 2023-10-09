//
//  NoteViewModel.swift
//  NotesApp
//
//  Created by Halle V` on 10/5/23.
//

import SwiftUI

final class NoteViewModel: ObservableObject {
    @Published var notes: [Note] = [] // put in userdefaults
}
