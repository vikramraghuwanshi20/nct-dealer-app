//
//  oDealerData.m
//  LoeberMotors
//
//  Created by ncompasstrac on 4/6/14.
//
//

#import "oDealerData.h"

@implementation oDealerData

@synthesize nDealerNumber,dddata;



-(NSString *) DealerGetFld:(NSString *)fld
{
    return [iRecord GetField:fld withdata:dddata];
}


-(void) LoadDealerInfo
{
 
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dealerdata" ofType:@"txt"];
    
    dddata = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
}



-(NSString *)GetRoadSide
{
   
    if (nDealerNumber== kDealerPORSCHE)
    {
        return [self DealerGetFld:D_ROADSIDEPHONEPORSCHE];
    }
    
    return [self DealerGetFld:D_ROADSIDEPHONE];
    
    
}


@end
