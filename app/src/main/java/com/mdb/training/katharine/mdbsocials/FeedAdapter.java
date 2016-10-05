package com.mdb.training.katharine.mdbsocials;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;

import static android.content.Intent.FLAG_ACTIVITY_NEW_TASK;

/**
 * Created by KJ on 10/4/16.
 */

public class FeedAdapter extends RecyclerView.Adapter<FeedAdapter.CustomViewHolder> {

    private Context context;
    private ArrayList<SocialsList.Social> socials;

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
        SocialsList.Social pokemon = socials.get(position);
        holder.pokemonNameTextView.setText(pokemon.name);
        holder.pokemonNumberTextView.setText("#" + (String)pokemon.number);
    }


    class CustomViewHolder extends RecyclerView.ViewHolder {
        TextView pokemonNameTextView;
        ImageView imageView;
        TextView pokemonNumberTextView;

        public CustomViewHolder (View view) {
            super(view);
            this.pokemonNameTextView = (TextView) view.findViewById(R.id.nameTextView);
            this.imageView = (ImageView) view.findViewById(R.id.imageView);
            this.pokemonNumberTextView = (TextView) view.findViewById(R.id.numberTextView);

            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    /*Get adapter position is getting the number of the row that was clicked,
                    starting at 0
                    */
                    SocialsList.Social pokemon = socials.get(getAdapterPosition());
                    Intent intent = new Intent(context, DetailsActivity.class);
                    intent.putExtra("name", pokemon.name);
                    intent.putExtra("number", pokemon.number);
                    intent.putExtra("attack", pokemon.attack);
                    intent.putExtra("defense", pokemon.defense);
                    intent.putExtra("hp", pokemon.hp);
                    intent.putExtra("species", pokemon.species);
                    intent.putExtra("url", getURL(pokemon.number));
                    intent.addFlags(FLAG_ACTIVITY_NEW_TASK);


                    context.startActivity(intent);
                }
            });
        }
    }
}
