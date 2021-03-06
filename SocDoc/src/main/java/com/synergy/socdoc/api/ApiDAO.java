package com.synergy.socdoc.api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.stereotype.Repository;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
 

@Repository
public class ApiDAO implements InterApiDAO {

	private String apiKey = "s9xg9Bp9ErcnSizOyrS0DSPvXB%2B1rKUHXQLztWL6s3RshEh5dVwOutBsMoRcIUcTjHXGPFB%2F%2B2%2FoU1rkIYi8gA%3D%3D";
	private String coronaKey = "%2FKS8ENjJIo1%2BhqYsxLHPWu3Lr0QDc9NhdYfzCHPhkyVur89R5P0uCoSQ4CSrZv%2FQUU4T5LIHvkWW6EVaDrN0xw%3D%3D";
	
	@Override
	public String getCovidStats() {
		String result = "";
		try {
			StringBuilder urlBuilder = new StringBuilder("http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson"); /* URL */

			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + apiKey); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("-", "UTF-8")); /*공공데이터포털에서 받은 인증키*/
	        
			urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /* 페이지번호 */
			urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /* 한 페이지 결과 수 */
			urlBuilder.append("&" + URLEncoder.encode("startCreateDt", "UTF-8") + "=" + URLEncoder.encode("20200729", "UTF-8")); /* 검색할 생성일 범위의 시작 */
			urlBuilder.append("&" + URLEncoder.encode("endCreateDt", "UTF-8") + "=" + URLEncoder.encode("20200805", "UTF-8")); /* 검색할 생성일 범위의 종료 */
			URL url = new URL(urlBuilder.toString());
			
			System.out.println("URL : " + url);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("GET");

			conn.setRequestProperty("Content-type", "application/json");
			System.out.println("Response code: " + conn.getResponseCode());
			BufferedReader rd;
			
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			
			StringBuilder sb = new StringBuilder();
			String line;
			
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			
			rd.close();
			conn.disconnect();
			System.out.println("result in DAO class : "+sb.toString());
			result = sb.toString();
			
			
			JSONObject xmlJSONObj = XML.toJSONObject(sb.toString());	
			System.out.println("‼️xmlJSONObj‼️ " + xmlJSONObj);
			result = xmlJSONObj.toString();
			System.out.println("‼️xmlJSONObjString‼️ " + result);
	
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	

	@Override
	public String getCoronaStats(String startCreateDt, String endCreateDt) {
		String result = "";
		try {
			StringBuilder urlBuilder = new StringBuilder("http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + coronaKey); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("-", "UTF-8")); /*공공데이터포털에서 받은 인증키*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("startCreateDt","UTF-8") + "=" + URLEncoder.encode(endCreateDt, "UTF-8")); /*검색할 생성일 범위의 시작*/
	        urlBuilder.append("&" + URLEncoder.encode("endCreateDt","UTF-8") + "=" + URLEncoder.encode(endCreateDt, "UTF-8")); /*검색할 생성일 범위의 종료*/
	        
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
			
			rd.close();
			conn.disconnect();
			System.out.println("result in DAO class : "+sb.toString());
			result = sb.toString();
			
			JSONObject xmlJSONObj = XML.toJSONObject(sb.toString());	
			System.out.println("‼️xmlJSONObj‼️ " + xmlJSONObj);
			result = xmlJSONObj.toString();
			System.out.println("‼️xmlJSONObjString‼️ " + result);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
