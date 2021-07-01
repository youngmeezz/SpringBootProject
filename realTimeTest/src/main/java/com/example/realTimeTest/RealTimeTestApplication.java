package com.example.realTimeTest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SocketChannel;
import java.nio.charset.Charset;

@SpringBootApplication
public class RealTimeTestApplication {

	public static void main(String[] args) {
		
		SpringApplication.run(RealTimeTestApplication.class, args);
	}
}



