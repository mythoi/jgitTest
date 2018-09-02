--lua extends java declare。
--使用前需在classes.lua文件声明。
--支持继承java中可以继承的类，支持继承jar、aar包中的类(线程相关的类暂不支持)
--支持重写类中的方法
--支持父类的protected方法类型转为public类型，以便lua访问
--classes.lua文件详解：
classes={--类表(在该表中定义自己想定义的类)     
  --创建MyView类
  MyView={--定义类名。在lua中可直接使用该类创建对象
    super="android.view.View";--定义父类(不使用继承可为留空)
    method={--方法表(里面定义的方法均在lua中回调，符号说明：@表示重写的方法会调用父类对应的方法super.xxx，没有则不会调用。 #表示将一个protected方法转为public方法，因为lua中只能访问到public的方法，如果你要在lua中调用protected的方法，必须转为public类型。转为public后，访问时需在该方法前添加下划线_
      MyView="android.content.Context";--构造方法，值为参数
      draw="void,android.graphics.Canvas"; --重写draw方法，第一个为返回值，其他为参数。重写方法里若需super.xxx，则要在返回值前加@
      onMeasure="void,int,int";--重写onMeasure
      setMeasuredDimension="#void,int,int";--将protected转为public类型，方便lua访问，lua访问方式，需在方法前加_，如_setMeasuredDimension。第一个是方法的返回值，其他为参数，需在返回值加#
      test="int,float,int"--自定义方法，返回值为int,参数为float和int类型
    }; 
  
    MyHandler={ --定义内部类
      super="android.os.Handler";
      method={ 
        -- MyHandler="";--值为空时是无参构造方法
        handleMessage="@void,android.os.Message"; 
      } 
    };
  };

--添加更多的类声明...
};