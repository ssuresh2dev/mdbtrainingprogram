package com.sharie.mdb.pokedex2;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;
import com.bumptech.glide.Glide;

import java.util.ArrayList;



public class PokemonAdapter extends RecyclerView.Adapter<PokemonAdapter.CustomViewHolder> {

    private Context context;
    private ArrayList<Pokedex.Pokemon> pokemons;
    MainActivity main = new MainActivity();

    public PokemonAdapter(Context context, ArrayList<Pokedex.Pokemon> pokemons) {
        this.context = context;
        this.pokemons = pokemons;
    }

    @Override
    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        boolean view_type = main.getTypeView();
        View view_list = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_view, parent, false);
        View view_grid = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_grid, parent, false);
//        if(view_type)
//            return new CustomViewHolder(view_list);
//        else
//            return new CustomViewHolder(view_grid);
        return new CustomViewHolder(view_grid);


    }

    @Override
    public void onBindViewHolder(CustomViewHolder holder, int position) {
        Pokedex.Pokemon pokemon = pokemons.get(position);

        holder.textView.setText(pokemon.name);
        String url = "http://img.pokemondb.net/artwork/" + pokemon.name.toLowerCase() +".jpg";
        Glide.with(context).load(url).into(holder.imageView);
    }

    @Override
    public int getItemCount() {
        return pokemons.size();
    }

    class CustomViewHolder extends RecyclerView.ViewHolder {
        TextView textView;
        ImageView imageView;

        public CustomViewHolder (View view) {
            super(view);
            this.textView = (TextView) view.findViewById(R.id.pokemonName);
            this.imageView = (ImageView) view.findViewById(R.id.imageButton);
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    /*Get adapter position is getting the number of the row that was clicked,
                    starting at 0
                    */
                    Pokedex.Pokemon pokemon = pokemons.get(getAdapterPosition());
                    Intent intent = new Intent(context, ScrollingActivity.class);
                    intent.putExtra("name", pokemon.name);
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    context.startActivity(intent);



                }
            });


        }
    }


}