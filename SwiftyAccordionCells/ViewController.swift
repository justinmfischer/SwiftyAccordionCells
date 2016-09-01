//
//  ViewController.swift
//  SwiftyAccordionCells
//
//  Created by Fischer, Justin on 9/24/15.
//  Copyright © 2015 Justin M Fischer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var enter: UIButton!
    @IBOutlet weak var table: UITableView!
    
    var previouslySelectedHeaderIndex: Int?
    var selectedHeaderIndex: Int?
    var selectedItemIndex: Int?
    
    let cells = SwiftyAccordionCells()
    
    override func viewDidLoad() {
        self.setup()
        self.table.estimatedRowHeight = 45
        self.table.rowHeight = UITableViewAutomaticDimension
        self.table.allowsMultipleSelection = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.table.reloadData()
    }
    
    func setup() {
        self.enter.layer.cornerRadius = 4
        
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 2"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 3"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 4"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 5"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 6"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 7"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 8"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 9"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 10"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 11"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 12"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 2"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 2"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 3"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 4"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 5"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 6"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 7"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 3"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 2"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 3"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 4"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 5"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 2"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 3"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 4"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 6"))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = self.cells.items[indexPath.row]
        let value = item.value as? String
        let isChecked = item.isChecked as Bool
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("cell") {
            cell.textLabel?.text = value
            
            if item as? SwiftyAccordionCells.HeaderItem != nil {
                cell.backgroundColor = UIColor.lightGrayColor()
                cell.accessoryType = .None
            } else {
                if isChecked {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let item = self.cells.items[indexPath.row]
        
        if item is SwiftyAccordionCells.HeaderItem {
            return 60
        } else if (item.isHidden) {
            return 0
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.cells.items[indexPath.row]
        
        if item is SwiftyAccordionCells.HeaderItem {
            if self.selectedHeaderIndex == nil {
                self.selectedHeaderIndex = indexPath.row
            } else {
                self.previouslySelectedHeaderIndex = self.selectedHeaderIndex
                self.selectedHeaderIndex = indexPath.row
            }
            
            if let previouslySelectedHeaderIndex = self.previouslySelectedHeaderIndex {
                self.cells.collapse(previouslySelectedHeaderIndex)
            }
            
            if self.previouslySelectedHeaderIndex != self.selectedHeaderIndex {
                self.cells.expand(self.selectedHeaderIndex!)
            } else {
                self.selectedHeaderIndex = nil
                self.previouslySelectedHeaderIndex = nil
            }
            
            self.table.beginUpdates()
            self.table.endUpdates()
            
        } else {
            if indexPath.row != self.selectedItemIndex {
                let cell = self.table.cellForRowAtIndexPath(indexPath)
                cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
                
                if let selectedItemIndex = self.selectedItemIndex {
                    let previousCell = self.table.cellForRowAtIndexPath(NSIndexPath(forRow: selectedItemIndex, inSection: 0))
                    previousCell?.accessoryType = UITableViewCellAccessoryType.None
                    cells.items[selectedItemIndex].isChecked = false
                }
                
                self.selectedItemIndex = indexPath.row
                cells.items[self.selectedItemIndex!].isChecked = true
            }
        }
    }
    
    @IBAction func enter(sender: AnyObject) {
        if let selectedItemIndex = self.selectedItemIndex {
            let selectedItemValue = self.cells.items[selectedItemIndex].value as? String
            
            let alert = UIAlertController(title: "Current Selection", message: selectedItemValue, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
