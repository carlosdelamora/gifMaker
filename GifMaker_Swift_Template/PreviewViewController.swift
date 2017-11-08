//
//  PreviewViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Carlos De la mora on 11/5/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    var gif: Gif?
    @IBOutlet weak var gifImageView: UIImageView!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gifImageView.image = gif?.gifImage
        title = "Preview"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareGif(_ sender: Any){
        var animatedGifData:Data?
        do{
          animatedGifData = try Data(contentsOf: gif!.url)
        }catch{
            return
        }
        let itemsToShare: [Data?] = [animatedGifData]
        let activityController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        activityController.completionWithItemsHandler = {activityType, completed, returnedItems, activityError in
            if completed {
               self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        present(activityController, animated: true)
        
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
