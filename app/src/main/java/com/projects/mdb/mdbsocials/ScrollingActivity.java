package com.projects.mdb.mdbsocials;

import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.CollapsingToolbarLayout;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
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
import com.google.firebase.storage.FirebaseStorage;

import java.util.ArrayList;

public class ScrollingActivity extends AppCompatActivity {
    private Socialist.Social s;

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
                if (dataSnapshot.child("interestedPeople").getValue() == null) {
                    CollapsingToolbarLayout collapsingToolbarLayout = (CollapsingToolbarLayout)findViewById(R.id.toolbar_layout);
                    collapsingToolbarLayout.setTitle(dataSnapshot.child("name").getValue(String.class));
                    FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
                    fab.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Toast.makeText(ScrollingActivity.this, "sorry no one likes you", Toast.LENGTH_SHORT).show();
                        }
                    });
                }
                else {
                    CollapsingToolbarLayout collapsingToolbarLayout = (CollapsingToolbarLayout)findViewById(R.id.toolbar_layout);
                    collapsingToolbarLayout.setTitle(dataSnapshot.child("name").getValue(String.class));
                    final ArrayList<String> jesus = dataSnapshot.child("interestedPeople").getValue(new GenericTypeIndicator<ArrayList<String>>() {});
                    FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
                    fab.setOnClickListener(new View.OnClickListener() {
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
                class DownloadFilesTask extends AsyncTask<String, Void, Bitmap> {
                    protected Bitmap doInBackground(String... strings) {
                        try {return Glide.
                                with(getApplicationContext()).
                                load(strings[0]).
                                asBitmap().
                                into(100, 100). // Width and height
                                get();}
                        catch (Exception e) {return null;}
                    }

                    protected void onProgressUpdate(Void... progress) {}

                    protected void onPostExecute(Bitmap result) {
                        Palette.PaletteAsyncListener paletteListener = new Palette.PaletteAsyncListener() {
                            public void onGenerated(Palette palette) {
                                int defaulto = 0x000000;
                                collapsingToolbarLayout.setBackgroundColor(palette.getDominantColor(defaulto));
                            }
                        };
                        if (result != null && !result.isRecycled()) {
                            Palette.from(result).generate(paletteListener);
                        }
                        ((ImageView)findViewById(R.id.imageView2)).setImageBitmap(result);
                    }
                }

                FirebaseStorage.getInstance().getReferenceFromUrl("gs://mdbsocials-700a9.appspot.com").child(id + ".png").getDownloadUrl().addOnSuccessListener(new OnSuccessListener<Uri>() {
                    @Override
                    public void onSuccess(Uri uri) {
                        Log.d("ye", uri.toString());
                        new DownloadFilesTask().execute(uri.toString());
                        //Glide.with(context).load(uri.toString()).thumbnail(0.5f).crossFade().diskCacheStrategy(DiskCacheStrategy.ALL).into(holder.imageView);
                    }
                }).addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception exception) {
                        Log.d("sad", exception.toString());
                    }
                });
                textView.setText(dataSnapshot.child("description").getValue(String.class));
            }



            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
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
                    public void onCancelled(DatabaseError databaseError) {

                    }
                });
            }
        });


    }
/*
    @Override
    public void onResume() {
        super.onResume();
        Socialist soc = new Socialist();
        s = soc.getSocialByID(s.getID());
        Log.d("yo", s.getID());
        collapsingToolbarLayout.setTitle(s.getName());
        textView.setText(s.getDescription() + '\n' + s.getDate());
    }
    */

}
