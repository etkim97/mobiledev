package kimnguyen.cs4640.bucketlist;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.content.Intent;
import android.util.Log;
import android.widget.TextView;
import android.os.Parcelable;

import java.util.ArrayList;
import java.util.Collections;

public class BucketListActivity extends AppCompatActivity {

    ArrayList<BucketItem> bucketItems;
    RecyclerView rvBucketList;
    static final int ADD_ITEM_REQUEST = 1;
    static final int EDIT_ITEM_REQUEST = 2;
    private static Bundle mBundleRecyclerViewState;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bucket_list);

        // Lookup the recyclerview in activity layout
        rvBucketList = (RecyclerView) findViewById(R.id.rvBucketList);

        // Initialize contacts
        bucketItems = BucketItem.createInitialBucketList();
        Collections.sort(bucketItems);
        // Create adapter passing in the sample user data
        BucketListAdapter adapter = new BucketListAdapter(this, bucketItems);
        // Attach the adapter to the recyclerview to populate items
        rvBucketList.setAdapter(adapter);
        // Set layout manager to position the items
        rvBucketList.setLayoutManager(new LinearLayoutManager(this));
        // That's all!
        Log.d("bucket", "onCreate() called");

    }

    @Override
    public void onSaveInstanceState(Bundle savedInstanceState) {
        // Save the user's current state
        savedInstanceState.putParcelableArrayList("items", bucketItems);
        mBundleRecyclerViewState = new Bundle();
        super.onSaveInstanceState(savedInstanceState);
    }

    @Override
    public void onRestoreInstanceState(Bundle savedInstanceState) {
        // Always call the superclass so it can restore the view hierarchy
        super.onRestoreInstanceState(savedInstanceState);

        // Restore state members from saved instance
        bucketItems = savedInstanceState.getParcelableArrayList("items");
            BucketListAdapter adapter = new BucketListAdapter(this, bucketItems);
            rvBucketList.setAdapter(adapter);
            rvBucketList.setLayoutManager(new LinearLayoutManager(this));
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        Log.d("bucket", "onactivityresult");
        // Check which request we're responding to
        if (requestCode == ADD_ITEM_REQUEST) {
            // Make sure the request was successful
            if (resultCode == RESULT_OK) {
                Bundle extras = data.getExtras();
                String name = extras.getString("Name");
                String desc = extras.getString("Description");
                String latitude = extras.getString("Latitude");
                String longitude = extras.getString("Longitude");
                Long date = extras.getLong("Date");
                bucketItems.add(new BucketItem(name, desc, latitude, longitude, false, date));
                Collections.sort(bucketItems);
                rvBucketList.getAdapter().notifyDataSetChanged();
                Log.d("bucket", "The count is: " + bucketItems.size());

            }
        }

        if (requestCode == EDIT_ITEM_REQUEST) {
            // Make sure the request was successful
            if (resultCode == RESULT_OK) {
                Bundle extras = data.getExtras();

                int index = extras.getInt("index");
                String name = extras.getString("Name");
                String desc = extras.getString("Description");
                String latitude = extras.getString("Latitude");
                String longitude = extras.getString("Longitude");
                Long date = extras.getLong("Date");

                bucketItems.get(index).setName(name);
                bucketItems.get(index).setDescription(desc);
                bucketItems.get(index).setLatitude(latitude);
                bucketItems.get(index).setLongitude(longitude);
                bucketItems.get(index).setName(name);
                bucketItems.get(index).setDate(date);
                Collections.sort(bucketItems);
                rvBucketList.getAdapter().notifyDataSetChanged();
                Log.d("bucket", "BucketListActivity: " + Long.toString(date));
                Log.d("bucket", "The count is: " + bucketItems.size());
            }
        }
    }

    public void addItem(View view){
        Intent addItemScreen = new Intent(getApplicationContext(), AddItemActivity.class);
        startActivityForResult(addItemScreen, ADD_ITEM_REQUEST);
    }

    public void editItem(View view) {
        Intent editItemScreen = new Intent(getApplicationContext(), EditItemActivity.class);
        TextView currentItem = (TextView)view;
        String name = currentItem.getText().toString();
        for(int i=0; i < bucketItems.size(); i++){
            if(bucketItems.get(i).getName().equals(name)) {
                BucketItem b = bucketItems.get(i);
                editItemScreen.putExtra("name", name);
                editItemScreen.putExtra("description", b.getDescription());
                editItemScreen.putExtra("latitude", b.getLatitude());
                editItemScreen.putExtra("longitude", b.getLongitude());
                editItemScreen.putExtra("date", b.getDateLong());
                editItemScreen.putExtra("index", i);
            }
        }
        startActivityForResult(editItemScreen, EDIT_ITEM_REQUEST);
    }
}
