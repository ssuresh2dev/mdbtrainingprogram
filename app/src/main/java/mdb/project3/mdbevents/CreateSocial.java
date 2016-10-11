package mdb.project3.mdbevents;

import android.app.DatePickerDialog;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageButton;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.util.Calendar;

public class CreateSocial extends AppCompatActivity implements View.OnClickListener {

    DatePickerDialog.OnDateSetListener[] dateSetListeners;
    EditText[] dates;
    EditText eventName, eventDescription;
    ImageButton eventPicture;
    Calendar myCalendar = Calendar.getInstance();
    boolean updatedPicture = false;

    DatabaseReference dbRef;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_social);

        bindViews();
        bindDateSetListeners();

        dbRef = FirebaseDatabase.getInstance().getReference();
    }

    private void bindViews() {
        dates = new EditText[]{
                (EditText) findViewById(R.id.first_date),
                (EditText) findViewById(R.id.second_date),
                (EditText) findViewById(R.id.third_date)
        };

        eventName = (EditText) findViewById(R.id.name_of_event);
        eventDescription = (EditText) findViewById(R.id.event_description);
        eventPicture = (ImageButton) findViewById(R.id.event_image);
    }

    private void bindDateSetListeners() {
        for (int i = 0; i < dateSetListeners.length; i++) {
            final int pos = i;
            dateSetListeners[i] = new DatePickerDialog.OnDateSetListener() {
                @Override
                public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
                    dates[pos].setText(new StringBuilder()
                            .append(month + 1).append("/")
                            .append(dayOfMonth).append("/")
                            .append(year));
                }
            };
        }
    }

    private void updateDatabase() {
        if (!validate())
            return;
    }

    private boolean validate() {
        boolean valid = !(TextUtils.isEmpty(eventName.getText().toString()) ||
                TextUtils.isEmpty(eventDescription.getText().toString()) ||
                TextUtils.isEmpty(dates[0].getText().toString()) ||
                TextUtils.isEmpty(dates[1].getText().toString()) ||
                TextUtils.isEmpty(dates[2].getText().toString())) || !updatedPicture;
        if (!valid) {
            Snackbar.make(findViewById(R.id.activity_register),
                    "Required fields are empty",
                    Snackbar.LENGTH_SHORT).show();
        }
        return valid;
    }

    @Override
    public void onClick(View v) {
        int id = v.getId();
        switch (id) {
            case R.id.first_date:
                new DatePickerDialog(getApplicationContext(),
                        dateSetListeners[0],
                        myCalendar.get(Calendar.YEAR),
                        myCalendar.get(Calendar.MONTH),
                        myCalendar.get(Calendar.DAY_OF_MONTH))
                        .show();
                break;
            case R.id.second_date:
                new DatePickerDialog(getApplicationContext(),
                        dateSetListeners[1],
                        myCalendar.get(Calendar.YEAR),
                        myCalendar.get(Calendar.MONTH),
                        myCalendar.get(Calendar.DAY_OF_MONTH))
                        .show();
                break;
            case R.id.third_date:
                new DatePickerDialog(getApplicationContext(),
                        dateSetListeners[2],
                        myCalendar.get(Calendar.YEAR),
                        myCalendar.get(Calendar.MONTH),
                        myCalendar.get(Calendar.DAY_OF_MONTH))
                        .show();
                break;
            case R.id.create_event_button:
                updateDatabase();
                break;
        }
    }
}
