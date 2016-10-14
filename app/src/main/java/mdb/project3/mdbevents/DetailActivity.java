package mdb.project3.mdbevents;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.google.firebase.storage.FirebaseStorage;

import android.util.Log;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


public class DetailActivity extends AppCompatActivity {

    TextView socialTitleView;
    TextView dateTextView;
    ImageView eventImageView;
    TextView descriptionTextView;
    Button interestedButton;
    ToggleButton interestedToggleButton;

    DatabaseReference dbRef;
    FirebaseStorage mStorage;
    FirebaseAuth mAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        String dbKey = getIntent().getExtras().getString("DBKEY");

        dbRef = FirebaseDatabase.getInstance().getReference();
        mStorage = FirebaseStorage.getInstance();
        mAuth = FirebaseAuth.getInstance();

        dbRef = dbRef.child("Events").child(dbKey);
        dbRef.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                Event event = snapshot.getValue(Event.class);
                socialTitleView.setText(event.getName());
                dateTextView
            }

            @Override
            public void onCancelled(DatabaseError firebaseError) {

            }
        });

    }

    public void bindViews()
    {
        socialTitleView = (TextView) findViewById(R.id.socialTitleView);
        dateTextView = (TextView) findViewById(R.id.dateTextView);
        eventImageView = (ImageView) findViewById(R.id.eventImageView);
        descriptionTextView = (TextView) findViewById(R.id.descriptionTextView);
        interestedButton = (Button) findViewById(R.id.InterestedButton);
        interestedToggleButton = (ToggleButton) findViewById(R.id.interestedToggleButton);
    }


}