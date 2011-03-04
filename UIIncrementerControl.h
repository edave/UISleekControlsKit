//
//  UIIncrementerControl.h
//  UISleekControlsKit
//
//  Provides a control for allowing a user to increment/decrement a numerical
//  value (either through the keyboard or increment/decrement buttons
//
//  Created by David Pitman on 3/3/11.
//
//  Under the MIT License
// 

#import <UIKit/UIKit.h>


@interface UIIncrementerControl : UIControl<UITextFieldDelegate> {
	NSObject<UITextFieldDelegate>* _delegate;
	
	NSNumber* _value;
	NSNumber* _defaultValue;
	NSNumber* _incrementAmount;
	NSNumber* _minValue;
	NSNumber* _maxValue;

	UIButton* _decrementButton;
	UIButton* _incrementButton;
	UITextField* _textField;
	
	NSNumberFormatter* _numberFormatter;
}

// Delegate for receiving TextField Events
@property(nonatomic, retain) NSObject<UITextFieldDelegate>* delegate;

// Value of the Incrementer
@property(nonatomic, retain) NSNumber* value;

// The value the incrementer starts at, defaults to 1
@property(nonatomic, retain) NSNumber* defaultValue;

// The minimum value allowed by the incrementer, defaults to 0
@property(nonatomic, retain) NSNumber* minValue;

// The maximum value allowed by the incrementer, defaults to 10
@property(nonatomic, retain) NSNumber* maxValue;

// The amount to increment/decrement the value if the buttons are used
@property(nonatomic, retain) NSNumber* incrementAmount;

// Called when the increment button is tapped
-(void)incrementEvent:(id)sender;

// Called when the decrement button is tapped
-(void)decrementEvent:(id)sender;

@end
