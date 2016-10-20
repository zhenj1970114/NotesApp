//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Jia Zheng on 10/17/16.
//  Copyright © 2016 Jia Zheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UITextView!


    func configureView() {
        // Update the user interface for the detail item.
        if objects.count == 0 {
            return
        }
            if let label = self.detailDescriptionLabel {
                label.text = objects[currentIndex]
                if label.text == BLANK_NOTE{
                    label.text = ""
                }
            }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        detailViewController = self
        detailDescriptionLabel.becomeFirstResponder()
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if objects.count == 0 {
            return
        }
        objects[currentIndex] = detailDescriptionLabel.text
        if(detailDescriptionLabel.text==""){
        objects[currentIndex] = BLANK_NOTE
            
        }
    }


    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
        func saveAndUpdate(){
        masterView?.save()
        masterView?.tableView.reloadData()
    }


}





































