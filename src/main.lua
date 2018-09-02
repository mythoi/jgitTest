require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "layout"
import "com.mythoi.example.R"
import "mixtureJava"
import "android.graphics.Paint"
import "android.graphics.Color"
import "java.io.File"
import "java.util.Calendar"
activity.setTheme(android.R.style.Theme_Material_Light)
--lua继承java，例子：
--各方法回调在classes.lua中声明
myViewTable={--表可以像类一样使用  (myViewTable.this表示当前类实例，可使用它调用该类里的方法,myViewTable.class是它的类类型)
  --定义变量  
  width;
  height;
  mPaintLine;
  mPaintCircle;
  mPaintHour;
  mPaintMinute;
  mPaintSec;
  mPaintText;
  mCalendar;
  NEED_INVALIDATE = 1;
  mHandler;

  MyView=function(context)--构造方法
    print(myViewTable.this)
    --在构造方法里初始化各变量
    myViewTable.mCalendar = Calendar.getInstance();
    
    myViewTable.mPaintLine = Paint();
    myViewTable.mPaintLine.setColor(Color.BLUE);
    myViewTable.mPaintLine.setStrokeWidth(10);

    myViewTable.mPaintCircle = Paint();
    myViewTable.mPaintCircle.setColor(Color.GREEN);--设置颜色
    myViewTable.mPaintCircle.setStrokeWidth(10);--设置线宽
    myViewTable.mPaintCircle.setAntiAlias(true);--设置是否抗锯齿
    myViewTable.mPaintCircle.setStyle(Paint.Style.STROKE);--设置绘制风格

    myViewTable.mPaintText = Paint();
    myViewTable.mPaintText.setColor(Color.BLUE);
    myViewTable.mPaintText.setStrokeWidth(10);
    myViewTable.mPaintText.setTextAlign(Paint.Align.CENTER);
    myViewTable.mPaintText.setTextSize(40);

    myViewTable.mPaintHour = Paint();
    myViewTable.mPaintHour.setStrokeWidth(20);
    myViewTable.mPaintHour.setColor(Color.BLUE);

    myViewTable.mPaintMinute = Paint();
    myViewTable.mPaintMinute.setStrokeWidth(15);
    myViewTable.mPaintMinute.setColor(Color.BLUE);

    myViewTable.mPaintSec = Paint();
    myViewTable.mPaintSec.setStrokeWidth(10);
    myViewTable.mPaintSec.setColor(Color.BLUE);

    myViewTable.mHandler=MyView.MyHandler(myViewTable.this)--myViewTable.this就是当前的类实例，myViewTable.class是当前的类类型
    myViewTable.mHandler.sendEmptyMessage(myViewTable.NEED_INVALIDATE);--向handler发送一个消息，让它开启重绘

  end;

  onMeasure=function(widthMeasureSpec,heightMeasureSpec)--重写onMeasure方法
    myViewTable.width = myViewTable.this.getDefaultSize(myViewTable.this.getMinimumWidth(), widthMeasureSpec);
    myViewTable.height = myViewTable.this.getDefaultSize(myViewTable.this.getMinimumHeight(), heightMeasureSpec);
    myViewTable.this._setMeasuredDimension(myViewTable.width, myViewTable.height);

  end,

  draw=function(canvas)--重写draw方法
     circleRadius = 400;
    --画出大圆
    canvas.drawCircle(int(myViewTable.width / 2),int(myViewTable.height / 2),circleRadius,myViewTable.mPaintCircle);
    --画出圆中心
    canvas.drawCircle(int(myViewTable.width / 2), int(myViewTable.height / 2), 20, myViewTable.mPaintCircle);
    --依次旋转画布，画出每个刻度和对应数字
    for i=1,12 do
      canvas.save();--保存当前画布
      canvas.rotate(360/12*i,myViewTable.width/2,myViewTable.height/2);
      --左起：起始位置x坐标，起始位置y坐标，终止位置x坐标，终止位置y坐标，画笔(一个Paint对象)
      canvas.drawLine(myViewTable.width / 2, myViewTable.height / 2 - circleRadius, myViewTable.width / 2, myViewTable.height / 2 - circleRadius + 30, myViewTable.mPaintCircle);
      --左起：文本内容，起始位置x坐标，起始位置y坐标，画笔
      canvas.drawText(""..i, myViewTable.width / 2, myViewTable.height / 2 - circleRadius + 70, myViewTable.mPaintText);
      canvas.restore();
    end

    minute = myViewTable.mCalendar.get(Calendar.MINUTE);--得到当前分钟数
    hour =myViewTable. mCalendar.get(Calendar.HOUR);--得到当前小时数
    sec = myViewTable.mCalendar.get(Calendar.SECOND);--得到当前秒数

    minuteDegree = minute/60*360;--得到分针旋转的角度
    canvas.save();
    canvas.rotate(minuteDegree, myViewTable.width / 2, myViewTable.height / 2);
    canvas.drawLine(myViewTable.width / 2, myViewTable.height / 2 - 250, myViewTable.width / 2, myViewTable.height / 2 + 40, myViewTable.mPaintMinute);
    canvas.restore();

    hourDegree = (hour*60+minute)/12/60*360;--得到时钟旋转的角度
    canvas.save();
    canvas.rotate(hourDegree, myViewTable.width / 2, myViewTable.height / 2);
    canvas.drawLine(myViewTable.width / 2, myViewTable.height / 2 - 200, myViewTable.width / 2, myViewTable.height / 2 + 30, myViewTable.mPaintHour);
    canvas.restore();

    secDegree = sec/60*360;--得到秒针旋转的角度
    canvas.save();
    canvas.rotate(secDegree,myViewTable.width/2,myViewTable.height/2);
    canvas.drawLine(myViewTable.width/2,myViewTable.height/2-300,myViewTable.width/2,myViewTable.height/2+40,myViewTable.mPaintSec);
    canvas.restore(); 
  end,

   test=function(a,b)     
       return int(a+b)  --因为返回值是int类型，需强转一下
  end,
  
  handleMessage=function()--重写内部类MyHanlder的handleMessage方法
    
    myViewTable.mCalendar = Calendar.getInstance();
    myViewTable.this.invalidate()
    myViewTable.mHandler.sendEmptyMessageDelayed(myViewTable.NEED_INVALIDATE,1000);
  end
}

mView=MyView(activity,myViewTable)--创建对象。最后一个参数是表。
activity.setContentView(mView)
print(mView.test(5,1))--调用自己定义的方法