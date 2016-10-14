package com.demo.mdb.mdbsocials;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Created by reddy on 10/4/2016.
 */

public class InterestedViewAdapter extends RecyclerView.Adapter<InterestedViewAdapter.CustomViewHolder> {

    private Context context;
    public ArrayList<String> userArrayList;

    public InterestedViewAdapter(Context context, ArrayList<String> userArrayList) {
        this.context = context;
        this.userArrayList = userArrayList;
    }

    @Override
    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.interested_view, parent, false);
        return new CustomViewHolder(view);
    }

    @Override
    public void onBindViewHolder(CustomViewHolder holder, int position) {
        String user = userArrayList.get(position);
        holder.interestedUserTextView.setText(user);
    }

    @Override
    public int getItemCount() {
        return userArrayList.size();
    }

    class CustomViewHolder extends RecyclerView.ViewHolder {
        TextView interestedUserTextView;

        public CustomViewHolder(View view) {
            super(view);
            this.interestedUserTextView = (TextView) view.findViewById(R.id.interestedUserTextView);
        }
    }
}

