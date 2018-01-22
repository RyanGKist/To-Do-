//
//  AddItemVC.swift
//  ToDo List
//
//  Created by Ryan Kistner on 1/18/18.
//  Copyright © 2018 Ryan Kistner. All rights reserved.
//

import UIKit

class AddItemVC: UIViewController {
    
    @IBOutlet weak var taskNameOutput: UITextField!
    @IBOutlet weak var taskDetailOutput: UITextView!
    @IBOutlet weak var datePickerOutput: UIDatePicker!
    
    weak var delegate : AddItemToListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        delegate?.addItemToList(title: taskNameOutput.text!, descirption: taskDetailOutput.text, date: datePickerOutput.date)
        dismiss(animated: true, completion: nil)
    }
    
}

