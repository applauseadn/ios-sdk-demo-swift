//
//  NativeAdSample4ViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/31.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VANativeAdDelegate
extension NativeAdSample4ViewController: VANativeAdDelegate {
    
    func nativeAdDidLoad(nativeAd: VANativeAd) {
        if let safeAdView = self.adView {
            
            // AdView存在時，可以直接將AdView帶入進行Rendering
            let render = VANativeAdViewRender(nativeAd: nativeAd, customAdView: safeAdView)
            
            // 清除AdView上廣告素材並重新Rendering
            render.renderWithCompleteHandler({ (view, error) in
                if let safeError = error {
                    print("Render did fail With error : \(safeError)")
                }
            })
        }
        else {
            let render = VANativeAdViewRender(nativeAd: nativeAd, customizedAdViewClass: SampleView1.self)
            render.renderWithCompleteHandler({ [weak self] (view, error) in
                guard let safeSelf = self else {
                    return
                }
                
                if let safeError = error {
                    print("Render did fail With error : \(safeError)")
                }
                else if let safeView = view {
                    safeSelf.view.addSubview(safeView)
                    
                    // autolayout 設定, 固定大小, 水平垂直置中
                    safeView.translatesAutoresizingMaskIntoConstraints = false
                    safeView.addConstraint(NSLayoutConstraint(item: safeView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGRectGetWidth(safeView.bounds)))
                    safeView.addConstraint(NSLayoutConstraint(item: safeView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGRectGetHeight(safeView.bounds)))
                    
                    safeSelf.view.addConstraint(NSLayoutConstraint(item: safeView, attribute: .CenterX, relatedBy: .Equal, toItem: safeSelf.view, attribute: .CenterX, multiplier: 1.0, constant: 0))
                    safeSelf.view.addConstraint(NSLayoutConstraint(item: safeView, attribute: .CenterY, relatedBy: .Equal, toItem: safeSelf.view, attribute: .CenterY, multiplier: 1.0, constant: 0))
                    safeSelf.view.layoutIfNeeded()
                    
                    safeSelf.adView = safeView
                }
            })
        }
    }
    
    func nativeAd(nativeAd: VANativeAd, didFailedWithError error: NSError) {
        print("\(#function) \(error)")
    }
    
    func nativeAdDidClick(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishHandlingClick(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdBeImpressed(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishImpression(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
}

// MARK: Life Cycle
class NativeAdSample4ViewController: UIViewController {
    
    private let nativeAd = VANativeAd(placement: "VMFiveAdNetwork_NativeAdSample4", adType:kVAAdTypeVideoCard)
    private var adView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NativeAdSample4"
        
        // 建立NativeAd物件做為Render的Ad資料來源
        self.nativeAd.testMode = true
        self.nativeAd.apiKey = "YOUR API KEY HERE"
        self.nativeAd.delegate = self
        
        // 改變 isNeedFullscreenIcon 設定值, 可控制 icon 是否出現
        // 需將 #import "VANativeAd+FullscreenIcon.h" 加入 Bridging file 內
        // 可以出現這個設定值
        print("===== will change isNeedFullscreenIcon from \(self.nativeAd.isNeedFullscreenIcon ? "YES" : "NO")")
        self.nativeAd.isNeedFullscreenIcon = false
        print("===== did change isNeedFullscreenIcon to \(self.nativeAd.isNeedFullscreenIcon ? "YES" : "NO")")
        
        // 改變 videoItemsAlignment 設定值, 可控制 icon 對齊的是 video 影片邊緣, 或是整個 adview 畫面邊緣
        // 0 為貼齊 video, 1 為貼齊 view
        // 需將 #import "VANativeAd+IconAlignment.h" 加入 Bridging file 內
        // 可以出現這個設定值
        print("===== will change videoItemsAlignment from \(self.nativeAd.videoItemsAlignment)");
        self.nativeAd.videoItemsAlignment = 1;
        print("===== did change videoItemsAlignment to \(self.nativeAd.videoItemsAlignment)");
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.nativeAd.loadAd()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.nativeAd.unloadAd()
    }
    
}
