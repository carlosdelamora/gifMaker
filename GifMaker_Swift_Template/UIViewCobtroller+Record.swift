//
//  UIViewCobtroller+Record.swift
//  GifMaker_Swift_Template
//
//  Created by Carlos De la mora on 11/5/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

//regifit constants
let frameCount = 16
let delayTime:Float = 0.2
let loopCount = 0 // 0 means it repeats forever

extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBAction func launchVideoCamera(sender: AnyObject){
        //create image picker
        let recordVideController = UIImagePickerController()
        //set properties mediatype, source type allows editing delegate
        recordVideController.sourceType = .camera
        recordVideController.mediaTypes = [kUTTypeMovie as String]
        recordVideController.allowsEditing = false
        recordVideController.delegate = self
        //present controller
        present(recordVideController, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == kUTTypeMovie as String{
            let videoURL = info[UIImagePickerControllerMediaURL] as! URL
            UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path, nil, nil, nil)
            dismiss(animated: true, completion: nil)
            convertVideoToGif(videoURL: videoURL)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func convertVideoToGif(videoURL:URL){
        let regift = Regift(sourceFileURL: videoURL, destinationFileURL: nil, frameCount: frameCount, delayTime: delayTime, loopCount: loopCount)
        let gifURL = regift.createGif()
        let gif = Gif(url: gifURL!, caption: nil, videoURL: videoURL)
        displayGif(gif:gif)
    }
    
    func displayGif(gif: Gif){
        let giftEditorViewController = storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        giftEditorViewController.gif = gif
        navigationController?.pushViewController(giftEditorViewController, animated: true)
    }
}
