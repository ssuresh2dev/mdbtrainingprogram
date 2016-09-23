package com.project1.mdb.matchthemembers;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class StartScreen extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_start_screen);
    }

    public void startGame(View v) {
        Intent myIntent = new Intent(getApplicationContext(), GameActivity.class);
        startActivity(myIntent);
    }
}
