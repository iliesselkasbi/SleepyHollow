package com.example.sleephollow;

import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.toolbox.ImageRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

public class MainActivity2 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);

        TextView tvName = findViewById(R.id.tvName);
        TextView tvSales = findViewById(R.id.tvSales);
        ImageView imgEmp = findViewById(R.id.imgEmp);
        Button btnTxn = findViewById(R.id.btnTxn);
        Button btnTxnDet = findViewById(R.id.btnTxnDet);
        Button btnAward = findViewById(R.id.btnAward);
        Button btnTransfer = findViewById(R.id.btnTransfer);
        Button btnExit = findViewById(R.id.btnExit);

        // Get SSN from login activity
        String ssn = getIntent().getStringExtra("ssn");

        RequestQueue queue = Volley.newRequestQueue(this);

        // Fetch employee name + sales
        String url = "http://10.0.2.2:8080/sleepyhollow/Info.jsp?ssn=" + ssn;
        StringRequest req = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String s) {
                        String[] info = s.trim().split(",");
                        tvName.setText(info[0]);

                        try {
                            // Convert the string amount into a double number
                            double amount = Double.parseDouble(info[1]);

                            // Defining a pattern that adds commas and handles standard grouping
                            // Using "#,##0" for no decimals included.
                            java.text.DecimalFormat formatter = new java.text.DecimalFormat("#,##0");
                            String formattedAmount = formatter.format(amount);

                            // Set the text with the dynamic comma-separated value
                            tvSales.setText("$" + formattedAmount);

                        } catch (NumberFormatException | ArrayIndexOutOfBoundsException e) {
                            // Fallback to the raw string if parsing fails or index is missing
                            tvSales.setText("$" + (info.length > 1 ? info[1] : "0"));
                        }
                    }
                }, null);
        queue.add(req);

        // Fetch employee photo
        String imgUrl = "http://10.0.2.2:8080/sleepyhollow/images/" + ssn + ".jpeg";
        ImageRequest imgReq = new ImageRequest(imgUrl,
                new Response.Listener<Bitmap>() {
                    @Override
                    public void onResponse(Bitmap bitmap) {
                        imgEmp.setImageBitmap(bitmap);
                    }
                }, 0, 0, null, null);
        queue.add(imgReq);

        // Transactions button -> MainActivity3
        btnTxn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity2.this, MainActivity3.class);
                intent.putExtra("ssn", ssn);
                startActivity(intent);
            }
        });

        // Transaction Details button -> MainActivity4
        btnTxnDet.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity2.this, MainActivity4.class);
                intent.putExtra("ssn", ssn);
                startActivity(intent);
            }
        });

        // Award Details button -> MainActivity5
        btnAward.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity2.this, MainActivity5.class);
                intent.putExtra("ssn", ssn);
                startActivity(intent);
            }
        });

        // Transfer button -> MainActivity6
        btnTransfer.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity2.this, MainActivity6.class);
                intent.putExtra("ssn", ssn);
                startActivity(intent);
            }
        });

        // Exit button -> closes app
        btnExit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finishAffinity();
            }
        });
    }
}