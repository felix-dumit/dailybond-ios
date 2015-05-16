//
//  DraggableView.swift
//  SmartCards
//
//  Created by André Vitor Terron on 5/5/15.
//  Copyright (c) 2015 André Vitor Terron. All rights reserved.
//

import Foundation
import UIKit

@objc class DraggableView : UIView {
    
    var animator : UIDynamicAnimator? = nil
    var oldPosition : CGPoint? = nil
    var itemBehavior : UIDynamicItemBehavior? = nil
    
    func initialSetup() {
        let panGesture : UIPanGestureRecognizer =  UIPanGestureRecognizer(target: self, action: Selector("dragging:"))
        
        //[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
        addGestureRecognizer(panGesture);
        //[self addGestureRecognizer:panGesture];
    }
    
    func dragging(sender: UIPanGestureRecognizer){
        switch (sender.state) {
            case UIGestureRecognizerState.Began:
                draggingStarted(sender)
                break;
            case UIGestureRecognizerState.Changed:
                draggingMoved(sender)
                break;
            case UIGestureRecognizerState.Cancelled, UIGestureRecognizerState.Ended, UIGestureRecognizerState.Failed:
                draggingEnded(sender)
                break;
            default:
                break;
        }
    }
    
    func draggingStarted(gesture: UIPanGestureRecognizer){
        if let sview = self.superview {
            let animator = UIDynamicAnimator(referenceView: sview)
            self.animator = animator
            self.oldPosition = gesture.locationInView(animator.referenceView);
            let itemBehavior = UIDynamicItemBehavior(items: [ gesture.view! ])
            self.itemBehavior = itemBehavior
            itemBehavior.angularResistance = CGFloat.max
            animator.addBehavior(itemBehavior)
        }
    }
    
    func draggingMoved(gesture: UIPanGestureRecognizer){
        
//        if (self.delegate && [self.delegate respondsToSelector:@selector(CCMPlayNDropView:manualTraslationDidMoveWithPercentageToCancel:angle:)]) {
//            CGFloat nonDismissableRadius = (self.nonDismissingRadius)? self.nonDismissingRadius.doubleValue : DEFAULT_RADIUS;
//            CGFloat percentage = [self percentageDismissableWithDissmissableRadius:nonDismissableRadius centerReference:gesture.view.center currentViewCenter:self.animator.referenceView.center];
//            CGFloat angle = [self angleBetweenPoint:self.animator.referenceView.center andPoint:[self.animator.referenceView.superview convertPoint:gesture.view.center fromView:self.animator.referenceView]];
//            
//            [self.delegate CCMPlayNDropView:self manualTraslationDidMoveWithPercentageToCancel:percentage angle:angle];
//        }
//        
//        CGFloat rotation = atan2(gesture.view.transform.b, gesture.view.transform.a);
//        CGFloat xDisplacement = [gesture locationInView:self.animator.referenceView].x - self.oldPosition.x;
//
//        
//        CGFloat maxAngleInRadians = self.maxAngle * M_PI / 180;
//        CGFloat translationAngle = (maxAngleInRadians > 0)? maxAngleInRadians : -maxAngleInRadians;
//        
//        CGPoint gestureViewCenter = [self.animator.referenceView convertPoint:gesture.view.center toView:gesture.view];
//        CGPoint touchLocationInGestureView = [gesture locationInView:gesture.view];
//        
//        if (touchLocationInGestureView.y > gestureViewCenter.y) {
//            if (xDisplacement < 0 && rotation > translationAngle) {
//                self.itemBehavior.allowsRotation = NO;
//            } else if (xDisplacement > 0 && rotation < -translationAngle){
//                self.itemBehavior.allowsRotation = NO;
//            } else {
//                self.itemBehavior.allowsRotation = YES;
//            }
//        } else {
//            if (xDisplacement < 0 && rotation < -translationAngle) {
//                self.itemBehavior.allowsRotation = NO;
//            } else if (xDisplacement > 0 && rotation > translationAngle){
//                self.itemBehavior.allowsRotation = NO;
//            } else {
//                self.itemBehavior.allowsRotation = YES;
//            }
//        }
//        
//        self.attachment.anchorPoint = [gesture locationInView:self.animator.referenceView];
//        self.oldPosition = [gesture locationInView:self.animator.referenceView];
    }
    
    func draggingEnded(gesture: UIPanGestureRecognizer){
        
    }
    
}
