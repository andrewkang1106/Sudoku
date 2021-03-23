//
//  GameViewController.m
//  Sudoku
//
//  Created by NYU on 3/6/20.
//  Copyright © NYU All rights reserved.
//

#import "GameViewController.h"
#import "MyUIButton.h"
#import "Game.h"

@interface GameViewController ()
@property (weak, nonatomic) IBOutlet MyUIButton *number1Button;
@property (weak, nonatomic) IBOutlet MyUIButton *number2Button;
@property (weak, nonatomic) IBOutlet MyUIButton *number3Button;
@property (weak, nonatomic) IBOutlet MyUIButton *number4Button;

@property (weak, nonatomic) IBOutlet MyUIButton *grid00Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid01Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid02Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid03Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid10Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid11Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid12Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid13Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid20Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid21Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid22Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid23Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid30Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid31Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid32Button;
@property (weak, nonatomic) IBOutlet MyUIButton *grid33Button;

@property (strong, nonatomic) NSArray *gridButtons;
@property (strong, nonatomic) NSArray *numberButtons;

@property (strong, nonatomic) Game *game;

@property (strong, nonatomic) MyUIButton *activeButton;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //makes grid buttons
    self.gridButtons = [[NSArray alloc] initWithObjects:
                        [[NSArray alloc] initWithObjects: self.grid00Button, self.grid01Button, self.grid02Button, self.grid03Button, nil],
                        [[NSArray alloc] initWithObjects: self.grid10Button, self.grid11Button, self.grid12Button, self.grid13Button, nil],
                        [[NSArray alloc] initWithObjects: self.grid20Button, self.grid21Button, self.grid22Button, self.grid23Button, nil],
                        [[NSArray alloc] initWithObjects: self.grid30Button, self.grid31Button, self.grid32Button, self.grid33Button, nil],
                        nil];
    
    //make number buttons 1,2,3,4
    self.numberButtons = [[NSArray alloc] initWithObjects:self.number1Button, self.number2Button, self.number3Button, self.number4Button, nil];
    
    for (int x = 0; x < 4; x ++) {
        for (int y = 0; y < 4; y ++) {
            MyUIButton * currentButton = self.gridButtons[x][y]; //iterates through each button, and creates a currentButton object for each one
            
            //assigns each currentButton obj its coordinates (x,y)
            //using these to find coordinates? in the GRID
            //for use of getting x,y when user touches the button and selects it
            currentButton.x = x;
            currentButton.y = y;
        }
    }
    // TODO: Finish this method
//    for(int x = 0; x < 4; x++){
//        for (int y = 0; y < 4; y++){
//            [_game setNumber:[_game.grid[x][y] intValue] forGridX: x andY: y]; //load data of grid into grid buttons
//
//        }
//    }
//
    //self.game = [[Game alloc] initWithName:@"Your Name" andSize: 4];
    self.game = [[Game alloc] init];
    for (int x = 0; x < 4; x ++) {
        for (int y = 0; y < 4; y ++) {
            MyUIButton * currentButton = self.gridButtons[x][y];
            NSString * currentString = self.game.grid[x][y];
            [currentButton setTitle:currentString forState: UIControlStateNormal];
        }
    }
}

- (IBAction)gridButtonPressed:(MyUIButton *)sender {
    // TODO: Finish this method
    //active button stores? the grid button before user chooses #
    //If "activeButton" points to the current,
    //current = sender rn
    //_activeButton == nil?
    
    for (int x = 0; x < 4; x ++) {
        for (int y = 0; y < 4; y ++) {
            MyUIButton * currentButton = self.gridButtons[x][y];
            
            NSString * currentString = self.game.grid[x][y];
            currentButton.backgroundColor = [UIColor whiteColor];
            currentButton.enabled = YES;
            [currentButton setTitle:currentString forState: UIControlStateNormal];
            //everything disabled except empty grids
            if ([currentString isEqualToString: @""]) {
                currentButton.enabled = YES;
            } else {
                currentButton.enabled = NO;
            }
        }
    }
    //before, checked x,and y of sender and activeButton
    if(_activeButton == nil){ //when it points to nothing
    //no match found. "activeButton" doesn't point to anything
        //activate current button (change background color to yellow)
        //if(_activeButton.enabled == NO){
        _activeButton = sender;
        //_activeButton.enabled = YES;
        _activeButton.backgroundColor = [UIColor yellowColor];
        //save it to "activeButton"
            //NSLog(@"asdf");
            
        //}
    }
    else{//not nil. Not sure if matches or different
        NSLog(@"not nil");
        if(_activeButton == sender){ //sender here is current. activeButton should be holding the previous button the user pressed. This executes if previously selected button and currently selected button match.
            //NSLog(@"is sender");
//deacctivate current button
            _activeButton.enabled=NO;
//change color to white
            _activeButton.backgroundColor = [UIColor whiteColor];
//remove from active button
            _activeButton = nil;
        } //end of if
        else{//when activeButton holds a dif button than one currently selected
            //NSLog(@"not sender");
            _activeButton.backgroundColor = [UIColor whiteColor];
            _activeButton = sender;
            _activeButton.backgroundColor = [UIColor yellowColor];
//deactivate that button
//            _activeButton.enabled=NO;
            //If there is already an active button (1), and the user selects another button (2), we should deactivate the button (1) and activate the button (2).
        }
    }

}

- (IBAction)numberButtonPressed:(MyUIButton *)sender {
    // TODO: Finish this method
    //deactivate the button, and
    //disable the button
    if(_activeButton != nil){    //If there is another "active" button in "activeButton", we want to
            //set the number to the active button,
        //access number from number button
        if(sender == _number1Button){
            _game.grid[_activeButton.x][_activeButton.y] = @"1";
            [_activeButton setTitle:@"1" forState:UIControlStateNormal];
            [_activeButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        }
        else if(sender == _number2Button){
            _game.grid[_activeButton.x][_activeButton.y] = @"2";
            [_activeButton setTitle:@"2" forState:UIControlStateNormal];
            [_activeButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        }
        else if(sender == _number3Button){
            _game.grid[_activeButton.x][_activeButton.y] = @"3";
            [_activeButton setTitle:@"3" forState:UIControlStateNormal];
            [_activeButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        }
        else if(sender == _number4Button){
            _game.grid[_activeButton.x][_activeButton.y] = @"4";
            [_activeButton setTitle:@"4" forState:UIControlStateNormal];
            [_activeButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        }
        
        _activeButton.enabled = NO;
        _activeButton=nil;
        
    }
    //-----------
    //check if the inputs are valid
    
    //check if game ends
    //check if player wins or loses
        //call loseTheGame or winTheGame
    if([_game isValid]){
        //if true
        if([_game isEnd]){//if ended
            [self winTheGame];
        }
    }
    else{ //if false
        [self loseTheGame];
    }
    
}

- (void) loseTheGame {
    // Feel free to read this method, but do not change anything here
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Game Over"
                                   message:@"Sorry, you lost."
                                   preferredStyle: UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {[self restart];}];
     
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion: nil];
}

- (void) winTheGame {
    // Feel free to read this method, but do not change anything here
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Game Over"
                                   message:@"Congratulations, you won!"
                                   preferredStyle: UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {[self restart];}];
     
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion: nil];
}

- (void) restart {
    // Feel free to read this method, but do not change anything here
    
    self.game = [[Game alloc] initWithName:@"Your Name" andSize: 4];
    
    for (int x = 0; x < 4; x ++) {
        for (int y = 0; y < 4; y ++) {
            MyUIButton * currentButton = self.gridButtons[x][y];
            
            NSString * currentString = self.game.grid[x][y];
            currentButton.backgroundColor = [UIColor whiteColor];
            currentButton.enabled = YES;
            [currentButton setTitle:currentString forState: UIControlStateNormal];
            
            if (![currentString isEqualToString: @""]) {
                currentButton.enabled = NO;
            } else {
                currentButton.enabled = YES;
            }
        }
    }
}

- (IBAction)restartButtonPressed:(id)sender {
    [self restart];
}

@end
