//
//  RenderComposition.swift
//  WCVideoEditor-WCVideoEditor
//
//  Created by Wc on 2023/8/17.
//

import AVFoundation
import UIKit

public class RenderComposition {
    public var backgroundColor: UIColor = UIColor.clear
    
    public var frameDuration: CMTime = CMTime(value: 1, timescale: 30)
    public var renderSize: CGSize = CGSize(width: 720, height: 1280)
    
    public var renderTrack: [SourceTrack] = []
    public var animationLayer: CALayer?
    
    public init() {}
}
