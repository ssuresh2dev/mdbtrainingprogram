package mdb.project3.mdbevents;

import android.graphics.Typeface;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

import org.w3c.dom.Text;

public class MainActivity extends AppCompatActivity {

    private TextView titleView, emailView, passwordView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        bindViews();
    }

    private void bindViews() {
        titleView = (TextView) findViewById(R.id.title_view);
        Typeface customFont = Typeface.createFromAsset(getAssets(), "fonts/cornerstone.ttf");
        titleView.setTypeface(customFont);
        emailView = (TextView) findViewById(R.id.email_input);
        passwordView = (TextView) findViewById(R.id.password_input);
        passwordView.setTypeface(Typeface.DEFAULT);
    }
}
