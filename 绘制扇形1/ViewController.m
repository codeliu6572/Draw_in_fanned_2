//
//  ViewController.m
//  绘制扇形1
//
//  Created by 刘浩浩 on 16/6/29.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimer *timer;
    UIBezierPath *circlePath;
    CAShapeLayer*layer;
    int end;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    end=0;
    [self draw];
    if (!timer)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                 target:self
                                               selector:@selector(updateLayer)
                                               userInfo:nil
                                                repeats:YES];
    }
}
- (void)updateLayer
{
    //起始点为0，结束点不断增加，圆的弧线越来越长，到结束点闭合就变成了圆，我们这里按贝斯阿尔曲线路径到结束点为一扇形
    if ( end < 10)
    {
        end ++;
    }
    else
    {
        [timer invalidate];
    }
    NSLog(@"----");
    layer.strokeEnd = end/10.0;
}

- (void)draw
{
    layer = [CAShapeLayer layer];
    //这里设置填充线的宽度，这个参数很重要
    layer.lineWidth = 120;
    //拐角设置
    layer.lineCap = kCALineCapButt;
    //绘制的线的颜色
    layer.strokeColor = [[UIColor redColor] CGColor];
    layer.fillColor = nil;
    layer.strokeStart=0;
    layer.strokeEnd=end/10;
    [self.view.layer addSublayer:layer];
    //用贝塞尔曲线来画扇形，实际上画的是圆，因为半径为边线中间到原点的距离，所以设置半径为线宽的一半，这样线宽就覆盖了中间填充部分的颜色，形成扇形
    UIBezierPath *bezierPath=[UIBezierPath bezierPathWithArcCenter:CGPointMake((self.view.frame.size.width)/2, (self.view.frame.size.height)/2) radius:60 startAngle:0 endAngle:M_PI/2*3 clockwise:YES];
    
    layer.path = bezierPath.CGPath;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
