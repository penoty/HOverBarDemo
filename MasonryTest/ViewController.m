//
//  ViewController.m
//  MasonryTest
//
//  Created by yupao on 9/23/16.
//  Copyright © 2016 penoty. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#define PULL_MAX_OFFSET 50.f
#define TOP_VIEW_HEIGHT 100.f
#define HOVER_VIEW_HEIGHT 50.f

@interface ViewController ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *hoverView;
@property (nonatomic, strong) UIScrollView *bottomView;
@property (nonatomic, assign) BOOL topViewHidden;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _topView = [[UIView alloc] init];
    [_topView setBackgroundColor:[UIColor redColor]];
    
    _hoverView = [[UIView alloc] init];
    [_hoverView setBackgroundColor:[UIColor blueColor]];
    
    _bottomView = [[UIScrollView alloc] init];
    [_bottomView setBackgroundColor:[UIColor grayColor]];
    [_bottomView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [_bottomView setDelegate:(id<UIScrollViewDelegate> _Nullable)self];
    
    [self.view addSubview:_topView];
    [self.view addSubview:_hoverView];
    [self.view addSubview:_bottomView];
    [self layoutSubViews];
    
}

- (void)layoutSubViews {
    
    [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.and.right.equalTo(self.view);
        make.height.mas_equalTo(TOP_VIEW_HEIGHT).priorityMedium();
        
    }];
    
    [_hoverView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(_topView.mas_bottom);
        make.height.mas_equalTo(HOVER_VIEW_HEIGHT);
        
    }];
    
    [_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(_hoverView.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
        
    }];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset > 0) {
        
        if (!_topViewHidden) {
            
            _topViewHidden = YES;
            [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.left.top.and.right.equalTo(self.view);
                make.height.mas_equalTo(0).priorityHigh();
                
            }];

        }
        
    } else if (yOffset < (-PULL_MAX_OFFSET)) {
        
        if (_topViewHidden) {
            
            _topViewHidden = NO;
            [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.left.top.and.right.equalTo(self.view);
                make.height.mas_equalTo(TOP_VIEW_HEIGHT).priorityHigh();
                
            }];
            
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
