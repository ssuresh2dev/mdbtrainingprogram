package com.projects.mdb.mdbsocials;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

import static android.content.Intent.FLAG_ACTIVITY_NEW_TASK;

/**
 * Created by Aayush on 10/12/2016.
 */

public class InterestedAdapter extends RecyclerView.Adapter<InterestedAdapter.CustomViewHolder> {

    private Context context;
    private String[] emails;

    public InterestedAdapter(Context context, String[] emails) {
        this.context = context;
        this.emails = emails;
    }


    @Override
    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.interested_row_view, parent, false);
        return new CustomViewHolder(view);
    }


    @Override
    public void onBindViewHolder(CustomViewHolder holder, int position) {
        holder.textView.setText(emails[position]);
    }

    @Override
    public int getItemCount() {
        return emails.length;
    }

    class CustomViewHolder extends RecyclerView.ViewHolder {
        TextView textView;

        public CustomViewHolder(View view) {
            super(view);
            this.textView = (TextView) view.findViewById(R.id.interested_text_view);
        }
    }
}
