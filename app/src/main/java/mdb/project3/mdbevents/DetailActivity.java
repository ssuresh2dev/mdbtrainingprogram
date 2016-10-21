package mdb.project3.mdbevents;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.graphics.Palette;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.google.firebase.storage.FirebaseStorage;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Locale;


public class DetailActivity extends AppCompatActivity implements View.OnClickListener {
    public static final String INTENT_KEY = "DBKEY";

    ScrollView detailScrollView;
    FirebaseUser mUser;
    String dbKey;

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
        bindViews();

        dbKey = getIntent().getExtras().getString("DBKEY");

        Toast.makeText(getApplicationContext(), "Loading event info...", Toast.LENGTH_SHORT).show();

        dbRef = FirebaseDatabase.getInstance().getReference();
        mStorage = FirebaseStorage.getInstance();
        mAuth = FirebaseAuth.getInstance();
        mUser = mAuth.getCurrentUser();

        dbRef = dbRef.child("Events").child(dbKey);
        dbRef.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                updateViewsWithEvent(snapshot.getValue(Event.class));
            }

            @Override
            public void onCancelled(DatabaseError firebaseError) {

            }
        });

    }


    @Override
    public void onClick(View v) {
        int id = v.getId();
        switch (id) {
            case R.id.interestedToggleButton:
                FirebaseUtils.updateInterested(dbRef, mUser);
                break;
            case R.id.interestedButton:
                Intent myIntent = new Intent(DetailActivity.this, InterestedActivity.class);
                myIntent.putExtra(INTENT_KEY, dbKey);
                startActivity(myIntent);
                break;
        }
    }

    private void bindViews() {
        socialTitleView = (TextView) findViewById(R.id.socialTitleView);
        dateTextView = (TextView) findViewById(R.id.dateTextView);
        eventImageView = (ImageView) findViewById(R.id.eventImageView);
        descriptionTextView = (TextView) findViewById(R.id.descriptionTextView);
        interestedButton = (Button) findViewById(R.id.interestedButton);
        interestedToggleButton = (ToggleButton) findViewById(R.id.interestedToggleButton);
        detailScrollView = (ScrollView) findViewById(R.id.detail_scrollview);

        interestedButton.setOnClickListener(this);
        interestedToggleButton.setOnClickListener(this);
    }

    private void updateViewsWithEvent(Event event) {
        socialTitleView.setText(event.getName());
        dateTextView.setText(event.date);
        DownloadBitmapTask getBitmap = new DownloadBitmapTask();
        getBitmap.execute(event.imageUrl);
        descriptionTextView.setText(event.description);
        interestedButton.setText(String.format(Locale.getDefault(), "%d people interested", event.numInterested));
    }

    private class DownloadBitmapTask extends AsyncTask<String, Void, Bitmap> {

        @Override
        protected Bitmap doInBackground(String... params) {
            try {
                URL url = new URL(params[0]);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setDoInput(true);
                connection.connect();
                InputStream input = connection.getInputStream();
                return BitmapFactory.decodeStream(input);
            } catch (IOException e) {
                e.printStackTrace();
                return null;
            }
        }

        @Override
        protected void onPostExecute(Bitmap bitmap) {
            if (bitmap != null) {
                eventImageView.setImageBitmap(bitmap);
                Palette.from(bitmap).generate(new Palette.PaletteAsyncListener() {
                    @Override
                    public void onGenerated(Palette palette) {
                        interestedButton.setBackgroundColor(palette.getLightVibrantColor(0xFF3396DC));
                        interestedToggleButton.setBackgroundColor(palette.getLightMutedColor(0xFF3396DC));
                    }
                });
            }
            super.onPostExecute(bitmap);
        }
    }
}