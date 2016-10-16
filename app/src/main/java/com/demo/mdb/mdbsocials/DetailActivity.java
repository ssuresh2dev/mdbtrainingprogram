package com.demo.mdb.mdbsocials;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.provider.ContactsContract;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.graphics.Palette;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.ValueEventListener;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;

import org.w3c.dom.Text;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

public class DetailActivity extends AppCompatActivity {
    ImageView eventImageView;
    TextView eventTitleTextView;
    TextView eventUserTextView;
    TextView eventDescriptionTextView;
    Button eventInterestedButton;
    CheckBox interestedCheckBox;
    FirebaseAuth mAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        eventImageView = (ImageView) findViewById(R.id.eventImageView);
        eventTitleTextView = (TextView) findViewById(R.id.eventTitleTextView);
        eventUserTextView = (TextView) findViewById(R.id.eventUserTextView);
        eventDescriptionTextView = (TextView) findViewById(R.id.eventDescriptionTextView);
        eventInterestedButton = (Button) findViewById(R.id.eventInterestedButton);
        interestedCheckBox = (CheckBox) findViewById(R.id.interestedCheckBox);

        Intent intent = getIntent();
        String title = intent.getStringExtra("title");
        final String user = intent.getStringExtra("user");
        String description = intent.getStringExtra("description");
        final ArrayList<String> interestedPeople = intent.getStringArrayListExtra("interestedPeople");

        eventTitleTextView.setText(title);
        eventUserTextView.setText("Created by " + user);
        eventDescriptionTextView.setText("Description: " + description);

        if (interestedPeople != null) {
            eventInterestedButton.setText(interestedPeople.size() + " People Interested");
        }

        StorageReference ref = FirebaseStorage.getInstance().getReferenceFromUrl("gs://mdb-socials-6fb87.appspot.com");
        StorageReference eventRef = ref.child(title);
        eventRef.getDownloadUrl().addOnSuccessListener(new OnSuccessListener<Uri>() {
            @Override
            public void onSuccess(final Uri uri) {
                AsyncTask<Void, Void, Bitmap> asyncTask = new AsyncTask<Void, Void, Bitmap>() {
                    @Override
                    protected Bitmap doInBackground(Void... params) {
                        return getBitmapFromURL(uri.toString());
                    }

                    public Bitmap getBitmapFromURL(String src) {
                        try {
                            URL url = new URL(src);
                            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                            connection.setDoInput(true);
                            connection.connect();
                            InputStream input = connection.getInputStream();
                            Bitmap myBitmap = BitmapFactory.decodeStream(input);
                            return myBitmap;
                        } catch (IOException e) {
                            // Log exception
                            return null;
                        }
                    }

                    @Override
                    protected void onPostExecute(Bitmap result) {
                        eventImageView.setImageBitmap(result);
                        final LinearLayout linlay = (LinearLayout)findViewById(R.id.activity_detail);
                        Palette.from(result).generate(new Palette.PaletteAsyncListener() {
                            public void onGenerated(Palette p) {
                                Palette.Swatch vibSwatch = p.getVibrantSwatch();
                                if (vibSwatch != null) {
                                    linlay.setBackgroundColor(vibSwatch.getRgb());
                                }
                            }
                        });
                    }
                }.execute();
            }
        });

        eventInterestedButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(interestedCheckBox.isChecked()) {
                    Intent intent = new Intent(DetailActivity.this, InterestedActivity.class);
                    //intent.putStringArrayListExtra("users", );
                    startActivity(intent);
                }
            }
        });
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
                Intent intent = new Intent(DetailActivity.this, MainActivity.class);
                startActivity(intent);
                return true;

            default:
                return super.onOptionsItemSelected(item);

        }
    }
}