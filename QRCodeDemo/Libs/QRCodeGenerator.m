//
//  QRCodeGenerator.m
//  QRCodeDemo
//
//  Created by Melike Sardogan on 13.03.2019.
//  Copyright © 2019 Alaattin Bedir. All rights reserved.
//

#import "QRCodeGenerator.h"
#import "NSString+Utils.h"

@interface QRCodeGenerator ()

- (CIImage *)getCIImage;

@end

@implementation QRCodeGenerator

@synthesize data = _data;

- (instancetype)init {
    if ((self = [super init])) {
        self.errorCorrection = QRErrorCorrectionLow;
        self.size = CGSizeMake(200.0f, 200.0f);
        self.color = [CIColor colorWithRed:0.0f green:0.0f blue:0.0f];
        self.backgroundColor = [CIColor colorWithRed:1.0f green:1.0f blue:1.0f];
        _data = nil;
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data {
    if ((self = [super init])) {
        self.errorCorrection = QRErrorCorrectionLow;
        self.size = CGSizeMake(200.0f, 200.0f);
        self.color = [CIColor colorWithRed:0.0f green:0.0f blue:0.0f];
        self.backgroundColor = [CIColor colorWithRed:1.0f green:1.0f blue:1.0f];
        _data = data;
    }
    return self;
}

- (instancetype)initWithString:(NSString *)string {
    if ((self = [super init])) {
        self.errorCorrection = QRErrorCorrectionLow;
        self.size = CGSizeMake(200.0f, 200.0f);
        self.color = [CIColor colorWithRed:0.0f green:0.0f blue:0.0f];
        self.backgroundColor = [CIColor colorWithRed:1.0f green:1.0f blue:1.0f];
        _data = [[NSString getSafeString:string] dataUsingEncoding:NSISOLatin1StringEncoding];
    }
    return self;
}

- (UIImage *)getImage {
    UIImage *r = nil;
    @try {
        CIImage *src = [self getCIImage];
        if (!src || src == nil) { return nil; }
        
        CGRect imageSize = CGRectIntegral(src.extent); // generated image size
        CGSize outputSize = self.size;
        CIImage *imageByTransform = [src imageByApplyingTransform:CGAffineTransformMakeScale(outputSize.width/CGRectGetWidth(imageSize), outputSize.height/CGRectGetHeight(imageSize))];
        
        r = [UIImage imageWithCIImage:imageByTransform];
    } @catch (NSException *exception) {
        NSLog(@"Error: %@", exception.reason);
    }
    return r;
}

- (CIImage *)getCIImage {
    CIImage *r = nil;
    @try {
        if (!self.data || self.data == nil || self.data.length <= 0) { return nil; }
        
        CIFilter *qrCodeFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        if (qrCodeFilter == nil) { return nil; }
        [qrCodeFilter setDefaults];
        [qrCodeFilter setValue:self.data forKey:@"inputMessage"];
        
        if (self.errorCorrection == QRErrorCorrectionLow) {
            [qrCodeFilter setValue:@"L" forKey:@"inputCorrectionLevel"];
        } else if (self.errorCorrection == QRErrorCorrectionMedium) {
            [qrCodeFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
        } else if (self.errorCorrection == QRErrorCorrectionQuartile) {
            [qrCodeFilter setValue:@"Q" forKey:@"inputCorrectionLevel"];
        } else if (self.errorCorrection == QRErrorCorrectionHigh) {
            [qrCodeFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
        }
        
        CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
        if (colorFilter == nil) { return nil; }
        [colorFilter setDefaults];
        [colorFilter setValue:qrCodeFilter.outputImage forKey:@"inputImage"];
        [colorFilter setValue:self.color forKey:@"inputColor0"];
        [colorFilter setValue:self.backgroundColor forKey:@"inputColor1"];
        
        r = colorFilter.outputImage;
        
    } @catch (NSException *exception) {
        NSLog(@"Error: %@", exception.reason);
    }
    return r;
}

@end
