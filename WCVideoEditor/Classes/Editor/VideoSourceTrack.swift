//
//  VideoSourceTrack.swift
//  WCVideoEditor-WCVideoEditor
//
//  Created by Wc on 2023/8/22.
//

import AVFoundation

public class VideoSourceTrack {
    let sourceTrack: SourceTrack
    var trackId: CMPersistentTrackID = kCMPersistentTrackID_Invalid
    var timeRangeInTimeline: CMTimeRange
    var preferredTransform: CGAffineTransform = CGAffineTransform.identity
    
    public init(sourceTrack: SourceTrack) {
        self.sourceTrack = sourceTrack
        self.timeRangeInTimeline = sourceTrack.timeRange
    }
    
    func addVideoTrack(to composition: AVMutableComposition, preferredTrackID: CMPersistentTrackID) {
        guard let source = sourceTrack.source else {
            debugFatalError("当前source为空")
        }
        
        guard let assetTrack = source.tracks(for: .video).first else {
            debugFatalError("当前sourceTrack为空")
        }
        
        trackId = preferredTrackID
        preferredTransform = assetTrack.preferredTransform
        
        let compositionTrack: AVMutableCompositionTrack? = {
            if let compositionTrack = composition.track(withTrackID: preferredTrackID) {
                return compositionTrack
            }
            return composition.addMutableTrack(withMediaType: .video, preferredTrackID: preferredTrackID)
        }()

        if let compositionTrack = compositionTrack {
            do {
                try compositionTrack.insertTimeRange(source.selectedTimeRange, of: assetTrack , at: timeRangeInTimeline.start)
            } catch {
                // TODO: handle Error
            }
        }
    }
}
