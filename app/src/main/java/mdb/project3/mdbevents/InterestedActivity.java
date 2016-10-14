package mdb.project3.mdbevents;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.Collections;

public class InterestedActivity extends AppCompatActivity {

    InterestedAdapter interestedAdapter;
    DatabaseReference dbRef;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_interested);

        RecyclerView recyclerView = (RecyclerView) (findViewById(R.id.interested_recycler_view));
        recyclerView.setLayoutManager(new LinearLayoutManager(this));

        final ArrayList<String> interested = new ArrayList<String>();

        String eventId = getIntent().getStringExtra("DBKEY");

        dbRef = FirebaseDatabase.getInstance().getReference();
        dbRef = dbRef.child("Events").child(eventId);
        interestedAdapter = new InterestedAdapter(getApplicationContext(), interested);

        dbRef.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                Log.e("Count " ,""+snapshot.getChildrenCount());
                Event event = snapshot.getValue(Event.class);
                interested.add(event.peopleInterested);

                interestedAdapter.interestedList = interested;
                interestedAdapter.notifyDataSetChanged();
            }
            @Override
            public void onCancelled(DatabaseError firebaseError) {
                Log.e("The read failed: " ,firebaseError.getMessage());
            }
        });


        recyclerView.setAdapter(interestedAdapter);
    }
}
