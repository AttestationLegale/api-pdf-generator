package com.onceforall.pdfgenerator.service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.stringtemplate.v4.ST;

import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.onceforall.pdfgenerator.exception.PdfGenerationException;
import com.onceforall.pdfgenerator.json.JSONObject;

@Service
public class PdfService {

    private static final Logger LOGGER = LoggerFactory.getLogger(PdfService.class);

    private final String baseUri;
    
    public PdfService(@Value("${application.base-uri}") final String baseUri) {
    	this.baseUri = baseUri;
    }

    public ByteArrayOutputStream generate(String template, Map<String, Object> data, Map<String, Object> i18n) {
    	  
    	LOGGER.debug(String.valueOf(data.keySet().size()));
    	LOGGER.debug(String.valueOf(i18n.keySet().size()));
    	
    	ST stringTemplate = new ST(template, '$', '$');
    	stringTemplate.add("data", new JSONObject(data));
    	stringTemplate.add("i18n", new JSONObject(i18n));
    	
    	String html = stringTemplate.render();
    	LOGGER.debug("Generated html : \n" + html);
    	
    	ByteArrayOutputStream baos = new ByteArrayOutputStream();
    	ConverterProperties properties = new ConverterProperties();
        properties.setBaseUri(baseUri);
        try {
			HtmlConverter.convertToPdf(html, baos, properties);
		} catch (IOException e) {
			throw new PdfGenerationException(e.getMessage());
		}
        
        return baos;
    }
}
