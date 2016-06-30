# Draw_in_fanned_2
绘制扇形

![image](https://github.com/codeliu6572/Draw_in_fanned_2/blob/master/绘制扇形1/1.gif)

原理：1.CAShapeLayer的strokeStart和strokeEnd两个属性，前面博客在画圆时有用到这俩属性，strokeStart是起始位置，为三点钟方向，
strokeEnd为结束绘制点，为一绘制的百分比，把贝塞尔曲线的路径给它； 
      2.利用定时器动态的改变绘制的百分比。

1.CAShapeLayer的strokeStart和strokeEnd两个属性，前面博客在画圆时有用到这俩属性，strokeStart是起始位置，为三点钟方向
，strokeEnd为结束绘制点，为一绘制的百分比，把贝塞尔曲线的路径给它

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
        

2.利用定时器动态的改变绘制的百分比

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
