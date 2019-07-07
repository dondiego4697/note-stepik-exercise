//
//  ViewController.swift
//  Notes
//
//  Created by Denis Stepanov on 02/07/2019.
//  Copyright © 2019 Denis Stepanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Logger.logger.info("App was runned")
        
        let notebook = Notebook()
        do {
            try notebook.loadFromFile()
        } catch {
            Logger.logger.error(error.localizedDescription)
        }
    }
}


