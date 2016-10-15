package com.sharie.mdb.mdbsocials;


import android.content.DialogInterface;
import android.content.Intent;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.provider.MediaStore;
import android.support.annotation.NonNull;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.view.ContextThemeWrapper;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;
import com.google.firebase.storage.UploadTask;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;

public class NewSocial extends AppCompatActivity {

    private final int SELECT_PHOTO = 1;
    private Bitmap selectedImage;

    private DatabaseReference database;
    private FirebaseAuth mAuth;
    EditText name, description, dates;
    FirebaseStorage storage = FirebaseStorage.getInstance();
    StorageReference storageRef = storage.getReferenceFromUrl("gs://mdb-socials-5cc85.appspot.com");
    StorageReference imageRef;
    private ImageButton photo;
    String key;
    private ArrayList<Idea> ideas = new ArrayList<Idea>();

    protected void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new_social);

        mAuth = FirebaseAuth.getInstance();
        database = FirebaseDatabase.getInstance().getReference();

        photo = (ImageButton) findViewById(R.id.photo);
        name = (EditText) findViewById(R.id.name);
        description = (EditText) findViewById(R.id.description);
        dates = (EditText) findViewById(R.id.dates);
        Button create = (Button) findViewById(R.id.create_event);

        photo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent photoPickerIntent = new Intent(Intent.ACTION_PICK);
                photoPickerIntent.setType("image/*");
                startActivityForResult(photoPickerIntent, SELECT_PHOTO);
            }
        });

        create.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                FirebaseUser user = mAuth.getCurrentUser();
                if(user != null) {
                    if(dates.getText().toString().equals("")){
                        Toast.makeText(getApplicationContext(), "Please enter at least one date",
                                Toast.LENGTH_SHORT).show();
                    }
                    else {
                        key = database.child("ideas").push().getKey();
                        Idea idea = new Idea(name.getText().toString(), user.getUid(), user.getEmail(), description.getText().toString(), key, dates.getText().toString(), 0);
                        database.child("ideas").child(key).setValue(idea);

                        ByteArrayOutputStream baos = new ByteArrayOutputStream();
                        selectedImage.compress(Bitmap.CompressFormat.JPEG,100,baos);
                        byte[] data = baos.toByteArray();

                        imageRef = storageRef.child(key+".jpg");
                        UploadTask uploadTask = imageRef.putBytes(data);

                        ideas.add(idea);
                        Intent intent = new Intent(getApplicationContext(), FeedActivity.class);
                        startActivity(intent);
                    }
                }
            }
        });
    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent imageReturnedIntent) {
        super.onActivityResult(requestCode, resultCode, imageReturnedIntent);

        switch(requestCode) {
            case SELECT_PHOTO:
                if(resultCode == RESULT_OK){
                    try {

                        final Uri imageUri = imageReturnedIntent.getData();
                        final InputStream imageStream = getContentResolver().openInputStream(imageUri);
                        selectedImage = BitmapFactory.decodeStream(imageStream);
                        photo.setImageBitmap(selectedImage);


                    } catch (FileNotFoundException e) {
                        e.printStackTrace();
                    }

                }
        }
    }
    public ArrayList<Idea> getIdeas(){ return ideas;}



}
