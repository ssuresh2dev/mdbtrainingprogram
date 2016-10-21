package com.demo.mdb.mdbsocials;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;

import com.google.firebase.auth.FirebaseAuth;

import java.util.ArrayList;

public class InterestedActivity extends AppCompatActivity {
    ArrayList<String> userArrayList;
    RecyclerView recyclerView;
    InterestedViewAdapter interestedViewAdapter;
    FirebaseAuth mAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_interested);

        Intent intent = getIntent();
        userArrayList = intent.getStringArrayListExtra("users");

        recyclerView = (RecyclerView) findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        interestedViewAdapter = new InterestedViewAdapter(getApplicationContext(), userArrayList);
        recyclerView.setAdapter(interestedViewAdapter);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.logout, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        mAuth = FirebaseAuth.getInstance();

        switch (item.getItemId()) {
            case R.id.action_logout:
                mAuth.getInstance().signOut();
                Intent intent = new Intent(InterestedActivity.this, MainActivity.class);
                startActivity(intent);
                return true;

            default:
                return super.onOptionsItemSelected(item);

        }
    }
}
