package com.demo.mdb.membermatch;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;

public class StartScreen extends AppCompatActivity
{

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_start_screen);
    }

    public void startGame(View view){
        Intent intent = new Intent(this, GameActivity.class);
        startActivity(intent);
    }
}
