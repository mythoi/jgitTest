import java.lang.System;
import android.widget.Button;
import android.widget.Toast;
import android.app.Activity;
import java.lang.Exception;
import java.lang.Thread;
import java.lang.String;
public class Main{
  public static void main(Activity activity){
    Toast.makeText(activity,"Hello World",1).show();
    new Thread(){
      public void run(){
        for(int i=0;i<1000;i++)
        { 
          System.out.println("Hello World"+i);
          try{
            Thread.sleep(100);
          }catch(Exception e){}
        }
      }
    }.start();
  }
}
