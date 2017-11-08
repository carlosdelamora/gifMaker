//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Carlos De la mora on 11/5/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class Gif:NSObject{
    
    var url:URL
    var caption:String?
    var gifImage: UIImage?
    var videoURL:URL?
    var gifData:Data?
    
    init(url:URL, caption: String?, videoURL:URL?){
        self.url = url
        self.caption = caption
        self.gifImage = UIImage.gif(url: url.absoluteString)!
        self.videoURL = videoURL
        self.gifData = nil
    }
    
    /*init(name:String){
        self.gifImage = UIImage.gif(name: name)
    }*/
}
