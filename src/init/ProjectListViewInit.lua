require "import"
import "android.widget.ArrayAdapter"
import "android.widget.LinearLayout"
import "android.widget.TextView"
import "java.io.File"
import "android.widget.ListView"
import "android.app.AlertDialog"

item={
  LinearLayout;
  layout_width="fill";
  layout_height="wrap";
  padding="10dp";
  orientation="horizontal";
  {
    ImageView;
    layout_width="40dp";
    id="img";
    src="icon.png";
    layout_height="40dp";
    layout_gravity="center";
  };
  {
    LinearLayout;
    layout_width="fill";
    layout_height="wrap";
    layout_marginLeft="10dp";
    orientation="vertical";
    {
      TextView;
      id="title";
      textColor="#777777";
      typeface=Typeface.defaultFromStyle(Typeface.BOLD);
    };
    {
      TextView;
      id="subtitle";
      text="包名 com.mythoi.androlj 权限 3";
      textColor="#888888";
    };
  };
};

function ProjectListViewInit(lv,StartPath,callback)
  --  lv.setFastScrollEnabled(true)
  adp=LuaAdapter(activity,item)
  lv.setAdapter(adp)
  function SetItem(path)
    path=tostring(path)
    adp.clear()--清空适配器
    drawerBar.subtitle=tostring(path)--设置当前路径
    if path~=StartPath then--不是根目录则加上../
      adp.add({title="../"}) 
    end
    ls=File(path).listFiles()
    if ls~=nil then
      ls=luajava.astable(File(path).listFiles()) --全局文件列表变量
      table.sort(ls,function(a,b)
        return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
      end)
    else
      ls={}
    end
    for index,c in ipairs(ls) do
      if c.isDirectory() then--如果是文件夹则
        adp.add({title=c.Name.."/"})
      else
        adp.add({title=c.Name})
      end
    end
  end

  lv.onItemClick=function(l,v,p,s)--列表点击事件
    项目=tostring(v.Tag.title.text)
    if tostring(drawerBar.subtitle)==StartPath then
      路径=ls[p+1]
    else
      路径=ls[p]
    end

    if 项目=="../" then
      SetItem(File(drawerBar.subtitle).getParentFile())
    elseif 路径.isDirectory() then
      SetItem(路径)
    elseif 路径.isFile() then
      callback(tostring(路径))
      --  ChoiceFile_dialog.hide()
    end

  end

  SetItem(StartPath)
end
