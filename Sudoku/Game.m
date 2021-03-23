//
//  Game.m
//  Sudoku
//
//  Created by NYU on 3/7/20.
//  Copyright © 2020 NYU All rights reserved.
//

#import "Game.h"

@implementation Game

- (instancetype) initWithName: (NSString *) name andSize: (int) size {
    // TODO: Finish this method
    
    //Initialize the object with the specific name and size
    _name = name;
    _size = size;
    //Use the private method "sudoku Generator" to generate the sudoku problem
    //and save into the grid
    _grid = [self sudokuGenerator];
    
    
    return self;
    
}

- (instancetype) init {
    // TODO: Finish this method
    //Initialize the object
    //Set name to "Anonymus", size to 4
    _name = @"Anonymus";
    _size = 4;
    //Use the provided private method "sudokuGenerator" to generate and save into grid
        //generator makes 2D array
    _grid = [self sudokuGenerator];
//    for (int x = 0; x < _size; x ++) { //randomly sets block as empty
//        for (int y = 0; y < _size; y ++) {
//            printf("%s", _grid[x][y]);
//        }
//    }
    
    
    return self;
}

- (BOOL) setNumber: (int) number forGridX: (int) x andY: (int) y {
    // TODO: Finish this method
    //When the user chooses a number for cell (X,Y), we use this method to save # to grid
    //Return True if input valid, or False otherwise
        //check if valid
    //private method "isValid" is provided to validify
     _temp = _grid[x][y];
    _grid[x][y] = [[NSString alloc] initWithFormat:@"%d", number];
    if ([self isValid]){
        return true;
    }
    else{
        _grid[x][y] = _temp; //restore grid to normal
        return false;
    }
    
}

- (BOOL) isEnd {
    // TODO: Finish this method
    //Return true if all inputs are valid, and there is no empty cell
    //Return False otherwise
    
    for (int y = 0; y < _size; y ++) { //check for empty string
          for (int x = 0; x < _size - 1; x ++) {
              if ([_grid[x][y] isEqualToString: @""]) {
                  return false;
              }
          }
    }
    if([self isValid]){ //check if input is valid
        return true;
    }
    else{
        return false;
    }
//    for (int x = 0; x < _size; x ++) { //randomly sets block as empty
//        for (int y = 0; y < _size; y ++) {
//            if ( [self isValid]){
//                return true;
//            }
//        } //inner for
//    }//outer for
    
    
    return true;
    
    
    
}



- (NSMutableArray *) sudokuGenerator {
    // Feel free to read this method to understand how to use _grid[x][y], but do not change anything here
    
    // this should be a new NSMutableArray, but since we need use [self isValid], we have to put the result in _grid
    _grid = [NSMutableArray arrayWithObjects:
            [NSMutableArray arrayWithObjects: @"", @"", @"", @"", nil],
            [NSMutableArray arrayWithObjects: @"", @"", @"", @"", nil],
            [NSMutableArray arrayWithObjects: @"", @"", @"", @"", nil],
            [NSMutableArray arrayWithObjects: @"", @"", @"", @"", nil], nil];
    
    int retryCount = 0;
    
    for (int x = 0; x < _size; x ++) { //populates grid, checks if valid
        for (int y = 0; y < _size; y ++) {
            //populates grid
            _grid[x][y] = [NSString stringWithFormat: @"%d", arc4random_uniform(_size) + 1];
            
            while (![self isValid]) { //while not valid
                _grid[x][y] = [NSString stringWithFormat: @"%d", arc4random_uniform(_size) + 1];
                
                retryCount += 1;
                
                // in a rare case, there is no solution, we have to restart the generator
                if (retryCount > 100)
                    return [self sudokuGenerator];
            }
        }
    }
    
    for (int x = 0; x < _size; x ++) { //randomly sets block as empty
        for (int y = 0; y < _size; y ++) {
            if ( arc4random_uniform(3) != 0 )
                _grid[x][y] = @"";
        }
    }
    
    return _grid;
}

- (BOOL) isValid {
    // Feel free to read this method
    // Bonus Points: come out a better algorithm to check if the Sudoku is valid
    
    // for each coloum
    for (int x = 0; x < _size; x ++) {
        for (int y = 0; y < _size - 1; y ++) {
            if ([_grid[x][y] isEqualToString: @""]) {
                continue;
            }
            
            for (int z = y + 1; z < _size; z ++) {
                if ([_grid[x][y] isEqualToString: _grid[x][z]]) {
                    return false;
                }
            }
        }
    }
    
    // for each row
    for (int y = 0; y < _size; y ++) {
        for (int x = 0; x < _size - 1; x ++) {
            if ([_grid[x][y] isEqualToString: @""]) {
                continue;
            }
            
            for (int z = x + 1; z < _size; z ++) {
                if ([_grid[x][y] isEqualToString: _grid[z][y]]) {
                    return false;
                }
            }
        }
    }
    
    
    
    // for each small grid
    int x = 0, y = 0;
    
    if ((![_grid[x][y] isEqualToString: @""] && ([_grid[x][y] isEqualToString: _grid[x + 1][y]] || [_grid[x][y] isEqualToString: _grid[x][y + 1]] || [_grid[x][y] isEqualToString: _grid[x + 1][y + 1]]))
        || (![_grid[x + 1][y] isEqualToString: @""] && ([_grid[x + 1][y] isEqualToString: _grid[x][y + 1]] || [_grid[x + 1][y] isEqualToString: _grid[x + 1][y + 1]])) ||
        (![_grid[x][y + 1] isEqualToString: @""] && [_grid[x][y + 1] isEqualToString: _grid[x + 1][y + 1]])) {
            return false;
    }
    
    x = 2; y = 0;
    
    if ((![_grid[x][y] isEqualToString: @""] && ([_grid[x][y] isEqualToString: _grid[x + 1][y]] || [_grid[x][y] isEqualToString: _grid[x][y + 1]] || [_grid[x][y] isEqualToString: _grid[x + 1][y + 1]]))
        || (![_grid[x + 1][y] isEqualToString: @""] && ([_grid[x + 1][y] isEqualToString: _grid[x][y + 1]] || [_grid[x + 1][y] isEqualToString: _grid[x + 1][y + 1]])) ||
        (![_grid[x][y + 1] isEqualToString: @""] && [_grid[x][y + 1] isEqualToString: _grid[x + 1][y + 1]])) {
            return false;
    }
    
    x = 0; y = 2;
    
    if ((![_grid[x][y] isEqualToString: @""] && ([_grid[x][y] isEqualToString: _grid[x + 1][y]] || [_grid[x][y] isEqualToString: _grid[x][y + 1]] || [_grid[x][y] isEqualToString: _grid[x + 1][y + 1]]))
        || (![_grid[x + 1][y] isEqualToString: @""] && ([_grid[x + 1][y] isEqualToString: _grid[x][y + 1]] || [_grid[x + 1][y] isEqualToString: _grid[x + 1][y + 1]])) ||
        (![_grid[x][y + 1] isEqualToString: @""] && [_grid[x][y + 1] isEqualToString: _grid[x + 1][y + 1]])) {
            return false;
    }
    
    x = 2; y = 2;
    
    if ((![_grid[x][y] isEqualToString: @""] && ([_grid[x][y] isEqualToString: _grid[x + 1][y]] || [_grid[x][y] isEqualToString: _grid[x][y + 1]] || [_grid[x][y] isEqualToString: _grid[x + 1][y + 1]]))
        || (![_grid[x + 1][y] isEqualToString: @""] && ([_grid[x + 1][y] isEqualToString: _grid[x][y + 1]] || [_grid[x + 1][y] isEqualToString: _grid[x + 1][y + 1]])) ||
        (![_grid[x][y + 1] isEqualToString: @""] && [_grid[x][y + 1] isEqualToString: _grid[x + 1][y + 1]])) {
            return false;
    }
            
    return true;
}


@end
