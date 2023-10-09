//
//  Note.swift
//  NotesApp
//
//  Created by Halle V` on 10/5/23.
//

import SwiftUI

struct Note: Identifiable {
    var id = UUID().uuidString
    var note: String
    var date: Date
    var color: Color
}

func getSampleDate(offset: Int) -> Date {
    let cal = Calendar.current
    let date = cal.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}
