package com.onceforall.pdfgenerator;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.apache.commons.io.IOUtils;
import org.stringtemplate.v4.ST;

import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.onceforall.pdfgenerator.json.JSONException;
import com.onceforall.pdfgenerator.json.JSONObject;


public class PdfGeneratorLauncher {

	public static void main(String[] args) throws JSONException, IOException {
		
		if (args.length < 3) {
			System.out.println("usage : jsonDataFilePath templateFilePath generatedPdfDirectory [staticResourceBaseUri]");
			return;
		}
		
		File jsonDataFile = new File(args[0]);
		
		if (!jsonDataFile.exists()
		 || jsonDataFile.isDirectory()) {
			System.out.println("jsonDataFilePath argument points to a directory or not present file.");
			System.out.println("usage : jsonDataFilePath templateFilePath generatedPdfDirectory [staticResourceBaseUri]");
			return;
		}
		
		File templateFile = new File(args[1]);
		
		if (!templateFile.exists()
		 || templateFile.isDirectory()) {
			System.out.println("templateFilePath argument points to a directory or not present file.");
			System.out.println("usage : jsonDataFilePath templateFilePath generatedPdfDirectory [staticResourceBaseUri]");
			return;
		}
		
		File generatedPdfDirectory = new File(args[2]);
		
		if (!generatedPdfDirectory.exists()
		 || generatedPdfDirectory.isFile()) {
			System.out.println("generatedPdfDirectory argument points to a file or not present directory.");
			System.out.println("usage : jsonDataFilePath templateFilePath generatedPdfDirectory [staticResourceBaseUri]");
			return;
		}
		
		String baseUri = ".";
		if (args.length == 4) {
			baseUri = args[3];
		}
		
		JSONObject data = null;
		try (FileInputStream fis = new FileInputStream(jsonDataFile);){
			String dataAsString = IOUtils.toString(fis, Charset.defaultCharset());
			System.out.println("Data : \n" + dataAsString);
			data = new JSONObject(dataAsString);
		}
		
		ST template = null;
		try (FileInputStream fis = new FileInputStream(templateFile);){
			String templateAsString = IOUtils.toString(fis, Charset.defaultCharset());
			System.out.println("Template : \n" + templateAsString);
			template = new ST(templateAsString, '$', '$');
		}
		
		template.add("data", data);
    	String html = template.render();
    	System.out.println("Generated html : \n" + html);
    	
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
		File pdfFile = new File(generatedPdfDirectory, sdf.format(Calendar.getInstance().getTime()) + "-generated-pdf.pdf");
		if (!pdfFile.exists()) {
			pdfFile.createNewFile();
		}
		
    	try (FileOutputStream fos = new FileOutputStream(pdfFile)){
        	ConverterProperties properties = new ConverterProperties();
            properties.setBaseUri(baseUri);
    		HtmlConverter.convertToPdf(html, fos, properties);
    	}
	}
}
