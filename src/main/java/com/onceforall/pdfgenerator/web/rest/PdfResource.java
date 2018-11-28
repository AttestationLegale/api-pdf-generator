package com.onceforall.pdfgenerator.web.rest;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.stringtemplate.v4.ST;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.onceforall.pdfgenerator.json.JSONException;
import com.onceforall.pdfgenerator.json.JSONObject;
import com.onceforall.pdfgenerator.web.rest.vm.PdfGenerationDataVM;

@RestController
@RequestMapping("/api/v1/pdf")
public class PdfResource {

	private static final Logger LOGGER = LoggerFactory.getLogger(PdfResource.class);
	
    private final ObjectMapper objectMapper;

    public PdfResource() {
        this.objectMapper = new ObjectMapper();
        this.objectMapper.findAndRegisterModules();
        this.objectMapper.disable(DeserializationFeature.ADJUST_DATES_TO_CONTEXT_TIME_ZONE);
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
        this.objectMapper.setDateFormat(df);
    }

    /**
     * Create a new Document
     * @throws IOException 
     * @throws JSONException 
     */
    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(HttpStatus.OK)
    public void generate(HttpServletResponse response, @RequestBody PdfGenerationDataVM pdfGenerationData) throws IOException, JSONException {
        
    	ST stringTemplate = new ST(pdfGenerationData.template);
    	stringTemplate.add("data", new JSONObject(pdfGenerationData.jsonData));
    	String html = stringTemplate.render();
    	LOGGER.debug("Generated html : \n" + html);
    	
    	ByteArrayOutputStream baos = new ByteArrayOutputStream();
    	ConverterProperties properties = new ConverterProperties();
        //properties.setBaseUri(baseUri);
        HtmlConverter.convertToPdf(html, baos, properties);
        
        response.setContentType("Content-Type: text/html; charset=UTF-8");
        response.addHeader(
            "Content-Disposition",
            "attachment; filename=toto.pdf");
        response.setContentLength(baos.size());
        baos.writeTo(response.getOutputStream());
    }
}
