//
//  QRCodeGenerator.h
//  QRCodeDemo
//
//  Created by Melike Sardogan on 13.03.2019.
//  Copyright © 2019 Alaattin Bedir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CIColor+QRCode.h"

typedef NS_ENUM(NSUInteger, QRErrorCorrection) {
    QRErrorCorrectionLow = 0,
    QRErrorCorrectionMedium = 1,
    QRErrorCorrectionQuartile = 2,
    QRErrorCorrectionHigh = 3,
};

@interface QRCodeGenerator : NSObject

@property (nonatomic, strong, readonly) NSData *data;
@property (nonatomic, assign) QRErrorCorrection errorCorrection;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) CIColor *color; // Defaults to black
@property (nonatomic, strong) CIColor *backgroundColor; // Defaults to white

- (instancetype)init;
- (instancetype)initWithData:(NSData *)data;
- (instancetype)initWithString:(NSString *)string;

- (UIImage *)getImage;

@end
