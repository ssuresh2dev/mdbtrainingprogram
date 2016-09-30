package com.pokedex.mdb.pokedex;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;

import java.util.ArrayList;

import static android.content.Intent.FLAG_ACTIVITY_NEW_TASK;

/**
 * Created by Aayush on 9/28/2016.
 */

public class Pokedapter extends RecyclerView.Adapter<Pokedapter.CustomViewHolder> {

    private Context context;
    private ArrayList<Pokedex.Pokemon> pokemons;
    private boolean isLinear;

    public Pokedapter(Context context, ArrayList<Pokedex.Pokemon> pokemons, boolean isLinear) {
        this.context = context;
        this.pokemons = pokemons;
        this.isLinear = isLinear;
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
        if(isLinear) {view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_view, parent, false);}
        else {view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_view_grid, parent, false);}
        return new CustomViewHolder(view);
    }

    public void setList(ArrayList<Pokedex.Pokemon> list) {
        this.pokemons = list;
    }

    public ArrayList<Pokedex.Pokemon> getPokemons() {
        return pokemons;
    }

    /* This function takes the previously made ViewHolder and uses it to actually display the
    data on the screen. Remember how the holder contains (pointers to) the 3 views? By doing, for
    example, "holder.imageView" we are accessing the imageView for that row and setting the
    ImageResource to be the corresponding image for that subject.
     */
    @Override
    public void onBindViewHolder(CustomViewHolder holder, int position) {
        Pokedex.Pokemon pokemon = pokemons.get(position);

        holder.pokemonNameTextView.setText(pokemon.name);
        Glide.with(context).load(getURL(pokemon.number)).thumbnail(0.5f).crossFade().diskCacheStrategy(DiskCacheStrategy.ALL).into(holder.imageView);
        holder.pokemonNumberTextView.setText("#" + (String)pokemon.number);
    }

    @Override
    public int getItemCount() {
        return pokemons.size();
    }

    public String getURL(String number) {
        /*if(name.equals("Farfetch'd")){name = "farfetchd";}
        else if(name.contains("Flab")){name = "flabebe";}
        return "http://img.pokemondb.net/artwork/" + (name).toLowerCase() + ".jpg";*/
        while(number.length() < 3){number = "0" + number;}
        return "http://assets.pokemon.com/assets/cms2/img/pokedex/full/" + number + ".png";
    }

    class CustomViewHolder extends RecyclerView.ViewHolder {
        TextView pokemonNameTextView;
        ImageView imageView;
        TextView pokemonNumberTextView;

        public CustomViewHolder (View view) {
            super(view);
            if(isLinear) {
                this.pokemonNameTextView = (TextView) view.findViewById(R.id.nameTextView);
                this.imageView = (ImageView) view.findViewById(R.id.imageView);
                this.pokemonNumberTextView = (TextView) view.findViewById(R.id.numberTextView);
            }
            else {
                this.pokemonNameTextView = (TextView) view.findViewById(R.id.nameTextView2);
                this.imageView = (ImageView) view.findViewById(R.id.imageView2);
                this.pokemonNumberTextView = (TextView) view.findViewById(R.id.numberTextView2);
            }
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    /*Get adapter position is getting the number of the row that was clicked,
                    starting at 0
                    */
                    Pokedex.Pokemon pokemon = pokemons.get(getAdapterPosition());
                    Intent intent = new Intent(context, PokemonActivity.class);
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
