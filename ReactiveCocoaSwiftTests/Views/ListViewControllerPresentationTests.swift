//
//  ListViewControllerPresentationTests.swift
//  ReactiveCocoaSwift
//
//  Created by Ono Masashi on 2015/01/14.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import UIKit
import Quick
import Nimble
import ReactiveCocoaSwift

class ListViewControllerPresentationTests: QuickSpec {
    override func spec() {
        var presentation: ListViewControllerPresentation!
        
        beforeEach {
            presentation = ListViewControllerPresentation(document: Document())
        }
        
        describe("its basic functionarity") {
            context("always") {
                it("should return document") {
                    expect(presentation.document).toNot(beNil())
                }
                it("should return signals") {
                    expect(presentation.documentUpdatedSignal).toNot(beNil())
                }
            }
            context("when 3 notes are added") {
                var presentation: ListViewControllerPresentation!
                beforeEach {
                    presentation = ListViewControllerPresentation(document: Document())
                    for i in 0..<3 {
                        presentation.addNote()
                    }
                }
                it("should return number of notes") {
                    expect(presentation.numberOfRowsInSection(0)).to(equal(3))
                }
                it("should return a specified note") {
                    expect(presentation.noteForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))).toNot(beNil())
                    expect(presentation.noteForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))).toNot(beNil())
                    expect(presentation.noteForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))).toNot(beNil())
                }
                it("should raise an exception for out-of-bounds index") {
                    expect(presentation.noteForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0))).to(raiseException())
                }
            }
        }
        
        describe("documentUpdatedSignal") {
            context("when a new note is added") {
                var presentation: ListViewControllerPresentation!
                beforeEach {
                    presentation = ListViewControllerPresentation(document: Document())
                }
                it("immediately sends a signal to documentupdatedSignal") {
                    var signalCount = 0
                    presentation.documentUpdatedSignal.subscribeNext({ (value: AnyObject!) -> Void in
                        signalCount = signalCount + 1
                        expect(value is [Note]).to(beTruthy())
                        let notes: [Note] = value as [Note]
                        expect(notes.count).to(equal(0))
                    })
                    expect(signalCount).to(equal(1))
                }
                it("should send a next signal to documentUpdatedSignal") {
                    var signalCount = 0
                    presentation.documentUpdatedSignal.subscribeNext({ (sender: AnyObject!) -> Void in
                        signalCount = signalCount + 1
                    })
                    presentation.addNote()
                    expect(signalCount).toEventually(equal(2))
                }
                it("should send multiple next signals to documentUpdatedSignal") {
                    var signalCount = 0
                    presentation.documentUpdatedSignal.subscribeNext({ (sender: AnyObject!) -> Void in
                        signalCount = signalCount + 1
                    })
                    for i in 0..<3 {
                        presentation.addNote()
                    }
                    expect(signalCount).toEventually(equal(4))
                }
            }
        }
    }
}