package mdb.pokedex;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.EditText;

import java.util.ArrayList;

public class SearchActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search);

        final RecyclerView recyclerView = (RecyclerView) findViewById(R.id.searchRecyclerView);

        recyclerView.setLayoutManager(new LinearLayoutManager(this));

        Pokedex pokedex = new Pokedex();
        final ArrayList<Pokedex.Pokemon> list = pokedex.getPokemon();

        final PokeAdapter pokeAdapter = new PokeAdapter(getApplicationContext(), list);
        recyclerView.setAdapter(pokeAdapter);

        EditText searchText = (EditText) findViewById(R.id.search_edit_text);

        searchText.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                // Update results that show up
                int numChars = charSequence.length();
                ArrayList<Pokedex.Pokemon> newList = new ArrayList<>();



                for(int j = 0; j < list.size(); j++){

                    if (numChars > 0 && list.get(j).name.length() >= numChars && list.get(j).name.substring(0, numChars).equals(charSequence.toString())){
                        newList.add(list.get(j));

                    }
                }

                //PokeAdapter newAdapter = new PokeAdapter(getApplicationContext(), newList);
                //recyclerView.setAdapter(pokeAdapter);
                pokeAdapter.pokemonArrayList = newList;
                pokeAdapter.notifyDataSetChanged();


            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });
    }
}
