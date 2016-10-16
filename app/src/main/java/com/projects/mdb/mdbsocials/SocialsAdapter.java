package com.projects.mdb.mdbsocials;

/**
 * Created by Aayush on 10/3/2016.
 */

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.AsyncTask;
import android.support.annotation.NonNull;
import android.support.v7.graphics.Palette;
import android.support.v7.widget.CardView;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.storage.FirebaseStorage;

import java.util.ArrayList;

import static android.content.Intent.FLAG_ACTIVITY_NEW_TASK;


/**
 * Created by Aayush on 9/28/2016.
 */

public class SocialsAdapter extends RecyclerView.Adapter<SocialsAdapter.CustomViewHolder> {

    private Context context;
    private ArrayList<Socialist.Social> socialist;

    public SocialsAdapter(Context context, ArrayList<Socialist.Social> socialist) {
        this.context = context;
        this.socialist = socialist;
    }


    @Override
    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.socials_row_view, parent, false);
        return new CustomViewHolder(view);
    }


    @Override
    public void onBindViewHolder(final CustomViewHolder holder, int position) {
        Socialist.Social social = socialist.get(position);
        holder.eventNameTextView.setText(social.getName());
        holder.numberTextView.setText("" + social.getInterested() + " people are interested");
        if (social.getInterested() == 1) {holder.numberTextView.setText("1 person is interested");}
        holder.creatorTextView.setText("Created by " + social.getCreator() + " on " + social.getDate());

        class DownloadFilesTask extends AsyncTask<String, Void, Bitmap> {
            protected Bitmap doInBackground(String... strings) {
                try {return Glide.
                        with(context).
                        load(strings[0]).
                        asBitmap().
                        into(100, 100). // Width and height
                        get();}
                catch (Exception e) {return null;}
            }

            protected void onProgressUpdate(Void... progress) {}

            protected void onPostExecute(Bitmap result) {
                Palette.PaletteAsyncListener paletteListener = new Palette.PaletteAsyncListener() {
                    public void onGenerated(Palette palette) {
                        int defaulto = 0x000000;
                        holder.cardView.setCardBackgroundColor(palette.getDominantColor(defaulto));
                    }
                };
                if (result != null && !result.isRecycled()) {
                    Palette.from(result).generate(paletteListener);
                }
                holder.imageView.setImageBitmap(result);
            }
        }

        FirebaseStorage.getInstance().getReferenceFromUrl("gs://mdbsocials-700a9.appspot.com").child(social.getID() + ".png").getDownloadUrl().addOnSuccessListener(new OnSuccessListener<Uri>() {
            @Override
            public void onSuccess(Uri uri) {
                Log.d("ye", uri.toString());
                new DownloadFilesTask().execute(uri.toString());
                //Glide.with(context).load(uri.toString()).thumbnail(0.5f).crossFade().diskCacheStrategy(DiskCacheStrategy.ALL).into(holder.imageView);
            }
        }).addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(@NonNull Exception exception) {
                Log.d("sad", exception.toString());
            }
        });
    }


    @Override
    public int getItemCount() {
        return socialist.size();
    }

    class CustomViewHolder extends RecyclerView.ViewHolder {
        TextView eventNameTextView;
        ImageView imageView;
        TextView numberTextView;
        TextView creatorTextView;
        CardView cardView;

        public CustomViewHolder (View view) {
            super(view);
            this.eventNameTextView = (TextView) view.findViewById(R.id.eventNameTextView);
            this.imageView = (ImageView) view.findViewById(R.id.imageView);
            this.numberTextView = (TextView) view.findViewById(R.id.numberTextView);
            this.creatorTextView = (TextView) view.findViewById(R.id.creatorTextView);
            this.cardView = (CardView) view.findViewById(R.id.card);

            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    /*Get adapter position is getting the number of the row that was clicked,
                    starting at 0
                    */
                    Toast.makeText(context, "yooooooo", Toast.LENGTH_SHORT).show();
                    Socialist.Social s = socialist.get(getAdapterPosition());
                    Intent intent = new Intent(context, ScrollingActivity.class);
                    String[] info = {(String)creatorTextView.getText(),
                            s.getDescription(),
                            (String)numberTextView.getText(),
                            (String)eventNameTextView.getText()};
                    intent.putExtra("id", s.getID());
                    intent.addFlags(FLAG_ACTIVITY_NEW_TASK);
                    context.startActivity(intent);
                }
            });
        }
    }

    private class DownloadFilesTask extends AsyncTask<String, Void, Bitmap> {
        protected Bitmap doInBackground(String... strings) {
            try {return Glide.
                    with(context).
                    load(strings[0]).
                    asBitmap().
                    into(100, 100). // Width and height
                    get();}
            catch (Exception e) {return null;}
        }

        protected void onProgressUpdate(Void... progress) {}

        protected void onPostExecute(Bitmap result) {

        }
    }
}
