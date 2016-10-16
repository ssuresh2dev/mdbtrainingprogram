package com.projects.mdb.mdbsocials;

import android.content.Intent;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Toast;

public class ListActivity extends AppCompatActivity {

    private Socialist s;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list);
        RecyclerView recycleman = (RecyclerView)findViewById(R.id.recycleman);
        recycleman.setLayoutManager(new LinearLayoutManager(this));
        s = new Socialist();
        SocialsAdapter adapter = new SocialsAdapter(getApplicationContext(), s.getSocialist());
        recycleman.setAdapter(adapter);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getApplicationContext(), NewSocialActivity.class);

                startActivity(intent);
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public void signout(MenuItem item) {
        Intent intent = new Intent(getApplicationContext(), LoginActivity.class);
        LoginActivity.getmAuth().signOut();
        startActivity(intent);
    }
}
