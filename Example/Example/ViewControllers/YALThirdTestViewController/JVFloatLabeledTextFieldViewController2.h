//
//  JVFloatLabeledTextFieldViewController.h
//  JVFloatLabeledTextField
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013-2015 Jared Verdi
//  Original Concept by Matt D. Smith
//  http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
@interface JVFloatLabeledTextFieldViewController2 : UIViewController
@property (nonatomic, strong)JVFloatLabeledTextField *titleField;
@property (nonatomic, strong)JVFloatLabeledTextField *priceField;
@property (nonatomic, strong)JVFloatLabeledTextField *locationField;
@property (nonatomic, strong)JVFloatLabeledTextView *descriptionField;
@property (nonatomic, strong)JVFloatLabeledTextView *usage;
@property (nonatomic, strong)JVFloatLabeledTextView *text5;
@property (nonatomic, strong)JVFloatLabeledTextView *text6;
@property (nonatomic, strong)JVFloatLabeledTextView *text7;
@property (nonatomic, strong)JVFloatLabeledTextView *text8;
@property (nonatomic, strong)JVFloatLabeledTextView *text9;
@property (nonatomic, strong)UIButton *deleteButton;
@property NSInteger index;
- (instancetype)initForWhat:(NSInteger)index name:(NSString *)name_ department:(NSString*)department_ role:(NSString*)role_ age:(int)age_ basePay:(int)basePay_ bonus:(int)bonus_ award:(int)award_ insurance:(int)insurance_ fund:(int)fund_ payNum:(int)payNum_;
- (instancetype)initForNew:(NSInteger)index;
@end
