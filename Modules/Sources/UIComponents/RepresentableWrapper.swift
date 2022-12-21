//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import UIKit
import SwiftUI

public struct RepresentableWrapper<A, Context> {
    let make: (Context) -> A
    let update: (A, Context) -> Void
}


extension RepresentableWrapper where A: UIView {

    static var view: (A) -> Self {
        { view in Self.init(make: { _ in view }, update: { _, _ in }) }
    }

    public func makeUIView(context: Context) -> A {
        make(context)
    }

    public func updateUIView(_ uiView: A, context: Context) {
        update(uiView, context)
    }

}

extension RepresentableWrapper where A: UIViewController {

    static var viewController: (A) -> Self {
        { vc in Self.init(make: { _ in vc }, update: { _, _ in }) }
    }

    public func makeUIViewController(context: Context) -> A {
        make(context)
    }

    public func updateUIViewController(_ uiViewController: A, context: Context) {
        update(uiViewController, context)
    }
}


//extension RepresentableWrapper: UIViewControllerRepresentable where A: UIViewController {
//    public typealias UIViewControllerType = A
//
//    public init(item: UIViewControllerType) {
//        self.item = item
//    }
//
//    public typealias Body = Self
//
//    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
//    public func makeUIViewController(context: Context) -> UIViewControllerType { item }
//}
//
//extension RepresentableWrapper: UIViewRepresentable where A: UIView {
//    public typealias UIViewType = A
//    public typealias Context = UIViewRepresentableContext<RepresentableWrapper<UIViewType>>
//
//    public init(item: UIViewType) {
//        self.item = item
//    }
//
////    public typealias Body = RepresentableWrapper<UIViewType>
//
//    public func updateUIView(_ uiView: UIViewType, context: Context) {}
//    public func makeUIView(context: Context) -> UIViewType { item }
//}

