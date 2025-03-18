//
//  RootSheetViewFinder.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/16/25.
//

import SwiftUI


//NOT USING
struct RootSheetViewFinder : UIViewRepresentable{
    
    var mask : Bool
    var height : CGFloat
    
    func makeUIView(context: Context) -> some UIView {
        return .init()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 ){
            
            guard !context.coordinator.isMasked else { return }
            
            if let rootView = uiView.viewBeforeWindow, let window = rootView.window{
                let safeArea = window.safeAreaInsets
                
                rootView.frame = .init(
                    origin: .zero,
                    size: .init(
                        width: window.frame.width,
                        height: window.frame.height - (mask ? (height + safeArea.bottom) : 0)
                    )
                )
                rootView.clipsToBounds = true
                
                for view in rootView .subviews {
                    view.layer.shadowColor = UIColor.clear.cgColor
                    
                    if view.layer.animationKeys() != nil {
                        if let cornerRadiusView = view.allSubViews.first(where: {
                            $0.layer.animationKeys()?.contains("cornerRadius") ?? false}) {
                            cornerRadiusView.layer.maskedCorners = []
                        }
                    }
                }
                
                context.coordinator.isMasked = true
                
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator : NSObject{
        
        var isMasked : Bool = false
    }
    
}


fileprivate extension UIView {
    var viewBeforeWindow : UIView? {
        if let superview , superview is UIWindow {
            return self
        }
        return superview?.viewBeforeWindow
    }
    
    var allSubViews : [UIView]  {
        return subviews.flatMap{ [$0] + $0.subviews }
    }
}

