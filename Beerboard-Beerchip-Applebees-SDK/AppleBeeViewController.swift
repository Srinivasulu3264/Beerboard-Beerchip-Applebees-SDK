//
//  AppleBeeViewController.swift
//  AppleBeeFramework
//
//  Created by Vmoksha on 19/03/18.
//  Copyright © 2018 Vmoksha. All rights reserved.
//

import UIKit

public class AppleBeeViewController: UIViewController {

    
    @IBOutlet weak var viewRedeemBtn: UIButton!
    
    var ismenuShowing = true
    
    var titleArr  = [String]()
    var imagesArr  = [String]()
    var isSegueEnbled = false
    var navigationBarLabel:UILabel?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        viewRedeemBtn.layer.cornerRadius = 8.0
        // Do any additional setup after loading the view.
    }

     
    @IBAction func viewRedeemBtnAction(_ sender: Any) {
        
         performSegue(withIdentifier: "toRedeemVC", sender: self)
    }
   
}


