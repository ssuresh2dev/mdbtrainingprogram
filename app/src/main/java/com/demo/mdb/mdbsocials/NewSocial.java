package com.demo.mdb.mdbsocials;

import android.app.Dialog;
import android.app.DialogFragment;
import android.app.Fragment;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.Image;
import android.net.Uri;
import android.provider.MediaStore;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;
import com.google.firebase.storage.UploadTask;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class NewSocial extends AppCompatActivity {
    ImageView eventImg;
    EditText nameEditText;
    EditText desEditText;
    EditText dateEditText;
    String picURL;
    DatabaseReference ref;
    FirebaseAuth mAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new_social);

        nameEditText = (EditText)findViewById(R.id.eventName);
        eventImg = (ImageView)findViewById(R.id.eventImg);
        desEditText = (EditText)findViewById(R.id.des);
        dateEditText = (EditText)findViewById(R.id.date);

        eventImg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent pickPhoto = new Intent(Intent.ACTION_PICK);
                pickPhoto.setType("image/*");
                startActivityForResult(pickPhoto , 1);
            }
        });

        Button done = (Button)findViewById(R.id.done);
        done.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ref = FirebaseDatabase.getInstance().getReference();
                mAuth = FirebaseAuth.getInstance();

                String email = mAuth.getCurrentUser().getEmail();
                String eventName = nameEditText.getText().toString();
                String description = desEditText.getText().toString();
                String eventDate = dateEditText.getText().toString();
                ArrayList<String> interestedPeople = new ArrayList<>();

                Map<String, Object> event = new HashMap<String, Object>();
                event.put("user", email);
                event.put("name", eventName);
                event.put("pictureURL", picURL);
                event.put("description", description);
                event.put("date", eventDate);
                event.put("interestedPeople", interestedPeople);
                ref.child("Events").push().setValue(event);

                eventImg.setDrawingCacheEnabled(true);
                eventImg.buildDrawingCache();
                Bitmap image = eventImg.getDrawingCache();
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                image.compress(Bitmap.CompressFormat.JPEG, 100, baos);
                byte[] data = baos.toByteArray();
                StorageReference ref = FirebaseStorage.getInstance().getReferenceFromUrl("gs://mdb-socials-6fb87.appspot.com");
                StorageReference eventRef = ref.child(eventName);
                UploadTask uploadTask = eventRef.putBytes(data);

                Intent intent = new Intent(NewSocial.this, FeedActivity.class);
                startActivity(intent);
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent imageReturnedIntent) {
        super.onActivityResult(requestCode, resultCode, imageReturnedIntent);
        switch(requestCode) {
            case 1:
                if (resultCode == RESULT_OK) {
                    Uri selectedImage = imageReturnedIntent.getData();
                    InputStream imageStream = null;
                    try {
                        imageStream = getContentResolver().openInputStream(selectedImage);
                    } catch (FileNotFoundException e) {
                        e.printStackTrace();
                    }
                    Bitmap myImg = BitmapFactory.decodeStream(imageStream);
                    eventImg.setImageBitmap(myImg);
                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    myImg.compress(Bitmap.CompressFormat.PNG, 100, baos);
                    picURL = Base64.encodeToString(baos.toByteArray(), Base64.DEFAULT);
                }
        }
    }
}