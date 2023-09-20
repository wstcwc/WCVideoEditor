//
//  AssetVideoSource.swift
//  WCVideoEditor-WCVideoEditor
//
//  Created by Wc on 2023/8/17.
//

import AVFoundation

public class AssetVideoSource: Source {
    public let asset: AVAsset
    
    public init(asset: AVAsset) {
        self.asset = asset
        selectedTimeRange = CMTimeRange(start: .zero, duration: asset.duration)
        duration = asset.duration
    }
    
    // MARK: - Source
    public var duration: CMTime
    public var selectedTimeRange: CMTimeRange = .zero
    
    public func tracks(for type: AVMediaType) -> [AVAssetTrack] {
        return asset.tracks(withMediaType: type)
    }
}
