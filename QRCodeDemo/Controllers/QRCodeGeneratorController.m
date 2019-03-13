//
//  QRCodeGeneratorController.m
//  QRCodeDemo
//
//  Created by Melike Sardogan on 13.03.2019.
//  Copyright © 2019 Alaattin Bedir. All rights reserved.
//

#import "QRCodeGeneratorController.h"
#import "QRCodeGenerator.h"

@interface QRCodeGeneratorController ()

@end

@implementation QRCodeGeneratorController



- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self generateQRCode];
}


// Mark: Provate Methods
- (void) generateQRCode {
    //1.method
    // generate a QR Code with `Hello World` and custom size and aspect
    QRCodeGenerator *qr = [[QRCodeGenerator alloc] initWithString:@"Merhaba!"];
    qr.size = CGSizeMake(400.0f, 400.0f); // 400x400 size
    qr.color = [CIColor colorWithRGBA:@"#FFFFFF"]; // white QR Code color
    qr.backgroundColor = [CIColor colorWithRGBA:@"#000000"]; // black background color
    
    self.QRcodeImageView.image = [qr getImage];
    
    //2.method
//    NSString *info = @"http://codeafterhours.wordpress.com";
//
//    // Generation of QR code image
//    NSData *qrCodeData = [info dataUsingEncoding:NSISOLatin1StringEncoding]; // recommended encoding
//    CIFilter *qrCodeFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    [qrCodeFilter setValue:qrCodeData forKey:@"inputMessage"];
//    [qrCodeFilter setValue:@"M" forKey:@"inputCorrectionLevel"]; //default of L,M,Q & H modes
//
//    CIImage *qrCodeImage = qrCodeFilter.outputImage;
//
//    CGRect imageSize = CGRectIntegral(qrCodeImage.extent); // generated image size
//    CGSize outputSize = CGSizeMake(240.0, 240.0); // required image size
//    CIImage *imageByTransform = [qrCodeImage imageByApplyingTransform:CGAffineTransformMakeScale(outputSize.width/CGRectGetWidth(imageSize), outputSize.height/CGRectGetHeight(imageSize))];
//
//    UIImage *qrCodeImageByTransform = [UIImage imageWithCIImage:imageByTransform];
//    //    self.imgViewQRCode.image = qrCodeImageByTransform;
//
//    // Generation of bar code image
//    CIFilter *barCodeFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
//    NSData *barCodeData = [info dataUsingEncoding:NSASCIIStringEncoding]; // recommended encoding
//    [barCodeFilter setValue:barCodeData forKey:@"inputMessage"];
//    [barCodeFilter setValue:[NSNumber numberWithFloat:7.0] forKey:@"inputQuietSpace"]; //default whitespace on sides of barcode
//
//    CIImage *barCodeImage = barCodeFilter.outputImage;
    //    self.imgViewBarCode.image = [UIImage imageWithCIImage:barCodeImage];
}


@end
