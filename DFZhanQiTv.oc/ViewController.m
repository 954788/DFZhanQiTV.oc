//
//  ViewController.m
//  DFZhanQiTv.oc
//
//  Created by 梁粱展焯 on 16/4/20.
//  Copyright © 2016年 粱展焯. All rights reserved.
//

#import "ViewController.h"
#import "TvCollectionViewCell.h"
#import "TvViewController.h"

#define RUI_WEN @"http://dlhls.cdn.zhanqi.tv/zqlive/24589_O0xLv.m3u8"
#define BIAO_GE @"http://dlhls.cdn.zhanqi.tv/zqlive/2766_OUCz5.m3u8"
#define KU_XIAO @"http://dlhls.cdn.zhanqi.tv/zqlive/101441_dDhu0.m3u8"
#define SHANG_DAN @"http://dlhls.cdn.zhanqi.tv/zqlive/76451_y0Orl.m3u8"
#define HUANG_SHI @"http://dlhls.cdn.zhanqi.tv/zqlive/92885_jXzXq.m3u8"
#define SHENG_QIANG @"http://dlhls.cdn.zhanqi.tv/zqlive/112513_uEsII.m3u8"

static NSString *cellID = @"cellID";

@interface ViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"战旗Tv.oc";
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
   
    [self.collectionView registerNib:[UINib nibWithNibName:@"TvCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollection data source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TvCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    
    if (indexPath.item == 0) {
        cell.label.text = @"表哥";
        cell.urlString = BIAO_GE;
    }else if (indexPath.item == 1){
        cell.label.text = @"苦笑";
        cell.urlString = KU_XIAO;
    }else if (indexPath.item == 2){
        cell.label.text = @"瑞文";
        cell.urlString = RUI_WEN;
    }else if (indexPath.item == 3){
        cell.label.text = @"上单";
        cell.urlString = SHANG_DAN;
    }else if (indexPath.item == 4){
        cell.label.text = @"皇室战争";
        cell.urlString = HUANG_SHI;
    }else if (indexPath.item == 5){
        cell.label.text = @"圣枪哥";
        cell.urlString = SHENG_QIANG;
    }
    
    return cell;
    
}

#pragma mark - UICollection delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(181, 99);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TvCollectionViewCell *cell = (TvCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    TvViewController *tvViewController = [[TvViewController alloc]initWithNibName:@"TvViewController" bundle:nil];
    
    tvViewController.urlString = cell.urlString;
    
    [self.navigationController pushViewController:tvViewController animated:YES];
}

@end
