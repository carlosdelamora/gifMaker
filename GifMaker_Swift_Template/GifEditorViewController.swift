//
//  GifEditorViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Carlos De la mora on 11/5/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifEditorViewController: UIViewController {

    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var gifImageView: UIImageView!
    var gifURL: URL? = nil
    var gif:Gif? 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gifImageView.image = gif?.gifImage
        captionTextField.delegate = self
        //subscribe to notifications
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //unsubscribe to notifications
        unsubsribeToKeyboardNotifications()
    }
    
    @IBAction func presentPreview(_ sender: Any){
        let previewViewController = storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        gif?.caption = captionTextField.text
        let regift = Regift(sourceFileURL: (gif?.videoURL)!, destinationFileURL: nil, frameCount: frameCount, delayTime: delayTime, loopCount: loopCount)
        let captionFont: UIFont = captionTextField.font!
        let gifURL = regift.createGif(captionTextField.text, font: captionFont)
        let newGif = Gif(url: gifURL!, caption: captionTextField.text, videoURL: gif?.videoURL)
        previewViewController.gif = newGif
        navigationController?.pushViewController(previewViewController, animated: true)
    }

//MARK: - Observe and respond to keyboard notifications
    func subscribeToKeyboardNotifications(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubsribeToKeyboardNotifications(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        if (view.frame.minY >= 0) {
            view.frame.origin.y -= getKeyboardHeight(notification: notification)
        }
    }
    
    @objc func keyboardWillHide(){
        if (view.frame.minY < 0) {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification:Notification)->CGFloat{
        let userInfo:[AnyHashable: Any]? = notification.userInfo
        let keyboardFrameEnd: NSValue? = userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
        let keyboardFrameEndRect = keyboardFrameEnd!.cgRectValue
        
        return keyboardFrameEndRect.height
    }
}

extension GifEditorViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
}





