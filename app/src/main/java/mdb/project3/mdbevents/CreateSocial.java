package mdb.project3.mdbevents;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Typeface;
import android.net.Uri;
import android.provider.MediaStore;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.AppCompatButton;
import android.text.TextUtils;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.TextView;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.io.IOException;
import java.util.Calendar;

public class CreateSocial extends AppCompatActivity implements View.OnClickListener {

    private final int PICK_IMAGE_REQUEST = 1;

    private DatePickerDialog.OnDateSetListener[] dateSetListeners = new DatePickerDialog.OnDateSetListener[3];
    private EditText dates[], socialName, socialDescription;
    private TextView createSocialTitle;
    private ImageButton socialPictureView;
    private Calendar myCalendar = Calendar.getInstance();
    private boolean updatedPicture = false;
    private AppCompatButton createSocialButton;
    private Bitmap socialImage;

    private DatabaseReference dbRef;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_social);

        bindDateSetListeners();
        bindViews();

        dbRef = FirebaseDatabase.getInstance().getReference();
    }

    private void bindViews() {
        dates = new EditText[]{
                (EditText) findViewById(R.id.first_date),
                (EditText) findViewById(R.id.second_date),
                (EditText) findViewById(R.id.third_date)
        };

        createSocialTitle = (TextView) findViewById(R.id.new_social_title);
        socialName = (EditText) findViewById(R.id.name_of_social);
        socialDescription = (EditText) findViewById(R.id.social_description);
        socialPictureView = (ImageButton) findViewById(R.id.social_image);
        createSocialButton = (AppCompatButton) findViewById(R.id.create_social_button);

        Typeface customFont = Typeface.createFromAsset(getAssets(), "fonts/cornerstone.ttf");
        createSocialTitle.setTypeface(customFont);

        for (EditText e : dates)
            e.setOnClickListener(this);
        socialPictureView.setOnClickListener(this);
        createSocialButton.setOnClickListener(this);
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
        boolean emptyFields = TextUtils.isEmpty(socialName.getText().toString()) ||
                TextUtils.isEmpty(socialDescription.getText().toString()) ||
                (TextUtils.isEmpty(dates[0].getText().toString()) &&
                        TextUtils.isEmpty(dates[1].getText().toString()) &&
                        TextUtils.isEmpty(dates[2].getText().toString()));
        boolean valid = !emptyFields && updatedPicture;
        if (!valid) {
            Snackbar.make(findViewById(R.id.activity_create_social),
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
                new DatePickerDialog(CreateSocial.this,
                        dateSetListeners[0],
                        myCalendar.get(Calendar.YEAR),
                        myCalendar.get(Calendar.MONTH),
                        myCalendar.get(Calendar.DAY_OF_MONTH))
                        .show();
                break;
            case R.id.second_date:
                new DatePickerDialog(CreateSocial.this,
                        dateSetListeners[1],
                        myCalendar.get(Calendar.YEAR),
                        myCalendar.get(Calendar.MONTH),
                        myCalendar.get(Calendar.DAY_OF_MONTH))
                        .show();
                break;
            case R.id.third_date:
                new DatePickerDialog(CreateSocial.this,
                        dateSetListeners[2],
                        myCalendar.get(Calendar.YEAR),
                        myCalendar.get(Calendar.MONTH),
                        myCalendar.get(Calendar.DAY_OF_MONTH))
                        .show();
                break;
            case R.id.social_image:
                Intent intent = new Intent();
                intent.setType("image/*");
                intent.setAction(Intent.ACTION_GET_CONTENT);
                startActivityForResult(Intent.createChooser(intent, "Select Image"), PICK_IMAGE_REQUEST);
                break;
            case R.id.create_social_button:
                updateDatabase();
                break;
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == PICK_IMAGE_REQUEST &&
                resultCode == RESULT_OK &&
                data != null &&
                data.getData() != null) {
            Uri uri = data.getData();
            try {
                socialImage = MediaStore.Images.Media.getBitmap(getContentResolver(), uri);
                if (socialImage.getWidth() > socialPictureView.getWidth()) {
                    int newHeight = (socialImage.getHeight() * socialPictureView.getWidth()) / socialImage.getWidth();
                    socialPictureView.setImageBitmap(
                            Bitmap.createScaledBitmap(socialImage, socialPictureView.getWidth(), newHeight, false));
                } else {
                    socialPictureView.setImageBitmap(socialImage);
                }

                updatedPicture = true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
