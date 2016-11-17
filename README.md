# PrettyRuler
一个漂亮的横向刻度尺自定义控件，用CAShapeLayer实现高效GPU渲染，没有用一张图片！
控件两边添加渐变透明效果，看起来更加自然。使用方法具体看demo，简单易懂，几句代码搞定，但是该自定义控件只支持代码方式创建。

#说明
iOS7 +，刻度选择支持选择0值，为最小模式，不能选择0值时候，为正常模式，具体请看最下面效果图。

#支持pod安装
pod 'PrettyRuler', '~> 2.1.1'

#用法
1. 拖拽class文件夹到你的项目
2. 在你的控制器里导入 `TXHRrettyRuler.h` 类
3. 类似以下这段代码
	TXHRrettyRuler *ruler = [[TXHRrettyRuler alloc] initWithFrame:CGRectMake(20, 220, [UIScreen mainScreen].bounds.size.width - 20 * 2, 140)];
	ruler.rulerDeletate = self;
	[ruler showRulerScrollViewWithCount:200 average:1 currentValue:36.5f smallMode:YES];
	[self.view addSubview:ruler];
	
#效果图
1.最小模式也就是当smallMode = yes。

<video id="video" controls="" preload="none" poster="http://media.w3.org/2010/05/sintel/poster.png">
      <source id="mov" src="https://yqall01.baidupcs.com/file/2fae77562f75716b0cabc9a3404ed8e7?bkt=p3-14002fae77562f75716b0cabc9a3404ed8e7c45035610000003ae36f&fid=1595368039-250528-935755121425755&time=1479365781&sign=FDTAXGERBH-DCb740ccc5511e5e8fedcff06b081203-w4JmdwU3zqbxQMXn6stqXqcNi0M%3D&to=yqvb&fm=Yan,B,T,t&sta_dx=3859311&sta_cs=&sta_ft=mov&sta_ct=0&sta_mt=0&fm2=Yangquan,B,T,t&newver=1&newfm=1&secfm=1&flow_ver=3&pkey=14002fae77562f75716b0cabc9a3404ed8e7c45035610000003ae36f&expires=8h&rt=sh&r=214876316&mlogid=7459333203970943262&vuk=1595368039&vbdid=2599916148&fin=%E5%88%BB%E5%BA%A6%E5%B0%BA%E6%98%BE%E7%A4%BA.mov&fn=%E5%88%BB%E5%BA%A6%E5%B0%BA%E6%98%BE%E7%A4%BA.mov&uta=0&rtype=0&iv=2&isw=0&dp-logid=7459333203970943262&dp-callid=0.1.1&hps=1&csl=0&csign=uBTcIgmQqeA3Cwqw1p20m0vnnwY%3D" type="video/mov">
      <p>Your user agent does not support the HTML5 Video element.</p>
    </video>

2.正常模式也就是smellmode = no。

![Smaller icon](http://img.hoop8.com/attachments/1512/7703071188604.gif "正常模式")
