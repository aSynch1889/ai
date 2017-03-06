//
//  ISVCustomSegView.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/6.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "ISVCustomSegView.h"

#define kNormalColor   [UIColor lightGrayColor]
// Button进行封装
@interface ISVCustomSegButton:UIButton

@property (nonatomic, weak) UIView *lineView;

@end

@implementation ISVCustomSegButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat lineWidth = 3;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - lineWidth, frame.size.width, lineWidth)];
        // 设置初始状态
        lineView.backgroundColor = kNormalColor;
        //        lineView.hidden = YES;
        _lineView = lineView;
        [self setTitleColor:kNormalColor forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:lineView];
        
    }
    return self;
}
@end


@interface ISVCustomSegView()

@property (nonatomic, weak) id<ISVCustomSegViewDelegate> delegate;
@property (nonatomic, strong) ISVCustomSegButton *lastClickButton;
@end
@implementation ISVCustomSegView

/**
 *  init方法
 *
 *  @param titles   title数组 :@[@"选项1",@"选项2"]
 *  @param frame    整个naviView frame
 *  @param delegate 设置代理
 *
 *  @return ISVCustomSegView实例
 */
- (instancetype)initWithNumberOfTitles:(NSArray *)titles andFrame:(CGRect)frame delegate:(id<ISVCustomSegViewDelegate>)delegate{
    if (self = [super initWithFrame:frame]) {
        // 设置代理
        self.delegate = delegate;
        CGFloat buttonWidth = kSCREEN_WIDTH / titles.count;
        
        for (int i = 0; i < titles.count; i ++) {
            ISVCustomSegButton *button = [[ISVCustomSegButton alloc] initWithFrame:CGRectMake(i *buttonWidth, 0, buttonWidth, frame.size.height)];
            // 默认选中第一个 设置状态
            if (i == 0) {
                [button setTitleColor:ISVMainColor forState:UIControlStateNormal];
                button.lineView.backgroundColor = ISVMainColor;
                // 保留为上次选择中的button
                _lastClickButton = button;
            }
            // 设置对应的tag
            button.tag = i;
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(A_choosed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    
    
    
    return self;
    
}

- (void)A_choosed:(ISVCustomSegButton *)button{
    // 连续点击同一个不响应回调
    if (_lastClickButton != button) {
        // 设置状态
        [button setTitleColor:ISVMainColor forState:UIControlStateNormal];
        button.lineView.backgroundColor = ISVMainColor;
        [_lastClickButton setTitleColor:kNormalColor forState:UIControlStateNormal];
        _lastClickButton.lineView.backgroundColor = kNormalColor;
        _lastClickButton = button;
        // 回调 可用block
        if ([self.delegate respondsToSelector:@selector(D_selectedTag:)]) {
            [self.delegate D_selectedTag:button.tag];
        }
    }
}


@end





