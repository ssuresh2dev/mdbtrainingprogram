package com.projects.mdb.mdbsocials;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;

/**
 * List of email addresses of those who are interested in the Social
 */
public class InterestedActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_interested);
        RecyclerView recyclerAdapter = (RecyclerView)findViewById(R.id.recyclegirl);
        recyclerAdapter.setLayoutManager(new LinearLayoutManager(this));
        String[] people = getIntent().getStringArrayExtra("interestedPeople");
        if (people.length > 0) {
            recyclerAdapter.setAdapter(new InterestedAdapter(getApplicationContext(), people));
        }
    }
}
