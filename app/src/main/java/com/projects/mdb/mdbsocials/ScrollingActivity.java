package com.projects.mdb.mdbsocials;

import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.CollapsingToolbarLayout;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.graphics.Palette;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.GenericTypeIndicator;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;

/**
 * Displays details of the Social given a social id
 */
public class ScrollingActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_scrolling);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        final CollapsingToolbarLayout collapsingToolbarLayout = (CollapsingToolbarLayout)findViewById(R.id.toolbar_layout);
        final TextView textView = (TextView)findViewById(R.id.maintext);
        final String id = getIntent().getStringExtra("id");
        DatabaseReference ref = FirebaseDatabase.getInstance().getReference("/socials/" + id);
        ref.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                collapsingToolbarLayout.setTitle(dataSnapshot.child("name").getValue(String.class));
                if (dataSnapshot.child("interestedPeople").getValue() == null) {
                    findViewById(R.id.fab).setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Toast.makeText(ScrollingActivity.this, "sorry no one is interested", Toast.LENGTH_SHORT).show();
                        }
                    });
                }
                else {
                    final ArrayList<String> jesus = dataSnapshot.child("interestedPeople").getValue(new GenericTypeIndicator<ArrayList<String>>() {});
                    findViewById(R.id.fab).setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(getApplicationContext(), InterestedActivity.class);
                            String[] arr = new String[jesus.size()];
                            for (int i = 0; i < jesus.size(); ++i) {
                                arr[i] = jesus.get(i);
                            }
                            intent.putExtra("interestedPeople", arr);
                            startActivity(intent);
                        }
                    });
                }
                Utils.setBitmap(getApplicationContext(), collapsingToolbarLayout, R.id.imageView2, id);
                textView.setText(dataSnapshot.child("description").getValue(String.class));
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {}
        });
        FloatingActionButton fab2 = (FloatingActionButton) findViewById(R.id.fab2);
        fab2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                final String email = FirebaseAuth.getInstance().getCurrentUser().getEmail();
                final DatabaseReference ref = FirebaseDatabase.getInstance().getReference("/socials/" + getIntent().getStringExtra("id"));
                ref.addListenerForSingleValueEvent(new ValueEventListener() {
                    @Override
                    public void onDataChange(DataSnapshot dataSnapshot) {
                        ref.child("interestedPeople").child("" + dataSnapshot.child("interested").getValue(Integer.class)).setValue(email);
                        ref.child("interested").setValue((int)(dataSnapshot.child("interested").getValue(Integer.class) + 1));
                    }

                    @Override
                    public void onCancelled(DatabaseError databaseError) {}
                });
            }
        });
    }
/*
    @Override
    public void onResume() {
        super.onResume();
        Utils soc = new Utils();
        s = soc.getSocialByID(s.getID());
        Log.d("yo", s.getID());
        collapsingToolbarLayout.setTitle(s.getName());
        textView.setText(s.getDescription() + '\n' + s.getDate());
    }
    */

}
