package com.pokedex.mdb.pokedex;

/**
 * Created by Aayush on 9/28/2016.
 */

        import android.app.SearchManager;
        import android.content.Context;
        import android.support.v7.app.AppCompatActivity;
        import android.os.Bundle;
        import android.support.v7.widget.GridLayoutManager;
        import android.support.v7.widget.LinearLayoutManager;
        import android.support.v7.widget.RecyclerView;
        import android.support.v7.widget.SearchView;
        import android.view.Menu;
        import android.view.MenuInflater;
        import android.view.MenuItem;

        import java.util.ArrayList;

public class ListActivity extends AppCompatActivity {

    private RecyclerView recycleboy;
    private boolean isLinear = false;
    private Pokedapter pokedapter;
    private ArrayList<Pokedex.Pokemon> pokemons;
    private ArrayList<Pokedex.Pokemon> searchingcache;
    private ArrayList<Pokedex.Pokemon> filteringcache;

    private ArrayList<Pokedex.Pokemon> lowHP;
    private ArrayList<Pokedex.Pokemon> medHP;
    private ArrayList<Pokedex.Pokemon> highHP;

    private boolean lowSelected = true;
    private boolean medSelected = true;
    private boolean highSelected = true;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list);
        recycleboy = (RecyclerView) findViewById(R.id.recycleboy);
        Pokedex pokedex = new Pokedex();
        pokemons = pokedex.getPokemon();
        setFilter(pokemons);
        setSearch(pokemons);
        lowHP = new ArrayList<>();
        medHP = new ArrayList<>();
        highHP = new ArrayList<>();
        updateRecyclerView(pokemons);

        // filter low HP pokemon
        for (int i = 0; i < pokemons.size(); i += 1) {
            String hpString = pokemons.get(i).hp;
            int hp = Integer.parseInt(hpString);
            if (hp < 50) {
                lowHP.add(pokemons.get(i));
            }
        }

        // filter med HP pokemon
        for (int i = 0; i < pokemons.size(); i += 1) {
            String hpString = pokemons.get(i).hp;
            int hp = Integer.parseInt(hpString);
            if (hp >= 50 && hp <= 100) {
                medHP.add(pokemons.get(i));
            }
        }

        // filter high HP pokemon
        for (int i = 0; i < pokemons.size(); i += 1) {
            String hpString = pokemons.get(i).hp;
            int hp = Integer.parseInt(hpString);
            if (hp > 100) {
                highHP.add(pokemons.get(i));
            }
        }
    }

    public ArrayList<Pokedex.Pokemon> getOverlap() {
        ArrayList<Pokedex.Pokemon> p = new ArrayList<Pokedex.Pokemon>();
        ArrayList<Pokedex.Pokemon> smaller = searchingcache;
        ArrayList<Pokedex.Pokemon> longer = filteringcache;
        if (smaller.size() > longer.size()) {
            smaller = filteringcache;
            longer = searchingcache;
        }
        for(int i = 0; i < smaller.size(); i++) {
            if(longer.contains(smaller.get(i))) {
                p.add(smaller.get(i));
            }
        }
        return p;
    }

    public ArrayList<Pokedex.Pokemon> setSearch(ArrayList<Pokedex.Pokemon> p) {
        searchingcache = new ArrayList<Pokedex.Pokemon>();
        for(int i = 0; i < p.size(); i++) {
            searchingcache.add(p.get(i));
        }
        return searchingcache;
    }

    public ArrayList<Pokedex.Pokemon> setFilter(ArrayList<Pokedex.Pokemon> p) {
        filteringcache = new ArrayList<Pokedex.Pokemon>();
        for(int i = 0; i < p.size(); i++) {
            filteringcache.add(p.get(i));
        }
        return filteringcache;
    }

    public void updateRecyclerView(ArrayList<Pokedex.Pokemon> p) {
        if (isLinear) {
            recycleboy.setLayoutManager(new LinearLayoutManager(this));
        } else {
            recycleboy.setLayoutManager(new GridLayoutManager(this, 2));
        }
        pokedapter = new Pokedapter(getApplicationContext(), p, isLinear);
        recycleboy.setAdapter(pokedapter);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.menu_list, menu);

        menu.findItem(R.id.filterLow).setChecked(true);
        menu.findItem(R.id.filterMed).setChecked(true);
        menu.findItem(R.id.filterHigh).setChecked(true);


        SearchManager searchManager = (SearchManager) getSystemService(Context.SEARCH_SERVICE);
        SearchView searchView = (SearchView) menu.findItem(R.id.action_search).getActionView();
        // Assumes current activity is the searchable activity
        searchView.setSearchableInfo(searchManager.getSearchableInfo(getComponentName()));
        searchView.setIconifiedByDefault(true); // Do not iconify the widget; expand it by default

        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {

            @Override
            public boolean onQueryTextSubmit(String query) {
                return false;
            }

            @Override
            public boolean onQueryTextChange(String newText) {
                searchingcache = setSearch(pokemons);

                // start search function
                for (int i = 0; i < searchingcache.size();) {
                    if (!(searchingcache.get(i).name.toLowerCase().startsWith(newText))) {
                        searchingcache.remove(i);
                    } else {i++;}
                }

                // reset the list in adapter and notify change
                pokedapter.setList(getOverlap());
                pokedapter.notifyDataSetChanged();
                return false;
            }
        });

        return true;
    }

    public void switchLayout(MenuItem item) {
        isLinear = !isLinear;
        updateRecyclerView(pokedapter.getPokemons());
    }

    public boolean isLinear() {
        return isLinear;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        filteringcache = setFilter(pokemons);

        int id = item.getItemId();
        if (id == R.id.filterLow) {
            if (item.isChecked()) {
                item.setChecked(false);
                lowSelected = false;
            } else {
                item.setChecked(true);
                lowSelected = true;
            }
        } else if (id == R.id.filterMed) {
            if (item.isChecked()) {
                item.setChecked(false);
                medSelected = false;
            } else {
                item.setChecked(true);
                medSelected = true;
            }
        } else {
            if (item.isChecked()) {
                item.setChecked(false);
                highSelected = false;
            } else {
                item.setChecked(true);
                highSelected = true;
            }
        }

        for (int i = 0; i < filteringcache.size();) {
            String hpString = filteringcache.get(i).hp;
            int hp = Integer.parseInt(hpString);
            if (hp < 50) {
                if (!lowSelected) {
                    filteringcache.remove(i);
                }
                else {i++;}
            } else if (hp >= 50 && hp <= 100) {
                if (!medSelected) {
                    filteringcache.remove(i);
                }
                else {i++;}
            } else {
                if (!highSelected) {
                    filteringcache.remove(i);
                }
                else {i++;}
            }
        }
        pokedapter.setList(getOverlap());
        pokedapter.notifyDataSetChanged();
        return super.onOptionsItemSelected(item);
    }
}