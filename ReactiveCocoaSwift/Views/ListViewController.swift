//
//  ListViewController.swift
//  ReactiveCocoaSwift
//
//  Created by Ono Masashi on 2015/01/14.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ListViewController: UITableViewController {
    var presentation: ListViewControllerPresentation!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.rac_command = RACCommand(signalBlock: { (sender: AnyObject!) -> RACSignal! in
            NSLog("Add a new note")
            self.presentation.addNote()
            return RACSignal.empty()
        })
        
        self.presentation.documentUpdatedSignal.subscribeNext { (value: AnyObject!) -> Void in
            NSLog("value = \(value)")
            self.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.presentation.numberOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presentation.numberOfRowsInSection(section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as UITableViewCell
        let note = self.presentation.noteForRowAtIndexPath(indexPath)
        cell.textLabel?.text = note.text
        cell.detailTextLabel?.text = note.timestamp
        return cell
    }
}
