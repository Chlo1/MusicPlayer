//
//  ViewController.swift
//  Music
//
//  Created by 張歆 on 2020/3/22.
//  Copyright © 2020 zxi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var BGImage: UIImageView!
    @IBOutlet weak var SongImage: UIImageView!
    @IBOutlet weak var SongName: UILabel!
    @IBOutlet weak var SingerLabel: UILabel!
    @IBOutlet weak var SongSlider: UISlider!
    @IBOutlet weak var CurrentLabel: UILabel!
    @IBOutlet weak var LengthLabel: UILabel!
    @IBOutlet weak var PlayerButton: UIButton!
    
    let player = AVQueuePlayer()
    var playerItem:AVPlayerItem?
    //var looper: AVPlayerLooper?
    var playIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let fileUrl = Bundle.main.url(forResource: "TANK-你的情歌", withExtension: "mp3")!
        playerItem = AVPlayerItem(url: fileUrl)
        SongImage.image = UIImage(named: "TANK-你的情歌.jpg")
        SongName.text = "你的情歌"
        SingerLabel.text = "TANK"
        BGImage.image = UIImage(named: "TANK-你的情歌.jpg")
        CurrentTime()
        updatePlayerUI()
        playIndex = 0
    }
    
    //播放、暫停
    @IBAction func playButton(_ sender: UIButton) {
        player.replaceCurrentItem(with: playerItem)
        if player.rate == 0 {
            PlayerButton.setImage(UIImage(named: "pause.png"), for: .normal)
            player.play()
        }
        else {
            PlayerButton.setImage(UIImage(named: "play.png"), for: .normal)
            player.pause()
        }
    }
    
    //下一首
    @IBAction func AcNextButton(_ sender: UIButton) {
        let fileUrl = Bundle.main.url(forResource: "周興哲-Im Happy", withExtension: "mp3")!
        playerItem = AVPlayerItem(url: fileUrl)
        SongImage.image = UIImage(named: "周興哲-Im Happy.jpg")
        SongName.text = "I'm Happy"
        SingerLabel.text = "周興哲"
        BGImage.image = UIImage(named: "周興哲-Im Happy.jpg")
        CurrentTime()
        updatePlayerUI()
        player.replaceCurrentItem(with: playerItem)
    }
    
    //上一首
    @IBAction func AcBackButton(_ sender: Any) {
        let fileUrl = Bundle.main.url(forResource: "TANK-你的情歌", withExtension: "mp3")!
        playerItem = AVPlayerItem(url: fileUrl)
        SongImage.image = UIImage(named: "TANK-你的情歌.jpg")
        SongName.text = "你的情歌"
        SingerLabel.text = "TANK"
        BGImage.image = UIImage(named: "TANK-你的情歌.jpg")
        CurrentTime()
        updatePlayerUI()
        player.replaceCurrentItem(with: playerItem)
    }
    
    //偵測歌曲播放時間
    @IBAction func TimeObserverSlider(_ sender: UISlider) {
        //  slider位置
        let seconds = Int64(SongSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)

        
    }
    func CurrentTime() {
          player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: { (CMTime) in
                  if self.player.currentItem?.status == .readyToPlay {
                      let currentTime = CMTimeGetSeconds(self.player.currentTime())
                    self.SongSlider.value = Float(currentTime)
                    self.CurrentLabel.text = self.formatConversion(time: currentTime)
                  }
              })
          }
    
    func updatePlayerUI() {
        guard let duration = playerItem?.asset.duration else {
            return
        }
                let seconds = CMTimeGetSeconds(duration)
                    LengthLabel.text = formatConversion(time: seconds)
                    SongSlider.minimumValue = 0
                    SongSlider.maximumValue = Float(seconds)
                    SongSlider.isContinuous = true
    }
    
    func formatConversion(time:Float64) -> String {
        let songLength = Int(time)
        let minutes = Int(songLength / 60) // 求 songLength 的商，為分鐘數
        let seconds = Int(songLength % 60) // 求 songLength 的餘數，為秒數
        var time = ""
        if minutes < 10 {
          time = "0\(minutes):"
        } else {
          time = "\(minutes)"
        }
        if seconds < 10 {
          time += "0\(seconds)"
        } else {
          time += "\(seconds)"
        }
        return time
    }
    
}

