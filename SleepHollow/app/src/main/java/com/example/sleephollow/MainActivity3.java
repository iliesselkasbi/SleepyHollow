package com.example.sleephollow;

import android.os.Bundle;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

public class MainActivity3 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main3);

        TextView tvList = findViewById(R.id.tvList);
        String ssn = getIntent().getStringExtra("ssn");

        RequestQueue queue = Volley.newRequestQueue(this);
        String url = "http://10.0.2.2:8080/sleepyhollow/Transactions.jsp?ssn=" + ssn;

        StringRequest req = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String s) {
                        String[] rows = s.trim().split("#");
                        StringBuilder sb = new StringBuilder();
                        sb.append(String.format("%-8s %-12s %-8s\n", "Txn ID", "date", "amount"));
                        sb.append("--------------------------------\n");
                        for (String row : rows) {
                            String[] cols = row.split(",");
                            sb.append(String.format("%-8s %-12s %-8s\n", cols[0], cols[1], cols[2]));
                        }
                        sb.append("--------------------------------");
                        tvList.setText(sb.toString());
                    }
                }, null);
        queue.add(req);
    }
}