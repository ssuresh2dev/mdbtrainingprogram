package com.demo.mdb.mdbsocials;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;
import com.google.firebase.storage.UploadTask;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class NewSocial extends AppCompatActivity implements View.OnClickListener{
    ImageView eventImg;
    EditText nameEditText;
    EditText desEditText;
    EditText dateEditText;
    String pushId;
    DatabaseReference ref;
    FirebaseAuth mAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new_social);

        eventImg = (ImageView)findViewById(R.id.eventImg);
        nameEditText = (EditText)findViewById(R.id.eventName);
        desEditText = (EditText)findViewById(R.id.des);
        dateEditText = (EditText)findViewById(R.id.date);

        //for picking photo from camera roll
        eventImg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent pickPhoto = new Intent(Intent.ACTION_PICK);
                pickPhoto.setType("image/*");
                startActivityForResult(pickPhoto , 1);
            }
        });

        Button done = (Button)findViewById(R.id.done);
        done.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch(v.getId()) {
            case R.id.done:
                ref = FirebaseDatabase.getInstance().getReference();
                mAuth = FirebaseAuth.getInstance();

                String email = mAuth.getCurrentUser().getEmail();
                String eventName = nameEditText.getText().toString();
                String description = desEditText.getText().toString();
                String eventDate = dateEditText.getText().toString();
                ArrayList<String> interestedPeople = new ArrayList<>();
                interestedPeople.add(0, "no one");

                //pushing event data to firebase
                Map<String, Object> event = new HashMap<String, Object>();
                event.put("user", email);
                event.put("name", eventName);
                event.put("description", description);
                event.put("date", eventDate);
                event.put("interestedPeople", interestedPeople);
                DatabaseReference pushedRef = ref.child("Events").push();
                pushId = pushedRef.getKey();
                event.put("pushId", pushId);
                ref.child("Events").child(pushId).setValue(event);

                //storing image to firebase
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
                break;
            default:
                break;
        }
    }

    //for retrieving picked image from camera roll
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
                }
        }
    }
}