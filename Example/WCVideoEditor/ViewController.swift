//
//  ViewController.swift
//  WCVideoEditor
//
//  Created by Wc on 08/17/2023.
//  Copyright (c) 2023 Wc. All rights reserved.
//

import UIKit
import WCVideoEditor
import AVFoundation

class ViewController: UIViewController {
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let render = RenderComposition()
        render.renderSize = CGSize(width: 1080, height: 760)
        render.frameDuration = CMTime(value: 30, timescale: 600)
        
        guard let url = videoUrl(with: 5) else { return }
        let asset = AVAsset(url: url)
        let source = AssetVideoSource(asset: asset)
        source.selectedTimeRange = CMTimeRange(start: kCMTimeZero, duration: asset.duration)
        let track1 = SourceTrack(timeRange: source.selectedTimeRange, source: source)
        
        guard let url2 = videoUrl(with: 6) else { return }
        let asset2 = AVAsset(url: url2)
        let source2 = AssetVideoSource(asset: asset2)
        source2.selectedTimeRange = CMTimeRange(start: CMTimeAdd(asset.duration, CMTime(value: 1, timescale: asset.duration.timescale)), duration: asset.duration)
        let track2 = SourceTrack(timeRange: source2.selectedTimeRange, source: source2)
        
        render.renderTrack = [track1, track2]
        
        let editor = VideoEditor(renderComposition: render)
        let item = editor.makePlayerItem()
        
        self.player = AVPlayer(playerItem: item)
        self.playerLayer = AVPlayerLayer(player: self.player)
        self.player?.play()
        if let layer = self.playerLayer {
            layer.frame = CGRect(x: 0, y: 30, width: UIScreen.main.bounds.width, height: 400)
            self.view.layer.addSublayer(layer)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func videoUrl(with index: Int) -> URL? {
        return Bundle.main.url(forResource: "video(\(index))", withExtension: "mp4")
    }
}
