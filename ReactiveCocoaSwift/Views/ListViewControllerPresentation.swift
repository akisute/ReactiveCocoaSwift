//
//  ListViewControllerPresentation.swift
//  ReactiveCocoaSwift
//
//  Created by Ono Masashi on 2015/01/14.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import UIKit
import ReactiveCocoa

public class ListViewControllerPresentation: NSObject {
    public let document: Document
    
    public init(document: Document) {
        self.document = document
    }
    
    public var numberOfSections: Int {
        return 1
    }
    
    public func numberOfRowsInSection(section: Int) -> Int {
        return self.document.notes.count
    }
    
    public func noteForRowAtIndexPath(indexPath: NSIndexPath) -> Note {
        let i = indexPath.row
        if (i < 0 || i >= self.document.notes.count) {
            NSException(name: NSRangeException, reason: "indexPath \(indexPath) is out of bounds (\(self.document.notes.count))", userInfo: nil).raise()
        }
        return self.document.notes[i]
    }
    
    public func addNote() {
        var notes = self.document.notes
        notes.append({
            let note: Note = Note()
            note.text = "Test"
            return note
            }())
        self.document.notes = notes
    }
    
    public func removeAllNotes() {
        self.document.notes = []
    }
    
    public var documentUpdatedSignal: RACSignal {
        return self.document.rac_valuesForKeyPath("notes", observer: self)
    }
    
}
