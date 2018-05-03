//
//  RedeemBeerchipViewController.swift
//  BeerboardBeerchipFramework
//
//  Created by Vmoksha on 26/02/18.
//  Copyright © 2018 Vmoksha. All rights reserved.
//

import UIKit

protocol redeemBeerchipVCProtocol {
        func displayLocationTable()
}

class RedeemBeerchipViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var receiptIDTxtfield: UITextField!
    @IBOutlet weak var redeemBeerchipVCLocationIndicatorBtn: UIButton!
    
    var redeemBeerchipVCDelegate : redeemBeerchipVCProtocol?
    var activeField:UIControl = UIControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

          redeemBeerchipVCLocationIndicatorBtn.layer.cornerRadius = 8.0
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        receiptIDTxtfield.delegate = self
        
        NotificationCenter.default.addObserver(self, selector:#selector(RedeemBeerchipViewController.keyboardWasShown(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(RedeemBeerchipViewController.KeyboaredWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWasShown(_ aNotification: Notification){
        print("keypadShow");
        let info = aNotification.userInfo! as NSDictionary;
        let kbSize = (info.object(forKey: UIKeyboardFrameBeginUserInfoKey)! as AnyObject).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)as UIEdgeInsets;
        self.scrollView.contentInset = contentInsets;
        var aRect = self.view.frame as CGRect;
        aRect.size.height -= kbSize.height;
        if !aRect.contains(activeField.frame.origin){
            self.scrollView.scrollRectToVisible(activeField.frame, animated: true);
        }
    }
    
    @objc func KeyboaredWillHide(){
        print("keypadHidden");
        let contentInsets = UIEdgeInsets.zero;
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 120
        }
    }
    
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        receiptIDTxtfield.resignFirstResponder()
        return false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var userdefaultsLocation = UserDefaults.standard.string(forKey: "location")
        
        if userdefaultsLocation == nil {
            userdefaultsLocation = "BROOKLYN, NY"
        }
        redeemBeerchipVCLocationIndicatorBtn.setTitle(userdefaultsLocation, for: .normal)
        
    }
    
    @IBAction func redeemBeerchipVCLocationIndicationBtnAction(_ sender: Any) {
        redeemBeerchipVCDelegate?.displayLocationTable()
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
