package mdb.project3.mdbevents;

import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.bumptech.glide.Glide;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.MutableData;
import com.google.firebase.database.Transaction;
import com.google.firebase.database.ValueEventListener;
import com.google.firebase.storage.FirebaseStorage;

import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;


public class DetailActivity extends AppCompatActivity implements View.OnClickListener {

    TextView socialTitleView;
    TextView dateTextView;
    ImageView eventImageView;
    TextView descriptionTextView;
    Button interestedButton;
    ToggleButton interestedToggleButton;

    DatabaseReference dbRef;
    FirebaseStorage mStorage;
    FirebaseAuth mAuth;
    FirebaseUser mUser;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        bindViews();

        String dbKey = getIntent().getExtras().getString("DBKEY");

        Toast.makeText(getApplicationContext(), "Loading event info...", Toast.LENGTH_SHORT).show();

        dbRef = FirebaseDatabase.getInstance().getReference();
        mStorage = FirebaseStorage.getInstance();
        mAuth = FirebaseAuth.getInstance();
        mUser = mAuth.getCurrentUser();

        dbRef = dbRef.child("Events").child(dbKey);
        dbRef.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                Event event = snapshot.getValue(Event.class);
                socialTitleView.setText(event.getName());
                dateTextView.setText(event.date);
                Glide.with(getApplicationContext()).load(event.imageUrl).into(eventImageView);
                descriptionTextView.setText(event.description);
                interestedButton.setText(String.format(Locale.getDefault(), "%d people interested", event.numInterested));
            }

            @Override
            public void onCancelled(DatabaseError firebaseError) {

            }
        });

    }

    public void bindViews() {
        socialTitleView = (TextView) findViewById(R.id.socialTitleView);
        dateTextView = (TextView) findViewById(R.id.dateTextView);
        eventImageView = (ImageView) findViewById(R.id.eventImageView);
        descriptionTextView = (TextView) findViewById(R.id.descriptionTextView);
        interestedButton = (Button) findViewById(R.id.InterestedButton);
        interestedToggleButton = (ToggleButton) findViewById(R.id.interestedToggleButton);

        interestedButton.setOnClickListener(this);
        interestedToggleButton.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        int id = v.getId();
        switch (id) {
            case R.id.interestedToggleButton:
                dbRef.runTransaction(new Transaction.Handler() {
                    @Override
                    public Transaction.Result doTransaction(MutableData mutableData) {
                        Event e = mutableData.getValue(Event.class);
                        if (e == null)
                            return Transaction.success(mutableData);
                        if (e.peopleInterested.contains(mUser.getEmail())) {
                            e.numInterested -= 1;
                            e.peopleInterested.remove(mUser.getEmail());
                        } else {
                            e.numInterested += 1;
                            e.peopleInterested.add(mUser.getEmail());
                        }
                        mutableData.setValue(e);
                        return Transaction.success(mutableData);
                    }

                    @Override
                    public void onComplete(DatabaseError databaseError, boolean b, DataSnapshot dataSnapshot) {

                    }
                });
                break;
            case R.id.InterestedButton:
                startActivity(new Intent());
                break;
        }
    }
}