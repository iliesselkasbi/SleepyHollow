package com.example.sleephollow;

import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import java.util.ArrayList;

public class MainActivity5 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main5);

        Spinner spinner = findViewById(R.id.spinner);
        TextView tvList = findViewById(R.id.tvList);
        String ssn = getIntent().getStringExtra("ssn");

        ArrayList<String> list = new ArrayList<>();
        RequestQueue queue = Volley.newRequestQueue(this);

        // Fill spinner with award IDs
        String url1 = "http://10.0.2.2:8080/sleepyhollow/AwardIds.jsp?ssn=" + ssn;
        StringRequest req1 = new StringRequest(Request.Method.GET, url1,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String s) {
                        String[] ids = s.trim().split("#");
                        for (String id : ids) {
                            list.add(id);
                        }
                        ArrayAdapter<String> adapter = new ArrayAdapter<>(MainActivity5.this,
                                android.R.layout.simple_spinner_dropdown_item, list);
                        spinner.setAdapter(adapter);
                    }
                }, null);
        queue.add(req1);

        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String awardid = parent.getSelectedItem().toString();
                String url2 = "http://10.0.2.2:8080/sleepyhollow/GrantedDetails.jsp?awardid="
                        + awardid + "&ssn=" + ssn;

                StringRequest req2 = new StringRequest(Request.Method.GET, url2,
                        new Response.Listener<String>() {
                            @Override
                            public void onResponse(String s) {
                                String[] rows = s.trim().split("#");
                                StringBuilder sb = new StringBuilder();
                                sb.append(String.format("%-12s %-20s\n", "Award Date", "Award Center"));
                                sb.append("------------------------------\n");
                                for (String row : rows) {
                                    String[] c = row.split(",");
                                    sb.append(String.format("%-12s %-20s\n", c[0], c[1]));
                                }
                                tvList.setText(sb.toString());
                            }
                        }, null);
                queue.add(req2);
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
    }
}