package mdb.project2.pokedex;

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

import java.text.Normalizer;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Sharie on 9/26/16.
 */

class PokemonAdapter extends RecyclerView.Adapter<PokemonAdapter.CustomViewHolder> {

    Context context;
    ArrayList<Pokedex.Pokemon> pokemons;

    PokemonAdapter(Context context, ArrayList<Pokedex.Pokemon> pokemons) {
        this.context = context;
        this.pokemons = pokemons;

    }

    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.pokemon_view, null, false);
        return new CustomViewHolder(view);
    }

    @Override
    public int getItemCount() {
        return pokemons.size();
    }

    @Override
    public void onBindViewHolder(CustomViewHolder holder, int position) {
        Pokedex.Pokemon poke_data = pokemons.get(position);
        Glide.with(context).load(findUrl(poke_data.name)).into(holder.image);
        holder.name.setText(poke_data.name);
    }

    private String findUrl(String name) {
        name = Normalizer.normalize(name.toLowerCase(), Normalizer.Form.NFD);
        name = name.replaceAll("[\\p{InCombiningDiacriticalMarks}]", "").replaceAll("\\p{P}", "");
        return String.format("http://img.pokemondb.net/artwork/%s.jpg", name);
    }

    public void setList(ArrayList<Pokedex.Pokemon> pokemons) {
        this.pokemons = pokemons;
    }

    class CustomViewHolder extends RecyclerView.ViewHolder {
        TextView name;
        ImageView image;

        CustomViewHolder(View view) {
            super(view);
            name = (TextView) view.findViewById(R.id.textView);
            image = (ImageView) view.findViewById(R.id.imageView);
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent myIntent = new Intent(v.getContext(), PokemonProfile.class);
                    myIntent.putExtra("NAME", name.getText().toString());
                    v.getContext().startActivity(myIntent);
                }
            });
        }
    }
}
