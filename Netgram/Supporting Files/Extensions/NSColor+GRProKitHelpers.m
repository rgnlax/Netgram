//
//  NSColor+GRProKitHelpers.m
//  GRProKit
//
//  Created by Guilherme Rambo on 22/09/15.
//  Copyright © 2015 Guilherme Rambo. All rights reserved.
//

#import "NSColor+GRProKitHelpers.h"

#define kDefaultBrightnessAdjustmentFactor 0.2

@implementation NSColor (GRProKitHelpers)

- (NSColor *)colorByAdjustingBrightnessWithFactor:(CGFloat)factor
{
    if (self.numberOfComponents == 2) {
        CGFloat white = self.whiteComponent;
        white += factor;
        
        CGFloat components[2] = { white, self.alphaComponent };
        
        return [NSColor colorWithColorSpace:self.colorSpace components:components count:2];
    }
    
    if (self.numberOfComponents == 4) {
        CGFloat red = self.redComponent;
        CGFloat green = self.greenComponent;
        CGFloat blue = self.blueComponent;
        CGFloat alpha = self.alphaComponent;
        
        CGFloat components[4] = { red+factor, green+factor, blue+factor, alpha };
        
        return [NSColor colorWithColorSpace:self.colorSpace components:components count:4];
    }
    
    return self;
}

- (NSColor *)darkerColor
{
    return [self colorByAdjustingBrightnessWithFactor:-kDefaultBrightnessAdjustmentFactor];
}

- (NSColor *)lighterColor
{
    return [self colorByAdjustingBrightnessWithFactor:kDefaultBrightnessAdjustmentFactor];
}

+ (NSColor *)colorWithString:(NSString *)seed{
    NSArray *array = @[@"#004d40", @"#006064", @"#00695c", @"#00796b", @"#00838f", @"#00897b", @"#0091ea", @"#009688", @"#0097a7", @"#00acc1", @"#00bcd4", @"#01579b", @"#0277bd", @"#0288d1", @"#039be5", @"#03a9f4", @"#056f00", @"#0a7e07", @"#0a8f08", @"#0d5302", @"#1a237e", @"#259b24", @"#283593", @"#2a36b1", @"#303f9f", @"#304ffe", @"#311b92", @"#33691e", @"#37474f", @"#3949ab", @"#3b50ce", @"#3d5afe", @"#3f51b5", @"#4527a0", @"#455a64", @"#455ede", @"#4a148c", @"#4d69ff", @"#4d73ff", @"#4e342e", @"#4e6cef", @"#512da8", @"#536dfe", @"#546e7a", @"#558b2f", @"#5677fc", @"#5c6bc0", @"#5d4037", @"#5e35b1", @"#607d8b", @"#6200ea", @"#651fff", @"#673ab7", @"#6889ff", @"#6a1b9a", @"#6d4c41", @"#78909c", @"#795548", @"#7986cb", @"#7b1fa2", @"#7c4dff", @"#7e57c2", @"#880e4f", @"#8d6e63", @"#8e24aa", @"#9575cd", @"#9c27b0", @"#aa00ff", @"#ab47bc", @"#ad1457", @"#b0120a", @"#ba68c8", @"#bf360c", @"#c2185b", @"#c41411", @"#c51162", @"#d01716", @"#d500f9", @"#d81b60", @"#d84315", @"#dd191d", @"#dd2c00", @"#e00032", @"#e040fb", @"#e51c23", @"#e64a19", @"#e65100", @"#e91e63", @"#ef6c00", @"#f4511e", @"#f50057", @"#ff2d6f", @"#ff3d00", @"#ff4081", @"#ff5177", @"#ff5722", @"#ff6f00", @"#ff8f00", @"#ffa000"];
    
    
    NSInteger randomIndex = [self randomfromString:seed]*[array count];
    
    return [NSColor colorWithHexString:[array objectAtIndex:randomIndex]];
}

+ (double)randomfromString:(NSString *)string{
    NSInteger code = 1;
    
    for (int i = 0; i < [string length]; ++i) {
        code += [string characterAtIndex:i];
    }
    
    float value = (float)(sinf(code)*1000);
    value = value - floor(value);
    return value;
}

+ (NSColor *) colorWithHexString:(NSString *)hexstr {
    NSScanner *scanner;
    unsigned int rgbval;
    
    scanner = [NSScanner scannerWithString: hexstr];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt: &rgbval];
    
    return [NSColor colorWithHexValue: rgbval];
}

// Create a color using a hex RGB value
// ex. [UIColor colorWithHexValue: 0x03047F]
+ (NSColor *) colorWithHexValue: (NSInteger) rgbValue {
    return [NSColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0
                           alpha:1.0];
    
    
}

@end
