package kimnguyen.cs4640.bucketlist;

import android.app.usage.NetworkStats;
import android.support.design.internal.ParcelableSparseArray;

import java.util.ArrayList;
import java.util.Date;
import java.text.SimpleDateFormat;


public class BucketItem extends ParcelableSparseArray implements Comparable{
    private String name;
    private String description;
    private String latitude;
    private String longitude;
    private boolean completed;
    private ArrayList BucketList;
    private long date;

    public BucketItem(String name, String description, String latitude, String longitude, boolean completed, long date){
        this.name = name;
        this.description = description;
        this.latitude = latitude;
        this.longitude = longitude;
        this.completed = completed;
        this.date = date;
    }

    public String getName(){
        return name;
    }

    public String getDescription(){ return description; }

    public String getLatitude(){ return latitude; }

    public String getLongitude(){ return longitude; }

    public String getDate(){
        String dateString = new SimpleDateFormat("MM/dd/yyyy").format(new Date(date));
        return dateString;
    }

    public boolean getCompleted() { return completed; }

    public long getDateLong(){ return date; }

    public void setName(String n){
        name = n;
    }

    public void setDescription(String d){ description = d; }

    public void setLatitude(String lat){ latitude = lat; }

    public void setLongitude(String lon){ longitude = lon; }

    public void setDate(long d){ date = d; }

    public void setCompleted(boolean b) { completed = b; }

    public static ArrayList<BucketItem> createInitialBucketList(){
        ArrayList<BucketItem> bucketitemlist = new ArrayList<>();
        bucketitemlist.add(new BucketItem("Get the number 1 ticket at Bodos",
                "number 1 ticket", "0", "0", false, 1517542352L));
        bucketitemlist.add(new BucketItem("Go to an acapella concert",
                "concert", "0", "0", false, 0));
        bucketitemlist.add(new BucketItem("Break into Scott Stadium",
                "stadium", "0", "0", false, 0));
        bucketitemlist.add(new BucketItem("Run across the lawn in a questionable fashion",
                "number 1 ticket", "0", "0", false, 0));
        bucketitemlist.add(new BucketItem("Take a column picture",
                 "concert", "0", "0", false, 0));
        bucketitemlist.add(new BucketItem("Hug Mrs. Kathy at Newcomb Dining Hall",
                "stadium", "0", "0", false, 0));


        return bucketitemlist;
    }

    public int compareTo(Object anotherItem) {
        BucketItem b = (BucketItem) anotherItem;

        boolean anotherItemComp = b.getCompleted();
        boolean thisItemComp = this.getCompleted();

        int i = 0;
        if (thisItemComp && !anotherItemComp) {i = 1; }
        else if (!thisItemComp && anotherItemComp) {i = -1; }
        else {i = 0; }

        if (i != 0) return i;


        Long anotherItemDate = b.getDateLong();
        return Long.compare(this.getDateLong(), anotherItemDate);
    }
}
