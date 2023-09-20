//
//  SourceTrack.swift
//  WCVideoEditor-WCVideoEditor
//
//  Created by Wc on 2023/8/17.
//

import AVFoundation

public class SourceTrack {
    var source: Source?
    var timeRange: CMTimeRange
    
    public init(timeRange: CMTimeRange, source: Source? = nil) {
        self.source = source
        self.timeRange = timeRange
    }
}
