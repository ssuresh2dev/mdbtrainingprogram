package com.sharie.mdb.triviagame;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.provider.ContactsContract;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Arrays;

public class MainActivity extends AppCompatActivity {

    ImageButton picture;
    Button name1, name2, name3, name4;
    TextView score,timer;
    Button endgame;
    String[] names = {"Jessica Cherny", "Richard Chen", "Mansi Shah", "Alice Wang", "Jessica Ji", "Kevin Jiang", "Jared Gutierrez", "Kristin Ho", "Christine Munar", "Mudit Mittal", "Ali Shelton", "Richard Hu", "Shaan Appel", "Ankur Mahesh", "Edward Liu", "Wilbur Shi", "Young Lin", "Abhinav Koppu", "Abhishek Mangla", "Akkshay Khoslaa", "Ally Koo", "Andy Wang", "Aneesh Jindal", "Anisha Salunkhe", "Aparna Krishnan", "Ashwin Vaidyanathan", "Cody Hsieh", "Connor Killion", "Jeffrey Zhang", "Justin Kim", "Kenneth Steele", "Krishnan Rajiyah", "Lisa Lee", "Peter Schafhalter", "Riley Edmunds", "Rohan Narayan", "Sahil Lamba", "Sameer Suresh", "Sona Jeswani", "Sirjan Kafle", "Tarun Khasnavis", "Virindh Borra", "Billy Lu", "Aayush Tyagi", "Ben Goldberg", "Candice Ye", "Eliot Han", "Emaan Hariri", "Jessica Chen", "Katharine Jiang", "Kedar Thakkar", "Leon Kwak", "Mohit Katyal", "Rochelle Shen", "Sayan Paul", "Sharie Wang", "Shreya Reddy", "Shubham Goenka", "Victor Sun", "Vidya Ravikumar"};
    int random_id1, random_id2, random_id3, random_id4, correct_id;
    String[] members = new String[60];
    String correct_name,ans;
    int myScore;
    CountDownTimer timer1;
    boolean time_left = true;
    String contact_name;


    //change the randoms, change correct_id, set the new names, set the new picture


    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main_activity);

        picture = (ImageButton) findViewById(R.id.imageButton);
        name1 = (Button) findViewById(R.id.name1);
        name2 = (Button) findViewById(R.id.name2);
        name3 = (Button) findViewById(R.id.name3);
        name4 = (Button) findViewById(R.id.name4);
        score = (TextView) findViewById(R.id.score);
        timer = (TextView) findViewById(R.id.timer);
        endgame = (Button) findViewById(R.id.endButton);
        myScore = 0;

        Arrays.sort(names);
        int i = 0;
        for(String name : names) {
            int space = name.indexOf(" ");
            name = name.substring(0,space)+name.substring(space+1);
            members[i] = name;
            i+=1;
        }


        timer1 = new CountDownTimer(10000, 1000) {

            public void onTick(long millisUntilFinished) {
                time_left = true;
                timer.setText("Seconds remaining: " + millisUntilFinished / 1000);
            }

            public void onFinish() {
                time_left = false;
                generate();
            }
        };
        generate();


        name1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v){
                if(name1.getText().equals(correct_name) && time_left){
                    myScore += 1;
                    score.setText("Score: " + myScore);
                }
                else{
                    Toast toast = Toast.makeText(getApplicationContext(),"Wrong Answer", Toast.LENGTH_SHORT);
                    toast.show();
                }
                generate();
            }
        });
        name2.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v){
                if(name2.getText().equals(correct_name) && time_left){
                    myScore += 1;
                    score.setText("Score: " + myScore);
                }
                else{
                    Toast toast = Toast.makeText(getApplicationContext(),"Wrong Answer", Toast.LENGTH_SHORT);
                    toast.show();
                }
                generate();
            }
        });
        name3.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v){
                if(name3.getText().equals(correct_name) && time_left){
                    myScore += 1;
                    score.setText("Score: " + myScore);
                }
                else{
                    Toast toast = Toast.makeText(getApplicationContext(),"Wrong Answer", Toast.LENGTH_SHORT);
                    toast.show();
                }
                generate();
            }
        });
        name4.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v){
                if(name4.getText().equals(correct_name) && time_left){
                    myScore += 1;
                    score.setText("Score: " + myScore);
                }
                else{
                    Toast toast = Toast.makeText(getApplicationContext(),"Wrong Answer", Toast.LENGTH_SHORT);
                    toast.show();
                }
                generate();
            }
        });
        endgame.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
                builder.setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        //User clicked Yes button
                        Intent back = new Intent(getApplicationContext(), StartActivity.class);
                        startActivity(back);
                    }
                });
                builder.setNegativeButton("No", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        //User cancelled the dialog
                        dialog.cancel();
                    }
                });
                builder.setMessage("End Game?");
//                AlertDialog dialog = builder.create();
                builder.show();

            }
        });
        picture.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent contact = new Intent(ContactsContract.Intents.Insert.ACTION);
                contact.setType(ContactsContract.RawContacts.CONTENT_TYPE);
                contact.putExtra(ContactsContract.Intents.Insert.NAME,contact_name);
                startActivity(contact);
            }
        });

    }
    private void generate(){
        //changes the randoms
        random_id1 = random_id2 = random_id3  = random_id4 = 0;
        while(random_id4 == random_id1 || random_id4 == random_id2 || random_id4 == random_id3 ||
                random_id1 == random_id2 || random_id1 == random_id3 || random_id2 == random_id3){
            random_id1 = (int)(Math.random()*60);
            random_id2 = (int)(Math.random()*60);
            random_id3 = (int)(Math.random()*60);
            random_id4 = (int)(Math.random()*60);
        }

        //sets correct_id to the correct answer's id
        int random_answer = (int)(Math.random()*4)+1;
        if(random_answer==1)
            correct_id = random_id1;
        if(random_answer==2)
            correct_id = random_id2;
        if(random_answer==3)
            correct_id = random_id3;
        if(random_answer==4)
            correct_id = random_id4;

        //gets names of the correct answer
        ans = members[correct_id].toLowerCase();

        correct_name = names[correct_id];
        contact_name = correct_name;
        //sets the picture and buttons
        picture.setImageResource(getResources().getIdentifier(ans,"drawable",getPackageName()));
        name1.setText(names[random_id1]);
        name2.setText(names[random_id2]);
        name3.setText(names[random_id3]);
        name4.setText(names[random_id4]);

        timer1.start();
    }

}
