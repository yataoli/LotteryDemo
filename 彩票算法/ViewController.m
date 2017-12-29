//
//  ViewController.m
//  彩票算法
//
//  Created by 付宝网络 on 2017/12/29.
//  Copyright © 2017年 付宝网络. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *one;
@property (weak, nonatomic) IBOutlet UITextField *two;
@property (weak, nonatomic) IBOutlet UITextField *three;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableArray * resultArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

 _resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)jiSuancLICK:(UIButton *)sender {
    [_dataArray removeAllObjects];
    [_resultArray removeAllObjects];

    [_dataArray addObject:@([_one.text integerValue])];
    [_dataArray addObject:@([_two.text integerValue])];
    [_dataArray addObject:@([_three.text integerValue])];
    
    [_dataArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序
    }];
    
    NSLog(@"%@",_dataArray);
    
    
//*******************************号码循环处理（不需要循环的话请将此块代码注释掉）*******************************
    
    NSString *tempStr = @"";
    for (NSInteger i = 0; i < _dataArray.count; i ++) {
        NSNumber *number = _dataArray[i];
        if (i == 0) {
            tempStr = [NSString stringWithFormat:@"%@",number];
        }else{
            tempStr = [NSString stringWithFormat:@"%@%@",tempStr,number];
        }
    }
    NSNumber *number = [_dataArray lastObject];
    //11选5特殊情况处理
    if ([number integerValue] > 9) {
        if ([tempStr isEqualToString:@"11011"] || [tempStr isEqualToString:@"1211"]) {
            self.resultLabel.text = @"顺子";
            return;
        }else if (![tempStr isEqualToString:@"1111"] && ![tempStr isEqualToString:@"11111"]){
            tempStr = [NSString stringWithFormat:@"%@%@",_dataArray[0],_dataArray[2]];
            if ([tempStr isEqualToString:@"111"]){
                self.resultLabel.text = @"半顺";
                return;
            }
        }
    }else{
        //时时彩特殊情况处理
        if ([tempStr isEqualToString:@"019"] || [tempStr isEqualToString:@"089"]) {
            self.resultLabel.text = @"顺子";
            return;
        }else if (![tempStr isEqualToString:@"099"] && ![tempStr isEqualToString:@"009"]){
            tempStr = [NSString stringWithFormat:@"%@%@",_dataArray[0],_dataArray[2]];
            if ([tempStr isEqualToString:@"09"]){
                self.resultLabel.text = @"半顺";
                return;
            }
        }
    }
    
//*******************************号码循环处理（不需要循环的话请将此块代码注释掉）*******************************

    [self jiSuan];
    NSString *jieGuo = @"";
    if([_resultArray[0] integerValue]== 1){
        jieGuo = @"对子";
       }else if([_resultArray[0] integerValue]== 2){
         jieGuo = @"豹子";
         }else if([_resultArray[1] integerValue]== 1){
          jieGuo = @"半顺";
         }else if([_resultArray[1] integerValue]== 2){
            jieGuo = @"顺子";
         }else{
           jieGuo = @"杂六";
         }
    
    self.resultLabel.text = jieGuo;

}
- (void)jiSuan{
     //计算豹子、对子
    NSInteger one = [_dataArray[2] integerValue] - [_dataArray[1] integerValue]== 0 ? 1 : 0;
    NSInteger two = [_dataArray[1] integerValue]- [_dataArray[0] integerValue]== 0 ? ++one : one;
    [_resultArray addObject:@(two)];
    
    //计算顺子、半顺、杂六
    NSInteger three = [_dataArray[2] integerValue] - [_dataArray[1] integerValue] == 1 ? 1 : 0;
    NSInteger four = [_dataArray[1] integerValue]- [_dataArray[0] integerValue] == 1 ? ++three :  three;
    [_resultArray addObject:@(four)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
