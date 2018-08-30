package com.androlua;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class ShowErrorActivity extends Activity {
    @Override
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        String errMsg = getIntent().getStringExtra("errMsg");
        TextView textView = new TextView(this);
        textView.setText(errMsg);
        setContentView(textView);
    }
  
 	@Override
	protected void onDestroy()
	{
   	super.onDestroy();
     System.exit(0);
	}

}