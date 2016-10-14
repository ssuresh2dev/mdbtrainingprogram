package mdb.project3.mdbevents;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kedarthakkar on 10/13/16.
 */

public class InterestedAdapter extends RecyclerView.Adapter<InterestedAdapter.CustomViewHolder> {

    Context context;
    List<String> interestedList;

    public InterestedAdapter (Context context, List<String> list){
        this.context = context;
        this.interestedList = list;
    }

    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType){
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.interested_row, parent, false);
        return new InterestedAdapter.CustomViewHolder(view);
    }

    public void onBindViewHolder(CustomViewHolder holder, int position){
        String currEmail = interestedList.get(position);
        holder.interestedTextView.setText(currEmail);
    }

    public int getItemCount(){
        return interestedList.size();
    }

    class CustomViewHolder extends RecyclerView.ViewHolder {

        TextView interestedTextView;

        public CustomViewHolder(View view){
            super(view);
            this.interestedTextView = (TextView) (view.findViewById(R.id.interested_email_address));
        }
    }

}
