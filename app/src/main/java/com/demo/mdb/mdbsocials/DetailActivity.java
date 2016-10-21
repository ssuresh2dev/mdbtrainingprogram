package com.demo.mdb.mdbsocials;

import android.content.Intent;
import android.graphics.Bitmap;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.graphics.Palette;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.HashMap;

public class DetailActivity extends AppCompatActivity implements View.OnClickListener{
    ImageView eventImageView;
    TextView eventTitleTextView;
    TextView eventUserTextView;
    TextView eventDescriptionTextView;
    Button eventInterestedButton;
    CheckBox interestedCheckBox;
    FirebaseAuth mAuth;
    ArrayList<String> userArrayList;

    //eventlisteners for each checkbox state; checked stores interested person in firebase interested person arraylist;
    //unchecked removes person from firebase arraylist
    final String interestedPerson = mAuth.getInstance().getCurrentUser().getEmail();
    final DatabaseReference dbref = FirebaseDatabase.getInstance().getReference();
    String id;
    ValueEventListener checkedListener = new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            ArrayList<String> interestedPeople = (ArrayList<String>)dataSnapshot.getValue();
            if(!interestedPeople.contains(interestedPerson)){
                if(interestedPeople.contains("no one")){
                    interestedPeople.remove("no one");
                }
                interestedPeople.add(interestedPerson);
                dbref.child("Events").child(id).child("interestedPeople").setValue(interestedPeople);
                eventInterestedButton.setText(interestedPeople.size()+" People Interested");
            }
        }
        @Override
        public void onCancelled(DatabaseError databaseError) {}
    };

    ValueEventListener uncheckedListener = new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            ArrayList<String> interestedPeople = (ArrayList<String>)dataSnapshot.getValue();
            if(interestedPeople.contains(interestedPerson)) {
                interestedPeople.remove(interestedPerson);
                if (!interestedPeople.contains("no one") && interestedPeople.size()==0) {
                    interestedPeople.add(0, "no one");
                }
                dbref.child("Events").child(id).child("interestedPeople").setValue(interestedPeople);
                if (interestedPeople.get(0).equals("no one")) {
                    eventInterestedButton.setText("0 People Interested");
                } else {
                    eventInterestedButton.setText(interestedPeople.size() + " People Interested");
                }
            }
        }
        @Override
        public void onCancelled(DatabaseError databaseError) {}
    };

    final ValueEventListener eventListener = new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            userArrayList = new ArrayList<>();
            for (DataSnapshot eventSnapshot: dataSnapshot.getChildren()) {
                HashMap<String,Object> map = (HashMap<String,Object>) eventSnapshot.getValue();
                userArrayList = (ArrayList<String>) map.get("interestedPeople");
            }
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {}
    };

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
        id = intent.getStringExtra("pushid");
        ArrayList<String> interestedPeople = intent.getStringArrayListExtra("interestedPeople");

        eventTitleTextView.setText(title);
        eventUserTextView.setText("Created by " + user);
        eventDescriptionTextView.setText("Description: " + description);

        //Palette colors
        final LinearLayout linlay = (LinearLayout)findViewById(R.id.activity_detail);
        EventList.Event.setImage(title, eventImageView);
        Palette.from((Bitmap) intent.getExtras().getParcelable("imagebitmap")).generate(new Palette.PaletteAsyncListener() {
            public void onGenerated(Palette p) {
                Palette.Swatch vibSwatch = p.getVibrantSwatch();
                if (vibSwatch != null) {
                    linlay.setBackgroundColor(vibSwatch.getRgb());
                }
            }
        });

        EventList.Event.checkInterestedArray(user, id, interestedCheckBox);
        if (interestedPeople.get(0).equals("no one")) {
            eventInterestedButton.setText("0 People Interested");
        }
        else{
            eventInterestedButton.setText(interestedPeople.size()+" people interested");
        }

        //takes in event listeners from earlier in class
        interestedCheckBox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            public void onCheckedChanged(CompoundButton b, boolean isChecked) {
                if(isChecked){
                    dbref.child("Events").child(id).child("interestedPeople").removeEventListener(uncheckedListener);
                    dbref.child("Events").child(id).child("interestedPeople").addValueEventListener(checkedListener);
                }
                else{
                    dbref.child("Events").child(id).child("interestedPeople").removeEventListener(checkedListener);
                    dbref.child("Events").child(id).child("interestedPeople").addValueEventListener(uncheckedListener);
                }
            }
        });

        eventInterestedButton.setOnClickListener(this);
    }

    //for logout
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.logout, menu);
        return true;
    }

    @Override
    public void onClick(View v) {
        switch(v.getId()) {
            case R.id.eventInterestedButton:
                DatabaseReference ref = FirebaseDatabase.getInstance().getReference();
                ref.child("Events").addValueEventListener(eventListener);
                if (userArrayList != null) {
                    Intent intent = new Intent(DetailActivity.this, InterestedActivity.class);
                    intent.putStringArrayListExtra("users", userArrayList);
                    startActivity(intent);
                }
                break;
            default:
                break;
        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        mAuth = FirebaseAuth.getInstance();

        switch (item.getItemId()) {
            case R.id.action_logout:
                mAuth.getInstance().signOut();
                Intent intent = new Intent(DetailActivity.this, MainActivity.class);
                startActivity(intent);
                return true;

            default:
                return super.onOptionsItemSelected(item);

        }
    }
}