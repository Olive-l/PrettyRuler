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

<embed wmode="Opaque" menu="false" allowscriptaccess="always" src="/box-static/disk-share/widget/pageModule/share-video/_nomd5/player/DiskPlayer.swf" flashvars="fsid=935755121425755&amp;filename=&amp;file=https%3A%2F%2Fpan.baidu.com%2Fshare%2Fstreaming%3Fchannel%3Dchunlei%26uk%3D1595368039%26type%3DM3U8_FLV_264_480%26path%3D%252F%25E5%2588%25BB%25E5%25BA%25A6%25E5%25B0%25BA%25E6%2598%25BE%25E7%25A4%25BA.mov%26sign%3D211cef1e6cd712dd6f4e0161450c6517aca7e735%26timestamp%3D1479365397%26shareid%3D2746767774&amp;srturl=%2Fapi%2Fresource%2Fsubtitle%3Fhash_str%3D2fae77562f75716b0cabc9a3404ed8e7%26format%3D2%26hash_method%3D1%26wd%3D%25E5%2588%25BB%25E5%25BA%25A6%25E5%25B0%25BA%25E6%2598%25BE%25E7%25A4%25BA.mov%26search_local%3D1%26video_path%3D%252F%25E5%2588%25BB%25E5%25BA%25A6%25E5%25B0%25BA%25E6%2598%25BE%25E7%25A4%25BA.mov&amp;logurl=https%3A%2F%2Fupdate.pan.baidu.com%2Fstatistics%3Fclienttype%3D0%26op%3Dwebvideo%26from%3Dsharevideo&amp;md5=2fae77562f75716b0cabc9a3404ed8e7&amp;onReady=windowPlayerFunc.onReady&amp;onLoad=windowPlayerFunc.onLoad&amp;onError=windowPlayerFunc.onPlayerErrorFunc&amp;onOver=windowPlayerFunc.onPlayerOverFunc&amp;onBeforeSeek=windowPlayerFunc.onPlayerBeforeSeekFunc&amp;onBeforePlay=windowPlayerFunc.onPlayerBeforePlayFunc&amp;onPlay=windowPlayerFunc.onPlayerPlayFunc&amp;onPause=windowPlayerFunc.onPlayerPauseFunc&amp;onSeek=windowPlayerFunc.onPlayerSeekFunc&amp;autoStart=false&amp;onTime=windowPlayerFunc.onTimeFunc" allowfullscreeninteractive="true" allowfullscreen="true" quality="high" type="application/x-shockwave-flash" width="100%" height="100%" id="flashplayer" class="visiblevideo">

2.正常模式也就是smellmode = no。

![Smaller icon](http://img.hoop8.com/attachments/1512/7703071188604.gif "正常模式")
