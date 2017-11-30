//
//  ViewController.swift
//  ConcurrencyNASA
//
//  Created by C4Q  on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var spaceImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func loadImageButtonPressed(_ sender: UIButton) {
        loadImage()
    }
    
    func loadImage() {
        guard let url = URL(string: "https://apod.nasa.gov/apod/image/1711/M33Nagy_tamed.jpg") else {return}
        let myGlobalQueue = DispatchQueue.global(qos: .utility)
        spinner.isHidden = false
        spinner.startAnimating()
        myGlobalQueue.async {
            print("About to make network connection")
            guard let rawImageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                guard let onlineImage = UIImage(data: rawImageData) else {return}
                self.spaceImageView.image = onlineImage
                print("Just set image")
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
            }
            print("Just dispatched to main queue")
        }
        print("Just dispatched to global queue")
    }

}

