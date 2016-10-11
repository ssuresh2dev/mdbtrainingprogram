package mdb.project3.mdbevents;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.util.ArrayList;
import java.util.HashMap;

public class FeedActivity extends AppCompatActivity {

    EventAdapter eventAdapter;
    DatabaseReference rootNode;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_feed);

        // Create a variable for the recycler view and set its layout manager to be linear
        RecyclerView recyclerView = (RecyclerView)findViewById(R.id.recycler_view);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));

        // Create a list of test events and bind the event adapter to this list
        ArrayList<Event> eventTestList = new ArrayList<>();

        rootNode = FirebaseDatabase.getInstance().getReference();

//        Event testEvent1 = new Event("Kedar Thakkar", "kedarthakkar@berkeley.edu", "10", "fakeurl1.com", new HashMap());
//        Event testEvent2 = new Event("Sayan", "sayansdope@berkeley.edu", "20", "probablyporn.com", new HashMap());
//        Event testEvent3 = new Event("Eman", "emanfyb@berkeley.edu", "30", "sleepsalot.com", new HashMap());
//
//        eventTestList.add(testEvent1);
//        eventTestList.add(testEvent2);
//        eventTestList.add(testEvent3);
//        eventTestList.add(testEvent1);
//        eventTestList.add(testEvent2);
//        eventTestList.add(testEvent3);
//        eventTestList.add(testEvent1);
//        eventTestList.add(testEvent2);
//        eventTestList.add(testEvent3);
//        eventTestList.add(testEvent1);
//        eventTestList.add(testEvent2);
//        eventTestList.add(testEvent3);

        eventAdapter = new EventAdapter(getApplicationContext(), eventTestList);

        // Set the adapter of the recycler view to the event adapter
        recyclerView.setAdapter(eventAdapter);
    }

}
