//
//  AddBehaviorViewController.swift
//  GoodGirlOrBoy
//
//  Created by Eric Chang on 12/28/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit
import CoreData

enum Children: String {
    case Joe = "Joe Rogan"
    case Tim = "Tim Ferriss"
    case Jordan = "Jordan Peterson"
}

class AddBehaviorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var childSegmentControl: UISegmentedControl!
    @IBOutlet weak var behaviorTextLabel: UILabel!
    @IBOutlet weak var behaviorPickerView: UIPickerView!
    @IBOutlet weak var goodBadSwitch: UISwitch!
    @IBOutlet weak var badBehaviorTextLabel: UILabel!
    @IBOutlet weak var goodBehaviorTextLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    var pickerData = [String]()
    var behaviorPicked: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        behaviorPickerView.dataSource = self
        behaviorPickerView.delegate = self
        pickerData = ["Meditating", "Stroking His Ego", "Studying", "Procrastinating", "Rock Climbing", "Being Lazy", "Reading", "Watching TV", "Cooking", "Being Gluttonous", "Cleaning", "Leaving Trash Out", "Not Conforming to Society", "Band Wagoning"]
        behaviorTextLabel.text = "Behaviors: The War Between Good & Evil"
        badBehaviorTextLabel.text = "💀"
        goodBehaviorTextLabel.text = "😇"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UIPickerView data source
    
    // Number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        behaviorPicked = pickerData[row]
        return behaviorPicked
    }
    
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        let entry = Entry(context: context)
        entry.date = NSDate()
        print(entry.date)
        switch childSegmentControl.selectedSegmentIndex {
        case 0:
            entry.name = Children.Joe.rawValue
        case 1:
            entry.name = Children.Tim.rawValue
        default:
            entry.name = Children.Jordan.rawValue
        }
        print(entry.name)
        if goodBadSwitch.isOn {
            entry.polarity = true
        }
        else { entry.polarity = false }
        print(entry.polarity)
        
        entry.behavior = behaviorPicked
        print(entry.behavior)
        try! context.save()
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
