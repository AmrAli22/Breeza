//
//  SwiftMessages.swift
//  Aljoud
//
//  Created by Sayed Abdo on 07/10/2021.
//

import UIKit
import SwiftMessages

class MessageViewAlert {
    // MARK: - Message View
    func messageViewAlert(title : String ,msg : String,type: MessageView.Layout ,postion : SwiftMessages.PresentationStyle,theme: Theme ,HaveButton : Bool){
        let messageView = MessageView.viewFromNib(layout: type)
        messageView.configureTheme(theme)
        messageView.configureContent(title: title, body: msg)
        messageView.button?.isHidden = HaveButton
        var messageViewConfig = SwiftMessages.defaultConfig
        messageViewConfig.presentationStyle = postion
        messageViewConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: messageViewConfig, view: messageView)
    }
    
    static func demoCustomNib(messageView : MessageView ,postion : SwiftMessages.PresentationStyle , duration : SwiftMessages.Duration , color : UIColor , interactive: Bool) {
        var view = messageView
        view = try! SwiftMessages.viewFromNib()
        view.configureDropShadow()
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        config.duration = duration
        config.presentationStyle = postion
        config.dimMode = .color(color: color, interactive: interactive)
        SwiftMessages.show(config: config, view: view)
    }
    
}
