package com.projects.mdb.mdbsocials;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;

public class InterestedActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_interested);
        RecyclerView recyclegirl = (RecyclerView)findViewById(R.id.recyclegirl);
        recyclegirl.setLayoutManager(new LinearLayoutManager(this));
        String[] people = getIntent().getStringArrayExtra("interestedPeople");
        if (people.length > 0) {
            recyclegirl.setAdapter(new InterestedAdapter(getApplicationContext(), people));
        }
    }
}
