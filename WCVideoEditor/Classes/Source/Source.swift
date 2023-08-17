//
//  Source.swift
//  WCVideoEditor
//
//  Created by Wc on 2023/8/17.
//

import AVFoundation

public protocol Source {
    var selectedTimeRange: CMTimeRange { get set }
}
