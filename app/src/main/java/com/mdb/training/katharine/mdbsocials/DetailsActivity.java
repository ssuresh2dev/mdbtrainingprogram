package com.mdb.training.katharine.mdbsocials;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.TextView;

public class DetailsActivity extends AppCompatActivity {

    private TextView eventName, date, author, description, numInterested;
    private CheckBox interested;

    private Toolbar toolbar;
    FloatingActionButton fab;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_details);
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        eventName = (TextView) findViewById(R.id.eventName);
        eventName.setText(getIntent().getExtras().getString("title"));

        date = (TextView) findViewById(R.id.textView);
        date.setText(getIntent().getExtras().getString("date"));

        author = (TextView) findViewById(R.id.textView2);
        author.setText(getIntent().getExtras().getString("author"));

        description = (TextView) findViewById(R.id.textView3);
        description.setText(getIntent().getExtras().getString("description"));

        numInterested = (TextView) findViewById(R.id.textView4);
        numInterested.setText("Interested: " + getIntent().getExtras().getInt("interested"));

        interested = (CheckBox) findViewById(R.id.interested);
        interested.setChecked(false);

        interested.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked){

                    //TODO: how would we set interested we dont have access to social arraylist, probelm with code structure
                }


            }
        });










    }
}
