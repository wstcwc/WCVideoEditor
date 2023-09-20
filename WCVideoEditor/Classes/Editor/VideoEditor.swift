//
//  VideoEditor.swift
//  Pods-WCVideoEditor_Example
//
//  Created by Wc on 2023/8/17.
//

import AVFoundation

public class VideoEditor {
    private(set) var renderComposition: RenderComposition
    
    private var videoTracks: [VideoSourceTrack] = []
    
    private var composition: AVComposition?
    private var videoComposition: AVMutableVideoComposition?
    private var audioMix: AVAudioMix?
    
    public init(renderComposition: RenderComposition) {
        self.renderComposition = renderComposition
    }
    
    public func makePlayerItem() -> AVPlayerItem {
        let composition = makeComposition()
        
        let item = AVPlayerItem(asset: composition)
        
        return item
    }
        
    private func makeComposition() -> AVComposition {
        let composition = AVMutableComposition()
        self.composition = composition
        
        // Increase track ID
        var increasementTrackID: CMPersistentTrackID = 0
        func increaseTrackID() -> Int32 {
            let trackID = increasementTrackID + 1
            increasementTrackID = trackID
            return trackID
        }
        
        videoTracks = renderComposition.renderTrack
            .sorted(by: { CMTimeCompare($0.timeRange.start, $1.timeRange.start) < 0 })
            .map({ VideoSourceTrack(sourceTrack: $0) })
        
        var videoTrackIDInfo: [CMPersistentTrackID: CMTimeRange] = [:]
        func videoTrackID(for track: VideoSourceTrack) -> CMPersistentTrackID {
            var videoTrackID: CMPersistentTrackID?
            for (trackID, timeRange) in videoTrackIDInfo {
                if track.timeRangeInTimeline.start > timeRange.end {
                    videoTrackID = trackID
                    videoTrackIDInfo[trackID] = track.timeRangeInTimeline
                    break
                }
            }
            
            if let videoTrackID = videoTrackID {
                return videoTrackID
            } else {
                let videoTrackID = increaseTrackID()
                videoTrackIDInfo[videoTrackID] = track.timeRangeInTimeline
                return videoTrackID
            }
        }
        
        let minimumStartTime = videoTracks.first?.timeRangeInTimeline.start
        var maximumEndTime = videoTracks.first?.timeRangeInTimeline.end
        videoTracks.forEach { videoTrack in
            if videoTrack.sourceTrack.source?.tracks(for: .video).first != nil {
                let trackID = videoTrackID(for: videoTrack)
                videoTrack.addVideoTrack(to: composition, preferredTrackID: trackID)
            }
            
            if maximumEndTime! < videoTrack.timeRangeInTimeline.end {
                maximumEndTime = videoTrack.timeRangeInTimeline.end
            }
        }
        
        return composition
    }
}
