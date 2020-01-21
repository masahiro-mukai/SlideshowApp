//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 向正裕 on 2020/01/19.
//  Copyright © 2020 masahiro.mukai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cmdNext: UIButton!
    @IBOutlet weak var cmdPrev: UIButton!
    @IBOutlet weak var cmdAutoRun: UIButton!
    
    // 画像ファイルの先頭
    let firstIdx: Int = 0
    // 画像ファイルの終端
    let lastIdx: Int = 3
    // 画像ファイルの現在値
    var currentIdx: Int = -1
    // 画像配列設定
    let lstImageFile: [UIImage] = [UIImage(named: "sample1.jpeg")!
                                    , UIImage(named: "sample2.jpeg")!
                                    , UIImage(named: "sample3.jpeg")!
                                    , UIImage(named: "sample4.jpeg")!]
    
    // 自動処理のボタン名設定
    let btnNamePlayback :String = "再生"
    let btnNameStop :String = "停止"
    
    // タイマー
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 先頭の画像を初期表示する
        self.imageView.image = switchImage(idx: 1)
        // ボタンの名前を初期設定する。
        self.cmdAutoRun.setTitle(self.btnNamePlayback, for: .normal)
    }
    
    // 進む
    @IBAction func cmdNextAction(_ sender: Any) {
        self.imageView.image = switchImage(idx: 1)
    }
    
    // 戻る
    @IBAction func cmdPrevAction(_ sender: Any) {
        self.imageView.image = switchImage(idx: -1)
    }
    // 自動再生/停止
    @IBAction func cmdAutoRunAction(_ sender: Any) {
        if self.cmdAutoRun.currentTitle == btnNamePlayback {
            // 再生押下イベント
            // ボタンの名前を停止にする。
            self.cmdAutoRun.setTitle(self.btnNameStop, for: .normal)
            // 対象オブジェクトを使用不可にする。
            self.setObjStatus(isStatus: false)
            // 画像自動切替呼び出し(2秒毎)
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.autoSwitchImage(_:)), userInfo: nil, repeats: true)
            }
        } else {
            // 停止押下イベント
            self.setStopAction()
        }
    }
    
    // 画像自動切替処理
    @objc func autoSwitchImage(_ timer: Timer) {
        // 呼ばれるたびに画像を進めていく
        self.imageView.image = self.switchImage(idx: 1)
    }
    
    // 拡大
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.cmdAutoRun.currentTitle == btnNameStop {
            // 自動再生実行時のみ停止処理を行う。
            self.setStopAction()
        }
        // segueから遷移先のResultViewControllerを取得する
        let expViewController:ExpViewController = segue.destination as! ExpViewController
        // 遷移先のExpViewControllerで宣言しているimageFileに画像を設定する。
        expViewController.imageFile = lstImageFile[currentIdx]
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        // 他の画面から segue を使って戻ってきた時に呼ばれる
    }
    // 画像切替共通処理
    func switchImage(idx:Int) -> UIImage {
        self.currentIdx += idx
        
        if self.currentIdx < self.firstIdx {
            // 設定した画像位置が最初の画像Fileより前の位置を指定された場合
            // 最終画像ファイル位置を設定する。
            self.currentIdx = self.lastIdx
        }else if self.currentIdx > self.lastIdx {
            // 設定した画像位置が最後の画像Fileより後の位置を指定された場合
            // 先頭画像ファイル位置を設定する。
            self.currentIdx = self.firstIdx
        }
        return lstImageFile[currentIdx]
    }
    
    // 対象オブジェクトの状態設定
    func setObjStatus(isStatus:Bool) {
        // ボタンを使用不可にする。
        self.cmdNext.isEnabled = isStatus
        self.cmdPrev.isEnabled = isStatus
    }
    
    // 自動再生の停止共通処理
    func setStopAction() {
        // ボタンの名前を再生にする。
        self.cmdAutoRun.setTitle(self.btnNamePlayback, for: .normal)
        // 対象オブジェクトを使用可能にする。
        self.setObjStatus(isStatus: true)
        // タイマーリセット
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
        }
    }

}

