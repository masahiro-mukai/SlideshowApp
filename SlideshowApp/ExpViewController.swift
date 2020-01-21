//
//  ExpViewController.swift
//  SlideshowApp
//
//  Created by 向正裕 on 2020/01/22.
//  Copyright © 2020 masahiro.mukai. All rights reserved.
//

import UIKit

class ExpViewController: UIViewController {

    @IBOutlet weak var expImageView: UIImageView!
    
    var imageFile:UIImage! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // 前の画面で設定した画像を出力
        expImageView.image = imageFile
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
