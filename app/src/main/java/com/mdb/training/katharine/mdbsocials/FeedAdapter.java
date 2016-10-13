package com.mdb.training.katharine.mdbsocials;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.HashMap;

import static android.content.Intent.FLAG_ACTIVITY_NEW_TASK;

/**
 * Created by KJ on 10/4/16.
 */

public class FeedAdapter extends RecyclerView.Adapter<FeedAdapter.CustomViewHolder> {

    private Context context;
    public ArrayList<SocialsList.Social> socials = new ArrayList<>();
    private DatabaseReference mDatabase = FirebaseDatabase.getInstance().getReference();;


    public FeedAdapter(Context context, ArrayList<SocialsList.Social> socials) {
        this.context = context;
        this.socials = socials;
    }

    @Override
    public int getItemCount() {
        return socials.size();
    }

    /* In simplified terms, a ViewHolder is an object that holds the pointers to the views in each
    each row. What does that mean? Every row has a TextView, ImageView, and CheckBox. Each row has
    a ViewHolder, and that ViewHolder holder these 3 views in it (hence "view holder").
    This function returns a single ViewHolder; it is called once for every row.
    */
    @Override
    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
//        This "inflates" the views, using the layout R.layout.row_view
        View view;
        view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_view, parent, false);
        return new CustomViewHolder(view);
    }

    /* This function takes the previously made ViewHolder and uses it to actually display the
    data on the screen. Remember how the holder contains (pointers to) the 3 views? By doing, for
    example, "holder.imageView" we are accessing the imageView for that row and setting the
    ImageResource to be the corresponding image for that subject.
     */
    @Override
    public void onBindViewHolder(CustomViewHolder holder, int position) {
        SocialsList.Social social = socials.get(position);
        holder.titleView.setText(social.title);
        holder.authorView.setText(social.author);
        if(social.interested == null){
            social.interested = new ArrayList<>();
        }
        holder.numinterestedView.setText(Integer.toString(social.interested.size()));
    }


    class CustomViewHolder extends RecyclerView.ViewHolder {
        TextView titleView;
        ImageView imageView;
        TextView authorView;
        TextView numinterestedView;
        ArrayList<String> interestedName = new ArrayList<String>();
        ArrayList<String> interestedEmail = new ArrayList<String>();

        public CustomViewHolder (View view) {
            super(view);
            this.titleView = (TextView) view.findViewById(R.id.title);
            this.imageView = (ImageView) view.findViewById(R.id.eventpic);
            this.authorView = (TextView) view.findViewById(R.id.author);
            this.numinterestedView = (TextView) view.findViewById(R.id.number);

            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    /*Get adapter position is getting the number of the row that was clicked,
                    starting at 0
                    */
                    final SocialsList.Social s = socials.get(getAdapterPosition());

                    Intent intent = new Intent(context, DetailsActivity.class);

                    ValueEventListener postListener = new ValueEventListener() {
                        @Override
                        public void onDataChange(DataSnapshot dataSnapshot) {
                            ArrayList<String> interested = s.getInterested();
                            for(DataSnapshot dsp: dataSnapshot.getChildren()){
                                HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                                if (interested.contains(map.get("uid"))) {
                                    String name = (String) map.get("name");
                                    String email = (String) map.get("email");
                                    interestedName.add(name);
                                    interestedEmail.add(email);

                                }

                            }

                        }
                        @Override
                        public void onCancelled(DatabaseError databaseError) {
                            Log.w("TAG", "loadPost:onCancelled", databaseError.toException());
                        }

                    };
                    mDatabase.child("Users").addValueEventListener(postListener);

                    intent.putExtra("title", s.title);
                    intent.putExtra("author", s.author);
                    intent.putExtra("description", s.description);
                    intent.putExtra("date", s.date);
                    intent.putExtra("interested", s.interested.size());
                    intent.putStringArrayListExtra("interestedName", interestedName);
                    intent.putStringArrayListExtra("interestedEmail", interestedEmail);
                    intent.addFlags(FLAG_ACTIVITY_NEW_TASK);
                    context.startActivity(intent);
                }
            });
        }
    }
}
