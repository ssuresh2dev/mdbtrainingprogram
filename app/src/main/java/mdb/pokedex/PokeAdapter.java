package mdb.pokedex;

/**
 * Created by victorsun on 9/28/16.
 */

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;

import java.util.ArrayList;

public class PokeAdapter extends RecyclerView.Adapter<PokeAdapter.CustomViewHolder> {
    private Context context;
    public ArrayList<Pokedex.Pokemon> pokemonArrayList;

    public PokeAdapter(Context context, ArrayList<Pokedex.Pokemon> pokemon) {
        this.context = context;
        pokemonArrayList = pokemon;
    }


    /* In simplified terms, a ViewHolder is an object that holds the pointers to the views in each
   each row. What does that mean? Every row has a TextView, ImageView, and CheckBox. Each row has
   a ViewHolder, and that ViewHolder holder these 3 views in it (hence "view holder").
   This function returns a single ViewHolder; it is called once for every row.
   */
    @Override
    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {

//        This "inflates" the views, using the layout R.layout.row_view
        //if(MainActivity.listView){
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_view, parent, false);
        //}
        //else
          //  view = LayoutInflater.from(parent.getContext()).inflate(R.layout.grid_view, parent, false);
        return new CustomViewHolder(view);
    }

    /* This function takes the previously made ViewHolder and uses it to actually display the
    data on the screen. Remember how the holder contains (pointers to) the 3 views? By doing, for
    example, "holder.imageView" we are accessing the imageView for that row and setting the
    ImageResource to be the corresponding image for that subject.
     */
    @Override
    public void onBindViewHolder(CustomViewHolder holder, int position) {
        Pokedex.Pokemon pokemon = pokemonArrayList.get(position);


        holder.pokemonTextView.setText(pokemon.name);


        String name = pokemon.name.toLowerCase();
        String url = "http://img.pokemondb.net/artwork/" + name + ".jpg";


        Glide.with(context)
                .load(url)
                .into(holder.imageView);
    }

    @Override
    public int getItemCount() {
        return pokemonArrayList.size();
    }

    class CustomViewHolder extends RecyclerView.ViewHolder {
        TextView pokemonTextView;
        ImageView imageView;

        public CustomViewHolder(View view) {
            super(view);
            this.pokemonTextView = (TextView) view.findViewById(R.id.pokemonNameTextView);
            this.imageView = (ImageView) view.findViewById(R.id.imageView);
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                    public void onClick(View v) {
                        Intent intent = new Intent(context, ProfileActivity.class);
                        intent.putExtra("POKEMON", getAdapterPosition());
                        imageView.getContext().startActivity(intent);
                    }
            });
            /*Think about what we said in the comment above onCreateViewHolder to determine the
            purpose of the ViewHolder. Does it make sense why we are doing this in the constructor?
            */

        }
    }

}
