package com.demo.mdb.mdbsocials;

import android.app.Dialog;
import android.app.DialogFragment;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.Image;
import android.net.Uri;
import android.provider.MediaStore;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
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

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class NewSocial extends AppCompatActivity {
    ImageView eventImg;
    EditText nameEditText;
    EditText desEditText;
    EditText dateEditText;
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
                DialogFragment newFragment = new PhotoDialogFragment();
                newFragment.show(getFragmentManager(), "dia");
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
                String pictureURL = "";
                String description = desEditText.getText().toString();
                String eventDate = dateEditText.getText().toString();
                ArrayList<String> interestedPeople = new ArrayList<>();

                Map<String, Object> event = new HashMap<String, Object>();
                event.put("user", email);
                event.put("name", eventName);
                event.put("pictureURL", pictureURL);
                event.put("description", description);
                event.put("date", eventDate);
                event.put("interestedPeople", interestedPeople);
                ref.child("Events").push().setValue(event);
                Intent intent = new Intent(NewSocial.this, FeedActivity.class);
                startActivity(intent);
            }
        });
    }

    public static class PhotoDialogFragment extends DialogFragment {
        @Override
        public Dialog onCreateDialog(Bundle savedInstanceState) {
            AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
            builder.setTitle(R.string.dialogTitle)
                    .setItems(R.array.choices, new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int which) {
                            if(which==0){
                                Intent takePicture = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                                startActivityForResult(takePicture, 0);//zero can be replaced with any action code
                            }
                            else{
                                Intent pickPhoto = new Intent(Intent.ACTION_PICK,
                                        android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                                startActivityForResult(pickPhoto , 1);//one can be replaced with any action code
                            }
                        }
                    })
                    .setNegativeButton(R.string.cancel, new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int id) {
                            PhotoDialogFragment.this.getDialog().cancel();
                        }
                    });
            return builder.create();
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent imageReturnedIntent) {
        super.onActivityResult(requestCode, resultCode, imageReturnedIntent);
        switch(requestCode) {
            case 0:
                if(resultCode == RESULT_OK){
                    Uri selectedImage = imageReturnedIntent.getData();
                    InputStream is = null;
                    try {
                        is = getApplicationContext().getContentResolver().openInputStream(imageReturnedIntent.getData());
                    }
                    catch (Exception e) {
                        Log.d("File", "Not Found");
                    }
                    if (is != null) {
                        Bitmap imageResource = BitmapFactory.decodeStream(is);
                        eventImg.setImageBitmap(imageResource);
                    } else {
                        Log.d("BITMAP", "is null");
                    }
                }
                break;
            case 1:
                if(resultCode == RESULT_OK){
                    Uri selectedImage = imageReturnedIntent.getData();
                    InputStream is = null;
                    try {
                        is = getApplicationContext().getContentResolver().openInputStream(imageReturnedIntent.getData());
                    }
                    catch (Exception e) {
                        Log.d("File", "Not Found");
                    }
                    if (is != null) {
                        Bitmap imageResource = BitmapFactory.decodeStream(is);
                        eventImg.setImageBitmap(imageResource);
                    } else {
                        Log.d("BITMAP", "is null");
                    }
                }
                break;
        }
    }
}