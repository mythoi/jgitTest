package com.androlua;
import android.content.Context;
import android.content.Intent;
import java.io.File;
import java.io.FileOutputStream;
public class Util
{
  public static void showError(Context context, Class target,String errMsg)
  {
    Intent intent=new Intent(context,target);
    intent.putExtra("errMsg",errMsg);
    context.startActivity(intent); 
  }

public static void write(String data, String toFile)
	{
		new File(toFile).getParentFile().mkdirs();
		try
		{
			FileOutputStream out=new FileOutputStream(toFile);
			byte[] b=data.getBytes();
			out.write(b, 0, b.length);
			out.close();
		}
		catch (Exception e)
		{
			//Log.d("fileutil", "文件写入失败");
		}

	}

}