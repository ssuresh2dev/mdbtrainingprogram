package com.mdb.training.katharine.mdbsocials;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Created by victorsun on 10/5/16.
 */

public class InterestedAdapter extends RecyclerView.Adapter<InterestedAdapter.CustomViewHolder>  {
    private Context context;
    public ArrayList<String> names;
    public ArrayList<String> emails;

    public InterestedAdapter(Context context, @NonNull ArrayList<String> interestedName, @NonNull ArrayList<String> interestedEmail) {
        this.context = context;
        names = interestedName;
        emails = interestedEmail;
    }


    /* In simplified terms, a ViewHolder is an object that holds the pointers to the views in each
   each row. What does that mean? Every row has a TextView, ImageView, and CheckBox. Each row has
   a ViewHolder, and that ViewHolder holder these 3 views in it (hence "view holder").
   This function returns a single ViewHolder; it is called once for every row.
   */
    @Override
    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {

//
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_view_members, parent, false);
        return new CustomViewHolder(view);
    }

    /* This function takes the previously made ViewHolder and uses it to actually display the
    data on the screen. Remember how the holder contains (pointers to) the 3 views? By doing, for
    example, "holder.imageView" we are accessing the imageView for that row and setting the
    ImageResource to be the corresponding image for that subject.
     */
    @Override
    public void onBindViewHolder(CustomViewHolder holder, int position) {
        holder.name.setText(names.get(position));
        holder.email.setText(emails.get(position));
    }

    public int getItemCount() {
        return names.size();
    }

    class CustomViewHolder extends RecyclerView.ViewHolder {
        TextView name, email;

        public CustomViewHolder(View view) {
            super(view);
            this.name = (TextView) view.findViewById(R.id.name);
            this.email = (TextView) view.findViewById(R.id.email);

            /*Think about what we said in the comment above onCreateViewHolder to determine the
            purpose of the ViewHolder. Does it make sense why we are doing this in the constructor?
            */

        }
    }

}
