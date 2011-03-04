//
//  UIIncrementerControl.m
//  UISleekControlsKit
//
//  Created by David Pitman on 3/3/11.
//  Under the MIT License


#import "UIIncrementerControl.h"


@implementation UIIncrementerControl

@synthesize value = _value;
@synthesize incrementAmount = _incrementAmount;
@synthesize minValue = _minValue;
@synthesize maxValue = _maxValue;
@synthesize defaultValue = _defaultValue;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    CGRect myFrame = CGRectMake(frame.origin.x, frame.origin.y, 200, 30);
    self = [super initWithFrame:myFrame];
    if (self) {
		
		// Increment Button
        _incrementButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_incrementButton setTitle:@"+" forState:UIControlStateNormal];
		[_incrementButton addTarget:self action:@selector(incrementEvent:) forControlEvents:UIControlEventTouchUpInside];
		
		UIImage* incrementImage = [UIImage imageNamed:@"right-tab.png"];
		[_incrementButton setBackgroundImage:[incrementImage stretchableImageWithLeftCapWidth:10 topCapHeight:0] forState:UIControlStateNormal];
		[_incrementButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[_incrementButton setTitleShadowColor:[UIColor darkTextColor] forState:UIControlStateNormal];
		
		// Decrement Button
		_decrementButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_decrementButton setTitle:@"—" forState:UIControlStateNormal];
		[_decrementButton addTarget:self action:@selector(decrementEvent:) forControlEvents:UIControlEventTouchUpInside];
		[_decrementButton setTitleShadowColor:[UIColor darkTextColor] forState:UIControlStateNormal];
		  
		 
		UIImage* decrementImage = [UIImage imageNamed:@"left-tab.png"];
		[_decrementButton setBackgroundImage:[decrementImage stretchableImageWithLeftCapWidth:10 topCapHeight:0] forState:UIControlStateNormal];
		[_decrementButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		
		
		// TextField
		_textField = [[UITextField alloc] init];
		_textField.delegate = self;
		_textField.text = [NSString stringWithFormat:@"%@", self.defaultValue];
		_textField.borderStyle = UITextBorderStyleBezel;
		_textField.backgroundColor = [UIColor whiteColor];
		_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		//_textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
		_textField.textAlignment = UITextAlignmentRight;
		_textField.keyboardType = UIKeyboardTypeNumberPad;
		[_textField setAdjustsFontSizeToFitWidth:YES];
		
		[self addSubview:_textField];
		[self addSubview:_decrementButton];
		[self addSubview:_incrementButton];
		
		_numberFormatter = [[NSNumberFormatter alloc] init];
		[_numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
		
		// Set Default Values
		self.defaultValue = [NSNumber numberWithInt:1];
		self.incrementAmount = [NSNumber numberWithInt:1];
		self.minValue = [NSNumber numberWithInt:0];
		self.maxValue = [NSNumber numberWithInt:10];
		self.value = self.defaultValue;
		
    }
    return self;
}

-(void)layoutSubviews{
	[super layoutSubviews];
	CGRect decrementFrame = _decrementButton.frame;
	CGSize buttonSize = CGSizeMake(32,40);
	decrementFrame.size = buttonSize;
	decrementFrame.origin = CGPointMake(0,0);
	_decrementButton.frame = decrementFrame;
	
	
	CGRect textFrame = _textField.frame;
	textFrame.size = buttonSize;
	textFrame.origin = CGPointMake(CGRectGetMaxX(decrementFrame)-2.0, 0);
	_textField.frame = textFrame;
	
	
	CGRect incrementFrame = _incrementButton.frame;
	incrementFrame.size = buttonSize;
	incrementFrame.origin = CGPointMake(CGRectGetMaxX(textFrame)-2.0,0);
	_incrementButton.frame = incrementFrame;

}

-(void)setNeedsDisplay{
	[super setNeedsDisplay];

}

-(void)setValue:(NSNumber*)newValue{
	if(newValue == nil){
		return;	
	}
	int tempValue = [newValue intValue];
	int incAmount = [self.incrementAmount intValue]; 
	int maValue = [self.maxValue intValue];
	int miValue = [self.minValue intValue];
	
	if(tempValue > maValue){
		tempValue = maValue;
	}else if(tempValue < miValue ){
		tempValue = miValue;
	}
	_incrementButton.enabled = !((tempValue + incAmount) > [self.maxValue intValue]);
	_decrementButton.enabled = !((tempValue - incAmount) < [self.minValue intValue]);	
	
	[_value release];
	NSNumber* finalValue = [NSNumber numberWithInt:tempValue];
	_value = finalValue;
	[_value retain];
	_textField.text = [self.value stringValue];
	if(self.delegate != nil){
		[self.delegate incrementerValueChanged:self];
	}
}

#pragma mark -
#pragma mark Events

-(void)incrementEvent:(id)sender{
	int newValue = [self.value intValue] + [self.incrementAmount intValue];
	self.value = [NSNumber numberWithInt:newValue];
}

-(void)decrementEvent:(id)sender{
	int newValue = [self.value intValue] - [self.incrementAmount intValue];
	self.value = [NSNumber numberWithInt:newValue];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if(self.delegate != nil){
		[self.delegate textFieldDidBeginEditing:textField];
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	self.value = [_numberFormatter numberFromString: textField.text];
    if(self.delegate != nil){
		[self.delegate textFieldDidBeginEditing:textField];
	}
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	[_value release];
	[_incrementButton release];
	[_decrementButton release];
	[_numberFormatter release];
	[_maxValue release];
	[_minValue release];
	[_incrementAmount release];
	[_defaultValue release];
	[_delegate release];
    [super dealloc];
}


@end
