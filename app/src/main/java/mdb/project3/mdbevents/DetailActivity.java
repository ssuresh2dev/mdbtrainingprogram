package mdb.project3.mdbevents;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class DetailActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

//        FirebaseDatabase database = FirebaseDatabase.getInstance();
//        DatabaseReference myRef =database.getReference("message");
//
//        myRef.setValue("Hello, World!");
    }
}
