//
//  NoteTests.swift
//  ReactiveCocoaSwift
//
//  Created by Ono Masashi on 2015/01/23.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import UIKit
import Quick
import Nimble
import ReactiveCocoaSwift

class NoteTests: QuickSpec {
    override func spec() {
        var note: Note!
        
        beforeEach {
            note = Note()
        }
        
        describe("its basic functionarity") {
            context("always") {
                it("returns modelType") {
                    expect(note.modelType).to(equal("Note"))
                }
                it("can be initialized from dictionary") {
                    
                }
            }
        }
        
        describe("its JSON serialization") {
            context("always") {
                var note: Note!
                beforeEach {
                    note = Note()
                }
                it("can be serialized to JSON") {
                    note.text = "Hello, World!"
                    let json = MTLJSONAdapter.JSONDictionaryFromModel(note)
                    NSLog("%@", json)
                    expect(json).toNot(beNil())
                    expect(json["text"] as String?).to(equal("Hello, World!"))
                    expect(json["createdAt"]).toNot(beNil())
                }
                it("can be deserialized from JSON") {
                    let json = [
                        "text": "Hello, World!",
                        "createdAt": "2015-01-01T00:00:00Z"
                    ]
                    // TODO: causes error "Invalid parameter not satisfying: [modelClass isSubclassOfClass:MTLModel.class]"
                    //       because of how cocoapods sets up Mantle
                    //       - in cocoapods 0.35.0, pods must not be separated between apps and test cases
                    //       - in Mantle, Mantle pod must only be included in apps target
                    //         doing so causes Mantle classes duplicated both in apps and test cases thus modelOfClass doesn't work anymore
                    //       there's no fix for this right now
                    let note = MTLJSONAdapter.modelOfClass(Note.self, fromJSONDictionary: json, error: nil) as Note?
                    expect(note).toNot(beNil())
                    let n = note!
                    expect(n.text).to(equal("Hello, World!"))
                    expect(n.createdAt.earlierDate(NSDate(timeIntervalSinceNow: -100.0))).to(equal(n.createdAt))
                }
            }
        }
    }
}
