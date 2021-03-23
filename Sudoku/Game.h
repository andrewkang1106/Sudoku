//
//  Game.h
//  Sudoku
//
//  Created by Alan Luo on 3/7/20.
//  Copyright © NYU All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Game : NSObject

// TODO: List all the properties

@property (nonatomic) NSString *name;
@property int size;
@property (nonatomic) NSMutableArray *grid;
@property (nonatomic) NSString *temp;


// TODO: List all the public methods
-(instancetype) init;
-(instancetype) initWithName: (NSString *) name
                     andSize: (int) size;
-(BOOL) setNumber: (int) number
         forGridX: (int) x
             andY: (int) y;
-(BOOL) isEnd;
-(BOOL) isValid;


@end

NS_ASSUME_NONNULL_END
