package com.demo.mdb.membermatch;

import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.CountDownTimer;
import android.provider.ContactsContract;
import android.app.DialogFragment;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Arrays;
import java.util.Random;

import static android.provider.AlarmClock.EXTRA_MESSAGE;

public class GameActivity extends AppCompatActivity {

    String[] members = {"Richard Chen", "Jessica Cherny", "Mansi Shah", "Alice Wang", "Jessica Ji", "Kevin Jiang", "Jared Gutierrez", "Kristin Ho", "Christine Munar", "Mudit Mittal", "Ali Shelton", "Richard Hu", "Shaan Appel", "Ankur Mahesh", "Edward Liu", "Wilbur Shi", "Young Lin", "Abhinav Koppu", "Abhishek Mangla", "Akkshay Khoslaa", "Ally Koo", "Andy Wang", "Aneesh Jindal", "Anisha Salunkhe", "Aparna Krishnan", "Ashwin Vaidyanathan", "Cody Hsieh", "Connor Killion", "Jeffrey Zhang", "Justin Kim", "Kenneth Steele", "Krishnan Rajiyah", "Lisa Lee", "Peter Schafhalter", "Riley Edmunds", "Rohan Narayan", "Sameer Suresh", "Sona Jeswani", "Sirjan Kafle", "Tarun Khasnavis", "Virindh Borra", "Billy Lu", "Aayush Tyagi", "Ben Goldberg", "Candice Ye", "Eliot Han", "Emaan Hariri", "Jessica Chen", "Katharine Jiang", "Kedar Thakkar", "Leon Kwak", "Mohit Katyal", "Rochelle Shen", "Sayan Paul", "Sharie Wang", "Shreya Reddy", "Shubham Goenka", "Victor Sun", "Vidya Ravikumar"};
    Random random = new Random();
    int randInt;
    int currScore = 0;
    public String currentName;
    Button firstName;
    Button secondName;
    Button thirdName;
    Button fourthName;
    TextView countdown_text;
    ImageView mainImage;
    static CountDownTimer cdTimer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game);

        //picture
        Arrays.sort(members);
        mainImage = (ImageView)(findViewById(R.id.mainImage));
        setImageView(mainImage);

        //buttons
        firstName = (Button)findViewById(R.id.firstName);
        secondName = (Button)findViewById(R.id.secondName);
        thirdName = (Button)findViewById(R.id.thirdName);
        fourthName = (Button)findViewById(R.id.fourthName);
        setButtons(firstName, secondName, thirdName, fourthName);

        final TextView score = (TextView)(findViewById(R.id.score));   //score
        score.setText("Score: "+currScore);
        // below is code for actions when buttons pressed
        firstName.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(firstName.getText()==currentName){
                    scorePlus(score);
                    cdTimer.cancel();
                    countDown(5000);
                }
                else{
                    Toast.makeText(getApplicationContext(), "Wrong!", Toast.LENGTH_SHORT).show();
                    cdTimer.cancel();
                    countDown(5000);
                }
                setImageView(mainImage);
                setButtons(firstName, secondName, thirdName, fourthName);
            }
        });
        secondName.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(secondName.getText()==currentName){
                    scorePlus(score);
                    cdTimer.cancel();
                    countDown(5000);
                }
                else{
                    Toast.makeText(getApplicationContext(), "Wrong!", Toast.LENGTH_SHORT).show();
                    cdTimer.cancel();
                    countDown(5000);
                }
                setImageView(mainImage);
                setButtons(firstName, secondName, thirdName, fourthName);
            }
        });
        thirdName.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(thirdName.getText()==currentName){
                    scorePlus(score);
                    cdTimer.cancel();
                    countDown(5000);
                }
                else{
                    Toast.makeText(getApplicationContext(), "Wrong!", Toast.LENGTH_SHORT).show();
                    cdTimer.cancel();
                    countDown(5000);
                }
                setImageView(mainImage);
                setButtons(firstName, secondName, thirdName, fourthName);
            }
        });
        fourthName.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(fourthName.getText()==currentName){
                    scorePlus(score);
                    cdTimer.cancel();
                    countDown(5000);
                }
                else{
                    Toast.makeText(getApplicationContext(), "Wrong!", Toast.LENGTH_SHORT).show();
                    cdTimer.cancel();
                    countDown(5000);
                }
                setImageView(mainImage);
                setButtons(firstName, secondName, thirdName, fourthName);
            }
        });

        countdown_text = (TextView) (findViewById(R.id.countdown_text));
        countDown(5000);
    }

    public void setImageView(ImageView imageView){
        randInt = random.nextInt(members.length);

        currentName = members[randInt];
        currentName = currentName.substring(0, currentName.indexOf(" ")) + currentName.substring(currentName.indexOf(" ")+1);
        currentName = currentName.toLowerCase();

        int resourceId = getResources().getIdentifier(currentName, "drawable", getPackageName());
        imageView.setImageResource(resourceId);

        currentName = members[randInt];
    }

    public void setButtons(Button a, Button b, Button c, Button d){
        int btnNum = random.nextInt(4);
        int randIndex = random.nextInt(members.length);
        int randIndexTwo = random.nextInt(members.length);
        int randIndexThree = random.nextInt(members.length);
        while(randInt==randIndex||randInt==randIndexTwo||randInt==randIndexThree
                ||randIndex==randIndexTwo||randIndex==randIndexThree||randIndexTwo==randIndexThree){
            randIndex = random.nextInt(members.length);
            randIndexTwo = random.nextInt(members.length);
            randIndexThree = random.nextInt(members.length);
        }
        if(btnNum==0) {
            a.setText(currentName);
            b.setText(members[randIndex]);
            c.setText(members[randIndexTwo]);
            d.setText(members[randIndexThree]);
        } else if(btnNum==1){
            b.setText(currentName);
            a.setText(members[randIndex]);
            c.setText(members[randIndexTwo]);
            d.setText(members[randIndexThree]);
        } else if(btnNum==2){
            c.setText(currentName);
            a.setText(members[randIndex]);
            b.setText(members[randIndexTwo]);
            d.setText(members[randIndexThree]);
        } else {
            d.setText(currentName);
            a.setText(members[randIndex]);
            b.setText(members[randIndexTwo]);
            c.setText(members[randIndexThree]);
        }
    }

    public void scorePlus(TextView text){
        currScore++;
        text.setText("Score: "+currScore);
    }

    public void makeContact(View view){
        // Creates a new Intent to insert a contact
        Intent intent = new Intent(ContactsContract.Intents.Insert.ACTION);
        // Sets the MIME type to match the Contacts Provider
        intent.setType(ContactsContract.RawContacts.CONTENT_TYPE);
        intent.putExtra(ContactsContract.Intents.Insert.NAME, members[randInt]);
        startActivity(intent);
    }

    public void countDown(int ms){
        cdTimer = new CountDownTimer(ms, 1000) {
            public void onTick(long millisUntilFinished) {
                countdown_text.setText("" + millisUntilFinished / 1000);
            }
            public void onFinish() {
                countdown_text.setText("0");
                Toast.makeText(getApplicationContext(), "Wrong!", Toast.LENGTH_SHORT).show();
                setImageView(mainImage);
                setButtons(firstName, secondName, thirdName, fourthName);
                countDown(5000);
            }
        }.start();
    }

    public void endGame(View view){
        EndGameFragment endGameFragment = new EndGameFragment();
        endGameFragment.show(getFragmentManager(), "endgame");
    }

    public static CountDownTimer getTimer(){
        return cdTimer;
    }

}

class EndGameFragment extends DialogFragment {
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        // Use the Builder class for convenient dialog construction
        // Pause the countdown timer
        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        builder.setMessage(R.string.end_game_text)
                .setPositiveButton(R.string.quit, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        // Start an intent that takes you back to StartScreen
                        GameActivity.getTimer().cancel();
                        Intent intent = new Intent(getActivity(), StartScreen.class);
                        startActivity(intent);
                    }
                })
                .setNegativeButton(R.string.cancel, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                    }
                });

        // Create the AlertDialog object and return it
        return builder.create();
    }
}