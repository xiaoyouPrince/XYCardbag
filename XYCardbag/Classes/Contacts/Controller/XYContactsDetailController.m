//
//  XYContactsDetailController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/18.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYContactsDetailController.h"

@interface XYContactsDetailController ()

@end

@implementation XYContactsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.conName;
    self.clearsSelectionOnViewWillAppear = NO;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellIDtemp";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@" ----- %zd ---- ",indexPath.row];
    
    return cell;
}



// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Create the next view controller.
    UITableViewController *detailViewController = [[UITableViewController alloc] init];
    
    detailViewController.editing = YES;
    
    
    // Push the view controller.
//    [self.navigationController pushViewController:detailViewController animated:YES];
    [self presentViewController:detailViewController animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
