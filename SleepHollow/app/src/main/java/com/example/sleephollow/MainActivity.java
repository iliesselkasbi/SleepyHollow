package com.example.sleephollow;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        EditText etUser = findViewById(R.id.etUser);
        EditText etPass = findViewById(R.id.etPass);
        Button btnLogin = findViewById(R.id.btnLogin);

        RequestQueue queue = Volley.newRequestQueue(this);

        btnLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String user = etUser.getText().toString();
                String pass = etPass.getText().toString();

                String url = "http://10.0.2.2:8080/sleepyhollow/login?user=" + user + "&pass=" + pass;

                StringRequest req = new StringRequest(Request.Method.GET, url,
                        new Response.Listener<String>() {
                            @Override
                            public void onResponse(String s) {
                                String resp = s.trim();
                                if (resp.startsWith("Yes:")) {
                                    String ssn = resp.substring(4);
                                    Intent intent = new Intent(MainActivity.this, MainActivity2.class);
                                    intent.putExtra("ssn", ssn);
                                    startActivity(intent);
                                } else {
                                    Toast.makeText(MainActivity.this,
                                            "Invalid username or password",
                                            Toast.LENGTH_SHORT).show();
                                }
                            }
                        }, null);

                queue.add(req);
            }
        });
    }
}