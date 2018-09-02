require "import"
import "mixtureJava"
import "android.graphics.Paint"
import "android.graphics.Path"
import "android.graphics.Canvas"
import "android.graphics.Bitmap"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.Typeface"
import "layout"
import"init.ProjectListViewInit"
import "android.graphics.LightingColorFilter"
--activity.setTheme(R.style.AppTheme)
activity.getWindow().setStatusBarColor(0xff3F51B5); 
activity.setTitle('Androlj')
activity.setContentView(loadlayout(layout))
btn.onClick=function(v)
 print(v.text) 
  end

function initProjectListView()
  ProjectListViewInit(projectListView,Environment.getExternalStorageDirectory().toString().."/MythoiProj/Project",
  function(path)
    print(path)
  end)
end


function initMenu()
  drawerBar.setTitleTextColor(0xffffffff)
  drawerBar.setSubtitleTextColor(0x55ffffff)
  mainBar.title="Androlj"
  mainBar.setTitleTextColor(0xffffffff)
  mainBar.setSubtitleTextColor(0x55ffffff) 

  drawerMenu=drawerBar.Menu
  activity.getMenuInflater().inflate(R.menu.menu_drawer, drawerMenu);
  drawerBar.onMenuItemClick=function(i)
    print(i)
  end

  mainMenu=mainBar.Menu
  activity.getMenuInflater().inflate(R.menu.menu_main, mainMenu);
  mainBar.onMenuItemClick=function(i)
    print(i)
  end

  mainBar.getChildAt(1).getOverflowIcon().setColorFilter(LightingColorFilter(0xffffffff,0xffffffff))
  drawerBar.getChildAt(2).getOverflowIcon().setColorFilter(LightingColorFilter(0xffffffff,0xffffffff))
end
initProjectListView()
initMenu()
