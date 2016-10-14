package com.demo.mdb.mdbsocials;

import android.content.Intent;
import android.provider.ContactsContract;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.ValueEventListener;

import org.w3c.dom.Text;

import java.util.ArrayList;
import java.util.HashMap;

public class DetailActivity extends AppCompatActivity {
    ImageView eventImageView;
    TextView eventTitleTextView;
    TextView eventUserTextView;
    TextView eventDescriptionTextView;
    Button eventInterestedButton;
    CheckBox interestedCheckBox;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        eventImageView = (ImageView) findViewById(R.id.eventImageView);
        eventTitleTextView = (TextView) findViewById(R.id.eventTitleTextView);
        eventUserTextView = (TextView) findViewById(R.id.eventUserTextView);
        eventDescriptionTextView = (TextView) findViewById(R.id.eventDescriptionTextView);
        eventInterestedButton = (Button) findViewById(R.id.eventInterestedButton);
        interestedCheckBox = (CheckBox) findViewById(R.id.interestedCheckBox);

        Intent intent = getIntent();
        String title = intent.getStringExtra("title");
        String user = intent.getStringExtra("user");
        String description = intent.getStringExtra("description");
        ArrayList<String> interestedPeople = intent.getStringArrayListExtra("interestedPeople");

        eventTitleTextView.setText(title);
        eventUserTextView.setText("Created by " + user);
        eventDescriptionTextView.setText("Description: " + description);
        if (interestedPeople != null) {
            eventInterestedButton.setText(interestedPeople.size() + " People Interested");
        }
        //set imageviews and textviews based on firebase data related to event

        /*ValueEventListener eventListener = new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot eventSnapshot: dataSnapshot.getChildren()) {
                    HashMap<String,Object> map = (HashMap<String,Object>) eventSnapshot.getValue();
                    String email = (String) map.get("user");
                    String name = (String) map.get("name");
                    if(title.equals(name)){

                    }
                    ArrayList<String> interestedPeople = (ArrayList<String>) map.get("interestedPeople");
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {}
        };*/

        eventInterestedButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(DetailActivity.this, InterestedActivity.class);
                //intent.putStringArrayListExtra("users",);
                startActivity(intent);
            }
        });
    }
}