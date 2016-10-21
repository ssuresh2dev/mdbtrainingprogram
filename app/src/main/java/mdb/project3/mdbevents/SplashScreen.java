package mdb.project3.mdbevents;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

/**
 * Created by emaanhariri on 10/14/16.
 */

public class SplashScreen extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        FirebaseUser mUser = FirebaseAuth.getInstance().getCurrentUser();
        if (mUser == null)
            startActivity(new Intent(SplashScreen.this, MainActivity.class));
        else
            startActivity(new Intent(SplashScreen.this, FeedActivity.class));
        finish();
    }
}
