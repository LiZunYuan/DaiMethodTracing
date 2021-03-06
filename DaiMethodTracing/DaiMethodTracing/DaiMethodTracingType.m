//
//  DaiMethodTracingType.m
//  DaiMethodTracing
//
//  Created by DaidoujiChen on 2015/6/10.
//  Copyright (c) 2015年 ChilunChen. All rights reserved.
//

#import "DaiMethodTracingType.h"

DaiMethodTracingType tracingType(NSString *type)
{
    if (strncmp([type UTF8String], "c", 1) == 0) {
        return DaiMethodTracingTypeChar;
    } else if (strncmp([type UTF8String], "i", 1) == 0) {
        return DaiMethodTracingTypeInt;
    } else if (strncmp([type UTF8String], "s", 1) == 0) {
        return DaiMethodTracingTypeShort;
    } else if (strncmp([type UTF8String], "l", 1) == 0) {
        return DaiMethodTracingTypeLong;
    } else if (strncmp([type UTF8String], "q", 1) == 0) {
        return DaiMethodTracingTypeLongLong;
    } else if (strncmp([type UTF8String], "C", 1) == 0) {
        return DaiMethodTracingTypeUnsignedChar;
    } else if (strncmp([type UTF8String], "I", 1) == 0) {
        return DaiMethodTracingTypeUnsignedInt;
    } else if (strncmp([type UTF8String], "S", 1) == 0) {
        return DaiMethodTracingTypeUnsignedShort;
    } else if (strncmp([type UTF8String], "L", 1) == 0) {
        return DaiMethodTracingTypeUnsignedLong;
    } else if (strncmp([type UTF8String], "Q", 1) == 0) {
        return DaiMethodTracingTypeUnsignedLongLong;
    } else if (strncmp([type UTF8String], "f", 1) == 0) {
        return DaiMethodTracingTypeFloat;
    } else if (strncmp([type UTF8String], "d", 1) == 0) {
        return DaiMethodTracingTypeDouble;
    } else if (strncmp([type UTF8String], "B", 1) == 0) {
        return DaiMethodTracingTypeBool;
    } else if (strncmp([type UTF8String], "v", 1) == 0) {
        return DaiMethodTracingTypeVoid;
    } else if (strncmp([type UTF8String], "^", 1) == 0) {
        return DaiMethodTracingTypeVoidPointer;
    } else if (strncmp([type UTF8String], "*", 1) == 0) {
        return DaiMethodTracingTypeCharPointer;
    } else if (strncmp([type UTF8String], "@", 1) == 0) {
        return DaiMethodTracingTypeObject;
    } else if (strncmp([type UTF8String], "#", 1) == 0) {
        return DaiMethodTracingTypeClass;
    } else if (strncmp([type UTF8String], ":", 1) == 0) {
        return DaiMethodTracingTypeSelector;
    } else if (strncmp([type UTF8String], "?", 1) == 0) {
        return DaiMethodTracingTypeUnknow;
    }
    //上面是比較基本的部分, 下面這些結構參考從 https://github.com/johnno1962/Xtrace
    else if (strncmp([type UTF8String], "{CGRect=", 8) == 0) {
        return DaiMethodTracingTypeCGRect;
    } else if (strncmp([type UTF8String], "{CGPoint=", 9) == 0) {
        return DaiMethodTracingTypeCGPoint;
    } else if (strncmp([type UTF8String], "{CGSize=", 8) == 0) {
        return DaiMethodTracingTypeCGSize;
    } else if (strncmp([type UTF8String], "{CGAffineTransform=", 19) == 0) {
        return DaiMethodTracingTypeCGAffineTransform;
    } else if (strncmp([type UTF8String], "{UIEdgeInsets=", 14) == 0) {
        return DaiMethodTracingTypeUIEdgeInsets;
    } else if (strncmp([type UTF8String], "{UIOffset=", 10) == 0) {
        return DaiMethodTracingTypeUIOffset;
    }
    
    return -1;
}

NSString *voidPointerAnalyze(NSString *typeEncoding)
{
    if (typeEncoding.length > 1) {
        switch (tracingType([typeEncoding substringWithRange:NSMakeRange(1, 1)])) {
            case DaiMethodTracingTypeChar:
                return @"char *";
                
            case DaiMethodTracingTypeInt:
                return @"int *";
                
            case DaiMethodTracingTypeShort:
                return @"short *";
                
            case DaiMethodTracingTypeLong:
                return @"long *";
                
            case DaiMethodTracingTypeLongLong:
                return @"long long*";
                
            case DaiMethodTracingTypeUnsignedChar:
                return @"unsigened char *";
                
            case DaiMethodTracingTypeUnsignedInt:
                return @"unsigened int *";
                
            case DaiMethodTracingTypeUnsignedShort:
                return @"unsigened short *";
                
            case DaiMethodTracingTypeUnsignedLong:
                return @"unsigened long *";
                
            case DaiMethodTracingTypeUnsignedLongLong:
                return @"unsigened long long *";
                
            case DaiMethodTracingTypeFloat:
                return @"float *";
                
            case DaiMethodTracingTypeDouble:
                return @"double *";
                
            case DaiMethodTracingTypeBool:
                return @"BOOL *";
                
            case DaiMethodTracingTypeCGRect:
                return @"CGRect *";
                
            case DaiMethodTracingTypeCGPoint:
                return @"CGPoint *";
                
            case DaiMethodTracingTypeCGSize:
                return @"CGSize *";
                
            case DaiMethodTracingTypeCGAffineTransform:
                return @"CGAffineTransform *";
                
            case DaiMethodTracingTypeUIEdgeInsets:
                return @"UIEdgeInsets *";
                
            case DaiMethodTracingTypeUIOffset:
                return @"UIOffset *";
                
            default:
                return @"void *";
        }
    }
    return @"void *";
}

NSString *objectAnalyze(NSString *typeEncoding)
{
    NSString *classString = [typeEncoding substringFromIndex:1];
    NSArray *splits = [classString componentsSeparatedByString:@"\""];
    if (splits.count == 3) {
        return [NSString stringWithFormat:@"%@ *", splits[1]];
    } else {
        return @"id";
    }
}
